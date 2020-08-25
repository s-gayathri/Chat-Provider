// Setting up the server and linking it to socket.io
const express = require('express');
const app = express();
const server = require('http').createServer(app);
var io = require('socket.io')(server);

const PORT = process.env.PORT || 3001;

// Importing user-defined events for socket as a map
const events = require('./constants');

// Initialize map to store the users that are online
const users = new Map();

io.sockets.on(events.ON_CONNECT, (socket) => {
    initializeOnConnect(socket);
});

const initializeOnConnect = (socket) => {
    // When a user logs in
    console.log(`NEW USER: ${JSON.stringify(socket.handshake.query)} with socketID - ${socket.id}`);

    var userID = socket.handshake.query.userID;
    // Add user to the list
    users.set(userID, {
        socketID: socket.id
    });
    console.log(`NEW USER ADDED - TOTAL NO. OF USERS ${users.size}`);

    // When the users sends a message
    onMessage(socket); 
    // When the user logs out
    disposeOnDisconnect(socket);
}

const onMessage = (socket) => {
    socket.on(events.INDIVIDUAL_CHAT_MESSAGE, (message) => {
        individualChatHandler(socket, message);
    });

    socket.on(events.GROUP_CHAT_MESSAGE, (message) => {
        groupChatHandler(socket, message);
    });
}

const individualChatHandler = (socket, message) => {
    let to = message.to;
    let from = message.from;
    let content = message.content;
    let toSocketID = getSocketID(to);

    // Check if the other person is online
    let isOnline = (toSocketID == undefined) ? false : true;
    console.log(`CHAT From-${from} To-${to} is Online-${isOnline} Message-${content}`);

    // Store in database

    // Send message
    message.status = isOnline ? events.STATUS_CODE_MESSAGE_SENT : STATUS_CODE_MESSAGE_NOT_SENT;
    message.recipientIsOnline = isOnline;
    sendToSelf(socket, events.MESSAGE_FROM_SERVER, content);

    if(isOnline == true)
        sendToOther(socket, events.RECEIVE_MESSAGE, toSocketID, content);
}

const groupChatHandler = (socket, message) => {
    socket.join(message.group);
    // Will implement after the individual chat works
    // Something of this sort
    //sendToAll(socket, event.GROUP_CHAT_MESSAGE, group, content);
    socket.leave(message.group);
}

const sendToSelf = (socket, event, message) => {
    socket.emit(event, message);
}

const sendToOther = (socket, event, toSocketID, message) => {
    socket.to(`${toSocketID}`).emit(event, message);
}

const sendToAll = (socket, event, groupID, message) => {
    socket.in(`${groupID}`).emit(event, message);
}

const getSocketID = (userID) => {
    let temp = users.get(`${userID}`);

    if (temp == undefined)
        return undefined;

    return temp.socketID;
}

const disposeOnDisconnect = (socket) => {
    socket.on(events.ON_DISCONNECT, () => {
        console.log(`USER DISCONNECTED with socketID ${socket.id}`);
        socket.removeAllListeners(events.ON_DISCONNECT);
        for(const [key, value] of Object.entries(users)) 
            if(value.socketID == socket.id)
                users.delete(key);
        console.log(`USER REMOVED - TOTAL NO. OF USERS ${users.size}`);
    });
}

server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
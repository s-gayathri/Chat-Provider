// Setting up the server and linking it to socket.io
const express = require('express');
const app = express();
const server = require('http').createServer(app);
const io = require('socket.io')(server);
const  bodyParser=require('body-parser');
const Chat=require('./models/ChatSchema');
const connect=require('./dbconnection');
const events = require('./constants');
 
 
const PORT = process.env.PORT || 3000;

// Importing user-defined events for socket as a map
 

app.get('/', (req, res) => {
    
    res.sendFile(__dirname+"/index1.html");

    // console.log("hey");


});
app.get("/e",(req,res)=>{
    res.sendFile(__dirname+"/index2.html");
})

io.on("connection", (socket) => {
 
    console.log(`NEW USER:USER connected   ${JSON.stringify(socket.handshake.query )} with socketID - ${socket.id}`);

    var roomID =  socket.handshake.query.roomID;

    // Add user to the list
    // if (rooms.get(roomID)) {

    //     arr = rooms.get(roomID);
    //     arr.push({
    //         socketID: socket.id
    //     });

    //     rooms.set(roomID, arr);
    // } else {
    //     rooms.set(roomID, [{
    //         socketID: socket.id
    //     }]);
    // }


    // console.log(rooms);
    // console.log(`NEW USER ADDED - TOTAL NO. OF ROOMS ${rooms.size}`);

    socket.join(roomID);
    // When the users sends a message
    console.log("pls");

    socket.on('send_message', (message) => {
       
        console.log("yo in ");
        
        let toID = message.receiverChatID;
        let fromID = message.senderChatID;
        let content = message.content;
        let time=message.time;
         
        // let check_online = checkOnline(toID);

        let response = {
            "content": content,
            "senderChatID": fromID,
            "receiverChatID": toID,
            "time":time
        } ;
        
        console.log(`CHAT From-${fromID} To-${toID} is Online-Message-${content} and ${time}`);
        connect.then(db  =>  {
            console.log("connected correctly to the DB");
        
            let  chat1 =  new Chat({
                content: content,
                senderChatID: fromID,
                receiverChatID: toID,
                time:time
            });
            chat1.save(function (err, chat) {
                if (err) return console.error(err);
                else{
                    console.log("saved to DB");
                    onMessage(socket,toID,fromID);
                }
              });
               
            });
             
        // Store in database

        // Send message
        // message.status = check_online ? events.STATUS_CODE_MESSAGE_SENT : STATUS_CODE_MESSAGE_NOT_SENT;
        // message.recipientIsOnline = check_online;

        // if(check_online){ 
            // io.sockets.in(toID).emit('receive_message', response);
        // }
    });
    
    // Chat.find(function (err, chats) {
    //     if (err) return console.error(err);
    //     console.log(chats);
    //     io.sockets.in(roomID).emit('receive_message', chats);

    //   });
    
    
    // When the user logs out
    disposeOnDisconnect(socket,roomID);
})

const onMessage = (socket,to_id,from_id) => {
    
    Chat.find(function (err, chats) {
        if (err) return console.error(err);
        console.log(chats);
        io.sockets.in(to_id).emit('receive_message', chats);
        io.sockets.in(from_id).emit('receive_message', chats);

      });
    // console.log("yo out",socket.rooms);
    
    
    // socket.on(events.INDIVIDUAL_CHAT_MESSAGE, (message) => {
    //     individualChatHandler(socket, message);
    // });

    // socket.on(events.GROUP_CHAT_MESSAGE, (message) => {
    //     groupChatHandler(socket, message);
    // });
}


const checkOnline = (roomID) => {
    let temp = rooms.get(roomID);
    // console.log(temp);
    if (temp == undefined || temp.length==0)//if no sockets, then no room
        return false;

    return true;
}

const disposeOnDisconnect = (socket,roomID) => {
    socket.on(events.ON_DISCONNECT, () => {
        
        socket.leave(roomID);
        console.log(`USER DISCONNECTED with socketID ${socket.id}`);
        // socket.removeAllListeners(events.ON_DISCONNECT);
        // if (rooms.size != 0) {
            
        //     for (let [key, value] of rooms) {
        //         // console.log(key, value);
        //         value.forEach((obj) => {
        //             if (obj.socketID == socket.id) {
        //                 let array1 = rooms.get(key);
        //                 array1.pop({
        //                     socketID: socket.id
        //                 });
        //                 if (array1.length == 0) {
        //                     rooms.delete(key); // user is no longer online
        //                     socket.leave(key);
        //                 } else
        //                     rooms.set(key, array1);
        //             }


        //         })
        //     }
        // }



        // console.log(rooms);
        // console.log(`USER REMOVED - TOTAL NO. OF ROOMS ${rooms.size}`);

    });

}

server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});


// const individualChatHandler = (socket, message) => {
//     let toID = message.toID;
//     let fromID = message.fromID;
//     let content = message.content;
//     let toSocketID = getSocketID(toID);

//     let response = {
//         'content': content,
//         'senderID': fromID,
//         'recipientID': toID
//     };

//     // Check if the other person is online
//     let isOnline = (toSocketID == undefined) ? false : true;
//     console.log(`CHAT From-${fromID} To-${toID} is Online-${isOnline} Message-${content}`);

//     // Store in database

//     // Send message
//     message.status = isOnline ? events.STATUS_CODE_MESSAGE_SENT : STATUS_CODE_MESSAGE_NOT_SENT;
//     message.recipientIsOnline = isOnline;
//     sendToSelf(socket, events.MESSAGE_FROM_SERVER, response);

//     if (isOnline == true)
//         sendToOther(socket, events.RECEIVE_MESSAGE, toSocketID, response);
// }

// const groupChatHandler = (socket, message) => {
//     socket.join(message.group);
//     // Will implement after the individual chat works
//     // Something of this sort
//     //sendToAll(socket, event.GROUP_CHAT_MESSAGE, group, content);
//     socket.leave(message.group);
// }

// const sendToSelf = (socket, event, message) => {
//     socket.emit(event, message);
// }

// const sendToOther = (socket, event, toSocketID, message) => {
//     socket.in(toSocketID).emit(event, message);
// }

// const sendToAll = (socket, event, groupID, message) => {
//     socket.in(groupID).emit(event, message);
// }
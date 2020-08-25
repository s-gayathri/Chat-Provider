
require('dotenv').config();
const express=require('express');
const app=express();
const httpServer =require('http').createServer(app);
const socketio=require('socket.io')(httpServer);

app.get("/",function(req,res){
    res.send("Server up and running");
})
socketio.on("connection",(userSocket)=>{
    console.log("connected");
    userSocket.on("send_message",(data)=>{
        userSocket.broadcast.emit("receive_message",data);
    })
})

httpServer.listen(process.env.PORT || 8080,()=>{
    console.log("server up and running");
});


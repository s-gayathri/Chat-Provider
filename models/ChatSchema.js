const mongoose=require('mongoose');

const chatSchema=new mongoose.Schema({
    receiverChatID:String,
    senderChatID:String,
    content:String,
    time:String,

});
const Chat=mongoose.model('Chat',chatSchema);
module.exports=Chat;
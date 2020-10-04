require('dotenv').config()
const  mongoose  = require("mongoose");
 
const  url  =  "mongodb+srv://"+process.env.USER+":"+process.env.PWD+"@cluster0.a25bs.azure.mongodb.net/chatDB?retryWrites=true&w=majority";
const connect=mongoose.connect(url, { useNewUrlParser: true ,useUnifiedTopology:true});
module.exports=connect;
 
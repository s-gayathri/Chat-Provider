const  mongoose  = require("mongoose");
mongoose.Promise  = require("bluebird");
const  url  =  "mongodb+srv://emily:test987@cluster0.a25bs.azure.mongodb.net/chatDB?retryWrites=true&w=majority";
const connect=mongoose.connect(url, { useNewUrlParser: true ,useUnifiedTopology:true});
module.exports=connect;
 
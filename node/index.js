const express = require('express')
const app = express()

const PORT = process.env.PORT || 5000
const socketIO = require('socket.io')
const cors = require('cors')
const btoa = require('btoa')

var redis = require('redis');
var clientRedis = redis.createClient(); // this creates a new client

//set up app engine and paths
var server = app
  .use(cors()) 
  .listen(PORT, () => console.log(`Listening on ${ PORT }`)) 
  
  
//store user id and username
let cameras = {}
let users = {}
const io = socketIO(server)

const mainSpace = io.of('/');

mainSpace.use((socket, next) => {
  // ensure the user has sufficient rights
  next();
});



//when new connection is established
mainSpace.on('connection',(socket) => {
      console.log("Client connected ==> "+socket.id) 

      socket.on('setname',(name)=>{
          cameras[socket.id] = name
          console.log("Camera sent name "+name)
      })
      
      socket.on('join',(cam)=>{
        socket.join(cam)
        console.log("User joined "+cam+"  "+socket.id)
      })

      socket.on('leave',(cam)=>{
         console.log("LEFT")
         socket.leave(cam)
      })

      socket.on('setuser',(name)=>{
         socket.join(name) 
         console.log("Saved User "+name)
      })

      socket.on('image',(image)=>{
         let camname = cameras[socket.id]
         io.in(camname).emit('image',image)

      })

      socket.on('disconnect',()=>{
          try{
            delete cameras[socket.id]
            socket.leaveAll()
          }catch(e){}
      })

 })

 function _arrayBufferToBase64( buffer ) {
    var binary = '';
    var bytes = new Uint8Array( buffer );
    var len = bytes.byteLength;
    for (var i = 0; i < len; i++) {
        binary += String.fromCharCode( bytes[ i ] );
    }
    return btoa( binary );
}



clientRedis.on('message',(channel,msg)=>{
   if(channel == 'users'){
     console.log("YESES")
     msg = JSON.parse(msg)

     console.log(msg['users'])
     let users = msg['users']   
  
      users.forEach(user =>{
        console.log(user)
        io.in(user).emit('alert',msg['camera'])
      })
     
   }

})

clientRedis.subscribe('users')

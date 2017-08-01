var riot = require('riot')
// var route = require('riot-route')
require('../styles/main.css');

require('../tags/chat.tag')
require('../tags/showtyping.tag')
require('../tags/auth.tag')
require('../tags/name.tag')

// document.addEventListener('DOMContentLoaded', () => 
//     riot.mount('*')
// )

// function cbfunc(tag) { 
//     console.log("callback function.")
//     var req = new XMLHttpRequest()
//     req.open('GET','../test.json',true)
//     req.onload = function(){
//         if(req.status === 200){
//             var data = JSON.parse(req.responseText)
//             tag.trigger('data_loaded', data.people)
//         }
//     }
//     req.send()

//     firebase.database().ref('messages/').on('value', function(snapshot){
//         var currmsgs = snapshot.val()
//         tag.trigger('load_msgs', currmsgs)
//         riot.update()
//     })             
// }

/* ROUTES */

route.stop()
route.start()

route.base('/')

 var routes = {
    Home: function(id, action){
        riot.mount('#view', 'auth')
    },
    Chat: function(id, action){
        riot.mount('#view', 'name')
    }
    // chatroom: function(id, action){
    //     riot.mount('#view', 'chat')
    // }
 }

 function handler(collection, id, action){
    var routeFn = routes[collection || 'Home']; 
    routeFn(id, action)
 }

 route(handler)
 route.exec(handler)

    // router.routes([
    //   new Router.Route({tag: 'users'}).routes([
    //     new Router.Route({tag: 'user', path: '/user/:id'}), // Named paths  
    //   ]),
    //   new Router.DefaultRoute({tag: 'auth'})
    // ])
    // riot.mount('*');
    // router.start();
<chat>
    <div id="info">
        <h1>RiotChat</h1>
        <div>
            <p>Logged in as<p>
            <span>{opts.chatname}<span>
        </div>
    </div>
    <div id="chat">
        <showtyping class={showtyping: type()} whouse={usr}></showtyping> 
        <ul id="chatwindow">
            <li each={m in messages} class={right: mymsg(m.by)}>
                <div>
                    <span class="who">{m.by}</span>
                </div>
                {m.text}
                <div>
                    <span class="time">{m.time}</span>
                </div>
            </li>
            <div id="bottom"></div>
        </ul>
    </div> 
    <div id="msgdiv">
        <input id="msg" type="text" ref="msg" placeholder="Say Something.." onfocus={typing} onblur={nottyping}> 
        <!--  <input type="text" ref="msg" placeholder="Type Your Message" onchange={typing}></input>  -->
        <button id="send" onclick={send}>Send</button>
    </div>
    <script>
        usr = ''
        by = firebase.auth().currentUser
        istyping = false
        itype = false
        user = this.opts.chatname
        messages=[]
        type(){
            return istyping && !itype
        }
        mymsg(email){
            //console.log(email) 
            return email===by.email  
        }
        typing(){
            //user = firebase.auth().currentUser; user.email
            firebase.database().ref('typing').set(true)
            firebase.database().ref('usertyping').set(user)
            itype = true
            this.updatetyping()
        }
        nottyping(){
            firebase.database().ref('typing').set(false)
            itype = false
            this.updatetyping()
        }
        updatetyping(){
            var t = firebase.database().ref('typing')
            var u = firebase.database().ref('usertyping')
            t.on('value', function(snapshot) {
                istyping = snapshot.val()
                riot.update()
            })
            u.on('value', function(snapshot) {
                usr = snapshot.val()
                riot.update()
            });
        }

        send(){
            var d = new Date(),
            h = d.getHours(),
            m = d.getMinutes()
            var t = h+":"+m
    
            nextmsg = {
                id: messages.length,
                text: this.refs.msg.value,
                time: t,
                by: by.email
            }
            messages.push(nextmsg)
            //console.log(messages)
            firebase.database().ref('messages/' + nextmsg.id).set(nextmsg)
            this.refs.msg.value = ''
            
        }

        this.on('mount', function(){
            firebase.database().ref('messages/').on('value', function(snapshot){
                var currmsgs = snapshot.val()
                if(currmsgs != null){ 
                    this.messages = currmsgs
                    //console.log(this.messages.length)
                    riot.update()
                    var div = document.getElementById("bottom")
                    div.scrollIntoView();
                    var height = div.style.clientHeight
                    window.scrollBy(0, height - window.innerHeight);
                }
            })
            /*
            console.log("Test Mounted.")
            opts.callback(this)
            */ 
        })
        /* 
        this.on('data_loaded', function(peeps){
            opts.people = peeps
            this.update()
        })
        */ 
    </script>
</chat>
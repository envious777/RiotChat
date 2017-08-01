<auth>
    <div id="error">
        <p>{errmsg}</p>
    </div>
    <div id="auth" class="scaleupfadein">
        <div class="title">
            <h1>RiotChat</h1>
            <h3>User Login</h3>
        </div>
        <input ref="email" type="email" placeholder="Enter Email" required/>
        <input ref="pwd" type="password" placeholder="Enter Password" required/>
        <div id="btn_grp">
            <button id="su" type="submit" onclick={submit}>New Users</button>
            <button id="si" type="submit" onclick={submit}>Sign In</button>
        </div>
    </div> 

    <script>
        var errorcodes = [
            {
                "code": "auth/invalid-email",
                "msg": "Please Enter a Valid Email Address."
            },
            {
                "code": "auth/email-already-in-use",
                "msg": "This Email is Already In Use."
            },
            {
                "code": "auth/wrong-password",
                "msg": "Invalid Password."
            },
            {
                "code": "auth/user-not-found",
                "msg": "This Account Does Not Exist."
            },
            {
                "code": "auth/weak-password",
                "msg": "Password Should Be At Least 6 Characters"
            }
        ]

        submit(e){
            id = e.target.id
            e.preventDefault()
            e = this.refs.email.value
            p = this.refs.pwd.value
            var obj = document.getElementById("error")
            //console.log(e,p) 
            if(id=="su"){
                firebase.auth().createUserWithEmailAndPassword(e, p).
                then(function(){
                    console.log("Created and Logged In")
                    obj.className+="nodisplay"
                    var d = document.getElementById("auth")
                    d.className += " fadeoutleft"
                    setTimeout(function(){
                        route('Chat', 'Welcome to RiotChat!') 
                    }, 500)
                }).catch(function(err) {
                    console.log("Error Code:"+err.code+" Error Message:"+err.message) 
                    for(i=0; i<errorcodes.length; i++){
                        var o = errorcodes[i]
                        if(o.code==err.code){
                            errmsg = o.msg
                            var o = document.getElementById("error")
                            obj.className = "showerror"
                            riot.update() 
                            setTimeout(function(){
                                obj.className = ""
                            },2000)
                        }
                    }
                })
            }
            else{
                firebase.auth().signInWithEmailAndPassword(e, p).
                then(function(){
                    console.log("Logged In")
                    obj.className+="nodisplay"
                    var d = document.getElementById("auth")
                    d.className += " fadeoutleft"
                    setTimeout(function(){
                        route('Chat', 'Welcome to RiotChat!') 
                    }, 500)
                }).catch(function(err) {
                    console.log("Error Code:"+err.code+" Error Message:"+err.message)
                    for(i=0; i<errorcodes.length; i++){
                        var o = errorcodes[i]
                        if(o.code==err.code){
                            errmsg = o.msg
                            obj.className = "showerror"
                            riot.update() 
                            setTimeout(function(){
                                obj.className = ""
                            },2000)
                        }
                    }
                })
            }
        }

         signin(e){
            e.preventDefault()
            var e = this.refs.email.value
            var p = this.refs.pwd.value
            var obj = document.getElementById("error")

            //console.log(e,p)
        } 

    </script>
</auth>

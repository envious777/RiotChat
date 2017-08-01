<name>
    <div id="name">
        <div class="title">
                <h1>RiotChat</h1>
                <h3>Please Enter Your Chat Name</h3>
        </div>
        <input type="text" ref="name" required/>
        <button type="submit" onclick={go}>Submit</button>
    </div>

    <script>
        go(e){
            e.preventDefault()
            var n = this.refs.name.value
            var d = document.getElementById("name")
            d.className += " fadeoutleft"
            setTimeout(function(){  
                riot.mount('#view', 'chat', {chatname: n})
                document.getElementById("msg").addEventListener("keydown", function(e) {
                    if(e.keyCode == 13) {
                        console.log("ENTER PRESSED")
                        document.getElementById("send").click();
                    }
                })
            }, 500)
        }
    </script>
</name>
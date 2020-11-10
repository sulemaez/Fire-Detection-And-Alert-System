<template>
  <div class="login card p-4">

      <div class="card-body card-block">
        <form  name="login">
          <div class="form-group">
              <small class="text-danger">{{ loginError }}</small>
          </div>
          <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon"><i class="fa fa-envelope"></i></div>
              <input  name="email" placeholder="email" class="form-control" v-model="email">
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
              <div class="input-group-addon"><i class="fa fa-asterisk"></i></div>
              <input type="password" id="password" name="password" placeholder="Password" class="form-control" v-model="password">
            </div>
          </div>
          <div class="form-actions form-group">
              <button type="submit" class="btn btn-success btn-md" @click="login"  >Log In</button>
          </div>
        </form>
      </div>

  </div>
</template>

<script>
export default {
  name: 'Login',
  data(){
     return{
         loginError : "",
         email : "",
         password : ""
     }
  },
  methods : {
    login(event){
       event.preventDefault();
       this.loginError = ""
       if(this.email == "" || this.password == ""){
         this.loginError = "Please enter email and password !"
         return
       }
       
       this.$store.commit('setLoading',true) 
       this.$http.post(`${this.$baseUrl}authenticate`,{
          email : this.email.trim(),
          password : this.password.trim() 
       })
       .then((data) => {
          this.$store.commit('setLoading',false) 
          this.$store.dispatch('setLoggedIn',data.data.token)
          this.$router.push("/")
       }).catch((err) => {
           console.log(err)
           this.loginError = "Invalid credential !"
           this.$store.commit('setLoading',false)  
       });

      
      
    }
  }
}
</script>

<style lang="scss" scoped>
  .card-title{
    padding-left: 20px;
  }
</style>
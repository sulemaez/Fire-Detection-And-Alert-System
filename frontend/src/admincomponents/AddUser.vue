<template>
    <div class="d-flex justify-content-center">
        <div class="col-md-6">
             <div class="card">
                <div class="card-header">
                    <strong>Add User</strong>
                </div>

                <div class="card-body card-block">
                    <form @submit.prevent="onSubmit" class="form-horizontal">
                        <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">Name :</label></div>
                            <div class="col-12 col-md-9">
                                <input v-model="name" class="form-control" type="text">
                                <small class="text-danger">{{ nameError }}</small>
                            </div>
                        </div>
                           <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">User Name :</label></div>
                            <div class="col-12 col-md-9">
                                <input v-model="username" class="form-control" type="text">
                                <small class="text-danger">{{ usernameError }}</small>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">Phone :</label></div>
                            <div class="col-12 col-md-9">
                                <input v-model="phone" class="form-control" type="text">
                                <small class="text-danger">{{ phoneError }}</small>
                            </div>
                        </div>

                        <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">Email :</label></div>
                            <div class="col-12 col-md-9">
                                <input v-model="email" class="form-control" type="text">
                                <small class="text-danger">{{ emailError }}</small>
                            </div>
                        </div>
                        
                        <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">Type :</label></div>
                            <div class="col-12 col-md-9">
                                <select class="form-control" id="userType" v-model="typeId">
                                    <option  v-for="userType in userTypes" :value="userType.id" >{{ userType.name }}</option>
                                </select>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col col-md-3"><label class=" form-control-label">Admin :</label></div>
                            <div class="col-12 col-md-9">
                                <input  class="form-control-inline" type="radio" value="true" v-model="admin"> 
                                <label  for="">Yes</label>
                                <input  class="form-control-inline" type="radio" value="false" v-model="admin">    
                                <label  for="">No</label>
                            </div>
                        </div>
                        <div class="col-md-12 d-flex justify-content-center">
                            <button class="btn btn-primary w-25">ADD</button>
                        </div>
                    </form>
                </div>
             </div>   
        </div>

        
    </div>
</template>  

<script>
export default {
    data (){
        return{
            name : "",
            phone : "",
            email : "",
            edit : false,
            admin : false, 
            username : "",
            typeId : "",
            userTypes : [ ],    
            nameError : "",
            phoneError : "",
            emailError : "",
            usernameError : ""
        }
    },
    methods : {
         onSubmit(){     
     
            //validate
            this.checkErrorMessages() 
            if(!this.formReady){
                return
            }
           
            let data = {
                name :  this.name,
                phone : this.phone,
                email : this.email,
                admin : this.admin,
                typeId : document.getElementById("userType").value,
                username : this.username
            }
             this.$store.dispatch('setLoading',true)
         
           if(!this.edit){
                 this.$http.post(`${this.$apiUrl}/users`,data)
                .then(data=>{
                    this.$store.commit('setLoading', false)
                this.$swal.fire(
                        ``,
                        `Added Successfully !`,
                        'success'
                    )
                    this.clear()
                }) 
                .catch(err => {
                    this.$store.commit('setLoading', false)
                    this.$swal.fire(
                        ``,
                        `${err.response.data.message}`,
                        'error'
                    )
                
                })
           }else{
                this.$http.put(`${this.$apiUrl}/users/${this.$route.query.edit}`,data)
                .then(data=>{
                    this.$store.commit('setLoading', false)
                    this.$swal.fire(
                        ``,
                        `Edited Successfully !`,
                        'success'
                    )
        
                }) 
                .catch(err => {
                    this.$store.commit('setLoading', false)
                    this.$swal.fire(
                        ``,
                        `${err.response.data.message}`,
                        'error'
                    )
                
                })
           }

       },
       checkErrorMessages(){
            console.log("check erros")
            this.nameError =  this.name.trim() == "" ?  "Please add a name" : ""
            this.phoneError = this.phone.trim() == "" ? "Please add a phone number" : ""
            this.emailError = this.email.trim() == "" ?  "Please add an email" : ""
            this.usernameError = this.usernameError.trim() == "" ? "Please add username" : ""
       },
       clear(){
            this.name = ""
            this.phone = ""
            this.email = ""
            this.username = ""
       },  
       
       getUserTypes(){
           this.$http.get(`${this.$apiUrl}/usertypes`)
           .then(data =>{ 
              this.userTypes = data.data._embedded.usertypes
            })
           .catch(e => {
              this.$swal.fire(
                 ``,
                 `${err.response.data.error}`,
                 'error'
             )
          })  
       },

    },
    computed : {
        formReady(){
            return this.nameError.length == 0 && this.phoneError.length == 0 && this.emailError == 0
        },
        
    },
    mounted(){
        this.getUserTypes()
  
        if(this.$route.query.edit != undefined){
            this.edit = true

            this.$http.get(`${this.$apiUrl}/users/${this.$route.query.edit}`)
            .then(data =>{ 
                let user = data.data
                this.name = user.name
                this.phone = user.phone
                this.email = user.email
                this.admin = user.admin
                this.typeId = user.typeId

             })
            .catch(e => {
                this.$swal.fire(
                    ``,
                    `${err.response.data.error}`,
                    'error'
                )
            })  
            
        }
    }

}
</script>
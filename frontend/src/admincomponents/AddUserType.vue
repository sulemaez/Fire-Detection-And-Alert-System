<template>
    <div class="d-flex justify-content-center">
        <div class="col-md-6">
             <div class="card">
          <div class="card-header">
            <strong>{{ edit ? 'Edit' : 'Add' }}  User Type</strong>
          </div>

          <div class="card-body card-block">
             <form @submit.prevent="onSubmit" class="form-horizontal">
                 <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Name :</label></div>
                      <div class="col-12 col-md-9">
                          <input  class="form-control" type="text" v-model="name">
                          <small class="text-danger">{{ nameError }}</small>
                      </div>
                 </div>
                 <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Description :</label></div>
                      <div class="col-12 col-md-9">
                          <textarea class="form-control" cols="30" rows="10" v-model="description"></textarea>
                          <small class="text-danger">{{ descriptionError }}</small>
                      </div>
                 </div>

                 <div class="col-md-12 d-flex justify-content-center">
                    <button class="btn btn-primary w-25">{{ edit ? 'Edit' : 'Add' }} </button>
                 </div>
             </form>
          </div>
        </div>   
        </div>
    </div>
</template>  


<script>
export default {
    data(){
        return {
            name : "",
            description : "",
            descriptionError : "",
            nameError : "",
            edit : true
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
                name : this.name,
                description : this.description
            }
      
            if(!this.edit){
                this.$http.post(`${this.$apiUrl}/usertypes`,data)
                .then(data=>{
                    this.$swal.fire(
                        ``,
                        `Added Successfully !`,
                        'success'
                    )
                    this.clear()
                }) 
                .catch(err => {
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
                })
            }else{
                    this.$http.put(`${this.$apiUrl}/usertypes/${this.$route.query.edit}`,data)
                    .then(data=>{
                        this.$swal.fire(
                            ``,
                            `Edit Successfully !`,
                            'success'
                        )
                        this.clear()
                    }) 
                    .catch(err => {
                        this.$swal.fire(
                            ``,
                            `${err.response.data.error}`,
                            'error'
                        )
                    })
            }

       },
       checkErrorMessages(){
           this.nameError = this.name.trim() == "" ?  "Please add a name" : ""
           this.descriptionError = this.description.trim() == "" ?  "Please add a description" : ""
       },
       clear(){
           this.name = ""
           this.description = ""
           this.descriptionError = ""
           this.nameError = ""
       }
    },
    computed : {
        formReady(){
            return this.nameError.length == 0 && 
            this.descriptionError.length == 0
        }
    },
    mounted(){
        if(this.$route.query.edit != undefined){
            this.edit = true

            this.$http.get(`${this.$apiUrl}/usertypes/${this.$route.query.edit}`)
            .then(data =>{ 
                let usertype = data.data
                this.name = usertype.name
                this.description = usertype.description
                
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
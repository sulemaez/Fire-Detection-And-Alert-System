<template>
    <div class="d-flex justify-content-center">
        <div class="col-md-6">
             <div class="card">
          <div class="card-header">
            <strong>{{ edit ? 'Edit' : 'Add' }}  Location</strong>
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
                      <div class="col col-md-3"><label class=" form-control-label">Main Location:</label></div>
                      <div class="col-12 col-md-9">
                           <select id="mainLocationSelect" class="form-control">
                               <option v-for="mainLocation in mainLocations" :value="mainLocation.id" :selected="mainLocation.id == mainLocationId">{{ mainLocation.name }}</option>
                           </select>
                            <small class="text-danger">{{ mainLocationError }}</small>
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
            nameError : "",
            mainLocations : [],
            mainLocationError : "",
            mainLocationId : "",
            edit : false
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
                mainLocationId : document.getElementById("mainLocationSelect").value
            }
      
            if(!this.edit){
                this.$http.post(`${this.$apiUrl}/locations`,data)
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
                 this.$http.put(`${this.$apiUrl}/locations/${this.$route.query.edit}`,data)
                .then(data=>{
                this.$swal.fire(
                        ``,
                        `Edited Successfully !`,
                        'success'
                    )
              
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
           let loc = document.getElementById("mainLocationSelect").value

           this.mainLocationError = loc == undefined || loc.trim() == "" ? "Please select main locatin" : "" 
       },
       clear(){
            this.name = ""
            this.nameError = ""
            this.mainLocationError = ""
       },
       getMainLocations(){
           this.$http.get(`${this.$apiUrl}/mainlocations`)
                .then(data =>{ 
                    let  locations = data.data._embedded.mainlocations
                    this.mainLocations = locations

                    if(locations.length == 0 ){
                        this.$swal.fire(
                            ``,
                            `No Main Locations available , Please add to continue`,
                            'info'
                         )
                    }
                })
             .catch(err => { 
                this.$swal.fire(
                    ``,
                    `${err.response.data.error}`,
                    'error'
                )
             } )
       }
    },
 
    computed : {
        formReady(){
            return this.nameError.length == 0 && this.mainLocationError.length == 0
        }
    },
    mounted(){
         this.getMainLocations()
         if(this.$route.query.edit != undefined){
            this.edit = true

            this.$http.get(`${this.$apiUrl}/locations/${this.$route.query.edit}`)
            .then(data =>{ 
                let location = data.data
                this.name = location.name
                this.mainLocationId = location.mainLocationId
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
<template>
   <div>
         <h3 class="text-center mb-4">EMERGENCY DETECTION SYSTEM</h3>
         <div class="pt-4 row justify-content-center">

             <div class="col-md-5">
                  <div class="card" style="width: 25rem;">
                        <div class="card-body">
                        <h5 class="card-title">CAMERAS</h5>
                        <p class="card-text">{{ cameras }}</p>
                        </div>
               </div>
             </div>

             <div class="col-md-5">
                  <div class="card" style="width: 25rem;">
                        <div class="card-body">
                        <h5 class="card-title">EMERGENCIES DETECTED</h5>
                        <p class="card-text">{{ emergencies }}</p>
                        </div>
               </div>
             </div>

             <div class="col-md-5">
                  <div class="card" style="width: 25rem;">
                        <div class="card-body">
                        <h5 class="card-title">LOCATIONS PRESENT</h5>
                        <p class="card-text">{{ locations }}</p>
                        </div>
               </div>
             </div>

                <div class="col-md-5">
                  <div class="card" style="width: 25rem;">
                        <div class="card-body">
                        <h5 class="card-title">USERS</h5>
                        <p class="card-text">{{ users }}</p>
                        </div>
               </div>
             </div>


         </div>
   </div>
</template>    


<script>
export default{
      data (){
        return{
            cameras : 0,
            locations : 0,
            emergencies : 0,
            users : 0
        }
    },
     methods : {
            getCameras(){
              this.$http.get(`${this.$apiUrl}/cameras`)
              .then(data =>{ 
                   this.cameras = data.data._embedded.cameras.length
               })
              .catch(err => { 
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
              })
       }   ,
         getEmergencies(){
              this.$http.get(`${this.$apiUrl}/emergencies`)
              .then(data =>{ 
                   this.emergencies = data.data._embedded.emergencies.length
               })
              .catch(err => { 
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
              })
         },
               getLocations(){
                this.$http.get(`${this.$apiUrl}/locations`)
                .then(data =>{ 
                    this.locations = data.data._embedded.locations.length
                    
                })
                .catch(err => { 
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
                })
            },
              getUsers(){
                this.$http.get(`${this.$apiUrl}/users`)
                .then(data =>{ 
                    this.users = data.data._embedded.users.length
                    
                })
                .catch(err => { 
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
                })
            },
    },
    mounted(){
        this.getCameras()
        this.getEmergencies()
        this.getLocations()
        this.getUsers()
    }

}
</script>

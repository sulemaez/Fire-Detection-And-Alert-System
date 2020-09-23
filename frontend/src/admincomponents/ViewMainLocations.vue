
<template>
    <div class="col-md-12">
        <card header-text="User Types">
          <div class="table-responsive">
            <table class="table table-striped first-td-padding">
              <thead>
              <tr>
                <td>#</td>
                <td>Name</td>
               
                <td>
                    <i class="fa fa-cogs"></i>
                </td>
              </tr>
              </thead>

              <tbody>
                    <tr v-for="(cam,index) in locations">
                        <td>{{ index + 1 }}</td>
                        <td>{{ cam.name }}</td>
                    
                        <td>
                            <div class="row">
                                <div class="col-12">
                                    <button @click="edit(cam.id)" class="btn btn-primary w-75">
                                        <i class="fa fa-pencil"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="row mt-1">
                                <div class="col-12">
                                    <button @click="deleteLocation(cam.id)" class="btn btn-danger w-75">
                                        <i class="fa fa-close"></i>
                                    </button>
                                </div>
                            </div>
                        </td>
                    </tr>
              </tbody>
            </table>
          </div>
        </card>
      
    </div>
</template>


<script>
    export default {
        data (){
            return{
                locations : [] 
            }
        },
        methods : {
           edit(id){
               this.$router.push({ path: 'addmainlocation', query: { edit : id } })
           },
           deleteLocation(id){
                    this.$http.delete(`${this.$apiUrl}/mainlocations/${id}`)
                    .then( data => {
                        this.$swal.fire(
                                ``,
                                `Deleted Successfully !`,
                                'success'
                            )
                            this.getLocations()
                    })
                    .catch( err => {
                        this.$swal.fire(
                                ``,
                                `${err.response.data.error}`,
                                'error'
                            )
                    })
           },
           getLocations(){
               this.locations = []
               this.$http.get(`${this.$apiUrl}/mainlocations`)
                .then(data =>{ 
                    let  locations = data.data._embedded.mainlocations
                    this.locations = locations
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
        mounted(){
            this.getLocations()
        }

    }
</script>
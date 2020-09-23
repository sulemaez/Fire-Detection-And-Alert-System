
<template>
    <div class="col-md-12">
        <card header-text="User Types">
          <div class="table-responsive">
            <table class="table table-striped first-td-padding">
              <thead>
              <tr>
                <td>#</td>
                <td>Name</td>
                <td>Location</td>
                <td>
                    <i class="fa fa-cogs"></i>
                </td>
              </tr>
              </thead>

              <tbody>
                    <tr v-for="(cam,index) in cameras">
                        <td>{{ index + 1 }}</td>
                        <td>{{ cam.name }}</td>
                        <td>{{ locations[cam.locationId] }}</td> 
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
                                    <button @click="deleteCam(cam.id)" class="btn btn-danger w-75">
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
            cameras : [],
            locations : {}
        }
    },
    methods:{
       getLocations(){
           this.$http.get(`${this.$apiUrl}/locations`)
              .then(data =>{ 
                   data.data._embedded.locations.forEach(location => {
                       this.locations[location.id] = location.name
                   })
                   this.getCameras()
               })
              .catch(err => { 
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
              })
       },
       edit(id){
           this.$router.push({ path: 'addcamera', query: { edit : id } })
       },
       deleteCam(id){
           this.$http.delete(`${this.$apiUrl}/cameras/${id}`)
                .then( data => {
                    this.$swal.fire(
                            ``,
                            `Deleted Successfully !`,
                            'success'
                        )
                        this.getCameras()
                })
                .catch( err => {
                    this.$swal.fire(
                            ``,
                            `${err.response.data.error}`,
                            'error'
                        )
                })
       },
       getCameras(){
              this.$http.get(`${this.$apiUrl}/cameras`)
              .then(data =>{ 
                   this.cameras = data.data._embedded.cameras
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

<template>
    <div class="col-md-12">
        <card header-text="User Types">
          <div class="table-responsive">
            <table class="table table-striped first-td-padding">
              <thead>
              <tr>
                <td>#</td>
                <td>Name</td>
                <td>County</td>
                <td>
                    <i class="fa fa-cogs"></i>
                </td>
              </tr>
              </thead>

              <tbody>
                    <tr v-for="(location,index) in locations">
                        <td>{{ index + 1 }}</td>
                        <td>{{ location.name }}</td>
                        <td>{{ counties[location.countyId] }}</td>
                        <td>
                            <div class="row">
                                <div class="col-12">
                                    <button @click="edit(location.id)" class="btn btn-primary w-75">
                                        <i class="fa fa-pencil"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="row mt-1">
                                <div class="col-12">
                                    <button@click="deleteLocation(location.id)" class="btn btn-danger w-75">
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
                locations : [] ,
                counties : {} ,
                
            }
        },
        methods : {
            getcounties(){
              this.$http.get(`${this.$apiUrl}/counties`)
              .then(data =>{ 
                    let  locations = data.data._embedded.counties
                    locations.forEach(location => {
                         this.counties[location.id] = location.name
                         console.log()
                    })

                    this.getLocations()
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
                    let  locations = data.data._embedded.locations
                    this.locations = locations
                    
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
               this.$router.push({ path: 'addlocation', query: { edit : id } })
            },
            deleteLocation(id){
                  this.$http.delete(`${this.$apiUrl}/locations/${id}`)
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
            }
        },
        mounted(){
            this.getcounties()
            
        }

    }
</script>
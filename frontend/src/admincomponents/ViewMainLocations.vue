
<template>
    <div class="col-md-12">
        <card header-text="User Types">
          <div class="table-responsive">
            <table class="table table-striped first-td-padding">
              <thead>
              <tr>
                <td>#</td>
                <td>Name</td>
                <td>Coordinates</td>
                <td>
                    <i class="fa fa-cogs"></i>
                </td>
              </tr>
              </thead>

              <tbody>
                    <tr v-for="(cam,index) in locations">
                        <td>{{ index + 1 }}</td>
                        <td>{{ cam.name }}</td>
                        <td>{{ cam.coordinates }}</td> 
                        <td>
                            <div class="row">
                                <div class="col-12">
                                    <button class="btn btn-primary w-75">
                                        <i class="fa fa-pencil"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="row mt-1">
                                <div class="col-12">
                                    <button class="btn btn-danger w-75">
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

        },
        mounted(){
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
             } )
        }

    }
</script>

<template>
    <div class="col-md-12">
        <card header-text="User Types">
          <div class="table-responsive">
            <table class="table table-striped first-td-padding">
              <thead>
              <tr>
                <td>#</td>
                <td>Name</td>
                <td>Description</td>
                <td>
                    <i class="fa fa-cogs"></i>
                </td>
              </tr>
              </thead>

              <tbody>
                    <tr v-for="(type,index) in types">
                        <td>{{ index + 1 }}</td>
                        <td>{{ type.name }}</td>
                        <td>{{ type.description }}</td> 
                        <td>
                            <div class="row">
                                <div class="col-12">
                                    <button @click="edit(type.id)" class="btn btn-primary w-75">
                                        <i class="fa fa-pencil"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="row mt-1">
                                <div class="col-12">
                                    <button @click="deleteType(type.id)" class="btn btn-danger w-75">
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
            types: [ ],    
        }
    },
    methods : {
       edit(id){
          this.$router.push({ path: 'addusertypes', query: { edit : id } })
       },
       deleteType(id){
           this.$http.delete(`${this.$apiUrl}/usertypes/${id}`)
                    .then( data => {
                        this.$swal.fire(
                                ``,
                                `Deleted Successfully !`,
                                'success'
                            )
                            this.getUserTypes()
                    })
                    .catch( err => {
                        this.$swal.fire(
                                ``,
                                `${err.response.data.error}`,
                                'error'
                            )
                    })
       },

       getUserTypes(){
            this.types = []
            
            this.$http.get(`${this.$apiUrl}/usertypes`)
            .then(data =>{ 
                let types = data.data._embedded.usertypes;
                this.types = types;
            })
            .catch(e => {
                this.$swal.fire(
                    ``,
                    `${err.response.data.error}`,
                    'error'
                )
            })
       }
    },
    mounted(){
       this.getUserTypes()
    }

}
</script>
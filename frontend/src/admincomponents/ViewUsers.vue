<template>
    <div class="col-md-12">
        <card header-text="Users">
          <div class="table-responsive">
            <table class="table table-striped first-td-padding">
              <thead>
              <tr>
                <td>Name</td>
                <td>Phone</td>
                <td>Email</td>
                <td>User Type</td>
                <td>Admin</td>
                <td>
                    <i class="fa fa-cogs"></i>
                </td>
              </tr>
              </thead>

              <tbody>
                    <tr v-for="(user,index) in users" :key="index">
                        <td>{{ user.name }}</td>
                        <td>{{ user.phone }}</td> 
                        <td>{{ user.email }}</td> 
                        <td>{{ userTypes[user.typeId] }}</td>
                        <td>{{ user.admin }}</td>
                        <td>
                            <div class="row">
                                <div class="col-12">
                                    <button @click="editUser(user.id)" class="btn btn-primary w-75">
                                        <i class="fa fa-pencil"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="row mt-1">
                                <div class="col-12">
                                    <button @click="deleteUser(user.id)" class="btn btn-danger w-75">
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

       <div class="modal" id="editModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Modal body text goes here.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary">Save changes</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
       </div>
    </div>
</template>



<script>
export default {
    data (){
        return{
            users: [ ],
            userTypes : {}
        }
    },
    methods : {
        editUser(id){
            this.$router.push({ path: 'adduser', query: { edit : id } })
        },
        deleteUser(id){
            this.$http.delete(`${this.$apiUrl}/users/${id}`)
            .then( data => {
                  this.$swal.fire(
                        ``,
                        `Deleted Successfully !`,
                        'success'
                    )
                    this.getUsers()
             })
             .catch( err => {
                  this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
             })

        }
       ,getUserTypes(){
           this.$http.get(`${this.$apiUrl}/usertypes`)
        .then(data =>{ 
            data.data._embedded.usertypes.forEach(type => {
                this.userTypes[type.id] = type.name
            });
        })
        .catch(e => {
             this.$swal.fire(
                ``,
                `${err.response.data.error}`,
                'error'
            )
         } )
       },
       getUsers(){
            this.users = []
            this.$http.get(`${this.$apiUrl}/users`)
            .then(data =>{ 
                let  users = data.data._embedded.users
                this.users = users
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
        this.getUserTypes()
        this.getUsers()
    }
}
</script>

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
                    <tr v-for="user in users">
                        <td>{{ user.name }}</td>
                        <td>{{ user.phone }}</td> 
                        <td>{{ user.email }}</td> 
                        <td>{{ user.userType }}</td>
                        <td>{{ user.admin }}</td>
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
            users: [
                { 
                    name : "Tom Hanks",
                    phone : "0723293609",
                    email : "steve.oyeyo@gmail.com",
                    userType : "Ploice",
                    admin : true
                },
                { 
                    name : "Tom Hanks",
                    phone : "0723293609",
                    email : "steve.oyeyo@gmail.com",
                    userType : "Ploice",
                    admin : true
                },
                { 
                    name : "Tom Hanks",
                    phone : "0723293609",
                    email : "steve.oyeyo@gmail.com",
                    userType : "Ploice",
                    admin : true
                },
                { 
                    name : "Tom Hanks",
                    phone : "0723293609",
                    email : "steve.oyeyo@gmail.com",
                    userType : "Ploice",
                    admin : true
                },
                { 
                    name : "Tom Hanks",
                    phone : "0723293609",
                    email : "steve.oyeyo@gmail.com",
                    userType : "Ploice",
                    admin : true
                }
            ]    
        }
    }
}
</script>

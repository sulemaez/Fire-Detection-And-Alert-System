
<template>
    <div class="col-md-12">
        <card header-text="Emergencies">
          <div class="table-responsive">
            <table class="table table-striped first-td-padding">
              <thead>
              <tr>
                <td>#</td>
                <td>Type</td>
                <td>Location</td>
                <td>Date</td>
                <td>
                    <i class="fa fa-cogs"></i>
                </td>
              </tr>
              </thead>

              <tbody>
                    <tr v-for="(em ,index) in emergencies">
                        <td>{{ index + 1 }}</td>
                        <td>{{ em.type }}</td>
                        <td>{{ em.location }}</td>
                        <td>{{ em.date }}</td> 
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
            emergencies : [
                { 
                    type : "Fire",
                    location : "Koinange",
                    date : "21st May 2020 20:18"
                },
                
            ]    
        }
    }
}
</script>

<template>
    <div class="col-md-12">
        <card header-text="Emergencies">
          <div class="table-responsive">
            <div clas s="row ">
               <div class="col-md-6 mb-3">
                  <label> FILTER : </label>
               </div>
               <div class="col-md-6">
                   <input type="text" class="form-control" v-model="filter"  v-on:keyup="keyUp" >
               </div>
            </div>        
            <table class="table table-striped first-td-padding">
              <thead>
              <tr>
                <td>#</td>
                <td>Location</td>
                <td>County</td>
                <td>Date</td> 
              </tr>
              </thead>

              <tbody>
                    <tr v-for="(em ,index) in emergenciesList">
                        <td>{{ index + 1 }}</td>
                        <td>{{ locate(em.locationId).name }}</td>
                        <td>{{ locateCounty(em.locationId) }}</td>
                        <td>{{ new Date(em.time).toString() }}</td> 
                    
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
            emergencies : [],
            locations : {},
            counties : {},
            emergenciesList : [],
            filter : ""
        }
    },
    methods:{
          getCounties(){
           this.$http.get(`${this.$apiUrl}/counties`)
              .then(data =>{ 
                   data.data._embedded.counties.forEach(county => {
                       this.counties[county.id] = county.name
                   })
                   console.log(this.counties)
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
                   data.data._embedded.locations.forEach(location => {
                       this.locations[location.id] = location
                   })
                           
                 this.getEmergencies()
               })
              .catch(err => { 
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
              })
       },
       getEmergencies(){
              this.$http.get(`${this.$apiUrl}/emergencies`)
              .then(data =>{ 
                   this.emergencies = data.data._embedded.emergencies
                   this.emergenciesList = this.emergencies
               })
              .catch(err => { 
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )
              })
       },
        locate(id){
           return this.locations[id];
        },
          locateCounty(id){
           let l =  this.locations[id];
           return this.counties[l.countyId]
        },
        keyUp(){
            
           if(this.filter.trim() != ""){
                this.emergenciesList = []
                this.emergencies.forEach(em => {
                    if(this.locate(em.locationId).name.toLowerCase().includes(this.filter.toLowerCase()) || 
                    this.locateCounty(em.locationId).toLowerCase().includes(this.filter.toLowerCase())
                     || new Date(em.time).toString().toLowerCase().includes(this.filter.toLowerCase())
                    ){
                        this.emergenciesList.push(em)
                    }
                })
           }else{
               this.emergenciesList = this.emergencies
           }
        }
    },
    
    mounted(){
        this.getCounties()

    }
}    
</script>
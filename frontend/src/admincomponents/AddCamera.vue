<template>
    <div class="d-flex justify-content-center">
        <div class="col-md-6">
             <div class="card">
          <div class="card-header">
            <strong>{{ edit ? 'Edit' : 'Add' }}  camera</strong>
          </div>

          <div class="card-body card-block">
             <form @submit.prevent="onSubmit"  class="form-horizontal">

                    <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Name :</label></div>
                      <div class="col-12 col-md-9">
                         <input  class="form-control" type="text" v-model="name">
                          <small class="text-danger">{{ nameError }}</small>
                      </div>
                      
                 </div>
                <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">County :</label></div>
                      <div class="col-12 col-md-9">
                           <select @change="countyChanged" id="countieselect" class="form-control">
                               <option v-for="county in counties" :value="county.id" >{{ county.name }}</option>
                           </select>
                      </div>
                 </div>

              

                 <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Location:</label></div>
                      <div class="col-12 col-md-9">
                           <select  id="locationSelect" class="form-control">
                               <option v-for="location in locations" :value="location.id" >{{ location.name }}</option>
                           </select>
                          <small class="text-danger">{{ locationError }}</small>
                      </div>
                 </div>
                
                <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Lat :</label></div>
                      <div class="col-12 col-md-9">
                         <input  class="form-control" type="text" v-model="latValue">
                         <small class="text-danger">{{ latError }}</small>
                      </div>
                 </div>

                 <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label"> Long :</label></div>
                      <div class="col-12 col-md-9">
                         <input  class="form-control" type="text" v-model="longValue">
                          <small class="text-danger">{{ longError }}</small>
                      </div>
                 </div>
                 

                 <div class="col-md-12 d-flex justify-content-center">
                    <button class="btn btn-primary w-25">{{ edit ? 'Edit' : 'Add' }} </button>
                 </div>
             </form>
          </div>
        </div>   
        </div>
    </div>
</template>  

<script>
export default {
    data(){
        return {
            name : "",
            longValue : "",
            latValue : "",
            nameError : "",
            longError : "",
            latError : "",
            locationError : "",
            counties : [],
            locations : [],
            locationsStore : {},
            edit : false,
            // default to Montreal to keep it simple
            // change this to whatever makes sense
            center: { lat: 45.508, lng: -73.587 },
            marker : {lat: 45.508, lng: -73.587}
        }
    },
    methods : {
       setMarker(place){
         alert(JSON.stringify(place))
       },
       onSubmit(){
         
            //validate
            this.checkErrorMessages() 
            if(!this.formReady){
                return
            }
           
           let data = {
                name : this.name,
                coordinates : `${this.latValue},${this.longValue}`,
                locationId : document.getElementById("locationSelect").value,
            }
            this.$store.commit('setLoading', true)
            if(this.edit){
        
                this.$http.put(`${this.$apiUrl}/cameras/${this.$route.query.edit}`,data)
                .then(data=>{
                    this.$store.commit('setLoading', false)
                this.$swal.fire(
                        ``,
                        `Edited Successfully !`,
                        'success'
                    )
                    this.clear()
                    
                }) 
                .catch(err => {
                    this.$store.commit('setLoading', false)
                    this.$swal.fire(
                        ``,
                        `${err.response.data.error}`,
                        'error'
                    )

                
                })
                return
            }

            this.$http.post(`${this.$apiUrl}/cameras`,data)
            .then(data=>{
                this.$store.commit('setLoading', true)
               this.$swal.fire(
                    ``,
                    `Added Successfully !`,
                    'success'
                )
                this.clear()
            }) 
            .catch(err => {
                this.$store.commit('setLoading', false)
                this.$swal.fire(
                    ``,
                    `${err.response.data.error}`,
                    'error'
                )
            
            })

       },
       checkErrorMessages(){
           this.nameError = this.name.trim() == "" ?  "Please add a name" : ""
           this.longError = this.longValue.trim() == "" ?  "Please add longitude" : ""
           this.latError = this.latValue.trim() == "" ?  "Please add Y latitude" : ""
           let loc = document.getElementById("locationSelect").value
           this.locationError = loc == undefined || loc.trim() == "" ? "Please select location" : "" 

           if(isNaN(this.longValue)){
               this.longError = "Enter a valid coordinate"
           }

           if(isNaN(this.latValue)){
               this.latError = "Enter a valid coordinatez"
           }
       },
       clear(){
            this.name = ""
            this.longValue = ""
            this.latValue = ""
            this.nameError = ""
            this.longError = ""
            this.latError = ""
            this.locationError = ""
       },
       getcounties(){
           this.$http.get(`${this.$apiUrl}/counties`)
                .then(data =>{ 
                    let  locations = data.data._embedded.counties
                    this.counties = locations

                    if(locations.length == 0 ){
                        this.$swal.fire(
                            ``,
                            `No Main Locations available , Please add to continue`,
                            'info'
                         )
                         return
                    }

                    locations.forEach(location => {
                        this.getLocation(location.id)
                    })

                    

                })
             .catch(err => { 
                this.$swal.fire(
                    ``,
                    `${err.response.data.error}`,
                    'error'
                )
             } )
       },
       countyChanged(){
           
            let id = document.getElementById("countieselect").value.trim()
            
            this.locations = this.locationsStore[id]
            console.log(this.locationsStore[id])
       },
       getLocation(countyId){
            this.$http.get(`${this.$apiUrl}/locations/search/findAllByCountyId?countyId=${countyId}`)
                .then(data =>{ 
                    let  locations = data.data._embedded.locations
                    this.locationsStore[countyId] = locations
                    this.locations = this.locationsStore[this.counties[0].id]
                })
              .catch(err => { 
                   console.log("ERRRR")
                   this.locationsStore[countyId] = []
               })
       }
    },
    computed : {
        formReady(){
            return this.nameError.length == 0 && 
            this.longError.length == 0 && this.latError.length == 0
        }
    },
    mounted(){
       this.getcounties()
       
       if(this.$route.query.edit != undefined){
            this.edit = true

            this.$http.get(`${this.$apiUrl}/cameras/${this.$route.query.edit}`)
            .then(data =>{ 
                let location = data.data
                this.name = location.name
                this.countyId = location.countyId
                this.longValue = location.coordinates.split(',')[0]
                this.latValue = location.coordinates.split(',')[1]
             })
            .catch(e => {
                this.$swal.fire(
                    ``,
                    `${err.response.data.error}`,
                    'error'
                )
            })  
        }
        console.log(this.$refs)



    }
}
</script>
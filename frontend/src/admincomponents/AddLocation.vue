<template>
    <div class="d-flex justify-content-center">
        <div class="col-md-6">
             <div class="card">
          <div class="card-header">
            <strong>Add Location</strong>
          </div>

          <div class="card-body card-block">
             <form @submit.prevent="onSubmit" class="form-horizontal">
                 <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Name :</label></div>
                      <div class="col-12 col-md-9">
                         <input  class="form-control" type="text" v-model="name">
                          <small class="text-danger">{{ nameError }}</small>
                      </div>
                 </div>

                 <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Main Location:</label></div>
                      <div class="col-12 col-md-9">
                           <select id="mainLocationSelect" class="form-control">
                               <option v-for="mainLocation in mainLocations" :value="mainLocation.id" >{{ mainLocation.name }}</option>
                           </select>
                      </div>
                 </div>
                 
                  <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">X :</label></div>
                      <div class="col-12 col-md-9">
                         <input  class="form-control" type="text" v-model="xValue">
                          <small class="text-danger">{{ xError }}</small>
                      </div>
                 </div>
                 
                 <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Y :</label></div>
                      <div class="col-12 col-md-9">
                         <input  class="form-control" type="text" v-model="yValue">
                         <small class="text-danger">{{ yError }}</small>
                      </div>
                 </div>

                 <div class="col-md-12 d-flex justify-content-center">
                    <button class="btn btn-primary w-25">ADD</button>
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
            xValue : "",
            yValue : "",
            nameError : "",
            xError : "",
            yError : "",
            mainLocations : [],
            mainLocationSelect 
        }
    },
    methods : {
 
       onSubmit(){
         
            //validate
            this.checkErrorMessages() 
            if(!this.formReady){
                return
            }

            let data = {
                name : this.name,
                coordinates : `${this.xValue},${this.yValue}`,
                mainLocationId : mainLocationSelect.value
            }
      
            this.$http.post(`${this.$apiUrl}/locations`,data)
            .then(data=>{
               this.$swal.fire(
                    ``,
                    `Added Successfully !`,
                    'success'
                )
                this.clear()
            }) 
            .catch(err => {
                this.$swal.fire(
                    ``,
                    `${err.response.data.error}`,
                    'error'
                )
            
            })

       },
       checkErrorMessages(){
           this.nameError = this.name.trim() == "" ?  "Please add a name" : ""
           this.xError = this.xValue.trim() == "" ?  "Please add X coordinate" : ""
           this.yError = this.yValue.trim() == "" ?  "Please add Y coordinate" : ""
       },
       clear(){
            this.name = ""
            this.xValue = ""
            this.yValue = ""
            this.nameError = ""
            this.xError = ""
            this.yError = ""
       },
       getMainLocations(){
           this.$http.get(`${this.$apiUrl}/mainlocations`)
                .then(data =>{ 
                    let  locations = data.data._embedded.mainlocations
                    this.mainLocations = locations
                })
             .catch(err => { 
                this.$swal.fire(
                    ``,
                    `${err.response.data.error}`,
                    'error'
                )
             } )
       }
    },
 
    computed : {
        formReady(){
            return this.nameError.length == 0 && 
            this.xError.length == 0 && this.yError.length == 0
        }
    },
    mounted(){
       this.getMainLocations()
       this.mainLocationSelect = document.getElementById("mainLocationSelect")
    }
}
</script>
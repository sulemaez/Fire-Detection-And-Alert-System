<template>
    <div class="d-flex justify-content-center">
        <div class="col-md-6">
             <div class="card">
          <div class="card-header">
            <strong>Add Location</strong>
          </div>

          <div class="card-body card-block">
             <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                 <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">Name :</label></div>
                      <div class="col-12 col-md-9">
                         <input  class="form-control" type="text">
                      </div>
                 </div>
                  <div class="row form-group">
                      <div class="col col-md-3"><label class=" form-control-label">X :</label></div>
                      <div class="col-12 col-md-9">
                           <select class="form-control">
                               <option value="">Nairobi</option>
                               <option value="">Kisumu</option>
                           </select>
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
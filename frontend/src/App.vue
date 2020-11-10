<template>
  <div id="app">
      <div v-if="show">
          <loader></loader>   
      </div>
     <router-view/>    
  </div>
</template>

<script>
import Loader from './components/Loader'
export default {
  components : { Loader },
  computed: {
     show(){
         return this.$store.state.isLoading
     }
  }
}
</script>

<style lang="scss">
@import url('./assets/css/font-awesome.min.css');
@import url('./assets/css/themify-icons.css');
@import url('./assets/css/pe-icon-7-filled.css');
@import url('./assets/css/cs-skin-elastic.css');

@import "./assets/scss/style";

button{
    cursor: pointer;
}
</style>

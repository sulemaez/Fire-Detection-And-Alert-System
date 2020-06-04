<template>
     <div class="admin-container" >
        <Sidebar :navItems="nav"/>
        <div id="right-panel" class="right-panel">
          <Header/>
          <div class="content pb-0">
              <transition enter-active-class="animated fadeIn">
                <router-view></router-view>
              </transition>
          </div>
        </div>
      </div>
</template>

<script>
import nav from '../nav'
import Header from '../components/Header.vue'
import Sidebar from '../components/Sidebar.vue'


export default{
    name: 'dashboard',
    components: {

    },
    data () {
       return {
         nav: nav.items
       }
    },
    components: {
        Header,
        Sidebar
    },
    computed: {
        name(){
        return this.$route.name
        },
        list() {
        return this.$route.matched
        },
    }
}


</script>

<style>

</style>
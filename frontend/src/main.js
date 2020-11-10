import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router';
import store from './store'
import router from './router/routes'
import axios from 'axios'
import { index } from './components/index';
import VueSweetalert2 from 'vue-sweetalert2';
// If you don't need the styles, do not connect
import 'sweetalert2/dist/sweetalert2.min.css';

import * as VueGoogleMaps from "vue2-google-maps";

Vue.use(VueGoogleMaps, {
  load: {
    key: "AIzaSyCz4GYEDrnU7yijbztMqZTINQS_4CA3QjU",
    libraries: "places" // necessary for places input
  }
});

// Router
Vue.use(VueRouter)
Vue.use(VueSweetalert2)

// let url = document.location.protocol + "//" + document.location.hostname + ":8080/"
let baseUrl = 'http://localhost:8080/'
Vue.prototype.$baseUrl = baseUrl
Vue.prototype.$apiUrl = `${baseUrl}api` 
Vue.prototype.$http = axios
Vue.prototype.$http.defaults.headers.common['Cache-control'] = 'no-cache'
Vue.prototype.$http.defaults.headers.common['Authorization'] = `Bearer ${store.state.userToken}`

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App),
  components: { App }
})

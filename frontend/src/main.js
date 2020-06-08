import Vue from 'vue'
import App from './App.vue'
import store from './store'
import VueRouter from 'vue-router';
import { routes } from './router/routes';
import { index } from './components/index';
import axios from 'axios'


// Router
Vue.use(VueRouter);

let url = document.location.protocol + "//" + document.location.hostname + ":8080/"
Vue.prototype.$apiUrl = url + 'api' //'http://admin:8080/api'
Vue.prototype.$http = axios

const router = new VueRouter({
    routes,
    linkActiveClass: 'open active',
    scrollBehavior: () => ({ y: 0 }),
    mode: 'hash'
})

router.beforeEach((to, from, next) => {
  // store.commit('setLoading', false)
  // store.commit('setLoading', true)

  if (store.state.userToken === '' && !store.state.loggedIn && to.name !== 'login' && to.name !== 'Register') {
     return next({ name : 'login' })
  }

  // Vue.prototype.$http.defaults.headers.common['Auth'] = store.state.userToken
  // Vue.prototype.$http.defaults.headers.common['Cache-control'] = 'no-cache'
  return next()
})


new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App),
  components: { App }
})

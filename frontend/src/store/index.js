import Vue from 'vue'
import Vuex from 'vuex'



import * as getters from './getters'

Vue.use(Vuex)

let userToken  = localStorage.getItem('token') || ""

const store = new Vuex.Store({
  strict: false,  // process.env.NODE_ENV !== 'production',
  getters,
  state: {
    userToken :  userToken,
    isLoggedIn : userToken == "" ? false : true,
    isLoading : false
  },
  actions:{
     setLoggedIn({ commit }, userToken){
       commit('setLoggedIn',userToken)
     },
     logout ({ commit }) {
      localStorage.removeItem('token')
      commit('logout')
    },
    setLoading({ commit }, isLoading) {
      commit('setLoading',isLoading)
    }
  },
  mutations: {
    setLoggedIn(state , userToken){
       state.userToken = userToken
       state.isLoggedIn = true
       localStorage.setItem('token',userToken)
       Vue.prototype.$http.defaults.headers.common['Authorization'] = `Bearer ${store.state.userToken}`
    },
    setLoading(state, isLoading) {
      state.isLoading =  isLoading
      console.log("LOADINGS "+isLoading)
    },
    logout (state) {
      state.userToken = ''
      state.isLoggedIn = true
      state.user = {}
    },
  }
})

export default store
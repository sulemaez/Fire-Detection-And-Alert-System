import VueRouter from 'vue-router';
import Vue from 'vue'
import store from '../store'

// Views
const Dashboard = resolve => { require.ensure(['../views/Dashboard.vue'], ()=>{ resolve(require('../views/Dashboard.vue')); }); };
const AuthLayout = resolve => { require.ensure(['../layouts/AuthLayout.vue'], ()=>{ resolve(require('../layouts/AuthLayout.vue')); }); };

//Pages
const Login = resolve => { require.ensure(['../pages/login/Login.vue'], ()=>{ resolve(require('../pages/login/Login.vue')); }); };

const Page404 = resolve => { require.ensure(['../pages/Page404.vue'], ()=>{ resolve(require('../pages/Page404.vue')); }); };
const Page500 = resolve => { require.ensure(['../pages/Page500.vue'], ()=>{ resolve(require('../pages/Page500.vue')); }); };

//admin components
const AddUserType = resolve => { require.ensure(['../admincomponents/AddUserType.vue'], ()=>{ resolve(require('../admincomponents/AddUserType.vue')); }); };
const AddEmergencyType = resolve => { require.ensure(['../admincomponents/AddEmergencyType.vue'], ()=>{ resolve(require('../admincomponents/AddEmergencyType.vue')); }); };
const AddLocation = resolve => { require.ensure(['../admincomponents/AddLocation.vue'], ()=>{ resolve(require('../admincomponents/AddLocation.vue')); }); };
const AddCamera = resolve => { require.ensure(['../admincomponents/AddCamera.vue'], ()=>{ resolve(require('../admincomponents/AddCamera.vue')); }); };
const AddUser = resolve => { require.ensure(['../admincomponents/AddUser.vue'], ()=>{ resolve(require('../admincomponents/AddUser.vue')); }); };

const ViewUsers = resolve => { require.ensure(['../admincomponents/ViewUsers.vue'], ()=>{ resolve(require('../admincomponents/ViewUsers.vue')); }); }
const ViewEmergencyTypes = resolve => { require.ensure(['../admincomponents/ViewEmergencyTypes.vue'], ()=>{ resolve(require('../admincomponents/ViewEmergencyTypes.vue')); }); }
const ViewUserTypes = resolve => { require.ensure(['../admincomponents/ViewUserTypes.vue'], ()=>{ resolve(require('../admincomponents/ViewUserTypes.vue')); }); }
const ViewEmergencies = resolve => { require.ensure(['../admincomponents/ViewEmergencies.vue'], ()=>{ resolve(require('../admincomponents/ViewEmergencies.vue')); }); } 
const ViewCameras = resolve => { require.ensure(['../admincomponents/ViewCameras.vue'], ()=>{ resolve(require('../admincomponents/ViewCameras.vue')); }); } 
const ViewLocations = resolve => { require.ensure(['../admincomponents/ViewLocations.vue'], ()=>{ resolve(require('../admincomponents/ViewLocations.vue')); }); } 
const DataPage = resolve => { require.ensure(['../admincomponents/DataPage.vue'], ()=>{ resolve(require('../admincomponents/DataPage.vue')); }); } 

const routes = [
    {
        path : '',
        name: 'home',
        redirect : { path: '/dashboard'}
    },
    {   path : '/dashboard',
        components:{
            default: Dashboard
        },
        children:[
            { path : '/' , component : DataPage },
            { path : '/addusertypes', name: 'addusertypes', component: AddUserType },
            { path : '/addemergencytype', component : AddEmergencyType },
            { path : '/addlocation', component : AddLocation },
            { path : '/addcamera' , component : AddCamera },
            { path : '/adduser' , component : AddUser},
            { path : '/viewusers' ,component : ViewUsers},
            { path : '/viewemergencytypes' , component : ViewEmergencyTypes },
            { path : '/viewusertypes' , component : ViewUserTypes},
            { path : '/viewemergencies', component : ViewEmergencies},
            { path : '/viewcameras' , component : ViewCameras},
            { path : '/viewlocations', component : ViewLocations}
        ]
    },
    {
        path : '/auth',
        name: 'auth',
        component: AuthLayout,
        children:[
            {
                path: '/login',
                component: Login,
                name : 'login'
            },
            {
                path: '/Page404',
                component: Page404,
                name: 'Page404'
            },
            {
                path: '/Page500',
                component: Page500,
                name: 'Page500'
            }

        ]
    },

    //Redirect to Home
    { path: '/redirect-me', redirect: { name: 'home' } },

    // 404 redirect to home
    { path: '*', redirect: { name: 'Page404', component: Page404 }  }
];


const router = new VueRouter({
    routes,
    linkActiveClass: 'open active',
    scrollBehavior: () => ({ y: 0 }),
    mode: 'hash'
})

router.beforeEach((to, from, next) => {

  store.commit('setLoading', true)

  if ((store.state.userToken == '' || store.state.userToken == null)  && to.path !== '/login') {
    store.commit('setLoading', false)
    return next({ name: 'login' })
  }

  store.commit('setLoading', false)


  return next()
})

router.afterEach((to, from) => {
    store.commit('setLoading', false)
})

export default router
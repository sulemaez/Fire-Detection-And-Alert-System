export default {
  items: [
    {
      name: 'Dashboard',
      url: '/dashboard',
      icon: 'fa fa-dashboard'
    },
    {
      name: 'Users',
      icon: 'fa fa-user',
      children:[
        {
          name : 'Add',
          url : '/adduser',
          icon : 'fa fa-plus',
        },
        {
          name : 'View All',
          url : '/viewusers',
          icon : 'fa fa-eye'
        }
      ]
    },
    {
      name: 'Emergencies',
      icon: 'fa fa-exclamation-triangle',
      children:[
        {
          name : 'View All',
          url : '/viewemergencies',
          icon : 'fa fa-eye'
        }
      ]
    },
    {
      name: 'Cameras',
      icon: 'fa fa-camera',
      children:[
        {
          name : 'Add',
          url : '/addcamera',
          icon : 'fa fa-plus',
        },
        {
          name : 'View All',
          url : '/viewcameras',
          icon : 'fa fa-eye'
        }
      ]
    },
    {
      name: 'Main Location',
      icon: 'fa fa-map-marker',
      children:[
        {
          name : 'Add',
          url : '/addmainlocation',
          icon : 'fa fa-plus',
        },
        {
          name : 'View All',
          url : '/viewmainlocations',
          icon : 'fa fa-eye'
        }
      ]
    },
    {
      name: 'Location',
      icon: 'fa fa-map-marker',
      children:[
        {
          name : 'Add',
          url : '/addlocation',
          icon : 'fa fa-plus',
        },
        {
          name : 'View All',
          url : '/viewlocations',
          icon : 'fa fa-eye'
        }
      ]
    },
    {
      name: 'User Types',
      icon: 'fa fa-user',
      children:[
        {
          name : 'Add',
          url : '/addusertypes',
          icon : 'fa fa-plus',
        },
        {
          name : 'View All',
          url : '/viewusertypes',
          icon : 'fa fa-eye'
        }
      ]
    },
    {
      name: 'Emergency Types',
      icon: 'fa fa-exclamation',
      children:[
        {
          name : 'Add',
          url : '/addemergencytype',
          icon : 'fa fa-plus',
        },
        {
          name : 'View All',
          url : '/viewemergencytypes',
          icon : 'fa fa-eye'
        }
      ]
    },
    
  ]
}

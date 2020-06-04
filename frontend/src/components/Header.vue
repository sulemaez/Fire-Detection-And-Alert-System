<template>
        <header id="basix-header" class="header">

            <div class="header-menu">
                <div class="row">
                    <div class="col-sm-7">

                        <div class="header-left" :class="{'open': isSearch, '': !isSearch }">
                    
                            <div class="dropdown for-notification">
                                <button
                                    class="btn btn-secondary dropdown-toggle"
                                    type="button"
                                    id="notification" data-toggle="dropdown"
                                    aria-haspopup="true"
                                    aria-expanded="false"
                                    :class="{'notification-show': isNotification, '': !isNotification }"
                                    @click="handleNotification"
                                    autoClose= true
                                >
                                    <i class="fa fa-bell"></i>
                                    <span class="count bg-danger">5</span>
                                </button>
                                <div class="dropdown-menu" aria-labelledby="notification">
                                    <a class="dropdown-item media bg-flat-color-2 text-white" href="#">
                                        <i class="fa fa-pencil"></i>
                                        <p class="text-white">You have 3 Notification</p>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-1 text-white" href="#">
                                        <i class="fa fa-check"></i>
                                        <p class="text-white">Server #1 overloaded.</p>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-4 text-white" href="#">
                                        <i class="fa fa-info"></i>
                                        <p class="text-white">Server #2 overloaded.</p>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-5 text-white" href="#">
                                        <i class="fa fa-warning"></i>
                                        <p class="text-white">Server #3 overloaded.</p>
                                    </a>
                                </div>
                            </div>

                            <div class="dropdown for-message">
                                <button
                                    class="btn btn-secondary dropdown-toggle"
                                    type="button"
                                    id="message"
                                    data-toggle="dropdown"
                                    aria-haspopup="true"
                                    aria-expanded="false"
                                    :class="{'message-show': isMessage, '': !isMessage }"
                                    @click="handleMessage"
                                >
                                    <i class="ti-email"></i>
                                    <span class="count bg-primary">9</span>
                                </button>
                                <div class="dropdown-menu" aria-labelledby="message">
                                    <p class="red">You have 4 Mails</p>
                                    <a class="dropdown-item media bg-flat-color-1" href="#">
                                        <span class="photo media-left"><img alt="avatar" src="../images/admin.jpg"></span>
                                        <div class="message media-body">
                                            <span class="name float-left text-light">Jonathan Smith</span>
                                            <span class="time float-right text-light">Just now</span>
                                            <p class="text-light">Hello, this is an example msg</p>
                                        </div>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-4" href="#">
                                        <span class="photo media-left"><img alt="avatar" src="../images/admin.jpg"></span>
                                        <div class="message media-body">
                                            <span class="name float-left text-light">Jack Sanders</span>
                                            <span class="time float-right text-light">5 minutes ago</span>
                                            <p class="text-light">Lorem ipsum dolor sit amet, consectetur</p>
                                        </div>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-5" href="#">
                                        <span class="photo media-left"><img alt="avatar" src="../images/admin.jpg"></span>
                                        <div class="message media-body">
                                            <span class="name float-left text-light">Cheryl Wheeler</span>
                                            <span class="time float-right text-light">10 minutes ago</span>
                                            <p class="text-light">Hello, this is an example msg</p>
                                        </div>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-3" href="#">
                                        <span class="photo media-left"><img alt="avatar" src="../images/admin.jpg"></span>
                                        <div class="message media-body">
                                            <span class="name float-left text-light">Rachel Santos</span>
                                            <span class="time float-right text-light">15 minutes ago</span>
                                            <p class="text-light">Lorem ipsum dolor sit amet, consectetur</p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-5">
                        <div class="user-area dropdown float-right">
                            <a href="#"
                                class="dropdown-toggle"
                                data-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                                :class="{'show': isActive, '': !isActive }"
                                @click="handleClick"
                            >
                                <img class="user-avatar rounded-circle" src="../images/admin.jpg" alt="User Avatar">
                            </a>

                            <div
                                class="user-menu dropdown-menu"
                                :class="{'show': isActive, '': !isActive }"
                                @click="handleClick"
                                >
                                <a class="nav-link" href="#"><i class="fa fa- user"></i>My Profile</a>

                                <a class="nav-link" href="#"><i class="fa fa- user"></i>Notifications <span class="count">13</span></a>

                                <a class="nav-link" href="#"><i class="fa fa -cog"></i>Settings</a>

                                <a class="nav-link" href="#"><i class="fa fa-power -off"></i>Logout</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </header><!-- /header -->
</template>


<script>
    export default {
    name: 'basix-header',
    data (){
      return{
        isActive: false,
        isFlag: false,
        isMessage: false,
        isNotification: false,
        isSearch: false,
        isOpen: false
      }
    },
    methods: {
        toggle(e){
            //this.isOpen = !this.isOpen
            e.target.parentElement.classList.toggle('close')
        },
        handleClick(e){
            this.isActive = !this.isActive;
            // if(e.target.className == "noclass"){
            //     e.target.className = "link active";
            // } else{
            //     e.target.className = "noclass";
            // }
        },
      
        handleMessage (e) {
          this.isMessage = !this.isMessage;
        },
        handleNotification (e) {
          this.isNotification = !this.isNotification;
        },
        handleFlag (e) {
          this.isFlag = !this.isFlag;
        }

      }
    }
</script>

<style>

</style>
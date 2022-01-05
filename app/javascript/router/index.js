import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store'
import Top from '../pages/Top.vue'
import Register from '../pages/users/Register.vue'
import Login from '../pages/users/Login.vue'
import Search from '../pages/tracks/Search.vue'
import MyLibrary from '../pages/tracks/MyLibrary'
import UserEdit from '../pages/users/UserEdit'
import PasswordReset from '../pages/users/PasswordReset'
import ContactForm from '../pages/contacts/ContactForm'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Top,
      name: 'Top'
    },
    {
      path: '/register',
      component: Register,
      name: 'Register'
    },
    {
      path: '/login',
      component: Login,
      name: 'Login'
    },
    {
      path: '/search',
      component: Search,
      name: 'Search',
      meta: { requiredAuth: true }
    },
    {
      path: '/mylibrary',
      component: MyLibrary,
      name: 'MyLibrary',
      meta: { requiredAuth: true }
    },
    {
      path: '/user/edit',
      component: UserEdit,
      name: 'UserEdit',
      meta: { requiredAuth: true }
    },
    {
      path: '/reset_password/:id',
      component: PasswordReset,
      name: 'PasswordReset'
    },
    {
      path: '/contact',
      component: ContactForm,
      name: 'ContactForm'
    }
  ]
})

router.beforeEach((to, from, next) => {
  store.dispatch("users/fetchAuthUser")
    .then((authUser) => {
      if (to.matched.some(record => record.meta.requiredAuth) && !authUser) {
        next({ name: "Login" })
      } else {
        next()
      }
    })
})

export default router

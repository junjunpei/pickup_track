import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store'
import Top from '../pages/top.vue'
import Register from '../pages/users/register.vue'
import Login from '../pages/users/login.vue'
import Search from '../pages/tracks/search.vue'

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

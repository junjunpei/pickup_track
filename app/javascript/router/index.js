import Vue from 'vue'
import VueRouter from 'vue-router'
import Top from '../pages/top.vue'
import Register from '../pages/user/register.vue'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Top,
      name: 'Top',
    },
    {
      path: 'register',
      component: Register,
      name: 'register'
    }
  ]
})

export default router

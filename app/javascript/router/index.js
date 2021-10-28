import Vue from 'vue'
import VueRouter from 'vue-router'
import Top from '../pages/top'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Top,
      name: 'Top',
    }
  ]
})

export default router

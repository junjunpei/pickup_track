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
import ContactForm from '../pages/shared/ContactForm'
import NotFoundError from '../pages/errors/NotFoundError'
import InternalServerError from '../pages/errors/InternalServerError'
import TermsOfService from '../pages/shared/TermsOfService'
import PrivacyPolicy from '../pages/shared/PrivacyPolicy'
import UserInformation from "../pages/users/UserInformation"
import VueGtag from "vue-gtag"

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Top,
      name: 'Top',
      meta: { title: "PICKUP TRACK" }
    },
    {
      path: '/register',
      component: Register,
      name: 'Register',
      meta: { title: "ユーザー登録 | PICKUP TRACK" }
    },
    {
      path: '/login',
      component: Login,
      name: 'Login',
      meta: { title: "ログイン | PICKUP TRACK" }
    },
    {
      path: '/search',
      component: Search,
      name: 'Search',
      meta: { requiredAuth: true, title: "楽曲検索 | PICKUP TRACK" }
    },
    {
      path: '/mylibrary',
      component: MyLibrary,
      name: 'MyLibrary',
      meta: { requiredAuth: true, title: "マイライブラリ | PICKUP TRACK" }
    },
    {
      path: '/user/edit',
      component: UserEdit,
      name: 'UserEdit',
      meta: { requiredAuth: true, title: "ユーザー情報編集 | PICKUP TRACK" }
    },
    {
      path: '/reset_password/:id',
      component: PasswordReset,
      name: 'PasswordReset',
      meta: { title: "パスワード再設定 | PICKUP TRACK" }
    },
    {
      path: '/contact',
      component: ContactForm,
      name: 'ContactForm',
      meta: { title: "お問い合わせ | PICKUP TRACK" }
    },
    {
      path: '*',
      component: NotFoundError,
      name: 'NotfoundError',
      meta: { title: "ページが見つかりませんでした | PICKUP TRACK" }
    },
    {
      path: '/error',
      component: InternalServerError,
      name: 'InternalServerError',
      meta: { title: "サーバーエラー | PICKUP TRACK" }
    },
    {
      path: '/terms',
      component: TermsOfService,
      name: 'TermsOfService',
      meta: { title: "利用規約 | PICKUP TRACK" }
    },
    {
      path: '/privacy',
      component: PrivacyPolicy,
      name: 'PrivacyPolicy',
      meta: { title: "プライバシーポリシー | PICKUP TRACK" }
    },
    {
      path: "/user",
      component: UserInformation,
      name: "UserInformation",
      meta: { requiredAuth: true, title: "ユーザー情報 | PICKUP TRACK" }
    }
  ],
  scrollBehavior() {
    return { x: 0, y: 0 }
  }
})

Vue.use(VueGtag, {
  config: { id: "G-CMJ10ZYXGQ" }
}, router)

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

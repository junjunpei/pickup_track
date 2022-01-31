<template>
  <v-app-bar
    app
    color="black"
    height="80"
  >

    <v-toolbar-title
      style="cursor: pointer"
      @click="$router.push('/')"
    >
      <v-img :width="width" :src="logo"></v-img>
    </v-toolbar-title>

    <v-spacer />

    <template v-if="$vuetify.breakpoint.mdAndUp">
      <v-btn
        text
        :to="{ name: 'Top' }"
        class="mr-5"
        exact
      >
        <v-icon>mdi-home</v-icon>
        ホーム
      </v-btn>
      <template v-if="authUser">
        <v-btn
          text
          :to="{ name: 'Search' }"
        >
          <v-icon>mdi-magnify</v-icon>
          楽曲検索
        </v-btn>
        <v-menu
          offset-y
          transition="scale-transition"
        >
          <template v-slot:activator="{ on: menu, attrs }">
            <v-tooltip bottom>
              <template v-slot:activator="{ on: tooltip }">
                <v-icon
                  x-large
                  v-bind="attrs"
                  v-on="{ ...tooltip, ...menu }"
                  class="mr-12 ml-8"
                  id="user-menu"
                >
                  mdi-account
                </v-icon>
              </template>
              <span>ユーザーメニュー</span>
            </v-tooltip>
          </template>
          <v-list>
            <v-list-item
              :to="{ name: 'MyLibrary' }"
              id="my-library"
            >
              <v-list-item-title>
                <v-icon>mdi-music-box-multiple</v-icon>
                マイライブラリ
              </v-list-item-title>
            </v-list-item>
            <v-list-item
              :to="{ name: 'UserInformation' }"
              id="user-information"
            >
              <v-list-item-title>
                <v-icon>mdi-account</v-icon>
                ユーザー情報
              </v-list-item-title>
            </v-list-item>
            <v-divider />
            <v-list-item
              @click="handleLogout"
              id="logout"
            >
              <v-list-item-title class="error--text">
                <v-icon color="error">mdi-logout</v-icon>
                ログアウト
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </template>
      <template v-else>
        <v-btn
          :to="{ name: 'Register' }"
          class="mr-6"
          text
        >
          <v-icon>mdi-account-plus</v-icon>
          ユーザー登録
        </v-btn>
        <v-btn
          :to="{ name: 'Login' }"
          text
        >
          <v-icon>mdi-login</v-icon>
          ログイン
        </v-btn>
      </template>
    </template>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "TheHeader",

  data() {
    return {
      logo: require('../images/logo.png')
    }
  },

  computed: {
    ...mapGetters("users", ["authUser"]),

    width () {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs': return 200
        case 'sm': return 280
        case 'md': return 280
        case 'lg': return 320
        case 'xl': return 320
      }
    }
  },

  methods: {
    ...mapActions("users", ["logoutUser"]),

    async handleLogout() {
      try {
        await this.logoutUser()
        this.$router.push({ name: "Top" })
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "ログアウトしました",
            type: "success",
            status: true
          }
        )
      } catch(error) {
        console.log(error)
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "ログアウトに失敗しました",
            type: "error",
            status: true
          }
        )
      }
    }
  }
}
</script>

<style scoped>
</style>

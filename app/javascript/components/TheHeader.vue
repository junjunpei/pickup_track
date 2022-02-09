<template>
  <v-app-bar
    app
    color="black"
    height="80"
  >
    <v-toolbar-title
      style="cursor: pointer"
      @click="$router.push('/').catch(err => {})"
    >
      <v-img
        :width="width"
        :src="logo"
      ></v-img>
    </v-toolbar-title>

    <v-spacer />

    <template v-if="$vuetify.breakpoint.mdAndUp">
      <template v-if="authUser">
        <v-btn
          text
          :to="{ name: 'Search' }"
          exact
        >
          <v-icon>mdi-magnify</v-icon>
          楽曲検索
        </v-btn>

        <v-btn
          text
          :to="{ name: 'MyLibrary' }"
          exact
        >
          <v-icon>mdi-music-box-multiple</v-icon>
          マイライブラリ
        </v-btn>

        <v-btn
          text
          :to="{ name: 'UserInformation' }"
          exact
        >
          <v-icon>mdi-account</v-icon>
          ユーザー情報
        </v-btn>

        <v-btn
          text
          @click="handleLogout"
          exact
          color="error"
        >
          <v-icon>mdi-logout</v-icon>
          ログアウト
        </v-btn>
      </template>
      <template v-else>
        <v-btn
          :to="{ name: 'Register' }"
          class="mr-6"
          text
          exact
        >
          <v-icon>mdi-account-plus</v-icon>
          ユーザー登録
        </v-btn>
        <v-btn
          :to="{ name: 'Login' }"
          text
          exact
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
        this.$router.push({ name: "Top" }).catch(err => {})
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

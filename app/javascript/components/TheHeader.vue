<template>
  <v-app-bar
    app
    color="black"
    height="80"
  >
    <v-avatar
      class="mr-3"
      color="grey lighten-5"
      size="30"
    >
      <v-img
        contain
        max-height="70%"
      ></v-img>
    </v-avatar>

    <v-toolbar-title
      style="cursor: pointer"
      @click="$router.push('/')"
      class="font-weight-black headline"
    >
      Song Shuffle
    </v-toolbar-title>

    <v-spacer />

    <template v-if="authUser">
      <v-btn
        text
        :to="{ name: 'Search' }"
      >
        楽曲検索
      </v-btn>
      <v-btn
        text
        @click="handleLogout"
      >
        ログアウト
      </v-btn>
    </template>
    <template v-else>
      <v-btn
        :to="{ name: 'Register' }"
        class="mr-6"
        text
      >
        新規登録
      </v-btn>
      <v-btn
        :to="{ name: 'Login' }"
        text
      >
        ログイン
      </v-btn>
    </template>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "TheHeader",
  computed: {
    ...mapGetters("users", ["authUser"])
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

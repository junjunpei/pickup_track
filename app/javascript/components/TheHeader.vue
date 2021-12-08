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
                class="mr-12"
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
              マイライブラリ
            </v-list-item-title>
          </v-list-item>
          <v-list-item
            :to="{ name: 'UserEdit' }"
            id="user-edit"
          >
            <v-list-item-title>
              ユーザー情報編集
            </v-list-item-title>
          </v-list-item>
          <v-divider />
          <v-list-item
            @click="handleLogout"
            id="logout"
          >
            <v-list-item-title class="error--text">
              ログアウト
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
      <v-btn
        text
        :to="{ name: 'Search' }"
        class="mr-5"
      >
        楽曲検索
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

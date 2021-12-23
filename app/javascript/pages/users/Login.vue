<template>
  <v-container
    id="login-form"
    class="text-center form-group col-lg-6 offset-lg-3"
  >
      <div class="h3 mt-10">
        ログイン
      </div>
      <ValidationObserver
        ref="observer"
        v-slot="{ invalid }"
      >
        <form @submit.prevent="submit">
          <ValidationProvider
            v-slot="{ errors }"
            name="メールアドレス"
            rules="required|email"
          >
            <v-text-field
              v-model="user.email"
              prepend-icon="mdi-email"
              :error-messages="errors"
              label="メールアドレス"
              class="mt-10"
            ></v-text-field>
          </ValidationProvider>
          <ValidationProvider
            v-slot="{ errors }"
            name="パスワード"
            rules="required|min:3"
            vid="password"
          >
            <v-text-field
              v-model="user.password"
              :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
              prepend-icon="mdi-shield-lock"
              :error-messages="errors"
              :type="showPassword ? 'text' : 'password'"
              @click:append="showPassword = !showPassword"
              label="パスワード"
              class="mt-10"
            ></v-text-field>
          </ValidationProvider>

          <v-btn
            @click="login"
            class="mt-10"
            type="submit"
            :disabled="invalid || loading"
            color="success"
            id="login"
          >
            ログイン
          </v-btn>
        </form>
      </ValidationObserver>
      <div class="text-center mt-7">
        <router-link
          color="blue"
          :to="{ name: 'Register'}"
        >
          登録がまだの方はこちら
        </router-link>
        <PasswordResetMail></PasswordResetMail>
      </div>
  </v-container>
</template>

<script>
import { mapActions } from 'vuex'
import PasswordResetMail from './components/PasswordResetMail.vue'

export default {
  name: "Login",
  data() {
    return {
      user: {
        email: '',
        password: ''
      },
      showPassword: false,
      loading: false
    }
  },

  components: {
    PasswordResetMail
  },

  methods: {
    ...mapActions("users", [
      "loginUser"
    ]),
    async login() {
      this.loading = true
      try {
        await this.loginUser(this.user)
        this.loading = false
        this.$router.push({ name: 'Top' })
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "ログインしました",
            type: "success",
            status: true
          }
        )
      } catch(error) {
        this.loading = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "メールアドレス、またはパスワードが間違っています",
            type: "error",
            status: true
          }
        )
        console.log(error)
      }
    },
    submit() {
      this.$refs.observer.validate()
    }
  }
}
</script>

<style scoped>
</style>

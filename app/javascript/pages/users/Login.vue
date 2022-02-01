<template>
  <v-container
    id="login-form"
  >
    <v-row>
      <v-col
        lg="8"
        offset-lg="2"
        md="8"
        offset-md="2"
        sm="10"
        offset-sm="1"
        xs="10"
        offset-xs="1"
      >
        <h2 class="mt-8">
          ログイン
        </h2>
        <ValidationObserver
          ref="observer"
          v-slot="{ invalid }"
          class="text-center"
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
              outlined
              class="mt-10"
              type="submit"
              :disabled="invalid || loading"
              color="green accent-3"
              id="login"
            >
              ログイン
            </v-btn>
          </form>
        </ValidationObserver>
        <div class="mt-5 d-flex justify-center">
          <v-btn
            text
            color="light-blue accent-3"
            :to="{ name: 'Register'}"
          >
            登録がまだの方はこちら
          </v-btn>
          <PasswordResetMail />
        </div>
      </v-col>
    </v-row>
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

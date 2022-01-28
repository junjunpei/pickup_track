<template>
  <v-container
    id="password-reset"
  >
    <v-row>
      <v-col
        lg="6"
        offset-lg="3"
        md="8"
        offset-md="2"
        sm="10"
        offset-sm="1"
        xs="10"
        offset-xs="1"
      >
        <h2>
          パスワード再設定
        </h2>
        <p class="mt-5">新しいパスワードをご入力ください。</p>
        <ValidationObserver
          ref="observer"
          v-slot="{ invalid }"
          class="text-center"
        >
          <form
            class="mt-10"
            @submit.prevent="submit"
          >
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
              ></v-text-field>
            </ValidationProvider>
            <ValidationProvider
              v-slot="{ errors }"
              name="パスワード確認"
              rules="required|min:3|password_confirmed:@password"
            >
              <v-text-field
                v-model="user.password_confirmation"
                :append-icon="showPasswordConfirmation ? 'mdi-eye' : 'mdi-eye-off'"
                prepend-icon="mdi-shield-lock"
                :error-messages="errors"
                :type="showPasswordConfirmation ? 'text' : 'password'"
                @click:append="showPasswordConfirmation = !showPasswordConfirmation"
                label="パスワード確認"
              ></v-text-field>
            </ValidationProvider>
            <v-btn
              @click="handlePasswordReset"
              class="mt-6"
              type="submit"
              outlined
              :disabled="invalid || loading"
              color="green accent-3"
            >
              更新
            </v-btn>
          </form>
        </ValidationObserver>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "PasswordReset",

  data() {
    return {
      loading: false,
      user: {
        password: '',
        password_confirmation: ''
      },
      showPassword: false,
      showPasswordConfirmation: false
    }
  },

  methods: {
    submit() {
      this.$refs.observer.validate()
    },

    handlePasswordReset() {
      this.loading = true
      this.$axios.patch(`password_resets/${this.$route.query.id}`, { user: this.user })
        .then(response => {
          this.loading = false
          this.$router.push({ name: 'Login' })
          this.$store.dispatch("flashMessages/showMessage",
            {
              message: "パスワードを変更しました",
              type: "success",
              status: true
            }
          )
        })
        .catch(error => {
          this.loading = false
          this.$store.dispatch("flashMessages/showMessage",
            {
              message: "パスワードの変更に失敗しました",
              type: "error",
              status: true
            }
          )
          console.log(error)
        })
    }
  }
}
</script>

<style scoped>
</style>
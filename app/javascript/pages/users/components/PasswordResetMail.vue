<template>
  <v-dialog
    max-width="400"
    v-model="dialog"
    id="password-reset-modal"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        color="error"
        text
        v-bind="attrs"
        v-on="on"
      >
        パスワードをお忘れの方
      </v-btn>
    </template>
    <v-card>
      <v-card-title class="text-h5">
        パスワード再設定
      </v-card-title>

      <v-divider />

      <v-card-text class="mt-6">
        ご登録されているメールアドレスをご入力ください。
        ご入力されたメールアドレス宛にパスワード再設定のメールを送信させていただきます。
      </v-card-text>
      <v-card-text class="error--text">
        メールが届かない場合はメールアドレスが間違っている可能性がございます。ご確認の上、再度ご入力ください。
      </v-card-text>

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
              class="mx-5"
              id="password-reset-mail"
            ></v-text-field>
          </ValidationProvider>
          <v-card-actions class="mt-5">
            <v-spacer/>
            <v-btn
              color="error"
              text
              @click="handleClosePasswordResetModal"
            >
              キャンセル
            </v-btn>
            <v-btn
              color="green accent-3"
              text
              type:="submit"
              :disabled="invalid || loading"
              @click="handlePasswordResetMail"
            >
              送信する
            </v-btn>
          </v-card-actions>
        </form>
      </ValidationObserver>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  name: "PasswordResetMail",

  data() {
    return {
      dialog: false,
      loading: false,
      user: {
        email: ''
      }
    }
  },

  methods: {
    handleOpenModal() {
      this.dialog = true
    },

    handleClosePasswordResetModal() {
      this.dialog = false
      this.$refs.observer.reset()
      this.user.email = ''
    },

    submit() {
      this.$refs.observer.validate()
    },

    handlePasswordResetMail() {
      this.loading = true
      this.$axios.post("password_resets", { email: this.user.email })
        .then(response => {
          this.loading = false
          this.dialog = false
          this.user.email = ''
          this.$refs.observer.reset()
          this.$store.dispatch("flashMessages/showMessage",
            {
              message: "メールを送信しました",
              type: "success",
              status: true
            }
          )
        })
        .catch(error => {
          this.loading = false
          this.dialog = false
          this.user.email = ''
          this.$refs.observer.reset()
          this.$store.dispatch("flashMessages/showMessage",
            {
              message: "メールを送信しました",
              type: "success",
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
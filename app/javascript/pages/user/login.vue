<template>
  <div
    id="login-form"
    class="text-center w-90 container"
    >
    <v-content>
      <div class="h3">
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
            rules="required|email|unique"
          >
            <v-text-field
              v-model="user.email"
              prepend-icon="mdi-email"
              :error-messages="errors"
              label="メールアドレス"
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
            ></v-text-field>
          </ValidationProvider>

          <v-btn
            @click="register"
            class="mt-4"
            type="submit"
            :disabled="invalid"
            color="success"
          >
            ログイン
          </v-btn>
          <div class="text-center">
            <v-btn
              text
              class="mt-4"
              color="blue"
              to="/"
            >
              登録済みの方はこちら
            </v-btn>
          </div>
        </form>
      </ValidationObserver>
    </v-content>
  </div>
</template>

<script>
export default {
  name: login,
  data() {
    return {
      user: {
        email: '',
        password: ''
      },
      showPassword: false
    }
  }
}
</script>

<style scoped>
</style>

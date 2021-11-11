<template>
  <div
    id="login-form"
    class="text-center w-90 container"
    >
    <v-content>
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
            rules="required|email|unique"
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
            @click=""
            class="mt-10"
            type="submit"
            :disabled="invalid"
            color="success"
          >
            ログイン
          </v-btn>
          <div class="text-center mt-7">
            <router-link
              color="blue"
              :to="{ name: 'Register'}"
            >
              登録がまだの方はこちら
            </router-link>
          </div>
        </form>
      </ValidationObserver>
    </v-content>
  </div>
</template>

<script>
export default {
  name: "Login",
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

<template>
  <v-container
    id="user-edit-form"
    class="text-center form-group col-lg-6 offset-lg-3 mt-8"
  >
    <div class="h3">
      ユーザー情報編集
    </div>
    <ValidationObserver
      ref="observer"
      v-slot="{ invalid }"
    >
      <form @submit.prevent="submit">
        <ValidationProvider
          v-slot="{ errors }"
          name="名前"
          rules="required|max:10"
        >
          <v-text-field
            v-model="user.name"
            prepend-icon="mdi-account"
            :counter="10"
            :error-messages="errors"
            label="名前"
          ></v-text-field>
        </ValidationProvider>
        <ValidationProvider
          v-slot="{ errors }"
          name="メールアドレス"
          :rules="{ required: true, email: true, unique: authUser.email }"
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
          rules="min:3"
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
          rules="min:3|password_confirmed:@password"
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
          @click="handleUpdateUser"
          class="mt-4"
          type="submit"
          :disabled="loading || invalid"
          color="success"
        >
          更新
        </v-btn>
      </form>
    </ValidationObserver>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: 'EditUser',
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
      // checkbox: null,
      showPassword: false,
      showPasswordConfirmation: false,
      loading: false
    }
  },

  computed: {
    ...mapGetters("users", ["authUser"])
  },

  created() {
    this.user = Object.assign({}, this.authUser)
  },

  methods: {
    ...mapActions("users", ['updateUser']),

    submit() {
      this.$refs.observer.validate()
    },

    handleUpdateUser() {
      this.loading = true
      try {
        this.updateUser(this.user)
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "更新が完了しました",
            type: "success",
            status: true
          },
        )
      } catch(error) {
        this.loading = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "更新に失敗しました",
            type: "error",
            status: true
          },
        )
        console.log(error)
      }
    }
  },
}
</script>

<style scoped>

</style>
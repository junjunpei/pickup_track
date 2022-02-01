<template>
  <v-container id="user-edit-form">
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
        <h2 class="my-7">
          ユーザー情報編集
        </h2>
        <ValidationObserver
          ref="observer"
          v-slot="{ invalid }"
          class="text-center"
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
              outlined
              class="mt-4"
              type="submit"
              :disabled="loading || invalid"
              color="green accent-3"
            >
              更新
            </v-btn>
          </form>
        </ValidationObserver>
        <UserLeave
          @leave-user="handleLeaveUser"
          :loading="this.loading"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import UserLeave from "./components/UserLeave"

export default {
  name: "EditUser",

  components: {
    UserLeave
  },

  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
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
    ...mapActions("users", [
      'updateUser',
      'leaveUser'
    ]),

    submit() {
      this.$refs.observer.validate()
    },

    handleUpdateUser() {
      this.loading = true
      try {
        this.updateUser(this.user)
        this.loading = false
        this.user.password = ''
        this.user.password_confirmation = ''
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
    },

    handleLeaveUser() {
      this.loading = true
      try {
        this.leaveUser()
        this.loading = false
        this.$router.push({ name: 'Top' })
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "退会しました、ご利用ありがとうございました",
            type: "success",
            status: true
          }
        )
      } catch(error) {
        this.loading = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "退会に失敗しました",
            type: "error",
            status: true
          }
        )
      }
    }
  },
}
</script>

<style scoped>

</style>
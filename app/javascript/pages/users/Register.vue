<template>
  <v-container
    id="register-form"
    class="text-center form-group col-lg-6 offset-lg-3 mt-8"
  >
    <h2>
      ユーザー登録
    </h2>
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
        <ValidationProvider
          v-slot="{ errors }"
          rules="required_checkbox"
          name="checkbox"
        >
          <v-checkbox
            v-model="checkbox"
            :error-messages="errors"
            value="1"
            type="checkbox"
            required
          >
            <template v-slot:label>
              <div>
                <v-btn color="success" text @click.stop="handleOpenTermsModal" class="px-0">利用規約</v-btn>及び<v-btn color="success" text @click.stop="handleOpenPrivacyModal" class="px-0">プライバシーポリシー</v-btn>に同意する
              </div>
            </template>
          </v-checkbox>
        </ValidationProvider>

        <v-btn
          @click="register"
          class="mt-4"
          type="submit"
          :disabled="invalid || loading"
          color="success"
        >
          登録
        </v-btn>
      </form>
    </ValidationObserver>
    <div class="text-center mt-7">
      <router-link
        color="blue"
        :to="{ name: 'Login' }"
      >
        登録済みの方はこちら
      </router-link>
    </div>
    <v-dialog
      max-width="500"
      v-model="dialog"
    >
      <v-card>
        <TermsOfService v-if="showTerms" />
        <PrivacyPolicy v-else-if="showPrivacy" />

        <v-card-actions>
          <v-spacer />
          <v-btn
            color="success"
            text
            @click="handleCloseModal"
          >
            閉じる
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import TermsOfService from '../shared/TermsOfService.vue'
import PrivacyPolicy from '../shared/PrivacyPolicy.vue'

export default {
  name: "Register",

  components: {
    TermsOfService,
    PrivacyPolicy
  },

  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
      checkbox: null,
      showPassword: false,
      showPasswordConfirmation: false,
      loading: false,
      dialog: false,
      showTerms: false,
      showPrivacy: false
    }
  },

  methods: {
    submit() {
      this.$refs.observer.validate()
    },

    register() {
      this.loading = true
      this.$axios.post("users", { user: this.user })
        .then(response => {
          this.loading = false,
          this.$router.push({ name: 'Login' }),
          this.$store.dispatch("flashMessages/showMessage",
            {
              message: "登録が完了しました",
              type: "success",
              status: true
            },
          )
        })
        .catch(error => {
          this.loading = false
          this.$store.dispatch("flashMessages/showMessage",
            {
              message: "登録に失敗しました",
              type: "error",
              status: true
            }
          ),
          console.log(error)
        })
    },

    handleOpenTermsModal() {
      this.dialog = true
      this.showPrivacy = false
      this.showTerms = true
    },

    handleOpenPrivacyModal() {
      this.dialog = true
      this.showTerms = false
      this.showPrivacy = true
    },

    handleCloseModal() {
      this.dialog = false
      this.showTerms = false
      this.showPrivacy = false
    }
  },
}
</script>

<style scoped>
</style>

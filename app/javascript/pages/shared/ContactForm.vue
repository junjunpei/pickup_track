<template>
  <v-container
    id="contact-form"
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
        <h2 class="mt-7">
          お問い合わせ
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
              rules="email"
            >
              <v-text-field
                v-model="contact.email"
                outlined
                dense
                prepend-icon="mdi-email"
                :error-messages="errors"
                class="mt-10"
                label="メールアドレス（任意）"
              ></v-text-field>
            </ValidationProvider>
            <ValidationProvider
              v-slot="{ errors }"
              name="お問い合わせの種類"
              rules="required"
            >
              <v-select
                v-model="contact.category"
                outlined
                dense
                class="mt-3"
                prepend-icon="mdi-format-list-bulleted-type"
                :items="categories"
                :error-messages="errors"
                label="お問い合わせの種類（必須）"
              ></v-select>
            </ValidationProvider>
            <ValidationProvider
              v-slot="{ errors }"
              name="お問い合わせ内容"
              rules="required|max:1000"
            >
              <v-textarea
                v-model="contact.message"
                id="contact-message"
                outlined
                auto-grow
                dense
                class="mt-3"
                prepend-icon="mdi-message-reply-text"
                :error-messages="errors"
                :counter="1000"
                label="お問い合わせ内容（必須）"
              ></v-textarea>
            </ValidationProvider>

            <v-btn
              @click="handleContactSubmit"
              type="submit"
              outlined
              :disabled="invalid || loading"
              color="green accent-3"
              class="mt-3"
            >
              送信
            </v-btn>
          </form>
        </ValidationObserver>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "ContactForm",

  data() {
    return {
      categories: ['バグ、不具合', 'ご要望', 'その他'],
      contact: {
        email: '',
        category: '',
        message: ''
      },
      loading: false
    }
  },

  methods: {
    submit() {
      this.$refs.observer.validate()
    },

    handleContactSubmit() {
      this.loading = true
      this.$axios.post("contacts", { contact: this.contact })
        .then(response => {
          this.loading = false
          this.$router.push({ name: 'Top' })
          this.$store.dispatch("flashMessages/showMessage",
            {
              message: "お問い合わせが完了しました",
              type: "success",
              status: true
            }
          )
        })
        .catch(error => {
          this.loading = false
          this.$store.dispatch("flashMessages/showMessage",
            {
              message: "お問い合わせに失敗しました",
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
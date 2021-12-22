<template>
  <v-dialog
    max-width="400"
    v-model="dialog"
    id="pickup-modal"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        color="success"
        text
        v-bind="attrs"
        v-on="on"
        @click="handlePickupTrack"
      >
        パスワードをお忘れの方
      </v-btn>
    </template>
    <v-card>
      <v-card-title class="text-h5">
        パスワード再設定
      </v-card-title>

      <v-divider />

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
      <v-card-actions>
        <v-btn
          color="error"
          text
          @click="handleClosePickupModal"
        >
          キャンセル
        </v-btn>
        <v-btn
          color="success"
          text
          :disabled="invalid || loading"
          @click="handlePickupTrack"
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
      dialog: false
    }
  },
}
</script>

<style scoped>
</style>
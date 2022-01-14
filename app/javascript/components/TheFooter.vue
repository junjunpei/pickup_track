<template>
  <v-footer
    app
    color="#292929"
  >
    <v-row
      no-gutters
    >
      <v-col class="d-flex justify-space-around pb-3">
        <v-btn
          color="white"
          text
          rounded
          small
          :to="{ name: 'TermsOfService' }"
        >
          利用規約
        </v-btn>
        <v-btn
          color="white"
          text
          rounded
          small
          :to="{ name: 'PrivacyPolicy' }"
        >
          プライバシーポリシー
        </v-btn>
        <v-btn
          color="white"
          text
          rounded
          small
          :to="{ name: 'ContactForm' }"
        >
          お問い合わせ
        </v-btn>
      </v-col>
      <v-col
        class="text-center white--text"
        cols="12"
      >
        {{ (new Date()).getFullYear() }} — <strong>Pickup Track</strong> —
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
export default {
  name: "TheFooter"
}
</script>

<style scoped>
</style>

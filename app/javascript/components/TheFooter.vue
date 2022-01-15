<template>
  <v-footer
    app
    color="#292929"
  >
    <v-row
      no-gutters
      justify="space-around"
    >
      <v-btn
        color="white"
        text
        rounded
        small
        class="mb-2"
        :to="{ name: 'TermsOfService' }"
      >
        利用規約
      </v-btn>
      <v-btn
        color="white"
        text
        rounded
        small
        class="mb-2"
        :to="{ name: 'PrivacyPolicy' }"
      >
        プライバシーポリシー
      </v-btn>
      <v-btn
        color="white"
        text
        rounded
        small
        class="mb-2"
        :to="{ name: 'ContactForm' }"
      >
        お問い合わせ
      </v-btn>
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

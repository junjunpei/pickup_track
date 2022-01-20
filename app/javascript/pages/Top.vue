<template>
  <div id="top">
    <section id="hero">
      <v-row no-gutters>
        <v-img
          :min-height="'calc(100vh - ' + $vuetify.application.top + 'px)'"
          :src="topImage"
        >
          <v-theme-provider dark>
            <v-container fill-height>
              <v-row
                align="center"
                class="white--text mx-auto"
                justify="center"
              >
                <v-col
                  class="white--text text-center"
                  cols="12"
                  tag="h1"
                >
                  <span
                    :class="[$vuetify.breakpoint.xs ? 'text-h5' : 'text-h3']"
                    class="font-weight-light"
                  >
                    WELCOME TO
                  </span>

                  <br>

                  <span
                    :class="[$vuetify.breakpoint.xs ? 'text-h3' : 'text-h2']"
                    class="font-weight-black"
                  >
                    Pickup Track
                  </span>

                </v-col>

                <v-btn
                  class="align-self-end"
                  fab
                  outlined
                  @click="$vuetify.goTo('#about-me')"
                >
                  <v-icon>mdi-chevron-double-down</v-icon>
                </v-btn>
              </v-row>
            </v-container>
          </v-theme-provider>
        </v-img>
      </v-row>
    </section>

    <section id="about-me">
      <div class="py-12"></div>

      <v-container class="text-center">
        <span
          :class="[$vuetify.breakpoint.xs ? 'text-h4': 'text-h3']"
          class="font-weight-bold mb-3"
        >
          ABOUT ME
        </span>
        <v-responsive
          class="mx-auto my-8"
          width="56"
        >
          <v-divider class="mb-1"></v-divider>

          <v-divider></v-divider>
        </v-responsive>

        <v-responsive
          class="mx-auto title font-weight-light mb-8"
          max-width="720"
        >
          ランダムで歌う曲を決めてくれることにより、カラオケで歌う曲に悩む時間を減らし、カラオケをより楽しめるようにするアプリケーション
        </v-responsive>
        <p class="success--text">※曲を聴くことはできません</p>
        <div></div>

        <v-btn
          color="green accent-3 mt-3"
          :to="{ name: 'Register' }"
          large
        >
          <span class="white--text text--darken-1 font-weight-bold">
            新規登録
          </span>
        </v-btn>
      </v-container>

      <div class="py-12"></div>
    </section>

    <section
      id="features"
      class="black"
    >
      <div class="py-12"></div>

      <v-container class="text-center">
        <span
          :class="[$vuetify.breakpoint.xs ? 'text-h4': 'text-h3']"
          class="font-weight-bold mb-3"
        >
          FEATURES
        </span>
        <v-responsive
          class="mx-auto my-8"
          width="56"
        >
          <v-divider class="mb-1"></v-divider>

          <v-divider></v-divider>
        </v-responsive>

        <v-row>
          <v-col
            v-for="({ src, title, text }, i) in features"
            :key="i"
            cols="12"
            md="4"
          >
            <v-card
              class="px-4"
              color="black"
              flat
            >
              <v-theme-provider dark>
                <v-col align="center">
                  <v-img
                    :src="src"
                    height="300"
                    width="400"
                    contain
                  />
                </v-col>
              </v-theme-provider>

              <v-card-title
                class="justify-center font-weight-black text-uppercase"
                v-text="title"
              ></v-card-title>

              <v-card-text
                class="subtitle-1"
                v-text="text"
              >
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>

      <div class="py-12"></div>
    </section>
  </div>
</template>

<script>
export default {
  name: "Top",

  data () {
    return {
      topImage: require('../images/top.jpg'),
      features: [
        {
          src: require('../images/add.svg'),
          title: '曲を検索して追加する',
          text: '数千万曲の楽曲の中から曲名、アーティスト名、アルバム名等から検索可能です。また、そこからお好きな曲をワンタッチでマイライブラリに追加したり削除することができます。',
        },
        {
          src: require('../images/choose.svg'),
          title: 'マイライブラリからピックアップ',
          text: 'マイライブラリに追加した楽曲の中からランダムで1曲をピックアップ！もし、気分じゃない楽曲が出ても、何度でもピックアップすることができます。',
        },
        {
          src: require('../images/music.svg'),
          title: 'あとは歌うだけ！',
          text: '歌う楽曲が決まったなら、あとは気持ちよく歌ってカラオケを楽しみましょう！',
        },
      ],
    }
  }
}
</script>

<template>
  <div
    id="tracks-search"
    class="col-lg-6 offset-lg-3"
  >
    <v-container>
      <div class="h2 mt-1 mb-5">
        検索
      </div>
      <v-text-field
        v-model="search"
        type="text"
        filled
        clearable
        label="Search"
        clear-icon="mdi-close-thick"
        @click:clear="clearSearch"
        @change="searchTrack"
      >
        <template v-slot:prepend-inner>
          <v-fade-transition leave-absolute>
            <v-progress-circular
              v-if="loading"
              size="24"
              color="info"
              indeterminate
            ></v-progress-circular>
            <v-icon>mdi-magnify</v-icon>
          </v-fade-transition>
        </template>
        <template v-slot:append-outer>
          <v-btn
            color="green accent-3"
            @click="searchTrack"
            :disabled="!search || loading"
          >
            検索
          </v-btn>
        </template>
      </v-text-field>
      <v-card
        class="mx-auto"
      >
        <v-list subheader>
          <v-subheader>検索結果</v-subheader>
          <v-list-item
            v-for="track in tracks"
            :key="track.id"
          >
            <!-- <v-list-item-icon class="mr-4">
              <v-icon :color="chat.active ? 'deep-purple accent-4' : 'grey'">
                mdi-message-outline
              </v-icon>
            </v-list-item-icon> -->

            <v-list-item-avatar class="mr-3">
              <v-img
                alt="Track image"
                :src="track.album.images[2].url"
              ></v-img>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title v-text="track.name"></v-list-item-title>
              <v-list-item-subtitle v-text="track.artists[0].name"></v-list-item-subtitle>
            </v-list-item-content>


          </v-list-item>
        </v-list>
      </v-card>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "Search",
  data() {
    return {
      search: '',
      loading: false,
    }
  },

  computed: {
    ...mapGetters("tracks", ["tracks"])
  },

  methods: {
    ...mapActions("tracks", ["searchTracks"]),

    clearSearch() {
      this.search = ''
    },

    async searchTrack() {
      this.loading = true
      try {
        await this.searchTracks(this.search)
        this.loading = false
        if (this.tracks.length == 0) {
          this.$store.dispatch("flashMessages/showMessage",
          {
            message: "検索結果がありません",
            type: "error",
            status: true
          }
        )
        }
      } catch(error) {
        console.log(error)
      }
    }
  }
}
</script>

<style scoped>
</style>

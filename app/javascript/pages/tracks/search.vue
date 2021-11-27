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
            v-for="track in displayTracks"
            :key="track.index"
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
              <v-list-item-subtitle v-text="`${track.artists[0].name} - ${track.album.name}`"></v-list-item-subtitle>
            </v-list-item-content>


          </v-list-item>
        </v-list>
      </v-card>
      <div
        class="text-center"
        v-if="!displayTracks.length == 0"
      >
        <v-pagination
          v-model="page"
          :length="lastPage"
          color="green accent-3"
          circle
          prev-icon="mdi-menu-left"
          next-icon="mdi-menu-right"
          @input="pageChange"
        ></v-pagination>
      </div>
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
      page: 1,
      lastPage: 1,
      displayTracks: [],
      pageSize: 10
    }
  },

  computed: {
    ...mapGetters("tracks", ["tracks"]),

    options () {
      return {
        duration: 0,
        offset: 0,
        easing: "easeOutQuint",
      }
    }
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
        this.displayTracks = this.tracks.slice(0, this.pageSize)
        this.lastPage = this.tracks.length / 10
        this.page = 1
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
    },

    pageChange() {
      this.$vuetify.goTo(0, this.options)
      this.displayTracks = this.tracks.slice(this.pageSize*(this.page - 1), this.pageSize*(this.page))
    }
  }
}
</script>

<style scoped>
</style>

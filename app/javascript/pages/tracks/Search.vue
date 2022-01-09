<template>
  <div
    id="tracks-search"
    class="col-lg-6 offset-lg-3"
  >
    <v-container>
      <h2 class="mt-1 mb-5">
        楽曲検索
      </h2>
      <v-text-field
        v-model="search"
        type="text"
        filled
        clearable
        label="Search"
        clear-icon="mdi-close-thick"
        @click:clear="clearSearch"
        @keydown.enter="searchTrack"
      >
        <template v-slot:prepend-inner>
          <v-fade-transition leave-absolute>
            <v-progress-circular
              v-if="loading"
              size="24"
              color="info"
              indeterminate
            ></v-progress-circular>
            <v-icon v-else>mdi-magnify</v-icon>
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
      <TracksListCard
        :tracks="displayTracks"
        :library="myLibrary"
        :submitting="submitting"
        @add-track="handleAddTrack"
        @delete-track="handleDeleteTrack"
      >
        <template v-slot:subheader>
          <v-subheader>
            検索結果
          </v-subheader>
        </template>
      </TracksListCard>
      <div
        class="text-center"
        v-if="displayTracks.length != 0"
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
import TracksListCard from "./components/TracksListCard"

export default {
  name: "Search",
  data() {
    return {
      search: '',
      loading: false,
      page: 1,
      lastPage: 1,
      displayTracks: [],
      pageSize: 10,
      submitting: false,
      track: {
        track_id: '',
        name: '',
        artist_name: '',
        album_name: '',
        image_url: ''
      }
    }
  },

  components: {
    TracksListCard
  },

  computed: {
    ...mapGetters("searchTracks", ["tracks"]),
    ...mapGetters("myLibrary", ["myLibrary"]),

    options() {
      return {
        duration: 0,
        offset: 0,
        easing: "easeOutQuint",
      }
    }
  },

  created() {
    this.fetchTracks()
  },

  methods: {
    ...mapActions("searchTracks", ["searchTracks"]),
    ...mapActions("myLibrary", [
      "fetchTracks",
      "addTrack",
      "deleteTrack"
    ]),

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
        this.loading = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "検索に失敗しました",
            type: "error",
            status: true
          }
        )
        console.log(error)
      }
    },

    pageChange() {
      this.$vuetify.goTo(0, this.options)
      this.displayTracks = this.tracks.slice(this.pageSize*(this.page - 1), this.pageSize*(this.page))
    },

    async handleAddTrack(addTrack) {
      this.track.track_id = addTrack.id
      this.track.name = addTrack.name
      this.track.artist_name = addTrack.artists[0].name
      this.track.album_name = addTrack.album.name
      this.track.image_url = addTrack.album.images[0].url
      this.submitting = true
      try {
        await this.addTrack(this.track)
        this.submitting = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "マイライブラリに追加しました",
            type: "blue lighten-1",
            status: true
          }
        )
      } catch(error) {
        this.submitting = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "追加に失敗しました",
            type: "error",
            status: true
          }
        )
        console.log(error)
      }
    },

    async handleDeleteTrack(deleteTrack) {
      this.track.track_id = deleteTrack.id
      this.track.name = deleteTrack.name
      this.track.artist_name = deleteTrack.artists[0].name
      this.track.album_name = deleteTrack.album.name
      this.track.image_url = deleteTrack.album.images[0].url
      this.submitting = true
      try {
        await this.deleteTrack(this.track)
        this.submitting = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "マイライブラリから削除しました",
            type: "pink lighten-1",
            status: true
          }
        )
      } catch(error) {
        this.submitting = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "削除に失敗しました",
            type: "error",
            status: true
          }
        )
        console.log(error)
      }
    }
  }
}
</script>

<style scoped>
</style>

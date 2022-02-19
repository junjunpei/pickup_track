<template>
  <v-container id="my-library">
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
        <div class="my-5 d-flex justify-space-between">
          <h2>
            マイライブラリ
          </h2>
          <PickupTrack
            :track="pickupTrack"
            :tracks="searchedTracks"
            :loading="loading"
            @pickup-track="handlePickupTrack"
            @history-track="handleAddHistory"
          />
        </div>
        <v-text-field
          v-model="search"
          type="text"
          filled
          dense
          label="Search"
          :append-icon="this.search != '' ? 'mdi-close-thick' : ''"
          @click:append="clearSearch"
        >
          <template v-slot:prepend-inner>
            <v-icon>mdi-magnify</v-icon>
          </template>
        </v-text-field>
        <TracksListCard
          :tracks="searchedTracks"
          :submitting="submitting"
          :recommendTracks="recommendTracks"
          :myLibrary="myLibrary"
          @delete-track="handleDeleteTrack"
          @delete-recommend-track="handleDeleteRecommendTrack"
          @add-track="handleAddTrack"
        >
          <template
            v-if="myLibrary.length === 0"
            v-slot:subheader
          >
            <v-subheader>
              まだ追加された曲はありません
            </v-subheader>
          </template>
          <template
            v-else
            v-slot:subheader
          >
            <v-subheader>
              {{ searchedTracks.length }}曲
            </v-subheader>
          </template>
        </TracksListCard>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import TracksListCard from "./components/TracksListCard"
import PickupTrack from "./components/PickupTrack"

export default {
  name: "MyLibrary",

  data() {
    return {
      search: '',
      loading: false,
      pickupTrack: '',
      submitting: false,
      track: {
        track_id: '',
        artist_id: '',
        name: '',
        artist_name: '',
        album_name: '',
        image_url: '',
        track_url: ''
      }
    }
  },

  components: {
    TracksListCard,
    PickupTrack
  },

  computed: {
    ...mapGetters("myLibrary", ["myLibrary"]),

    ...mapGetters("recommendTracks", ["recommendTracks"]),

    searchedTracks() {
      return this.myLibrary.filter(track => {
        return track.name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.artist_name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.album_name.toLowerCase().indexOf(this.search.toLowerCase()) != -1
      })
    }
  },

  created() {
    this.fetchTracks()

    var unwatch = this.$watch("pickupTrack", function() {
      this.fetchRecommendTracks(this.pickupTrack)
      unwatch()
    })
  },

  mounted() {
    this.handlePickupTrack()
  },

  watch: {
    searchedTracks: function() {
      this.handlePickupTrack()
    }
  },

  methods: {
    ...mapActions("myLibrary", [
      "fetchTracks",
      "deleteTrack",
      "addTrack"
    ]),

    ...mapActions("historyTracks", [
      "addHistoryTrack"
    ]),

    ...mapActions("recommendTracks", [
      "fetchRecommendTracks"
    ]),

    async handleAddTrack(addTrack) {
      this.track.track_id = addTrack.id
      this.track.artist_id = addTrack.artists[0].id
      this.track.name = addTrack.name
      this.track.artist_name = addTrack.artists[0].name
      this.track.album_name = addTrack.album.name
      this.track.image_url = addTrack.album.images[0].url
      this.track.track_url = addTrack.external_urls.spotify
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

    async handleAddHistory(addHistoryTrack) {
      this.loading = true
      try {
        await this.addHistoryTrack(addHistoryTrack)
        this.loading = false
      } catch(error) {
        this.loading = false
        console.log(error)
      }
    },

    async handleDeleteTrack(deleteTrack) {
      this.submitting = true
      try {
        await this.deleteTrack(deleteTrack)
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
    },

    async handleDeleteRecommendTrack(deleteTrack) {
      this.track.track_id = deleteTrack.id
      this.track.artist_id = deleteTrack.artists[0].id
      this.track.name = deleteTrack.name
      this.track.artist_name = deleteTrack.artists[0].name
      this.track.album_name = deleteTrack.album.name
      this.track.image_url = deleteTrack.album.images[0].url
      this.track.track_url = deleteTrack.external_urls.spotify
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
    },

    clearSearch() {
      this.search = ''
    },

    handlePickupTrack() {
      this.loading = true
      this.pickupTrack = this.searchedTracks[Math.floor(Math.random() * this.searchedTracks.length)]
      this.loading = false
    }
  }
}
</script>

<style scoped>
</style>
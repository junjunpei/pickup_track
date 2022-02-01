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
          clearable
          label="Search"
          clear-icon="mdi-close-thick"
          @click:clear="clearSearch"
        >
          <template v-slot:prepend-inner>
            <v-icon>mdi-magnify</v-icon>
          </template>
        </v-text-field>
        <TracksListCard
          :tracks="searchedTracks"
          :submitting="submitting"
          @delete-track="handleDeleteTrack"
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
      // myLibraryTracks: [],
      search: '',
      loading: false,
      pickupTrack: '',
      submitting: false
    }
  },

  components: {
    TracksListCard,
    PickupTrack
  },

  computed: {
    ...mapGetters("myLibrary", ["myLibrary"]),

    // sortTracks() {
    //   return this.myLibraryTracks.sort((a,b) => a.index - b.index)
    // },

    searchedTracks() {
      return this.myLibrary.filter(track => {
        return track.name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.artist_name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.album_name.toLowerCase().indexOf(this.search.toLowerCase()) != -1
      })
    },

    // setPickupTrack() {
    //   this.pickupTrack = this.searchedTracks[Math.floor(Math.random() * this.searchedTracks.length)]
    // }
  },

  created() {
    this.fetchTracks()
  },

  methods: {
    ...mapActions("myLibrary", [
      "fetchTracks",
      // "addTrack",
      "deleteTrack",
    ]),

    ...mapActions("historyTracks", [
      "addHistoryTrack"
    ]),

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
<template>
  <v-container
    id="my-library"
  >
    <v-row align="center">
      <v-col
        lg="6"
        offset-lg="3"
        md="8"
        offset-md="2"
        sm="10"
        offset-sm="1"
        xs="10"
        offset-xs="1"
      >
        <div class="mt-4 mb-5 d-flex justify-content-between">
          <h2>
            マイライブラリ
          </h2>
          <PickupTrack
            :track="pickupTrack"
            :loading="loading"
            @pickup-track="handlePickupTrack"
          />
        </div>
        <v-text-field
          v-model="search"
          type="text"
          filled
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
          :library="myLibrary"
          :submitting="loading"
          @create-track="handleCreateTrack"
          @delete-track="handleDeleteTrack"
        >
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
      myLibraryTracks: [],
      search: '',
      loading: false,
      pickupTrack: '',
    }
  },

  components: {
    TracksListCard,
    PickupTrack
  },

  computed: {
    ...mapGetters("myLibrary", ["myLibrary"]),

    sortTracks() {
      return this.myLibraryTracks.sort((a,b) => a.index - b.index)
    },

    searchedTracks() {
      return this.sortTracks.filter(track => {
        return track.name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.artists[0].name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.album.name.toLowerCase().indexOf(this.search.toLowerCase()) != -1
      })
    },

    setPickupTrack() {
      this.pickupTrack = this.searchedTracks[Math.floor(Math.random() * this.searchedTracks.length)]
    }
  },

  watch: {
    myLibrary() {
      const added = this.myLibraryTracks.some(myLibraryTrack => {
        return this.myLibrary.indexOf(myLibraryTrack.id)
      })

      this.myLibrary.forEach((myTrack, index) => {
        this.$axios.post("tracks/my-library",{ track_id: myTrack.track_id })
          .then(response => {
            if (!added) {
              response.data["index"] = index
              this.myLibraryTracks.push(response.data)
            }
          })
          .catch(error => {
            this.$store.dispatch("flashMessages/showMessage",
              {
                message: "ライブラリの読み込みに失敗しました",
                type: "error",
                status: true
              }
            )
            console.log(error)
          })
      })
    }
  },

  created() {
    this.fetchTracks()
  },

  methods: {
    ...mapActions("myLibrary", [
      "fetchTracks",
      "createTrack",
      "deleteTrack",
    ]),

    async handleCreateTrack(trackId) {
      this.submitting = true
      try {
        await this.createTrack(trackId)
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

    async handleDeleteTrack(trackId) {
      this.submitting = true
      try {
        await this.deleteTrack(trackId)
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
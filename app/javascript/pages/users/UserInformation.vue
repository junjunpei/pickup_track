<template>
  <v-container
    id="user-information"
  >
    <v-row>
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
        <h2 class="mt-5">
          ユーザー情報
        </h2>
        <v-list
          color="#121212"
          class="text-center my-8"
        >
          <v-list-item>
            <h4>名前</h4>
            <v-list-item-content>
              <v-list-item-title class="list-item">{{ authUser.name }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item class="mt-5">
            <h4>メールアドレス</h4>
            <v-list-item-content>
              <v-list-item-title class="list-item">{{ authUser.email }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item class="mt-6">
            <h4>今までに歌った回数</h4>
            <v-list-item-content>
              <v-list-item-title class="list-item">{{ historyTracks.length }}回</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-btn
            color="success"
            outlined
            class="mt-3"
            :to="{ name: 'UserEdit' }"
          >
            <v-icon>mdi-account-edit-outline</v-icon>
            ユーザー情報編集
          </v-btn>
        </v-list>
        <HistoryTracksList
          :tracks="historyTracks"
          :submitting="submitting"
          :tracksTimes="historyTracksTimes"
          @delete-history-track="handleDeleteHistoryTrack"
        >
          <template v-slot:subheader>
            <v-subheader>
              歌った履歴
            </v-subheader>
          </template>
        </HistoryTracksList>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex"
import HistoryTracksList from "./components/HistoryTracksList.vue"

export default {
  name: "UserInformation",

  components: {
    HistoryTracksList
  },

  data() {
    return {
      submitting: false,
      historyTracksTimes: ""
    }
  },

  created() {
    this.fetchHistoryTracks()
    this.handleFetchHistoryTracksTimes()
  },

  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("historyTracks", ["historyTracks"]),
  },

  watch: {
    historyTracks: function() {
      this.handleFetchHistoryTracksTimes()
    }
  },

  methods: {
    ...mapActions("historyTracks",[
      "fetchHistoryTracks",
      "deleteHistoryTrack"
    ]),

    handleFetchHistoryTracksTimes() {
      this.$axios.get("histories/times")
        .then(response => {
          this.historyTracksTimes = response.data
        })
        .catch(error => {
          console.log(error)
        })
    },

    async handleDeleteHistoryTrack(deleteTrack) {
      this.submitting = true
      try {
        await this.deleteHistoryTrack(deleteTrack)
        this.submitting = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "履歴から削除されました",
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
.list-item {
  word-break: break-word;
  white-space: pre-line;
}
</style>
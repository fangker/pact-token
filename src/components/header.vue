<template>
  <v-app-bar
      color="white"
      flat
      app
      style="height: 12.5%"
  >
    <v-container class="py-0 fill-height">
      <a style="margin-right: 0%" href="/">
        <v-img style=""
               max-height="110%"
               max-width="110"
               src="data:image/png;base64,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"
        ></v-img>
      </a>

      <v-btn
          v-for="link in links"
          :key="link"
          text
      >
        {{ link }}
      </v-btn>

      <v-spacer></v-spacer>
      <v-btn
          class="ma-2 metamask"
          :loading="connecting"
          :disabled="connecting"
          color="secondary"
          @click="this.connectMetamask"
      >
        <div v-if="!this.$store.state.user.select" style="padding-left: 10%">
          Connect metaMask
        </div>
        <div v-else style="padding-left: 10%;font-size: x-small;font-weight: bold">
          {{ this.$store.state.user.account.slice(0, 20) }}
        </div>
      </v-btn>

    </v-container>
  </v-app-bar>
</template>

<script>

import loadWeb3 from "../util/web3";
import chain from "../store/modules/chain";

export default {
  name: 'appHeader',
  data: () => ({
    URL:"http://localhost:8080/",
    loader: null,
    connecting: false,
    links: [
      'Dashboard',
      'Messages',
      'Profile',
      'Updates',
    ],
  }),
  async mounted() {
    this.connecting = true;
    setTimeout(async () => {
      const state = await loadWeb3(true);
      await this.$store.dispatch('chain/registerWeb3', state);
      const selectAccount = (await state.eth.getAccounts())[0];
      await this.$store.dispatch('user/commitAccount', { account: selectAccount, select: state.currentProvider.isMetaMask });
      this.connecting = false;
      console.log("load account ", selectAccount, state.currentProvider.isMetaMask)
    }, 300);
  },
  methods: {
    async connectMetamask() {
      this.connecting = true;
      const state = await loadWeb3(false);
      if (!window.ethereum) {
        this.connecting = false;
        return alert("Can't find MetaMask")
      }
      await this.$store.dispatch('chain/registerWeb3', state);
      const selectAccount = (await state.eth.getAccounts())[0];
      console.log("connect account ", selectAccount)
      await this.$store.dispatch('user/commitAccount', { account: selectAccount, select: state.currentProvider.isMetaMask });
      setTimeout(() => {
        this.connecting = false;
      }, 1000)
    }
  },
}
</script>
<style>

.metamask {
  background: url(data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjM1NSIgdmlld0JveD0iMCAwIDM5NyAzNTUiIHdpZHRoPSIzOTciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGcgZmlsbD0ibm9uZSIgZmlsbC1ydWxlPSJldmVub2RkIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMSAtMSkiPjxwYXRoIGQ9Im0xMTQuNjIyNjQ0IDMyNy4xOTU0NzIgNTIuMDA0NzE3IDEzLjgxMDE5OHYtMTguMDU5NDlsNC4yNDUyODMtNC4yNDkyOTJoMjkuNzE2OTgydjIxLjI0NjQ1OSAxNC44NzI1MjNoLTMxLjgzOTYyNGwtMzkuMjY4ODY4LTE2Ljk5NzE2OXoiIGZpbGw9IiNjZGJkYjIiLz48cGF0aCBkPSJtMTk5LjUyODMwNSAzMjcuMTk1NDcyIDUwLjk0MzM5NyAxMy44MTAxOTh2LTE4LjA1OTQ5bDQuMjQ1MjgzLTQuMjQ5MjkyaDI5LjcxNjk4MXYyMS4yNDY0NTkgMTQuODcyNTIzaC0zMS44Mzk2MjNsLTM5LjI2ODg2OC0xNi45OTcxNjl6IiBmaWxsPSIjY2RiZGIyIiB0cmFuc2Zvcm09Im1hdHJpeCgtMSAwIDAgMSA0ODMuOTYyMjcgMCkiLz48cGF0aCBkPSJtMTcwLjg3MjY0NCAyODcuODg5NTIzLTQuMjQ1MjgzIDM1LjA1NjY1NyA1LjMwNjYwNC00LjI0OTI5Mmg1NS4xODg2OGw2LjM2NzkyNSA0LjI0OTI5Mi00LjI0NTI4NC0zNS4wNTY2NTctOC40OTA1NjUtNS4zMTE2MTUtNDIuNDUyODMyIDEuMDYyMzIzeiIgZmlsbD0iIzM5MzkzOSIvPjxwYXRoIGQ9Im0xNDIuMjE2OTg0IDUwLjk5MTUwMjIgMjUuNDcxNjk4IDU5LjQ5MDA4NTggMTEuNjc0NTI4IDE3My4xNTg2NDNoNDEuMzkxNTExbDEyLjczNTg0OS0xNzMuMTU4NjQzIDIzLjM0OTA1Ni01OS40OTAwODU4eiIgZmlsbD0iI2Y4OWMzNSIvPjxwYXRoIGQ9Im0zMC43NzgzMDIzIDE4MS42NTcyMjYtMjkuNzE2OTgxNTMgODYuMDQ4MTYxIDc0LjI5MjQ1MzkzLTQuMjQ5MjkzaDQ3Ljc1OTQzNDN2LTM3LjE4MTMwM2wtMi4xMjI2NDEtNzYuNDg3MjUzLTEwLjYxMzIwOCA4LjQ5ODU4M3oiIGZpbGw9IiNmODlkMzUiLz48cGF0aCBkPSJtODcuMDI4MzAzMiAxOTEuMjE4MTM0IDg3LjAyODMwMjggMi4xMjQ2NDYtOS41NTE4ODYgNDQuNjE3NTYzLTQxLjM5MTUxMS0xMC42MjMyMjl6IiBmaWxsPSIjZDg3YzMwIi8+PHBhdGggZD0ibTg3LjAyODMwMzIgMTkyLjI4MDQ1NyAzNi4wODQ5MDU4IDMzLjk5NDMzNHYzMy45OTQzMzR6IiBmaWxsPSIjZWE4ZDNhIi8+PHBhdGggZD0ibTEyMy4xMTMyMDkgMjI3LjMzNzExNCA0Mi40NTI4MzEgMTAuNjIzMjI5IDEzLjc5NzE3IDQ1LjY3OTg4OC05LjU1MTg4NiA1LjMxMTYxNS00Ni42OTgxMTUtMjcuNjIwMzk4eiIgZmlsbD0iI2Y4OWQzNSIvPjxwYXRoIGQ9Im0xMjMuMTEzMjA5IDI2MS4zMzE0NDgtOC40OTA1NjUgNjUuODY0MDI0IDU2LjI1LTM5LjMwNTk0OXoiIGZpbGw9IiNlYjhmMzUiLz48cGF0aCBkPSJtMTc0LjA1NjYwNiAxOTMuMzQyNzggNS4zMDY2MDQgOTAuMjk3NDUxLTE1LjkxOTgxMi00Ni4yMTEwNDl6IiBmaWxsPSIjZWE4ZTNhIi8+PHBhdGggZD0ibTc0LjI5MjQ1MzkgMjYyLjM5Mzc3MSA0OC44MjA3NTUxLTEuMDYyMzIzLTguNDkwNTY1IDY1Ljg2NDAyNHoiIGZpbGw9IiNkODdjMzAiLz48cGF0aCBkPSJtMjQuNDEwMzc3NyAzNTUuODc4MTkzIDkwLjIxMjI2NjMtMjguNjgyNzIxLTQwLjMzMDE5MDEtNjQuODAxNzAxLTczLjIzMTEzMzEzIDUuMzExNjE2eiIgZmlsbD0iI2ViOGYzNSIvPjxwYXRoIGQ9Im0xNjcuNjg4NjgyIDExMC40ODE1ODgtNDUuNjM2NzkzIDM4LjI0MzYyNy0zNS4wMjM1ODU4IDQyLjQ5MjkxOSA4Ny4wMjgzMDI4IDMuMTg2OTY5eiIgZmlsbD0iI2U4ODIxZSIvPjxwYXRoIGQ9Im0xMTQuNjIyNjQ0IDMyNy4xOTU0NzIgNTYuMjUtMzkuMzA1OTQ5LTQuMjQ1MjgzIDMzLjk5NDMzNHYxOS4xMjE4MTNsLTM4LjIwNzU0OC03LjQzNjI2eiIgZmlsbD0iI2RmY2VjMyIvPjxwYXRoIGQ9Im0yMjkuMjQ1Mjg2IDMyNy4xOTU0NzIgNTUuMTg4NjgtMzkuMzA1OTQ5LTQuMjQ1MjgzIDMzLjk5NDMzNHYxOS4xMjE4MTNsLTM4LjIwNzU0OC03LjQzNjI2eiIgZmlsbD0iI2RmY2VjMyIgdHJhbnNmb3JtPSJtYXRyaXgoLTEgMCAwIDEgNTEzLjY3OTI1MiAwKSIvPjxwYXRoIGQ9Im0xMzIuNjY1MDk2IDIxMi40NjQ1OTMtMTEuNjc0NTI4IDI0LjQzMzQyNyA0MS4zOTE1MS0xMC42MjMyMjl6IiBmaWxsPSIjMzkzOTM5IiB0cmFuc2Zvcm09Im1hdHJpeCgtMSAwIDAgMSAyODMuMzcyNjQ2IDApIi8+PHBhdGggZD0ibTIzLjM0OTA1NyAxLjA2MjMyMjk2IDE0NC4zMzk2MjUgMTA5LjQxOTI2NTA0LTI0LjQxMDM3OC01OS40OTAwODU4eiIgZmlsbD0iI2U4OGYzNSIvPjxwYXRoIGQ9Im0yMy4zNDkwNTcgMS4wNjIzMjI5Ni0xOS4xMDM3NzM5MiA1OC40Mjc3NjI5NCAxMC42MTMyMDc3MiA2My43MzkzNzgxLTcuNDI5MjQ1NDEgNC4yNDkyOTIgMTAuNjEzMjA3NzEgOS41NjA5MDYtOC40OTA1NjYxNyA3LjQzNjI2MSAxMS42NzQ1Mjg0NyAxMC42MjMyMjktNy40MjkyNDU0IDYuMzczOTM4IDE2Ljk4MTEzMjMgMjEuMjQ2NDU5IDc5LjU5OTA1NzctMjQuNDMzNDI4YzM4LjkxNTA5Ni0zMS4xNjE0NzMgNTguMDE4ODY5LTQ3LjA5NjMxOCA1Ny4zMTEzMjItNDcuODA0NTMzLS43MDc1NDgtLjcwODIxNS00OC44MjA3NTYtMzcuMTgxMzAzNi0xNDQuMzM5NjI1LTEwOS40MTkyNjUwNHoiIGZpbGw9IiM4ZTVhMzAiLz48ZyB0cmFuc2Zvcm09Im1hdHJpeCgtMSAwIDAgMSAzOTkuMDU2NjExIDApIj48cGF0aCBkPSJtMzAuNzc4MzAyMyAxODEuNjU3MjI2LTI5LjcxNjk4MTUzIDg2LjA0ODE2MSA3NC4yOTI0NTM5My00LjI0OTI5M2g0Ny43NTk0MzQzdi0zNy4xODEzMDNsLTIuMTIyNjQxLTc2LjQ4NzI1My0xMC42MTMyMDggOC40OTg1ODN6IiBmaWxsPSIjZjg5ZDM1Ii8+PHBhdGggZD0ibTg3LjAyODMwMzIgMTkxLjIxODEzNCA4Ny4wMjgzMDI4IDIuMTI0NjQ2LTkuNTUxODg2IDQ0LjYxNzU2My00MS4zOTE1MTEtMTAuNjIzMjI5eiIgZmlsbD0iI2Q4N2MzMCIvPjxwYXRoIGQ9Im04Ny4wMjgzMDMyIDE5Mi4yODA0NTcgMzYuMDg0OTA1OCAzMy45OTQzMzR2MzMuOTk0MzM0eiIgZmlsbD0iI2VhOGQzYSIvPjxwYXRoIGQ9Im0xMjMuMTEzMjA5IDIyNy4zMzcxMTQgNDIuNDUyODMxIDEwLjYyMzIyOSAxMy43OTcxNyA0NS42Nzk4ODgtOS41NTE4ODYgNS4zMTE2MTUtNDYuNjk4MTE1LTI3LjYyMDM5OHoiIGZpbGw9IiNmODlkMzUiLz48cGF0aCBkPSJtMTIzLjExMzIwOSAyNjEuMzMxNDQ4LTguNDkwNTY1IDY1Ljg2NDAyNCA1NS4xODg2OC0zOC4yNDM2MjZ6IiBmaWxsPSIjZWI4ZjM1Ii8+PHBhdGggZD0ibTE3NC4wNTY2MDYgMTkzLjM0Mjc4IDUuMzA2NjA0IDkwLjI5NzQ1MS0xNS45MTk4MTItNDYuMjExMDQ5eiIgZmlsbD0iI2VhOGUzYSIvPjxwYXRoIGQ9Im03NC4yOTI0NTM5IDI2Mi4zOTM3NzEgNDguODIwNzU1MS0xLjA2MjMyMy04LjQ5MDU2NSA2NS44NjQwMjR6IiBmaWxsPSIjZDg3YzMwIi8+PHBhdGggZD0ibTI0LjQxMDM3NzcgMzU1Ljg3ODE5MyA5MC4yMTIyNjYzLTI4LjY4MjcyMS00MC4zMzAxOTAxLTY0LjgwMTcwMS03My4yMzExMzMxMyA1LjMxMTYxNnoiIGZpbGw9IiNlYjhmMzUiLz48cGF0aCBkPSJtMTY3LjY4ODY4MiAxMTAuNDgxNTg4LTQ1LjYzNjc5MyAzOC4yNDM2MjctMzUuMDIzNTg1OCA0Mi40OTI5MTkgODcuMDI4MzAyOCAzLjE4Njk2OXoiIGZpbGw9IiNlODgyMWUiLz48cGF0aCBkPSJtMTMyLjY2NTA5NiAyMTIuNDY0NTkzLTExLjY3NDUyOCAyNC40MzM0MjcgNDEuMzkxNTEtMTAuNjIzMjI5eiIgZmlsbD0iIzM5MzkzOSIgdHJhbnNmb3JtPSJtYXRyaXgoLTEgMCAwIDEgMjgzLjM3MjY0NiAwKSIvPjxwYXRoIGQ9Im0yMy4zNDkwNTcgMS4wNjIzMjI5NiAxNDQuMzM5NjI1IDEwOS40MTkyNjUwNC0yNC40MTAzNzgtNTkuNDkwMDg1OHoiIGZpbGw9IiNlODhmMzUiLz48cGF0aCBkPSJtMjMuMzQ5MDU3IDEuMDYyMzIyOTYtMTkuMTAzNzczOTIgNTguNDI3NzYyOTQgMTAuNjEzMjA3NzIgNjMuNzM5Mzc4MS03LjQyOTI0NTQxIDQuMjQ5MjkyIDEwLjYxMzIwNzcxIDkuNTYwOTA2LTguNDkwNTY2MTcgNy40MzYyNjEgMTEuNjc0NTI4NDcgMTAuNjIzMjI5LTcuNDI5MjQ1NCA2LjM3MzkzOCAxNi45ODExMzIzIDIxLjI0NjQ1OSA3OS41OTkwNTc3LTI0LjQzMzQyOGMzOC45MTUwOTYtMzEuMTYxNDczIDU4LjAxODg2OS00Ny4wOTYzMTggNTcuMzExMzIyLTQ3LjgwNDUzMy0uNzA3NTQ4LS43MDgyMTUtNDguODIwNzU2LTM3LjE4MTMwMzYtMTQ0LjMzOTYyNS0xMDkuNDE5MjY1MDR6IiBmaWxsPSIjOGU1YTMwIi8+PC9nPjwvZz48L3N2Zz4=) #2A2F36 15px local;
  border: 1px solid #F6BA5E;
  background-size: auto 50%;
  background-repeat: no-repeat;
  text-align: center;
  border-radius: 24px;
  color: #F6BA5E;
  display: flex;
  margin: 0px;
  width: 25%;
  min-width: 36px;
  text-rendering: auto;
  appearance: auto;
  text-transform: unset;
}

/*.header_bar{*/
/*  display: block;*/
/*  height: 400%;*/
/*  border-style: solid;*/
/*}*/
</style>

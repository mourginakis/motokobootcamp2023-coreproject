<script>
  import * as dao from "../src/declarations/dao"
  import Navbar from "./components/Navbar.svelte"
  import ConnectButton from "./components/shared/ConnectButton.svelte"
  import { view } from "./stores.js"
  import Home from "./components/Home.svelte"
  import Vote from "./components/Vote.svelte"
  import View from "./components/View.svelte"
  import Create from "./components/Create.svelte"
</script>

<div class="App">
    <ConnectButton />
  <div class="main">
    <Navbar />
    {#if $view.current === $view.home}
      <Home />
    {:else if $view.current === $view.view}
      <View />
    {:else if $view.current === $view.vote}
      <Vote />
    {:else if $view.current === $view.create}
      <Create />
    {/if}
  </div>
</div>

<style global>
  body {
    font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;
  }

</style>

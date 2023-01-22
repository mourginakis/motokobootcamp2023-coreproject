<script>
  import { plugConnection } from "../connexion"
  export let message = "Sign in"
  import { principal } from "../../stores"
  import { get } from "svelte/store"

  import { dao as DAO_anony } from "../../../src/declarations/dao"

  const testconnection = async () => {
    let result = await DAO_anony.whoami("");
    return result;
  }
  let userid_promise = testconnection();

</script>



<button on:click={() => plugConnection()}> {message} </button>
<span class="userid">
  {#if $principal}
    whoami: {get(principal)}
  {:else}
    whoami: {#await userid_promise then userid} {userid} {/await}
  {/if}
</span>

<style>
  .userid {
    margin-left: 15px;
    font-size: small;
  }
</style>


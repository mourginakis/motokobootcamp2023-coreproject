<script>
  import logo from ".././assets/camp_logo.png"
  import trifinity_1080p from ".././assets/trifinity_1080p.mp4"
  import trifinity_720p from ".././assets/trifinity_720p.mp4"


  import { dao as DAO_anony } from "../../src/declarations/dao"

  const getcyclesbalance = async () => {
    let result = await DAO_anony.get_cycles_balance();
    return result;
  }

let cycles_count_promise = getcyclesbalance();
console.log(cycles_count_promise);

</script>


<div class="home">
  <div class="center">

    <h2>George's DAO</h2>
    <hr />
    <h4>just a dao that will dissappear when the canister runs out of cycles</h4>

    <p>This dao doesn't do anything fancy at all.</p>
    <p>But we have a cool animation, so there's that.</p>

    <p>we have this many cycles left, btw: <br />
      {#await cycles_count_promise}
          |&nbsp;&nbsp;&nbsp;UNKNOWN 😱
      {:then cycles_count}
      |&nbsp;&nbsp;&nbsp;{cycles_count} cycles or <br />
      |&nbsp;&nbsp;&nbsp;{Number(BigInt(cycles_count)) / 1000000000000} Trillion cycles
      {/await}
    </p>


    <!-- svelte-ignore a11y-media-has-caption -->
    <video id="trifinity-background" autoplay loop muted>
      <source src={trifinity_1080p} type="video/mp4">
    </video>
  </div>
</div>


<style> 

#trifinity-background {
  width: 720px;
  height: 480px;
  object-fit: contain;
  position: fixed;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  z-index: -1;
  margin: auto;
  margin-top: 200px;
}

.center {
  margin: auto;
  width: 70%;
  padding: 10px;
}

</style>
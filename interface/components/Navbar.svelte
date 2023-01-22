<script>
  import { view } from "../stores.js"

  const handleView = () => {
    $view.current = $view.view
  }
  const handleCreate = () => {
    $view.current = $view.create
  }
  const handleVote = () => {
    $view.current = $view.vote
  }
  const handleHome = () => {
    $view.current = $view.home
  }
</script>

<nav>
  <ul id="navoptions">
    <li><a href="/" on:click|preventDefault={() => handleHome()}>George's DAO!</a></li>
    <li><a href="/" on:click|preventDefault={() => handleHome()}>Home</li>
    <li><a href="/" on:click|preventDefault={() => handleView()}>View</li>
    <li><a href="/" on:click|preventDefault={() => handleCreate()}>Create</li>
    <li><a href="/" on:click|preventDefault={() => handleVote()}>Vote</li>
  </ul>
</nav>


<style>
  ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333
  }
  
  li {
    float: left;
  }
  
  li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
  }
  
  li a:hover {
    background-color: #111;
  }

</style>

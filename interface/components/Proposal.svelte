<script>
  export let post

  let [id, proposal] = post;

</script>

<div class="post-preview">
  <h3>{proposal['id']}:</h3>
  <!-- <p>{post[1].creator.owner.toString()}</p> -->
  <p>Change website text to: {proposal['body']}</p>
  <p>Yes: {proposal['votesFor']}</p>
  <p>No:  {proposal['votesAgainst']}</p>
  <hr />
    <!-- Yes: {(post[1].votes[0] / BigInt(100000000)).toString()}, No: {(
      post[1].votes[1] / BigInt(100000000)
    ).toString()} -->
</div>

<style>
  .post-preview {
    border: 1px green;
    border-radius: 10px;
    margin-bottom: 8vmin;
  }

</style>

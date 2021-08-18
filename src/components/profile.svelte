<script>
  export let uid;
</script>

<style>
  div {
    display: flex;
    flex-direction: row;

    width: 30%;
  }
  img {
    position: flex-inline;
    height: 25px;
    width: 25px;
    border-radius: 30px;
  }
  span {margin-left: 1rem;}
</style>

<div>
  <aside>status: authenticated</aside> <span>uid: {uid}</span> 
</div>

<script>
import { onMount } from "svelte";

import {db} from "../firebase.js";
export let story;
export let user;

onMount(() => {

});

let player_name;
const setPlayerName = async (e) => {
  story.variablesState["character_name"] = player_name;
  let userRef = db.collection('players').doc(user.uid);
  
  await userRef.update({character_name: player_name});
  console.log('updated character name');
  
}

</script>


<input type="text" placeholder="Gahlahad" on:blur={setPlayerName} bind:value={player_name} />
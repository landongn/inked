<script>
import Choice from "../components/choice.svelte";
import StateManager from "$lib/story";
import story_data from "$lib/story_data/story.json";
import {Story} from "inkjs/dist/ink-es6.js";

let story = new Story(story_data);
let gameState = new StateManager(story);

import {latest_fragment, choices_list} from "$lib/story";


</script>

  {$latest_fragment}

  {#each $choices_list as choice}
    <Choice state={gameState} choice_data={choice} />
  {/each}


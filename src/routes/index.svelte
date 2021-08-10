<script>
import Choice from "../components/choice.svelte";
import StateManager from "$lib/story";
import story_data from "$lib/story_data/story.json";
import {Story} from "inkjs/dist/ink-es6.js";


import {fade} from "svelte/transition";


let story = new Story(story_data);
let gameState = new StateManager(story);

import {choices_list, dialog_backfill} from "$lib/story";
import { onMount } from "svelte";

onMount(() => {
  window.stateManager = gameState;
  window.story = story;
})

</script>

{#each $dialog_backfill as line}
  <p in:fade="{{delay: 250, duration: 300}}">{@html line}</p>
{/each}



{#each $choices_list as choice (choice.index)}
  <Choice state={gameState} choice_data={choice} />
{/each}


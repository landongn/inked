<script context="module">
  export async function load({ page, fetch, session, context }) {
    const res = await fetch("http://localhost:3000/json/2xs.json");
    if (res.ok) {
      return {
        props: {
          story_data: await res.json()
        }
      };
    }

    return {
      status: res.status,
      error: new Error(`Could not load`)
    };
  }
</script>

<style>
  .backfill {
    position: fixed;
    display: flex;
    right: 3rem;
    top: 0;
    height: 100vh;
    padding: 8px;
    width: 36%;
    margin: 0;
    flex-direction: column;
    overflow-y: scroll;
    padding-bottom: 3rem;
  }
</style>

<script>

export let story_data;
import Choice from "../components/choice.svelte";
import {Story} from "inkjs/dist/ink.js";
import StateManager from "$lib/story";
import { onMount } from "svelte";
import {latest_fragment, choices_list, dialog_backfill} from "$lib/story";
let parsed_story, gameState, backfill;

onMount(() => {
 parsed_story = new Story(story_data);
 gameState = new StateManager(parsed_story, backfill);
});


dialog_backfill.subscribe(() => {
  if (!backfill) { return }
  backfill.scrollTop = (backfill.scrollHeight * 2);
});
</script>

<div class="backfill" bind:this={backfill}>
  {#each $dialog_backfill as line}
    <p>{line}
  {/each}
</div>

{#each $choices_list as choice}
  <Choice state={gameState} choice_data={choice} />
{/each}


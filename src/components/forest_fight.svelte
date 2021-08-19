<script>
import { onMount } from "svelte";
import moblist from "$lib/entities/forest_creatures.js";
import {db} from "../firebase.js";
import { writable } from "svelte/store";
export let story;
export let user;

let backfill = writable([]);
let delay = 100;
let inc = 15;

function gameState() {
  let obj = {};
  Array.from(story.variablesState._globalVariables).map(([name, valueObj]) => {
    console.log(name, valueObj);
    obj[name] = valueObj.value;
  });
  return obj;
}

function add_delayed_line(line) {
  setTimeout(() => {
    backfill.update((v) => {
      v.push(line);
      return v;
    }, delay);
  })
}

function generate_text(props) {
 add_delayed_line({
   action: props.action,
   text: props.text
 })
}

function start_fight(mob) {
  let lines = [];
  let text, action;
  let state = gameState();

  text = `<div class="fight start-fight-line">
    <div class="fight-banner">**<span>FIGHT</span>**</div>
    <div class="mob_introduction">You have encountered ${mob.name}!</div>
    <div class="skill">Your skill allows you to get the first strike.</div>
    <div class="battle_report">
      <p>Your Hitpoints: ${state["hitpoints"]}</p>
      <p>${mob.name}'s Hitpoints: ${mob.hitpoints}</p>
    </div>
  `;
  generate_text({action: 'generated', text});
}

onMount(() => {
  let dice_mob = Math.floor(Math.random() * 8)
  let rank = story.variablesState["rank"];
  let mobs = moblist.map((e) => {if(e.rank == rank) return e;});
  let mob = mobs[dice_mob];
  console.log(mob);
  start_fight(mob, {...story.variablesState})
});
    
  </script>
  
  <div class="backfill">
    {#each $backfill as line} <!-- for each line of our current knot-->
      {#if line.action == 'generated'}
        {@html line.text}
      {/if}
    {/each}
  </div>
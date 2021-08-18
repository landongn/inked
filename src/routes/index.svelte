<script context="module">
  export async function load({ page, fetch, session, context }) {
    const res = await fetch("/json/lord/lord.json");
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
  footer {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100vw;
    display: flex;
    margin: 0;
    background: black; color: white;
    height: 30px;
    font-size: 13px;
    padding: 0 2rem;
  }
  footer button {
    box-shadow:inset 0px 1px 0px 0px #ffffff;
    background:linear-gradient(to bottom, #ededed 5%, #dfdfdf 100%);
    background-color:#ededed;
    border:1px solid #dcdcdc;
    display:flex;
    cursor:pointer;
    margin: 4px;
    text-decoration:none;
    text-shadow:0px 1px 0px #ffffff;
    color:#777777;
  }
</style>

<script>
  import { auth, googleProvider } from '../firebase.js';
export let story_data;
import Choice from "../components/choice.svelte";
import {Story} from "inkjs/dist/ink.js";
import StateManager from "$lib/story";
import { onMount } from "svelte";
import {latest_fragment, choices_list, dialog_backfill} from "$lib/story";
let parsed_story, gameState, backfill;

//import custom components 
import PlayerAlias from "../components/player_alias.svelte";
import CharacterSheet from "../components/character_sheet.svelte";
import DailyNews from "../components/daily_news.svelte";
import Disconnect from "../components/disconnect.svelte";
import PlayerFight from "../components/player_fight.svelte";
import ForestFight from "../components/forest_fight.svelte";
import DepositGold from "../components/deposit_gold.svelte";
import WithdrawGold from "../components/withdraw_gold.svelte";
import TransferGold from "../components/transfer_gold.svelte";
import PlayerList from "../components/player_list.svelte";
import SlaughterSearch from "../components/slaughter_search.svelte";
import AttackablePlayers from "../components/attackable_players.svelte";
import EnterRealm from "../components/enter_realm.svelte";
import Connect from "../components/connect.svelte";

import Profile from "../components/profile.svelte";

// preconfigured component map for words
const componentMap = {
  '<PlayerAlias>': PlayerAlias,
  '<SlaughterSearch>': SlaughterSearch,
  '<AttackablePlayers>': AttackablePlayers,
  '<DailyNews>': DailyNews,
  '<Disconnect>': Disconnect,
  '<CharacterSheet>': CharacterSheet,
  '<PlayerList>': PlayerList,
  '<PlayerTable>': PlayerList,
  '<TransferGold>': TransferGold,
  '<WithdrawGold>': WithdrawGold,
  '<DepositGold>': DepositGold,
  '<ForestFight>': ForestFight,
  '<PlayerFight>': PlayerFight,
  '<EnterRealm>': EnterRealm,
  '<Connect>': Connect
}

onMount(() => {
 parsed_story = new Story(story_data);

 
});

let user;

auth.onAuthStateChanged((u) => {
  if (u) { user = u; } else {user = null}
  if (u) {
    console.log('gamestate::load()');
    gameState = new StateManager(parsed_story, backfill, user);
  }
})


function login() {
    auth.signInWithPopup(googleProvider);
    
}

</script>


{#if user} <!-- wait until we have a user before rendering the game area-->
  <div class="backfill" bind:this={backfill}>
    {#each $dialog_backfill as line} <!-- for each line of our current knot-->
      <p>{#each line.trimRight('\n').split(" ") as word} <!-- decimate the line into tokens, trimming newlines for parsing-->
        {#if word.substring(0, 1) == '<'} <!-- we've matched a custom component from our ink markup, here-->
          <svelte:component 
            this={componentMap[word]} 
            story={gameState.story} 
            user={user} /> <!-- and now we render the corresponding component, based on our lookup above-->
          
        {:else} 
          {[word, " "].join(" ")} <!-- when no match is found, we render the word into the line instead. -->
        {/if}
      {/each}
      </p>
    {/each}
  </div>


  {#each $choices_list as choice}
    <Choice state={gameState} choice_data={choice} />
  {/each}

{:else}
  <h1> Hi hello, welcome. to play, sign in below. </h1>
{/if}

<footer>
{#if user}
    <Profile uid={user.uid} />
    <button on:click={ () => auth.signOut() }>sign out</button>
{:else}
	<button on:click={login}>
		sign in
	</button>
{/if}
</footer>
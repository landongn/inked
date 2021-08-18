<script>
import { onMount } from "svelte";

import {db} from "../firebase.js";
export let story;
export let user;

// fetch current player object, load it into story as appropriate. 

onMount(async () => {
  let ref = db.collection('players').doc(user.uid);
  let player_doc = await ref.get();
  if (player_doc.exists) {
    let data = player_doc.data();

    // set story variables
    story.variablesState["character_name"] = data.character_name;
    story.variablesState["rank"] = data.rank;
    story.variablesState["experience_points"] = data.experience_points;
    story.variablesState["weapon_name"] = data.weapon_name;
    story.variablesState["armor_name"] = data.armor_name;
    story.variablesState["class"] = data.class;
    story.variablesState["beauty"] = data.beauty;
    story.variablesState["reputation"] = data.reputation;
    story.variablesState["gold"] = data.gold;
    story.variablesState["master"] = data.master;
    story.variablesState["hitpoints"] = data.hitpoints;
    story.variablesState["skill_uses"] = data.skill_uses;
    story.variablesState["gems"] = data.gems;
    story.variablesState["forest_fights"] = data.forest_fights;
    story.variablesState["is_alive"] = data.is_alive;
    story.variablesState["attack_power"] = data.attack_power;
    story.variablesState["armor_class"] = data.armor_class;
    story.variablesState["spirits"] = data.spirits;
    story.variablesState["hitspoints_max"] = data.hitpoints_max;

  } else {
    // create a user record in firebase
    let new_user = {
      character_name: "",
      uid: user.uid,
      rank: 1,
      experience_points: 0,
      weapon_name: "Stick",
      armor_name: "Coat",
      class: "",
      beauty: 1,
      reputation: 0,
      gold: 300,
      master: "Halder",
      hitpoints: 30,
      skill_uses: 1,
      gems: 0,
      forest_fights: 100,
      is_alive: true,
      attack_power: 1,
      armor_class: 1,
      spirits: "high",
      hitspoints_max: 30,
    }
    let newRef = db.collection('players').doc(user.uid);
    newRef.set(new_user);

  }
});
  
</script>
  
import { get, writable } from "svelte/store";

// specifically export the store objects
// since they will be bound as observed values
export const latest_fragment = writable("");
export const choices_list = writable([]);
export const dialog_backfill = writable([]);

export const globals = writable({});
export const tags = writable({});

import { db } from '../firebase';



export default class StateManager {
  constructor(story, dialog_element, user) {
    this.story = story;
    this.user = user;
    this.story_state = writable({})
    this.possible_states = this.story.mainContentContainer.namedContent;
    console.log("possible knots", this.possible_states);
    

    latest_fragment.set(this.story.Continue());
    
    
    
    choices_list.set(this.story.currentChoices);

    latest_fragment.subscribe((v) => {
      dialog_backfill.update((history) => {
        history.push(v);
        return history;
      })
    })


    this.story.onMakeChoice = (choice) => {
      console.log("Choice made", choice);
      console.log(this.story)
      dialog_backfill.update((v) => {
        return [];
      })
    }


    this.buildObservers();
    this.updateTags();

    this.story.onChoosePathString = (path) => {
      console.log(path, arguments);
    }
    this.story.onEvaluateFunction = () => {
      console.log("evalFn", arguments);
    }
    this.story.onCompleteEvaluateFunction = () => {
      console.log("evalFnComplete", arguments);
    }
    this.story.onDidContinue = () => {
      this.updateTags();
      console.log("didContinue", arguments);
  
    }

    var that = this;
    function updateFn() {
      
      if (that.story.canContinue) {
        latest_fragment.set(that.story.Continue());
        choices_list.set(that.story.currentChoices)
      }
      setTimeout(requestAnimationFrame(updateFn), 1200)
    }

    requestAnimationFrame(updateFn)
  }

  updateTags() {
    let new_tags = {};
    console.log(":: tags", this.story.currentTags);
    this.story.currentTags.map((s) => {
      let t = JSON.parse(s);
      for (let key in t) {
        new_tags[key] = t[key]
      }
    })
    tags.set(new_tags);
  }

  async updateUserRecord(props) {
    let userRef = db.collection('players').doc(this.user.uid);
    await userRef.update(props);
  }
  
  addChoice(choice_text) {
    dialog_backfill.update((history) => {
      history.push(choice_text);
      history.push("")
      return history;
    })
  }

  buildObservers() {
    this.story.ObserveVariable("character_name", (varName, newValue) => {
      console.log("character name changed", varName, newValue);
      this.updateUserRecord({character_name: newValue})
    })

    this.story.ObserveVariable("hitpoints_max", (varName, newValue) => {
      console.log("hitpoints_max changed", varName, newValue);
      this.updateUserRecord({hitpoints_max: newValue});
    })

    this.story.ObserveVariable("has_fairy", (varName, newValue) => {
      console.log("has_fairy changed", varName, newValue);
      this.updateUserRecord({has_fairy: newValue});
    })

    this.story.ObserveVariable("rank", (varName, newValue) => {
      console.log("rank changed", varName, newValue);
      this.updateUserRecord({rank: newValue})
    })

    this.story.ObserveVariable("experience_points", (varName, newValue) => {
      console.log("experience changed", varName, newValue);
      this.updateUserRecord({experience_points: newValue})
    })

    this.story.ObserveVariable("weapon_name", (varName, newValue) => {
      console.log("weapon_name", varName, newValue);
      this.updateUserRecord({weapon_name: newValue})
    })

    this.story.ObserveVariable("armor_name", (varName, newValue) => {
      console.log("armor_name", varName, newValue);
      this.updateUserRecord({armor_name: newValue})
    })

    this.story.ObserveVariable("class", (varName, newValue) => {
      console.log("class", varName, newValue);
      this.updateUserRecord({class: newValue})
    })
    this.story.ObserveVariable("charm", (varName, newValue) => {
      console.log("charm updated", varName, newValue);
      this.updateUserRecord({charm: newValue})
    })
    this.story.ObserveVariable("reputation", (varName, newValue) => {
      console.log("reputation", varName, newValue);
      this.updateUserRecord({reputation: newValue})
    })
    this.story.ObserveVariable("gold", (varName, newValue) => {
      console.log("gold", varName, newValue);
      this.updateUserRecord({gold: newValue})
    })
    this.story.ObserveVariable("current_trainer", (varName, newValue) => {
      console.log("current_trainer updated", varName, newValue);
      this.updateUserRecord({current_trainer: newValue})
    })
    this.story.ObserveVariable("hitpoints", (varName, newValue) => {
      console.log("hitpoints", varName, newValue);
      this.updateUserRecord({hitpoints: newValue})
    })
    this.story.ObserveVariable("skill_uses", (varName, newValue) => {
      console.log("skill_uses", varName, newValue);
      this.updateUserRecord({skill_uses: newValue})
    })
    this.story.ObserveVariable("gems", (varName, newValue) => {
      console.log("gems", varName, newValue);
      this.updateUserRecord({gems: newValue})
    })
    this.story.ObserveVariable("forest_fights", (varName, newValue) => {
      console.log("forest_fights", varName, newValue);
      this.updateUserRecord({forest_fights: newValue})
    })
    this.story.ObserveVariable("is_alive", (varName, newValue) => {
      console.log("is_alive", varName, newValue);
      this.updateUserRecord({is_alive: newValue})
    })
    this.story.ObserveVariable("strength", (varName, newValue) => {
      console.log("strength", varName, newValue);
      this.updateUserRecord({strength: newValue})
    })
    this.story.ObserveVariable("defense", (varName, newValue) => {
      console.log("defense", varName, newValue);
      this.updateUserRecord({defense: newValue})
    })
    this.story.ObserveVariable("spirits", (varName, newValue) => {
      console.log("spirits", varName, newValue);
      this.updateUserRecord({spirits: newValue})
    })
    
  }
}
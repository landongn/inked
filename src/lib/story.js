import { get, writable } from "svelte/store";

// specifically export the store objects
// since they will be bound as observed values
export const latest_fragment = writable("");
export const choices_list = writable([]);
export const dialog_backfill = writable([]);

export default class StateManager {
  constructor(story) {
    this.story = story;
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

    var that = this;
    function updateFn() {
      
      if (that.story.canContinue) {
        latest_fragment.set(that.story.Continue());
        choices_list.set(that.story.currentChoices)
      }
      setTimeout(requestAnimationFrame(updateFn), 200)
    }

    requestAnimationFrame(updateFn)
  }
  
  addChoice(choice_text) {
    dialog_backfill.update((history) => {
      history.push(choice_text);
      history.push("")
      return history;
    })
  }
}
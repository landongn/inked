import { get, writable } from "svelte/store";

// specifically export the store objects
// since they will be bound as observed values
export const latest_fragment = writable("");
export const choices_list = writable([]);

export default class StateManager {
  constructor(story) {
    this.story = story;
    this.story_state = writable({})
    
    latest_fragment.set(this.story.Continue());
    choices_list.set(this.story.currentChoices);

    var that = this;
    function updateFn() {
      setTimeout(requestAnimationFrame(updateFn), 200)
      if (that.story.canContinue) {
        latest_fragment.set(that.story.Continue());
        choices_list.set(that.story.currentChoices)
      }
    }

    requestAnimationFrame(updateFn)
  }
}
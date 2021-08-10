<script>
  export let state;
  export let choice_data;

  const select_choice = (choice) => {
    state.story.ChooseChoiceIndex(choice.index);
    state.addChoice(choice.text);
  }
</script>

<style>
  p {
    font-size: 1.3em;
    text-decoration: underline;
    transition: all 200ms ease-in-out;
  }
  p:hover {
    transition: all 200ms ease-in-out;
    font-size: 1.4em;
  }
</style>

<section class="choice_list">
  <p on:click={() => select_choice(choice_data)}>{@html choice_data.text}</p>
</section>
<script>
  export let state;
  export let choice_data;

  const select_choice = (choice) => {
    state.story.ChooseChoiceIndex(choice.index);
  }
</script>

<p on:click={() => select_choice(choice_data)}>{choice_data.text}</p>
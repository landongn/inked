# inked
Inked is a tool that takes in a [ink](https://www.inklestudios.com/ink/) story's JSON representation, and renders it to the web along with all of the interactivity you would expect. 

However, in order to make stories more expressive and artistic, inked attempts to extend the ink specifications, to provide simple to use tools to provide visual representations to characters or specific dialogs, knots, and so on, using [Svelte Components](https://svelte.dev)

In other words, you have creative control over how each ink story step is rendered into html, along with control over how to make them interactive (click, drag, swipe, and so on.)

## why?
I like [Twine] and I think [ink] is a superb tool. My hesitation into investing more into interactive fiction and storytelling has been that I haven't had the right tools to customize the presentation as much as i'd like.  A lot of Twine games look and feel similar.  

With inked, the goal is that it is a "Unity for inked" on the web.  It should be easy to get started, and have dark blood magics for those willing to go the extra step.  

Utilizing svelte and the wonderful [svelte-kit](https://kit.svelte.dev) means that we get powerful, lightweight, fast webpages to run our creations, and deployment is simple to [many different providers](https://kit.svelte.dev/docs#adapters)

## Developing 

Once you've cloned and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

Before creating a production version of your app, install an [adapter](https://kit.svelte.dev/docs#adapters) for your target environment. Then:

```bash
npm run build
```

> You can preview the built app with `npm run preview`, regardless of whether you installed an adapter. This should _not_ be used to serve your app in production.

## Okay, seriously, how do I make interactive fiction with inked?


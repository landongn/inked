# inked
Inked is a tool that takes in a [ink](https://www.inklestudios.com/ink/) story's JSON representation, and renders it to the web along with all of the interactivity you would expect. 

However, in order to make stories more expressive and artistic, inked attempts to extend the ink specifications by mapping them into [Svelte Components](https://svelte.dev) -- web components, basically -- to provide a full suite of tools to construct visual representations for everything within the ink specficiations, as well as some fun tricks. 

In other words, you have total creative control over how each ink story step is rendered into html, along with control over how to make them interactive (click, drag, swipe, and so on.), without sacrificing a powerful and expressive interactivity model based on a familiar, web based interaction paradigm.

## why?
The web is a perfect medium for interactive fiction; writing interactive fiction web applications isn't exactly a great time. 

With inked, the goal is that it is a "Unity for inked" on the web.  It should be easy to get started, and have dark blood magics for those willing to go the extra step.  

Utilizing svelte and the wonderful [svelte-kit](https://kit.svelte.dev) means that we get powerful, lightweight, fast webpages to run our creations, and deployment is simple to [many different providers](https://kit.svelte.dev/docs#adapters)

## Plans for further development
Suffice to say, this is really early days.  The amount of work left to do before this is 1.0 is quite a bit:
- [ ] implement diverts and knots
- [ ] map knots into specific component layout 
- [ ] add examples for common use cases
- [ ] add examples for how to animate 'the svelte way' with ink content
- [ ] support custom annotations within ink files for "custom action component trees"
- [ ] support sprite components and viewport constraint positoning
- [ ] support audio cues from ink annotations
- [ ] add optional animation into text output
- [ ] add a configurable line count for main narrative
- [ ] (STRETCH) add websocket based multiplayer support with corresponding serverless websocket implementation
- [ ] (STRETCH) add serverless analytics for stories to understand common paths through your narrative

However, if you have an interest in contributing to any of the above, feel free!

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

Inked essentially is a state machine and corresponding component framework for rendering [ink](https://www.inklestudios.com/ink/) scripts, which uses [inkjs]() under the hood to take your ink script, and turn it into something inked can utilize. 

In the simplest possible terms, you'd create your ink formatted script, export that script into a `.json` file, add it to the project, and your project *just works* within the context of a self contained, simple to deploy, incredibly expressive boilerplate web based rendering environment. 

You can take this project as is, clean and fresh from github, and deploy it to services like [netlify](https://netlify.com) or [vercel](https://netlify.com) -- you could even upload a zip of a static site containing everything the game needs to run as a static site, to places like [itch.io](https://itch.io)

### inked for narrative designers / creators
The most important thing to understand about what's going on under the hood is each knot within your ink story is essentially a game state, and should be named similar to a "world -> area -> interaction" format.  The goal here is to be able to ensure that we have enough detail in our knot relationships that you can create components based on each segment of the name. e.g; `seattle_fuchi_arcology_exterior_night_introduction` as as knot identifier gives us considerable customization; we can build components for each of those segments -- inked parses knot ids into components, split by underscores -- and by defining components with `CapCase` in the project and importing them into your root component (typically `index.svelte`) they will render when the corresponding knot id is active. 

This is the most important concept to understand about working with inked; your knots are identified with a tree of components, which you create and define in `inked/src/components`, import into your root component tree `inked/src/routes/index.svelte`, and are rendered when identified by inked. 

### inked for web developers
the ink format is essentially markdown for narrative design, and similar tricks we've picked up along the long road of using markdown to drive webpages applies here. The main driving force behind the front-end implementation is the `StateManager` class, which exists as a way to bind ink annotations to some javascript state. When the story state changes, these properties update and drive the component rendering process. In a typical implementation, the `StateManager` class will be considerably augmented to fit your specific annotation style and story flow. 

## Known Issues
- using inkjs will fail until [this pr](https://github.com/y-lohse/inkjs/pull/903) is merged -- until then, you'll need to use [this fork](https://github.com/landongn/inkjs) until it's merged. to do so, open up package.json and make sure your `dependencies` is set to
```
"dependencies": {
  "inkjs": "github:landongn/inkjs"
}
```

an re-run `npm install` to download the fork. Everything should work not (if not, shout at me @landongn on twitter or pop open an issue)


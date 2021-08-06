# inked
Inked is a tool that takes in a [ink](https://www.inklestudios.com/ink/) story's JSON representation, and renders it to the web along with all of the interactivity you would expect. 

However, in order to make stories more expressive and artistic, inked attempts to extend the ink specifications by mapping them into [Svelte Components](https://svelte.dev) -- web components, basically -- to provide a full suite of tools to construct visual representations for everything within the ink specficiations, as well as some fun tricks. 

In other words, you have creative control over how each ink story step is rendered into html, along with control over how to make them interactive (click, drag, swipe, and so on.), without sacrificing a powerful and expressive interactivity model based on a familiar, web based interaction paradigm.

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

Inked essentially is a state machine and corresponding component framework for rendering [ink](https://www.inklestudios.com/ink/) scripts, which uses [inkjs]() under the hood to take your ink script, and turn it into something inked can utilize. 

In the simplest possible terms, you'd create your ink formatted script, export that script into a `.json` file, add it to the project, and your project *just works* within the context of a self contained, simple to deploy, incredibly expressive boilerplate web based rendering environment. 

You can take this project as is, clean and fresh from github, and deploy it to services like [netlify](https://netlify.com) or [vercel](https://netlify.com) -- you could even upload a zip of a static site containing everything the game needs to run as a static site, to places like [itch.io](https://itch.io)


## Known Issues
- using inkjs will fail until [this pr](https://github.com/y-lohse/inkjs/pull/903) is merged -- until then, you'll need to use `npm link` alongside a local copy that can output ES6 modules. 


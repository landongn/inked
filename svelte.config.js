/** @type {import('@sveltejs/kit').Config} */
const config = {
	kit: {
		ssr: true,
		// hydrate the <div id="svelte"> element in src/app.html
		target: '#svelte'
	}
};

export default config;

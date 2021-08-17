<main><slot></slot></main>
<style>
 main {
   width: 100%;
   height: 100%;
   padding: 2rem;
   font-size: 20px;
   line-height: 1.8rem;
   font-family: "Fira Mono", "Menlo", "Consolas", monospace;
   margin: 0;
   background: #34344A;
   color: #d3d3d1;
   max-height: 100vh;
   max-width: 100vw;
 }
 :global(body) {
   margin: 0; padding: 0;
   height: 100vh;
   width: 100vw;
   background: #34344a;
   color:#d3d3d1;
   font-family: "Fira Mono", "Menlo", "Consolas", monospace;
   font-size: 16px;
   overflow: hidden;
 }
 :global(::-webkit-scrollbar) {
  width: 20px;
 }
:global(::-webkit-scrollbar-track) {
  background-color: transparent;
}
:global(::-webkit-scrollbar-thumb) {
  background-color: #d6dee1;
  border-radius: 20px;

}
:global(::-webkit-scrollbar-thumb) {
  background-color: #d6dee1;
  border-radius: 20px;
  border: 6px solid transparent;
  background-clip: content-box;
}
</style> 
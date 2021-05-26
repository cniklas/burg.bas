<template>
	<Intro v-if="showIntro" @start="startGame" />
	<Game v-else :user-name="userName" />
</template>

<script setup>
import Intro from './components/Intro.vue'
import Game from './components/Game.vue'
import { ref } from 'vue'

const userName = ref('')

const showIntro = ref(true)
const startGame = (name) => {
	userName.value = name
	showIntro.value = false
}
</script>

<style lang="postcss">
:root {
	/* --global-font-size: 14px; */
	--global-line-height: 1.375; /* 'leading-snug' */

	/* --spacing:        1em; */
	/* --spacing-medium: calc(var(--spacing) * 2); */
	/* --spacing-large:  calc(var(--spacing) * 3); */

	--blue-light:   #89d3fd;
	--blue-dark:    #067df7;
	--gold:         #ffbd2e;
	--green:        #5ce6cd;
	--papayawhip:   papayawhip;
	--pink:         hotpink;
	--purple-light: #7775A7;
	/* --purple-dark:  #bd10e0; */
	--red:          #ff0080;

	--text-color:   #cbd5e0;
	--bg-color:     #0f0f17;
	--button-color: hsl(182, 25%, 50%); /* cadetblue */
	--button-color-hover: hsl(182deg 35% 50%);
}

.white        { color: #fff; }
.blue-light   { color: var(--blue-light); }
.blue-dark    { color: var(--blue-dark); }
.gold         { color: var(--gold); }
.green        { color: var(--green); }
.papayawhip   { color: papayawhip; }
.pink         { color: hotpink; }
.purple-light { color: var(--purple-light); }
/* .purple-dark  { color: var(--purple-dark); } */
.red          { color: var(--red); }

::-webkit-scrollbar { width: 6px; height: 6px; }
::-webkit-scrollbar-track { background-color: hsla(218, 40%, 50%, 0.08); border-radius: 3px; }
::-webkit-scrollbar-thumb { background-color: #97a0af; border-radius: 3px; }

html {
	background-color: var(--bg-color);
	color: var(--text-color);
}

body {
	/* font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; */
	font-family: Menlo, 'DejaVu Sans Mono', 'Lucida Console', monospace;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

pre:empty,
div:empty,
p:empty {
	@apply m-0
}

.ascii-text {
	font-size: 0.8125rem;
	line-height: 1.153846;
}

.base-column {
	@apply mx-auto px-2 md:px-0;
	max-width: 720px;
}

.story {
	@apply mb-8;
	line-height: var(--global-line-height);
}

.story p {
	margin-bottom: calc(var(--global-line-height) * 1rem);
}

.story > :last-child {
	@apply mb-0;
}

.text-prewrap {
	@apply block whitespace-pre-wrap text-center;
}

.battle {
	line-height: var(--global-line-height);
	scroll-behavior: smooth;
}

.battle li:nth-child(2n+3),
.battle-result {
	margin-top: calc(var(--global-line-height) * 1rem);
}

.actions {
	@apply mt-8 text-center;
}

.hint,
.button-wrapper,
.input-wrapper {
	@apply my-4;
}

.button {
	@apply tracking-wider border border-current py-2 px-7 select-none focus:outline-none;
	background-color: #1a202c;
	color: var(--button-color);
	font-size: 1rem;
	box-shadow: 0 0 0px 0px var(--bg-color), 0 0 0px 0px currentColor;
	transition: color 160ms ease, box-shadow 160ms ease;
}

.button:not(:disabled):hover {
	color: var(--button-color-hover);
	box-shadow: 0 0 0px 1px var(--bg-color), 0 0 0px 2px currentColor;
}

.input {
	@apply w-full py-2 bg-transparent outline-none;
	color: inherit;
	font-size: 1.625rem;
}
</style>
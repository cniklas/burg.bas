<template>
<!-- <pre class="ascii-text">
</pre> -->

<!-- <pre class="ascii-drawing">
▓▓▓
</pre> -->

	<section class="scene">
		<article class="story grid">
			<transition name="panel">
				<component :is="panel" class="grid-child">
					<template v-for="paragraph in story">
						<p v-if="typeof paragraph === 'string'" class="text-preline" v-html="paragraph" />

						<template v-else>
							<template v-for="section in paragraph">
								<p v-show="!isDisabled(section)" class="text-preline" v-html="section.story" />
							</template>
						</template>
					</template>
				</component>
			</transition>

			<!-- <div v-if="scene.delayed" class="delayed" :class="{animated}" :style="`transition-delay:${scene.delayed.delay}ms`"> -->
		</article>

		<div v-show="!onHold" class="actions">
			<div class="button-wrapper">
				<!-- <button type="button" v-for="command in clickCommands" :disabled="isDisabled(command)" @click="handleCommand(command)">
					{{ command.text || 'weiter' }}
					{{ command.condition ? `[${command.condition}]` : null }}
					{{ command.notCondition ? `[NOT ${command.notCondition}]` : null }}
				</button> -->
				<button v-show="goNext" type="button" @click="handleCommand(goNext)">weiter</button>
			</div>

			<div v-show="hint && showHint" class="hint">{{ hint }}</div>

			<div v-show="!goNext && sceneId !== 'credits'" class="input-wrapper">
				<input type="text" v-model.trim="typed" class="input" @keyup.enter="handleInput" />
			</div>
		</div>
	</section>

	<div class="debug">
		<div>id: {{ sceneId }}</div>
		<div>music: {{ isPlaying }}</div>
		<!-- <div>
			<span v-for="command in textCommands" class="as-button" :class="{disabled: isDisabled(command)}">
				{{ command.text }}
				{{ command.condition ? `[${command.condition}]` : null }}
				{{ command.notCondition ? `[NOT ${command.notCondition}]` : null }}
			</span>
		</div> -->
		<pre><code v-for="condition in conditions">{{ `${condition}\n` }}</code></pre>
	</div>
</template>

<script setup>
import burg from './burg.json'
import { ref, computed, watch } from 'vue'
import PanelA from './components/Panel.vue'
import PanelB from './components/Panel.vue'
import { Howl, Howler } from 'howler'

// // Audio test
// const sound = new Howl({
// 	src: ['audio/dragon.mp3']
// });
// sound.play();
let music
const isPlaying = ref(false)

const panel = ref('PanelA')
let i = 0

let sceneId = ref('start')
const scene = computed(() => burg.find(scene => scene.id === sceneId.value))
const story = ref([])
const onHold = ref(false)
const handleStory = () => {
	// animate panel
	panel.value = ++i % 2 ? 'PanelA' : 'PanelB'

	// replace story
	story.value = [...scene.value.story]
	requestAnimationFrame(() => {
		document.querySelector('.input').focus()
	})

	// set time for delayed story
	if (scene.value.delayed) {
		onHold.value = true

		setTimeout(() => {
			onHold.value = false
			story.value = [...story.value, ...scene.value.delayed.story]

			requestAnimationFrame(() => {
				document.querySelector('.input').focus()
			})
		}, scene.value.delayed.delay)
	}

	// fade out music
	if (isPlaying.value) {
		music.fade(1, 0, 1200)
	}

	if (scene.value.audio_file) {
		music = new Howl({
			src: [`audio/${scene.value.audio_file}.mp3`],
			onplay: () => { isPlaying.value = true },
			// onend: () => { isPlaying.value = false },
			onfade: () => { isPlaying.value = false }
		})
		music.play()
	}
}
watch(sceneId, handleStory, { immediate: true })
// const animated = ref(false)
// const animateIn = () => {
// 	setTimeout(() => {
// 		animated.value = true
// 	}, 100)
// }

const end_death = computed(() => sceneId.value.endsWith('_tod'))
const end_freedom = computed(() => sceneId.value.endsWith('_ende'))

const typed = ref('')

// const clickCommandsList = ['hoch', 'runter', 'links', 'rechts', 'weiter', 'zurück']
// const clickCommands = computed(() => scene.value.commands?.filter(cmd => clickCommandsList.includes(cmd.text) || cmd.key === 'enter') ?? [])
// const textCommands = computed(() => scene.value.commands?.filter(cmd => !clickCommandsList.includes(cmd.text) && cmd.key !== 'enter') ?? [])
const goNext = computed(() => scene.value.commands?.find(cmd => cmd.key === 'enter' && !isDisabled(cmd)));

const conditions = ref([])
const hasCondition = term => conditions.value.includes(term)

const hint = ref('')
const showHint = ref(false)

const randomBattle = () => {
	const rnd = Math.floor(Math.random() * Math.floor(3))
	console.log(rnd)
	const action = rnd > 0 ? 'thronsaal_kampf-sieg' : 'thronsaal_kampf-tod'

	setTimeout(() => {
		handleAction({ action })
	}, 3000)
}

const resetGame = () => {
	conditions.value = []
}

const handleAction = command => {
	if (command.setCondition && !hasCondition(command.setCondition)) {
		conditions.value.push(command.setCondition)
	}

	// Endgegner
	if (command.action === 'thronsaal_kampf') {
		randomBattle()
	}

	// zurück auf Start
	if (command.action === 'start') {
		resetGame()
	}

	showHint.value = false
	hint.value = ''
	typed.value = ''
	// animated.value = false
	sceneId.value = command.action

	// animateIn()
}

const handleMessage = command => {
	hint.value = command.message
	showHint.value = true
}

const handleCommand = command => {
	command.message ? handleMessage(command) : handleAction(command)
}

const isDisabled = ({ condition, notCondition }) => {
	if (condition && notCondition) {
		return !hasCondition(condition) || hasCondition(notCondition)
	}
	if (condition) {
		return !hasCondition(condition)
	}
	if (notCondition) {
		return hasCondition(notCondition)
	}

	return false
}

const cleanInput = (string) => {
	const regex = /[!"#$%&\'()*+,\-./:;<=>?@[\\\]^_`{\|}~]/g;
	return string
		.replaceAll(regex, '')
		.toLowerCase()
		.split(' ')
		.filter(word => word.length && !['der', 'die', 'das', 'den', 'dem', 'und', 'mit'].includes(word))
		.join(' ')
}

const handleInput = () => {
	const input = cleanInput(typed.value)

	// let command
	// if (input === 'weiter') {
	// 	command = scene.value.commands?.find(cmd => !isDisabled(cmd) && cmd.key === 'enter')
	// }

	// if (command === undefined) {
	// 	command = scene.value.commands?.find(cmd => !isDisabled(cmd) && cmd.text.toLowerCase() === input)
	// }
	const command = scene.value.commands?.find(cmd => !isDisabled(cmd) && cmd.text.toLowerCase() === input)

	if (command === undefined) {
		hint.value = scene.value.hint || ''
		showHint.value = true
		return
	}

	handleCommand(command)
}
</script>

<style>
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
	--grey-dark:    #999;
	--papayawhip:   papayawhip;
	--pink:         hotpink;
	--purple-light: #7775A7;
	--purple-dark:  #bd10e0;
	--red:          #ff0080;
}

.white        { color: #fff; }
.blue-light   { color: var(--blue-light); }
.blue-dark    { color: var(--blue-dark); }
.gold         { color: var(--gold); }
.green        { color: var(--green); }
.grey-dark    { color: var(--grey-dark); }
.papayawhip   { color: papayawhip; }
.pink         { color: hotpink; }
.purple-light { color: var(--purple-light); }
.purple-dark  { color: var(--purple-dark); }
.red          { color: var(--red); }

html {
	background-color: #0f0f17;
	color: #cbd5e0;
}

pre:empty,
div:empty,
p:empty {
	margin: 0;
}

button {
	background-color: #1a202c;
	color: cadetblue;
	font-size: 80%;
	border: 1px solid currentColor;
	padding: .5rem 1rem;
	user-select: none;
}
/*
button:disabled {
	opacity: .4;
	cursor: initial;
} */

/* button:focus, */
button:not(:disabled):hover {
	color: #e2e8f0;
}

#app {
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	font-family: Menlo, 'DejaVu Sans Mono', 'Lucida Console', monospace;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	margin: 60px auto 0;
	max-width: 720px;
}

.ascii-drawing {
	font-size: 42px;
}

.ascii-text {
	font-size: 0.8125rem;
	line-height: 1.153846;
}

.grid-child {
	grid-column: 1 / 2;
	grid-row: 1 / 2;
}

.panel-enter-active,
.panel-leave-active {
	transition: opacity 90ms ease-out;
}

.panel-leave-active {
	transition-timing-function: ease-in;
}

.panel-enter,
.panel-leave-to {
	opacity: 0;
}

.scene {
	@apply relative z-10;
}

.story,
.actions {
	@apply my-8;
}

.story {
	line-height: var(--global-line-height);
}

.story p {
	margin-bottom: calc(var(--global-line-height) * 1rem);
}

.text-preline {
	@apply whitespace-pre-line;
}
/*
.story .disabled {
	opacity: .35;
} */

.actions {
	@apply text-center;
}

.hint,
.button-wrapper,
.input-wrapper {
	@apply my-4;
}

/*
.delayed {
	visibility: hidden;
	opacity: 0;
	transition: opacity 180ms ease-out;
}

.delayed.animated {
	visibility: visible;
	opacity: 1;
} */

.hint {
	font-style: italic;
}

.input {
	@apply w-2/4 p-2;
	color: #000;
}

.debug {
	font-family: 'Courier New', Courier, monospace;
	text-align: center;
	border: 2px dashed;
	position: fixed;
	z-index: 1;
	bottom: 0;
	width: 100%;
	max-width: 720px;
}

.debug > * {
	margin: .75rem 0;
}

.as-button {
	display: inline-block;
	margin: 0 .5rem;
}

.as-button.disabled {
	opacity: .35;
}
</style>
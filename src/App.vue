<template>
<pre class="ascii-text">
88                                                 88
88                                                 88
88                                                 88
88,dPPYba,  88       88 8b,dPPYba,  ,adPPYb,d8     88,dPPYba,  ,adPPYYba, ,adPPYba,
88P'    "8a 88       88 88P'   "Y8 a8"    `Y88     88P'    "8a ""     `Y8 I8[    ""
88       d8 88       88 88         8b       88     88       d8 ,adPPPPP88  `"Y8ba,
88b,   ,a8" "8a,   ,a88 88         "8a,   ,d88 888 88b,   ,a8" 88,    ,88 aa    ]8I
8Y"Ybbd8"'   `"YbbdP'Y8 88          `"YbbdP"Y8 888 8Y"Ybbd8"'  `"8bbdP"Y8 `"YbbdP"'
                                    aa,    ,88
                                     "Y8bbdP"
</pre>

<!-- <pre class="ascii-drawing">
▓▓▓
</pre> -->

	<section class="scene">
		<article class="story">
			<template v-for="paragraph in story">
				<p v-if="typeof paragraph === 'string'" class="text-preline">{{ paragraph }}</p>

				<template v-else>
					<template v-for="section in paragraph">
						<p :class="{disabled: isDisabled(section)}" class="text-preline">{{ section.story }}</p>
					</template>
				</template>
			</template>

			<!-- <div v-if="scene.delayed" class="delayed" :class="{animated}" :style="`transition-delay:${scene.delayed.delay}ms`"> -->
		</article>

		<div v-show="!onHold" class="actions">
			<div class="button-wrapper">
				<button type="button" v-for="command in clickCommands" :disabled="isDisabled(command)" @click="handleCommand(command)">
					{{ command.text || 'weiter' }}
					{{ command.condition ? `[${command.condition}]` : null }}
					{{ command.notCondition ? `[NOT ${command.notCondition}]` : null }}
				</button>
			</div>

			<div v-show="hint && showHint" class="hint">{{ hint }}</div>

			<div v-show="sceneId !== 'credits'" class="input-wrapper">
				<input type="text" v-model.trim="typed" class="input" @keyup.enter="handleInput" />
			</div>
		</div>
	</section>

	<div class="debug">
		<div>{{ sceneId }}</div>
		<div>
			<span v-for="command in textCommands" class="as-button" :class="{disabled: isDisabled(command)}">
				{{ command.text }}
				{{ command.condition ? `[${command.condition}]` : null }}
				{{ command.notCondition ? `[NOT ${command.notCondition}]` : null }}
			</span>
		</div>
		<pre><code v-for="condition in conditions">{{ `${condition}\n` }}</code></pre>
	</div>
</template>

<script setup>
import burg from './burg.json'
import { ref, computed, watch } from 'vue'

let sceneId = ref('start')
const scene = computed(() => burg.find(scene => scene.id === sceneId.value))
const story = ref([])
const onHold = ref(false)
const handleStory = () => {
	story.value = [...scene.value.story]

	if (scene.value.delayed) {
		onHold.value = true

		setTimeout(() => {
			onHold.value = false
			story.value = [...story.value, ...scene.value.delayed.story]
		}, scene.value.delayed.delay)
	}
}
watch(sceneId, handleStory, { immediate: true })
// const animated = ref(false)
// const animateIn = () => {
// 	setTimeout(() => {
// 		animated.value = true
// 	}, 100)
// }

const typed = ref('')

const clickCommandsList = ['hoch', 'runter', 'links', 'rechts', 'weiter', 'zurück']
const clickCommands = computed(() => scene.value?.commands?.filter(cmd => clickCommandsList.includes(cmd.text) || cmd.key === 'enter') ?? [])
const textCommands = computed(() => scene.value?.commands?.filter(cmd => !clickCommandsList.includes(cmd.text) && cmd.key !== 'enter') ?? [])

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
	document.querySelector('.input').focus()
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
		.filter(word => word.length && !['der', 'die', 'das', 'den', 'und'].includes(word))
		.join(' ')
}

const handleInput = () => {
	const input = cleanInput(typed.value)

	let command
	if (input === 'weiter') {
		command = scene.value.commands?.find(cmd => cmd.key === 'enter')
	}

	if (command === undefined) {
		command = scene.value.commands?.find(cmd => !isDisabled(cmd) && cmd.text.toLowerCase() === input)
	}

	if (command === undefined) {
		hint.value = scene.value.hint || ''
		showHint.value = true
		return
	}

	handleCommand(command)
}
</script>

<style>
html {
	background-color: #0f0f17;
	color: #cbd5e0;
}

pre:empty {
	margin: 0;
}

input {
	font-family: inherit;
	font-size: inherit;
	line-height: inherit;
}

button {
	background-color: #1a202c;
	color: cadetblue;
	font-family: inherit;
	font-size: inherit;
	font-size: 80%;
	line-height: inherit;
	border: 1px solid currentColor;
	padding: .5rem 1rem;
	cursor: pointer;
	user-select: none;
}

button:disabled {
	opacity: .4;
	cursor: initial;
}

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

.scene {
	position: relative;
	z-index: 10;
}

.story,
.actions {
	margin: 2rem 0;
}

.story {
	line-height: 1.375;
}

.text-preline {
	/* berücksichtigt line breaks */
	white-space: pre-line;
}

.story .disabled {
	opacity: .35;
}

.actions {
	text-align: center;
}

.hint,
.button-wrapper,
.input-wrapper {
	margin: 1rem 0;
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
	width: 50%;
	padding: 0.5rem 0.5rem;
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

.ascii-drawing {
	font-size: 42px;
}
</style>
<template>
	<img alt="Vue logo" src="./assets/logo.png" />

	<section>
		<article class="story">
			<template v-for="paragraph in scene.story">
				<p v-if="typeof paragraph === 'string'" class="text-preline">{{ paragraph }}</p>
				<template v-else>
					<template v-for="section in paragraph">
						<p :class="{disabled: isDisabled(section)}" class="text-preline">{{ section.story }}</p>
					</template>
				</template>
			</template>
		</article>

		<div class="actions">
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

		<div class="debug">
			<div>{{ sceneId }}</div>
			<div>
				<span v-for="command in noClickCommands" class="as-button" :class="{disabled: isDisabled(command)}">
					{{ command.text }}
					{{ command.condition ? `[${command.condition}]` : null }}
					{{ command.notCondition ? `[NOT ${command.notCondition}]` : null }}
				</span>
			</div>
			<pre><code v-for="condition in conditions">{{ `${condition}\n` }}</code></pre>
		</div>
	</section>
</template>

<script setup>
import burg from './burg.json'
import { ref, computed } from 'vue'

let sceneId = ref('start')
const getSceneById = id => burg.find(scene => scene.id === id)
const scene = computed(() => getSceneById(sceneId.value))

const typed = ref('')

const clickCommandsList = ['hoch', 'runter', 'links', 'rechts', 'weiter', 'zurück']
const clickCommands = computed(() => scene.value?.commands?.filter(cmd => clickCommandsList.includes(cmd.text) || cmd.key === 'enter') ?? [])
const noClickCommands = computed(() => scene.value?.commands?.filter(cmd => !clickCommandsList.includes(cmd.text) && cmd.key !== 'enter') ?? [])

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
	sceneId.value = command.action
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
	text-align: center;
	margin: 60px auto 0;
	max-width: 720px;
}

.story,
.actions {
	margin: 2rem 0;
}

.hint,
.button-wrapper,
.input-wrapper {
	margin: 1rem 0;
}

.story {
	text-align: initial;
}

.text-preline {
	/* berücksichtigt line breaks */
	white-space: pre-line;
}

.story .disabled {
	opacity: .35;
}

.hint {
	font-style: italic;
}

.debug {
	font-family: 'Courier New', Courier, monospace;
	border: 2px dashed deeppink;
	position: fixed;
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

.as-button .disabled {
	opacity: .35;
}
</style>
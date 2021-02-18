<template>
	<img alt="Vue logo" src="./assets/logo.png" />

	<section>
		<h3>{{ sceneId }}</h3>

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
				<button type="button" v-for="command in typeCommands" :disabled="isDisabled(command)" @click="handleCommand(command)" style="font-family:'Courier New',Courier,monospace;font-size:1rem;border-style:dashed">
					{{ command.text }}
					{{ command.condition ? `[${command.condition}]` : null }}
					{{ command.notCondition ? `[NOT ${command.notCondition}]` : null }}
				</button>
			</div>
			<div class="button-wrapper">
				<button type="button" v-for="command in clickCommands" :disabled="isDisabled(command)" @click="handleCommand(command)">
					{{ command.text || 'weiter' }}
					{{ command.condition ? `[${command.condition}]` : null }}
					{{ command.notCondition ? `[NOT ${command.notCondition}]` : null }}
				</button>
			</div>

			<div v-show="scene.hint" class="hint">{{ scene.hint }}</div>
			<div class="input-wrapper">
				<input type="text" v-model.trim="typed" class="input" />
			</div>
		</div>

		<div class="debug">
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

const typed = ref()

const clickCommandsList = ['hoch', 'runter', 'links', 'rechts', 'weiter', 'zurück']
const clickCommands = computed(() => scene.value?.commands?.filter(cmd => clickCommandsList.includes(cmd.text) || cmd.key === 'enter') ?? [])
const typeCommands = computed(() => scene.value?.commands?.filter(cmd => !clickCommandsList.includes(cmd.text) && cmd.key !== 'enter') ?? [])

const conditions = ref([])
// const findCondition = (term) => {
// 	return conditions.value.find(c => c === term)
// }
const hasCondition = (term) => {
	return conditions.value.includes(term)
}

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

	typed.value = ''
	sceneId.value = command.action
}

const handleMessage = command => {
	alert(command.message)
}

const handleCommand = command => {
	if (command.message) {
		handleMessage(command)
		return
	}

	handleAction(command)
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
</script>

<style>
html {
	background-color: #0f0f17;
	color: #cbd5e0;
}

button {
	background-color: #1a202c;
	color: #a0aec0;
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

/* button:focus, */
button:not(:disabled):hover {
	color: #e2e8f0;
}

button:disabled {
	opacity: .4;
	cursor: initial;
}

.debug {
	font-family: 'Courier New', Courier, monospace;
	outline: 2px dashed deeppink;
}

#app {
	/* font-family: Avenir, Helvetica, Arial, sans-serif; */
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	text-align: center;
	/* color: #2c3e50; */
	margin-top: 60px;

	margin: 60px auto 0;
	max-width: 720px;
}

.story,
.actions {
	margin: 2rem 0;
}

.button-wrapper,
.hint,
.input-wrapper {
	margin: 1rem 0;
}

.hint {
	font-style: italic;
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
</style>
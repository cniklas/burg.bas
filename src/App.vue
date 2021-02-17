<template>
	<img alt="Vue logo" src="./assets/logo.png" />

	<section>
		<h3>{{ sceneId }}</h3>

		<article class="story">
			<template v-for="paragraph in scene.story">
				<div v-if="typeof paragraph === 'string'" class="text-preline">{{ paragraph }}</div>
				<template v-else>
					<template v-for="section in paragraph">
						<div :class="{disabled: isDisabled(section)}" class="text-preline">{{ section.story }}</div>
					</template>
				</template>
			</template>
		</article>

		<div class="actions">
			<!-- <button type="button" @click="next">weiter</button> -->
			<button type="button" v-for="command in scene.commands" :disabled="isDisabled(command)" @click="handleCommand(command)">
				{{ command.text || 'weiter' }}
				{{ command.condition ? `[${command.condition}]` : null }}
				{{ command.notCondition ? `[NOT ${command.notCondition}]` : null }}
			</button>
		</div>

		<div v-show="scene.hint" class="hint">{{ scene.hint }}</div>

		<pre><code v-for="condition in conditions">{{ `${condition}\n` }}</code></pre>
	</section>
</template>

<script setup>
import burg from './burg.json'
import { ref, computed } from 'vue'

const getSceneById = id => burg.find(scene => scene.id === id)

let sceneId = ref('start')
const scene = computed(() => getSceneById(sceneId.value))
const conditions = ref([])

// const next = () => {
// 	// first valid command
// 	sceneId.value = scene.value.commands?.find(command => command.action !== null && !command.action.endsWith('_tod'))?.action ?? 'start'
// 	// last valid command
// 	// sceneId.value = scene.value.commands?.filter(command => command.action !== null && !command.action.endsWith('_tod'))?.slice(-1)[0].action ?? 'start'
// }

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

#app {
	font-family: Avenir, Helvetica, Arial, sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	text-align: center;
	/* color: #2c3e50; */
	margin-top: 60px;

	margin: 60px auto 0;
	max-width: 720px;
}

.actions {
	margin-top: 2rem;
}

.hint {
	font-style: italic;
	margin-top: 2rem;
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
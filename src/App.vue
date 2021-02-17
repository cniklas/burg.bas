<template>
	<img alt="Vue logo" src="./assets/logo.png" />

	<section>
		<h3>{{ sceneId }}</h3>

		<article class="story">
			<template v-for="paragraph in scene.story">
				<div v-if="typeof paragraph === 'string'" class="text-preline">{{ paragraph }}</div>
				<template v-else>
					<template v-for="section in paragraph">
						<div :class="{disabled: !conditions.find(cnd => cnd === section.condition)}" class="text-preline">{{ section.story }}</div>
					</template>
				</template>
			</template>
		</article>

		<div class="actions">
			<!-- <button type="button" @click="next">weiter</button> -->
			<button type="button" v-for="command in scene.commands" :disabled="isDisabled(command)" @click="nextStep(command)">
				{{ command.text || 'weiter' }}
				{{ command.condition ? `[${command.condition}]` : null }}
				{{ command['not-condition'] ? `[NOT ${command['not-condition']}]` : null }}
			</button>
		</div>

		<div v-show="scene.hint" class="hint">{{ scene.hint }}</div>

		<pre><code v-for="condition in conditions">{{ `${condition}\n` }}</code></pre>

	</section>
</template>

<script setup>
import burg from './burg.json'
import { ref, reactive, computed } from 'vue'

const _getSceneById = id => burg.find(scene => scene.id === id)

let sceneId = ref('start')
const scene = computed(() => _getSceneById(sceneId.value))
const conditions = ref([])

// const next = () => {
// 	// first valid command
// 	sceneId.value = scene.value.commands?.find(command => command.action !== null && !command.action.endsWith('_tod'))?.action ?? 'start'
// 	// last valid command
// 	// sceneId.value = scene.value.commands?.filter(command => command.action !== null && !command.action.endsWith('_tod'))?.slice(-1)[0].action ?? 'start'
// }

const resetGame = () => {
	conditions.value = []
	sceneId.value = 'start'
}

const handleAction = command => {
	if (command.action === 'start') {
		resetGame()
		return
	}

	if (command['set-condition']) {
		conditions.value.push(command['set-condition'])
	}

	sceneId.value = command.action
}

const handleMessage = command => {
	alert(command.message)
}

const nextStep = command => {
	if (command.message) {
		handleMessage(command)
		return
	}

	handleAction(command)
}

const isDisabled = command => {
	// console.log(command.action, !!(command.condition && !conditions.value.find(cnd => cnd === command.condition)) || !!(command['not-condition'] && conditions.value.find(cnd => cnd === command['not-condition'])))
	return !!(command.condition && !conditions.value.find(cnd => cnd === command.condition)) || !!(command['not-condition'] && conditions.value.find(cnd => cnd === command['not-condition']))

	// besser?
	// if (command.condition) {
	// 	return !conditions.value.find(cnd => cnd === command.condition)
	// }
	// if (command['not-condition']) {
	// 	return conditions.value.find(cnd => cnd === command['not-condition'])
	// }
	// return false
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
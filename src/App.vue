<template>
	<img alt="Vue logo" src="./assets/logo.png" />
	<!-- <HelloWorld msg="Hello Vue 3 + Vite" /> -->

	<section>
		<h3>{{ sceneId }}</h3>
		<div class="actions">
			<button type="button" @click="next">weiter</button>
		</div>
		<article class="story">
			<template v-for="paragraph in story">
				<div v-if="typeof paragraph === 'string'" class="text-preline">{{ paragraph }}</div>
				<template v-else>
					<div v-for="section in paragraph" class="text-preline">
						{{ section.story }}
					</div>
				</template>
			</template>
		</article>
	</section>
</template>

<script setup>
// import HelloWorld from './components/HelloWorld.vue'
import burg from './burg.json'
import { ref, computed } from 'vue'

const _getSceneById = id => burg.find(scene => scene.id === id)

let sceneId = ref('start')
const scene = computed(() => _getSceneById(sceneId.value))
const story = computed(() => scene.value.story)

const next = () => {
	// first valid command
	sceneId.value = scene.value.commands?.find(command => command.action !== null && !command.action.endsWith('_tod'))?.action ?? 'start'
	// last valid command
	// sceneId.value = scene.value.commands?.filter(command => command.action !== null && !command.action.endsWith('_tod'))?.slice(-1)[0].action ?? 'start'
}
</script>

<style>
#app {
	font-family: Avenir, Helvetica, Arial, sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	text-align: center;
	color: #2c3e50;
	margin-top: 60px;

	margin: 60px auto 0;
	max-width: 720px;
}

.actions {
	margin-bottom: 2rem;
}

.story {
	text-align: initial;
}

.text-preline {
	/* berücksichtigt line breaks */
	white-space: pre-line;
}
</style>
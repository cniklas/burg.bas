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

	<section class="actions">
		<div class="input-wrapper">
			<input type="text" v-model.trim="userName" ref="input" class="input" placeholder="Gib einen Namen ein oder drücke ENTER" @click.stop @keyup.enter="createName" />
		</div>

		<!-- TODO fade in/out nicely -->
		<div v-show="showButton" class="button-wrapper">
			<button type="button" class="button" @click.stop="$emit('start', userName)">Spiel starten</button>
		</div>
	</section>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, defineEmit } from 'vue'
// import useHowler from '../useHowler'

defineEmit([
	'start'
])

const userName = ref('')
const showButton = computed(() => userName.value !== '')

const firstNames = [
	'Basil',
	'Herbert',
	'Winston',
	'Fredrick',
	'Grumpf',
	'Wilhelm',
	'Theodore',
	'Greasus'
]
const lastNames = [
	'Berrybrook',
	'Deathrump',
	'Wellington',
	'Bloodlord',
	'Firerump',
	'Flamebeard',
	'the Flatulant IV',
	'Thornheart',
	'Ragefist',
	'Goldtooth',
	'Guillemaere'
]
const randomize = (store) => store[ Math.floor(Math.random() * store.length) ]
const createName = () => {
	userName.value = `${randomize(firstNames)} ${randomize(lastNames)}`
}

const input = ref(null)
const focusInput = () => {
	input.value.focus()
}
onMounted(() => {
	focusInput()
	document.addEventListener('click', focusInput)
})
onUnmounted(() => {
	document.removeEventListener('click', focusInput)
})
</script>

<style>

</style>

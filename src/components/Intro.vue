<template>
<!-- <pre class="ascii-text">
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
</pre> -->
	<div class="base-column">
		<h2 class="text-3xl text-center font-medium my-8">Bist du bereit für ein waghalsiges Abenteuer in einer unbekannten Burg?</h2>

		<section class="actions">
			<div class="input-wrapper">
				<input type="text" v-model.trim="userName" ref="input" class="input text-center" placeholder="Gib einen Namen ein oder drücke ENTER" @click.stop @keyup.enter="createName" />
			</div>

			<transition name="fade" mode="in-out">
				<div v-show="showButton" class="button-wrapper">
					<button type="button" class="button" @click.stop="$emit('start', userName)">Spiel starten</button>
				</div>
			</transition>
		</section>
	</div>
</template>

<script setup>
import simCityNames from '../names.json'
import { ref, computed, onMounted, onUnmounted, defineEmit } from 'vue'
import useHowler from '../useHowler'

defineEmit([
	'start'
])

const { loadMusic } = useHowler

const userName = ref('')
const showButton = computed(() => userName.value.length >= 2)

let names = []
// const randomize = (store) => store[ Math.floor(Math.random() * store.length) ]
const randomSplice = (store) => store.splice( Math.floor(Math.random() * store.length), 1 ).shift()
const createName = () => {
	// userName.value = `${randomize(firstNames)} ${randomize(lastNames)}`
	if (!names.length) {
		names = [...simCityNames]
	}
	userName.value = randomSplice(names)
}

const input = ref(null)
const focusInput = () => {
	input.value.focus()
}
onMounted(() => {
	focusInput()
	document.addEventListener('click', focusInput)
	loadMusic('intro-2')
})
onUnmounted(() => {
	document.removeEventListener('click', focusInput)
})
</script>

<style scoped>
h2 {
	color: hsl(172deg 88% 20%); /* ~ text-green-800 */
}

@media (min-width: 768px) {
	.input {
		max-width: 50%;
	}
}

.input::placeholder {
	font-size: 1rem; /* 16px */
}
</style>
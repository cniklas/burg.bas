<template>
	<div class="base-column">
		<h1 class="headline text-3xl text-center font-medium mb-8">Bist du bereit für ein waghalsiges Abenteuer in einer unbekannten Burg?</h1>

		<section class="actions">
			<div class="input-wrapper">
				<input type="text" v-model.trim="userName" ref="input" class="input text-center max-w-sm" placeholder="Gib einen Namen ein oder drücke ENTER" spellcheck="false" @click.stop @keyup.enter="createName" />
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
const showButton = computed(() => userName.value.length >= 3)

let names = []
const randomSplice = (store) => store.splice( Math.floor(Math.random() * store.length), 1 ).shift()
const createName = () => {
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

<style lang="postcss" scoped>
.headline {
	color: hsl(172deg 88% 22%); /* ~ text-green-800 */
}

.input::placeholder {
	font-size: 1rem;
	line-height: 2.375rem;
}

.fade-enter-active,
.fade-leave-active {
	transition: opacity 320ms ease-in-out;
}

.fade-enter-from,
.fade-leave-to {
	opacity: 0;
}
</style>
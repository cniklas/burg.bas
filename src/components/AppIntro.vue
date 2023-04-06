<script setup>
import simCityNames from '../data/names.json'
import { computed, onMounted, onUnmounted } from 'vue'
import { loadMusic } from '../use/howler'
import { useInput } from '../use/input'
import { userName } from '../use/store'

defineEmits(['start'])

const { input, focusInput } = useInput()

const showButton = computed(() => userName.value.length >= 3)

let names = []
const randomSplice = store => store.splice(Math.floor(Math.random() * store.length), 1).shift()
const createName = () => {
	if (!names.length) {
		names = [...simCityNames]
	}
	userName.value = randomSplice(names)
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

<template>
	<div class="base-column mx-auto flex-1 px-4 pt-8 lg:px-8">
		<h1 class="headline mb-8 text-center text-3xl font-medium">
			Bist du bereit für ein waghalsiges Abenteuer in einer unbekannten Burg?
		</h1>

		<section class="mt-8 text-center">
			<div class="my-4">
				<input
					ref="input"
					v-model.trim="userName"
					type="text"
					class="input w-full max-w-sm rounded p-2 text-center outline-none"
					placeholder="Gib einen Namen ein oder drücke ENTER"
					spellcheck="false"
					@click.stop
					@keyup.enter="createName"
				/>
			</div>

			<transition name="fade" mode="in-out">
				<div v-show="showButton" class="my-4">
					<button
						type="button"
						class="button inline-flex select-none items-center border border-current px-7 py-2 tracking-wider focus:outline-none"
						@click.stop="$emit('start')"
					>
						Spiel starten
					</button>
				</div>
			</transition>
		</section>
	</div>
</template>

<style scoped>
.input::placeholder {
	font-size: 1rem;
	line-height: 2.375rem;
}

.fade-enter-active,
.fade-leave-active {
	transition: opacity var(--transition-duration) ease-in-out;
}

.fade-enter-from,
.fade-leave-to {
	opacity: 0;
}
</style>

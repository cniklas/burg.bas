<template>
	<div class="base-column flex-1 mx-auto pt-8 px-4 lg:px-8">
		<h1 class="headline text-3xl font-medium text-center mb-8">
			Bist du bereit für ein waghalsiges Abenteuer in einer unbekannten Burg?
		</h1>

		<section class="mt-8 text-center">
			<div class="input-wrapper my-4">
				<input
					ref="input"
					v-model.trim="userName"
					type="text"
					class="input w-full p-2 rounded outline-none text-center max-w-sm"
					placeholder="Gib einen Namen ein oder drücke ENTER"
					spellcheck="false"
					@click.stop
					@keyup.enter="createName"
				/>
			</div>

			<transition name="fade" mode="in-out">
				<div v-show="showButton" class="button-wrapper my-4">
					<button
						type="button"
						class="
							button
							inline-flex
							items-center
							tracking-wider
							border border-current
							py-2
							px-7
							select-none
							focus:outline-none
						"
						@click.stop="$emit('start')"
					>
						Spiel starten
					</button>
				</div>
			</transition>
		</section>
	</div>
</template>

<script setup>
import simCityNames from '../names.json'
import { ref, computed, watch, onMounted, onUnmounted } from 'vue'
import { loadMusic } from '../useHowler'
import { useInput } from '../useInput'
import { setName } from '../useState'

const { input, focusInput } = useInput()

const userName = ref('')
const showButton = computed(() => userName.value.length >= 3)
watch(userName, val => {
	setName(val)
})

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

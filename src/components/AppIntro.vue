<script setup lang="ts">
import simCityNames from '@/data/names.json'
import { ref, computed, watch, onMounted, onUnmounted } from 'vue'
import { loadMusic } from '@/use/howler'
import { useInput } from '@/use/input'
import { useStore } from '@/use/store'

defineEmits<{ (event: 'start'): void }>()

const { inputEl, focusInput } = useInput()

const userName = ref('')
const { setUserName } = useStore()
watch(userName, setUserName)

const showButton = computed(() => userName.value.length >= 3)

let names: string[] = []
const randomSplice = (store: string[]) => store.splice(Math.floor(Math.random() * store.length), 1).shift()
const createName = () => {
	if (!names.length) names = [...simCityNames]
	userName.value = randomSplice(names) as string
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
		<h1 class="headline mb-8 text-3xl font-medium md:text-center">
			Bist du bereit für ein waghalsiges Abenteuer in einer unbekannten Burg?
		</h1>

		<div class="mt-8 text-center">
			<div class="my-4">
				<input
					ref="inputEl"
					v-model.trim="userName"
					type="text"
					class="input w-full max-w-sm rounded px-2 outline-none md:text-center"
					placeholder="Gib einen Namen ein oder drücke ENTER"
					spellcheck="false"
					enterkeyhint="next"
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
		</div>
	</div>
</template>

<style scoped>
.input::placeholder {
	font-size: 1rem;
}

:is(.fade-enter-active, .fade-leave-active) {
	transition: opacity var(--transition-duration) ease-in-out;
}

:is(.fade-enter-from, .fade-leave-to) {
	opacity: 0;
}
</style>

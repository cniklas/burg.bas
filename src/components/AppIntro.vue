<script setup lang="ts">
import { ref, computed, watch, onMounted, onUnmounted } from 'vue'
import simCityNames from '@/data/names.json'
import { loadMusic } from '@/use/howler'
import { useInput } from '@/use/input'
import { useStore } from '@/use/store'

defineEmits<{ start: [] }>()

const { inputEl, focusInput } = useInput()

const userName = ref('')
const { setUserName } = useStore()
watch(userName, setUserName)

const showButton = computed(() => userName.value.length >= 3)

let names: string[] = []
const randomSplice = (store: string[]) => store.splice(Math.floor(Math.random() * store.length), 1).shift()
const createName = () => {
	if (!names.length) names = [...simCityNames]
	userName.value = randomSplice(names)!
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

		<div class="text-center">
			<div class="mx-auto grid max-w-sm">
				<label
					class="col-start-1 row-start-1 content-center rounded bg-[--input-bg-color] text-gray-400"
					for="username"
				>
					Gib einen Namen ein oder drücke ENTER
				</label>
				<input
					ref="inputEl"
					v-model.trim="userName"
					type="text"
					id="username"
					class="input col-start-1 row-start-1 rounded px-2 md:text-center"
					:class="{ '!bg-transparent': !userName.length }"
					spellcheck="false"
					autocomplete="off"
					enterkeyhint="next"
					@click.stop
					@keyup.enter="createName"
				/>
			</div>

			<Transition name="fade" mode="in-out">
				<button
					v-show="showButton"
					type="button"
					class="button mt-4 select-none border border-current px-7 py-2 tracking-wider"
					@click.stop="$emit('start')"
				>
					Spiel starten
				</button>
			</Transition>
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

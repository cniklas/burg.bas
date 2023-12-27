<script setup lang="ts">
import burg from '@/data/burg.json'
import type { Scene, Story, Command } from '@/types/Scene.type'
import AppStory from './AppStory.vue'
import AppPanel from './AppPanel.vue'
import { ref, computed, watch, onMounted, onUnmounted, nextTick, defineAsyncComponent } from 'vue'
import { playlist, loadMusic, playMusic, fadeOutMusic } from '@/use/howler'
import { useInput } from '@/use/input'
import { useStore } from '@/use/store'
import { animateNumber } from '@/use/countUpAnimation'

const { isTouch, inputEl, focusInput, cleanInput, buttonEl, blurButton } = useInput()
const { state, setGold, setHealth, hasCondition, isEnabled, handleCondition, manageInventory, getArmed, resetState } =
	useStore()

const sceneId = ref('intro')
const gameWon = computed(
	() => hasCondition('battle-won') || sceneId.value.endsWith('_ende') || sceneId.value.startsWith('congratulations'),
)
const gameLost = computed(
	() =>
		sceneId.value === 'game-over' || scene.value?.commands?.find(cmd => cmd.action === 'game-over' && isEnabled(cmd)),
)
const showCredits = computed(() => sceneId.value === 'credits')
const scene = computed<Scene | undefined>(() => burg.find(scene => scene.id === sceneId.value))
const story = ref<Story>([])
const onHold = ref(false)
const handleStory = async () => {
	if (!scene.value) return

	// für Transition
	story.value = []
	await nextTick()

	// replace story
	story.value = [...scene.value.story]

	// set time for delayed story
	if (scene.value.delayed) {
		onHold.value = true

		setTimeout(() => {
			onHold.value = false
			story.value = [...story.value, ...(scene.value?.delayed?.story ?? [])]

			requestAnimationFrame(focusInput)
		}, scene.value.delayed.delay)
	} else {
		requestAnimationFrame(focusInput)
	}

	// fade out music
	fadeOutMusic()

	// play music
	if (scene.value.play) {
		scene.value.play_delay
			? setTimeout(playMusic, scene.value.play_delay, scene.value.play)
			: playMusic(scene.value.play)
	}

	// reduce health
	if (scene.value.health) {
		reduceHealth(Math.abs(scene.value.health))
	}
	if (gameLost.value) {
		animateNumber(state.health, state.health, setHealth)
	}

	// continue
	if (scene.value.continue) {
		let delay = scene.value.continue.delay ?? 200
		if (scene.value.play) {
			delay = Math.ceil(
				(playlist.value.find(item => item.id === scene.value?.play)?.audio?.duration() ?? delay / 1000) * 1000,
			)
		}

		setTimeout(handleAction, delay, { action: scene.value.continue.action })
	}

	// load music
	if (scene.value.load_audio) {
		loadMusic(scene.value.load_audio)
	}

	// do other stuff
	switch (sceneId.value) {
		case 'waffenkammer':
			getArmed()
			break
		case 'schatzkammer_ende':
			animateNumber(state.gold, 100, setGold, true)
			break
		case 'vorzimmer_drache_sieg':
			setTimeout(manageInventory, scene.value.delayed?.delay, 'discard-magic-wand')
			break
		case 'thronsaal_kampf':
			finalBattle()
			break
		case 'thronsaal_ende':
			animateNumber(state.gold, 1000, setGold, true)
			break
	}
}
watch(sceneId, handleStory, { immediate: true })

const reduceHealth = (points: number) => {
	const min = Math.ceil(points / 2)
	const max = Math.floor(points)

	const rnd = Math.floor(Math.random() * (max - min + 1)) + min
	sceneId.value === 'lagerhaus_kampf'
		? setTimeout(animateNumber, scene.value?.delayed?.delay, state.health, rnd, setHealth)
		: animateNumber(state.health, rnd, setHealth)
}

const AppBattle = defineAsyncComponent(() => import('./AppBattle.vue'))
const showBattle = computed(() => sceneId.value === 'thronsaal_kampf')
const startBattle = ref(false)
const finalBattle = () => {
	scene.value?.play_delay
		? setTimeout(() => {
				startBattle.value = true
			}, scene.value.play_delay)
		: (startBattle.value = true)
}
const onBattleFinished = (result: string) => {
	fadeOutMusic()
	handleCondition(`battle-${result}`)
}

const nextScene = (id: string) => {
	hint.value = ''
	showHint.value = false
	inputRef.value = ''
	sceneId.value = id
}

const resetGame = () => {
	startBattle.value = false
	resetState()
}

let _timeout: number | undefined
const handleAction = (command: Command) => {
	if (!command.action) return

	clearTimeout(_timeout)
	_timeout = undefined

	handleCondition(command.setCondition)

	if (['start', 'credits'].includes(command.action)) {
		resetGame()
	}

	nextScene(command.action)
}

const handleMessage = (message: string) => {
	hint.value = message
	showHint.value = true
}

const handleCommand = (command: Command) => {
	command.message ? handleMessage(command.message) : handleAction(command)
}

const nextButton = computed(() => scene.value?.commands?.find(cmd => cmd.key === 'enter' && isEnabled(cmd)))
const onClick = () => {
	if (!nextButton.value) return

	blurButton()
	handleCommand(nextButton.value)
}
const hint = ref('')
const showHint = ref(false)
const inputRef = ref('')
const showInput = computed(() => !(!!scene.value?.continue || nextButton.value || showBattle.value))
const touchButtonEl = ref<HTMLButtonElement | null>(null)
const handleInput = () => {
	touchButtonEl.value?.blur()

	if (scene.value?.timeout && !_timeout) {
		_timeout = setTimeout(handleAction, 7000, { action: scene.value.timeout.action })
	}

	const inputString = cleanInput(inputRef.value)
	const command = scene.value?.commands?.find(
		cmd =>
			isEnabled(cmd) &&
			(typeof cmd.text === 'string'
				? cmd.text.toLowerCase() === inputString
				: cmd.text.find(text => text.toLowerCase() === inputString)),
	)

	if (command === undefined) {
		hint.value = scene.value?.hint ?? ''
		showHint.value = true
		return
	}

	handleCommand(command)
}

onMounted(() => {
	document.addEventListener('click', focusInput)
})

onUnmounted(() => {
	document.removeEventListener('click', focusInput)
})
</script>

<template>
	<div
		class="base-column mx-auto flex flex-1 flex-col justify-between gap-y-8 px-4 pt-8 lg:px-8"
		:class="{ 'game-won': gameWon, 'game-lost': gameLost }"
	>
		<main class="main flex-auto">
			<div class="flex h-full flex-col justify-between">
				<AppStory :story="story" class="<md:overflow-y-auto" :class="{ '<md:hidden': showBattle && startBattle }">
					<div v-if="showCredits" class="mt-12 hidden justify-center md:flex">
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
</pre
						>
					</div>
				</AppStory>

				<AppBattle
					v-if="showBattle && startBattle"
					class="flex-auto overflow-y-auto md:mt-8"
					@finished.once="onBattleFinished"
				/>

				<div v-show="!onHold && !showCredits" class="mt-8 md:text-center">
					<div v-if="nextButton" class="text-center">
						<button
							ref="buttonEl"
							type="button"
							class="button inline-flex select-none items-center border border-current px-7 py-2 tracking-wider focus:outline-none"
							@click.stop="onClick"
						>
							{{ nextButton?.text || 'weiter' }}
						</button>
					</div>

					<div v-show="hint && showHint" class="hint white mb-4">{{ hint }}</div>
					<div v-if="showInput" class="flex gap-x-4">
						<input
							ref="inputEl"
							v-model.trim="inputRef"
							type="text"
							class="input w-full rounded px-2 outline-none"
							placeholder="?"
							spellcheck="false"
							enterkeyhint="send"
							@click.stop
							@keyup.enter="handleInput"
						/>
						<button
							v-if="isTouch"
							ref="touchButtonEl"
							type="button"
							class="button inline-flex w-11 shrink-0 select-none items-center justify-center border border-current tracking-wider focus:outline-none sm:w-12"
							@click="handleInput"
						>
							Go
						</button>
					</div>
				</div>
			</div>
		</main>

		<AppPanel v-show="!showCredits" />
	</div>
</template>

<style>
.base-column {
	box-shadow: 0 0 5.375rem var(--bg-color);
	transition: box-shadow 480ms ease-out;

	&.game-won {
		box-shadow: 0 0 5.375rem var(--green);
	}

	&.game-lost {
		box-shadow: 0 0 5.375rem var(--red);
	}
}

.main {
	max-height: calc(100% - 8rem); /* row-gap + .panel */
}

.ascii-text {
	font-family: 'Courier New', Courier, monospace;
	font-size: 0.75rem;
	line-height: 1;
}
</style>

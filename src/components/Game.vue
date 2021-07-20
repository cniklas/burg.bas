<template>
	<div
		class="base-column flex-1 mx-auto pt-8 px-4 lg:px-8 flex flex-col justify-between gap-y-8"
		:class="{ 'game-won': gameWon, 'game-lost': gameLost }"
	>
		<main class="main flex-auto">
			<div class="scene h-full flex flex-col justify-between">
				<AppStory :story="story" :is-enabled="isEnabled">
					<div v-if="showCredits" class="hidden md:flex justify-center mt-12">
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
					class="flex-auto overflow-y-auto"
					:user-name="userName"
					:health="health"
					:strike-interval="strikeInterval"
					@got-hit="onHit"
					@finish="onBattleFinished"
				/>

				<section v-show="!onHold && !showCredits" class="actions mt-8 text-center">
					<div v-if="nextButton" class="button-wrapper my-4">
						<button
							ref="button"
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
							@click.stop="onClick"
						>
							{{ nextButton?.text || 'weiter' }}
						</button>
					</div>

					<div v-show="hint && showHint" class="hint my-4 papayawhip">{{ hint }}</div>
					<div v-if="showInput" class="input-wrapper my-4">
						<input
							ref="input"
							v-model.trim="typed"
							type="text"
							class="input w-full p-2 rounded outline-none"
							placeholder="?"
							spellcheck="false"
							@click.stop
							@keyup.enter="handleInput"
						/>
					</div>
				</section>
			</div>
		</main>

		<AppPanel v-show="!showCredits" />
	</div>
</template>

<script setup>
import burg from '../burg.json'
import AppStory from './Story.vue'
import AppBattle from './Battle.vue'
import AppPanel from './Panel.vue'
import { ref, computed, watch, onMounted, onUnmounted, nextTick } from 'vue'
import useHowler from '../useHowler'
import useInput from '../useInput'
import useState from '../useState'
import useCountAnimation from '../useCountAnimation'

const { playlist, loadMusic, playMusic, fadeOutMusic } = useHowler
const { userName, gold, health, hasCondition, isEnabled, handleCondition, manageInventory, getArmed, resetState } =
	useState
const { input, focusInput, cleanInput, button, blurButton } = useInput()
const { animateCount } = useCountAnimation()

const sceneId = ref('intro')
const gameWon = computed(
	() => hasCondition('battle-won') || sceneId.value.endsWith('_ende') || sceneId.value.startsWith('congratulations')
)
const gameLost = computed(
	() => sceneId.value === 'game-over' || scene.value.commands?.find(cmd => cmd.action === 'game-over' && isEnabled(cmd))
)
const showCredits = computed(() => sceneId.value === 'credits')
const scene = computed(() => burg.find(scene => scene.id === sceneId.value))
const story = ref([])
const onHold = ref(false)
const handleStory = async () => {
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
			story.value = [...story.value, ...scene.value.delayed.story]

			requestAnimationFrame(focusInput)
		}, scene.value.delayed.delay)
	}
	else {
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
		animateCount(health, health.value, false)
	}

	// continue
	if (scene.value.continue) {
		let delay = scene.value.continue.delay ?? 200
		if (scene.value.play) {
			delay = Math.ceil(
				(playlist.value.find(item => item.id === scene.value.play)?.audio?._duration ?? delay / 1000) * 1000
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
			animateCount(gold, 100)
			break
		case 'vorzimmer_drache_sieg':
			setTimeout(manageInventory, scene.value.delayed.delay, 'discard-magic-wand')
			break
		case 'thronsaal_kampf':
			finalBattle()
			break
	}
}
watch(sceneId, handleStory, { immediate: true })

const reduceHealth = points => {
	const min = Math.ceil(points / 2)
	const max = Math.floor(points)

	const rnd = Math.floor(Math.random() * (max - min + 1)) + min
	sceneId.value === 'lagerhaus_kampf'
		? setTimeout(animateCount, scene.value.delayed.delay, health, rnd, false)
		: animateCount(health, rnd, false)
}

const showBattle = computed(() => sceneId.value === 'thronsaal_kampf')
const startBattle = ref(false)
const finalBattle = () => {
	scene.value.play_delay
		? setTimeout(() => {
				startBattle.value = true
		  }, scene.value.play_delay)
		: (startBattle.value = true)
}
const strikeInterval = ref(1200)
const onHit = points => {
	animateCount(health, points, false, strikeInterval.value)
}
const onBattleFinished = result => {
	fadeOutMusic()
	handleCondition(`battle-${result}`)
}

const nextScene = id => {
	hint.value = ''
	showHint.value = false
	typed.value = ''
	sceneId.value = id
}

const resetGame = () => {
	startBattle.value = false
	resetState()
}

let timeout = null
const handleAction = command => {
	clearTimeout(timeout)
	timeout = null

	handleCondition(command.setCondition)

	if (['start', 'credits'].includes(command.action)) {
		resetGame()
	}

	nextScene(command.action)
}

const handleMessage = message => {
	hint.value = message
	showHint.value = true
}

const handleCommand = command => {
	command.message ? handleMessage(command.message) : handleAction(command)
}

const nextButton = computed(() => scene.value.commands?.find(cmd => cmd.key === 'enter' && isEnabled(cmd)))
const onClick = () => {
	blurButton()
	handleCommand(nextButton.value)
}
const hint = ref('')
const showHint = ref(false)
const typed = ref('')
const showInput = computed(() => !(!!scene.value.continue || nextButton.value || showBattle.value))
const handleInput = () => {
	if (scene.value.timeout && !timeout) {
		timeout = setTimeout(handleAction, 7000, { action: scene.value.timeout.action })
	}

	const inputString = cleanInput(typed.value)
	const command = scene.value.commands?.find(
		cmd =>
			isEnabled(cmd) &&
			(typeof cmd.text === 'string'
				? cmd.text.toLowerCase() === inputString
				: cmd.text.find(text => text.toLowerCase() === inputString))
	)

	if (command === undefined) {
		hint.value = scene.value.hint ?? ''
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

<style>
.base-column {
	box-shadow: 0 0 5.375rem var(--bg-color);
	transition: box-shadow 480ms ease-out;
}

.base-column.game-won {
	box-shadow: 0 0 5.375rem var(--green);
}

.base-column.game-lost {
	box-shadow: 0 0 5.375rem var(--red);
}

.main {
	max-height: calc(100% - 8rem); /* row-gap + .panel */
}
</style>

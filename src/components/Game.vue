<template>
	<div class="base-column flex flex-col justify-between gap-y-8" :class="{'game-won': gameWon, 'game-lost': gameLost}">
		<main class="main flex-auto">
			<div class="scene h-full flex flex-col justify-between">
				<AppStory
					:story="story"
					:is-disabled="isDisabled"
				>
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
</pre>
					</div>
				</AppStory>

				<AppBattle
					v-if="showBattle && startBattle"
					class="flex-auto overflow-y-auto"
					:user-name="userName"
					:health="health"
					:strike-interval="strikeInterval"
					@got-hit="onHit"
					@finish="finishBattle"
				/>

				<section v-show="!onHold && !showCredits" class="actions">
					<div v-if="nextButton" class="button-wrapper">
						<button type="button" class="button" @click.stop="handleCommand(nextButton)">{{ nextButton?.text || 'weiter' }}</button>
					</div>

					<div v-show="hint && showHint" class="hint papayawhip">{{ hint }}</div>
					<div v-if="showInput" class="input-wrapper">
						<input type="text" v-model.trim="typed" ref="input" class="input" placeholder="?" spellcheck="false" @click.stop @keyup.enter="handleInput" />
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
import { ref, computed, watch, onMounted, onUnmounted, defineProps, nextTick } from 'vue'
import useHowler from '../useHowler'
import useState from '../useState'
import useCountAnimation from '../useCountAnimation'

defineProps({
	userName: String
})

const { playlist, loadMusic, playMusic, fadeOutMusic } = useHowler
const { gold, health, hasCondition, handleCondition, manageInventory, getArmed, finishBattle, resetState } = useState
const { animateCount } = useCountAnimation()

const input = ref(null)
const focusInput = () => {
	input.value?.focus()
}

const sceneId = ref('intro')
const gameWon = computed(() => hasCondition('battle-won') || sceneId.value.endsWith('_ende') || sceneId.value.startsWith('congratulations'))
const gameLost = computed(() => sceneId.value === 'game-over' || scene.value.commands?.find(cmd => cmd.action === 'game-over' && !isDisabled(cmd)))
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
		let delay = scene.value.continue.delay || 200
		if (scene.value.play) {
			delay = Math.ceil( (playlist.value.find(item => item.id === scene.value.play)?.audio?._duration ?? delay / 1000) * 1000 )
		}

		setTimeout(handleAction, delay, { action: scene.value.continue.action })
	}

	// load music
	if (scene.value.load_audio) {
		loadMusic(scene.value.load_audio)
	}

	// do other stuff
	switch (sceneId.value) {
		case 'waffenkammer': getArmed(); break;
		case 'schatzkammer_ende': animateCount(gold, 100); break;
		case 'vorzimmer_drache_sieg': setTimeout(manageInventory, scene.value.delayed.delay, 'discard-magic-wand'); break;
		case 'thronsaal_kampf': finalBattle(); break;
	}
}
watch(sceneId, handleStory, { immediate: true })

const nextButton = computed(() => scene.value.commands?.find(cmd => cmd.key === 'enter' && !isDisabled(cmd)))
const hint = ref('')
const showHint = ref(false)
const showInput = computed(() => !(
	!!scene.value.continue
	|| nextButton.value
	|| showBattle.value
))
const typed = ref('')

const reduceHealth = points => {
  const min = Math.ceil(points / 2)
  const max = Math.floor(points)

	const rnd = Math.floor(Math.random() * (max - min + 1)) + min
	sceneId.value === 'lagerhaus_kampf'
		? setTimeout(animateCount, scene.value.delayed.delay, health, rnd, false)
		: animateCount(health, rnd, false)
}
const strikeInterval = ref(1200)
const onHit = points => {
  animateCount(health, points, false, strikeInterval.value)
}

const showBattle = computed(() => sceneId.value === 'thronsaal_kampf')
const startBattle = ref(false)
const finalBattle = () => {
	scene.value.play_delay
		? setTimeout(() => { startBattle.value = true }, scene.value.play_delay)
		: startBattle.value = true
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

const handleMessage = command => {
	hint.value = command.message
	showHint.value = true
}

const handleCommand = command => {
	command.message ? handleMessage(command) : handleAction(command)
}

const isDisabled = ({ condition, notCondition }) => {
	if (condition && notCondition) {
		return !hasCondition(condition) || hasCondition(notCondition)
	}
	if (condition) {
		return !hasCondition(condition)
	}
	if (notCondition) {
		return hasCondition(notCondition)
	}

	return false
}

const cleanInput = string => {
	const regex = /[!"#$%&\'()*+,\-./:;<=>?@[\\\]^_`{\|}~]/g;
	return string
		.replaceAll(regex, '')
		.toLowerCase()
		.replaceAll('geradeaus', 'weiter')
		.split(' ')
		.filter(word => word.length && !['der', 'die', 'das', 'den', 'dem', 'und', 'mit'].includes(word))
		.join(' ')
}

const handleInput = () => {
	if (scene.value.timeout && !timeout) {
		timeout = setTimeout(handleAction, 7000, { action: scene.value.timeout.action })
	}

	const input = cleanInput(typed.value)
	const command = scene.value.commands?.find(cmd => !isDisabled(cmd) && cmd.text.toLowerCase() === input)

	if (command === undefined) {
		hint.value = scene.value.hint || ''
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

<style lang="postcss" scoped>
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
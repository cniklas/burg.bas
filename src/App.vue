<template>
<!-- <pre class="ascii-text">
</pre> -->

<!-- <pre class="ascii-drawing">
▓▓▓
</pre> -->

	<section class="scene">
		<Story
			:story="story"
			:is-disabled="isDisabled"
		/>

		<Battle
			v-if="showBattle && startFight"
			:health="health"
			@got-hit="gotHit"
		/>

		<div v-show="isMusicReady && !onHold" class="actions">
			<div v-show="nextButton" class="button-wrapper">
				<button type="button" @click.stop="handleCommand(nextButton)">{{ nextButton?.text || 'weiter' }}</button>
			</div>

			<div v-show="hint && showHint" class="hint papayawhip">{{ hint }}</div>
			<div v-show="showInput && !nextButton" class="input-wrapper">
				<input type="text" v-model.trim="typed" ref="input" class="input" @click.stop @keyup.enter="handleInput" />
			</div>
		</div>
	</section>

	<div class="debug">
		<div class="gold">Gold: {{ gold }}</div>
		<div class="pink">Health: {{ health }}</div>
		<!-- <pre><code v-for="condition in conditions">{{ `${condition}\n` }}</code></pre> -->
		<pre class="blue-dark"><code v-for="item in inventory">{{ item }} </code></pre>
	</div>
</template>

<script setup>
import burg from './burg.json'
import Story from './components/Story.vue'
import Battle from './components/Battle.vue'
import { ref, computed, watch, onMounted, onUnmounted, nextTick } from 'vue'
import useHowler from './useHowler'
import useCountAnimation from './useCountAnimation'

const { playlist, isMusicReady, loadMusic, playMusic, fadeOutMusic } = useHowler()
const { animateCount } = useCountAnimation()

const input = ref(null)
const focusInput = () => {
	input.value.focus()
}

let sceneId = ref('start')
// todo zum Einfärben des Hintergrunds
const end_death = computed(() => sceneId.value.endsWith('_tod'))
const end_freedom = computed(() => sceneId.value.endsWith('_ende'))
const scene = computed(() => burg.find(scene => scene.id === sceneId.value))
const story = ref([])
const onHold = ref(false)
const handleStory = async () => {
	// für Transition
	story.value = []
	await nextTick()

	// replace story
	story.value = [...scene.value.story]
	requestAnimationFrame(focusInput)

	// set time for delayed story
	if (scene.value.delayed) {
		onHold.value = true

		setTimeout(() => {
			onHold.value = false
			story.value = [...story.value, ...scene.value.delayed.story]

			requestAnimationFrame(focusInput)
		}, scene.value.delayed.delay)
	}

	// fade out music
	fadeOutMusic()

	// play music
	if (scene.value.play) {
		scene.value.play_delay
			? setTimeout(() => { playMusic(scene.value.play) }, scene.value.play_delay)
			: playMusic(scene.value.play)
	}

	// reduce health
	if (scene.value.health) {
		reduceHealth(Math.abs(scene.value.health))
	}
	if (end_death.value) {
		animateCount(health, health.value, false)
	}

	// continue
	if (scene.value.continue) {
		/*
		// continue after audio has been loaded
		if (scene.value.load_audio) {
			let i = 0
			// console.time('foo')
			const interval = setInterval(() => {
				i += 300
				// console.log(i)
				// console.timeLog('foo')
				const loaded = playlist.find(item => item.id === scene.value.load_audio)?.audio?._state ?? false
				if (loaded === 'loaded' || i >= 3000) {
					// console.timeEnd('foo')
					clearInterval(interval)
					handleAction({ action: scene.value.continue.action })
				}
			}, 300)
		}
		// continue after audio has been played oder given delay or fallback
		else {
		} */
		let delay = scene.value.continue.delay || 200
		if (scene.value.play) {
			delay = Math.ceil( (playlist.find(item => item.id === scene.value.play)?.audio?._duration ?? delay / 1000) * 1000 )
		}

		setTimeout(() => {
			handleAction({ action: scene.value.continue.action })
		}, delay)
	}

	// load music
	if (scene.value.load_audio) {
		loadMusic(scene.value.load_audio)
	}

	// do other stuff
	switch (sceneId.value) {
		case 'waffenkammer': getArmed(); break;
		case 'schatzkammer_ende': animateCount(gold, 100); break;
		case 'vorzimmer_drache_sieg': setTimeout(() => { manageInventory('discard-magic-wand') }, scene.value.delayed.delay); break;
		case 'thronsaal_kampf': finalBattle(); break;
	}
}
watch(sceneId, handleStory, { immediate: true })
// const animated = ref(false)
// const animateIn = () => {
// 	setTimeout(() => {
// 		animated.value = true
// 	}, 100)
// }

// const clickCommandsList = ['hoch', 'runter', 'links', 'rechts', 'weiter', 'zurück']
// const clickCommands = computed(() => scene.value.commands?.filter(cmd => clickCommandsList.includes(cmd.text) || cmd.key === 'enter') ?? [])
// const textCommands = computed(() => scene.value.commands?.filter(cmd => !clickCommandsList.includes(cmd.text) && cmd.key !== 'enter') ?? [])
const nextButton = computed(() => scene.value.commands?.find(cmd => cmd.key === 'enter' && !isDisabled(cmd)));

const conditions = ref([])
const hasCondition = term => conditions.value.includes(term)

const typed = ref('')
const hint = ref('')
const showHint = ref(false)
// const hideInput = computed(() => !!scene.value.continue || ['thronsaal_kampf', 'credits'].includes(sceneId.value))
const showInput = computed(() => !(!!scene.value.continue || ['thronsaal_kampf', 'credits'].includes(sceneId.value)))
// const showInput = computed(() => {
// 	return (
// 		!scene.value.continue
// 		&& !['thronsaal_kampf', 'credits'].includes(sceneId.value)
// 		&& !scene.value.commands?.find(cmd => cmd.key === 'enter' && !isDisabled(cmd))
// 	)
// })

const gold = ref(0)

const health = ref(100)
const reduceHealth = points => {
  const min = Math.ceil(points / 2)
  const max = Math.floor(points)

	const rnd = Math.floor(Math.random() * (max - min + 1)) + min
	// health.value -= rnd
	sceneId.value === 'lagerhaus_kampf'
		? setTimeout(() => { animateCount(health, rnd, false) }, scene.value.delayed.delay)
		: animateCount(health, rnd, false)
}
const gotHit = points => {
	// todo Dauer der Animation muss definierbar sein
  // animateCount(health, points, false)
	health.value -= points
}

const inventory = ref([])
const manageInventory = condition => {
	switch (condition) {
		case 'has-helmet': inventory.value.push('Helm', 'Umhang'); break;
		case 'has-keys': inventory.value.push('Keule', 'Schlüssel'); break;
		case 'has-sword': inventory.value.push('Schwert', 'Seil'); break;
		case 'has-magic-wand': inventory.value.push('Stab'); break;
		case 'discard-mace': inventory.value.splice(inventory.value.indexOf('Keule'), 1); break;
		case 'get-armed': inventory.value.push('Schwert', 'Schild'); break;
		case 'discard-magic-wand': inventory.value.splice(inventory.value.indexOf('Stab'), 1); break;
	}
}

const resetGame = () => {
	conditions.value = []
	inventory.value = []
	gold.value = 0
	health.value = 100
}

const getArmed = () => {
	if (!hasCondition('has-sword')) {
		if (hasCondition('has-keys')) {
			manageInventory('discard-mace')
		}
		manageInventory('get-armed')
	}
}

const showBattle = computed(() => sceneId.value === 'thronsaal_kampf')
const startFight = ref(false)
const finalBattle = () => {
	// const rnd = Math.floor(Math.random() * Math.floor(3))
	// console.log(rnd > 0 ? '👍' : '👎')
	// const action = rnd > 0 ? 'thronsaal_kampf_sieg' : 'thronsaal_kampf_tod'

	// const delay = scene.value.play_delay + 200 + Math.ceil( (playlist.find(item => item.id === scene.value.play)?.audio?._duration ?? 70) * 1000 )
	// setTimeout(() => {
	// 	handleAction({ action })
	// }, delay)
	scene.value.play_delay
		? setTimeout(() => { startFight.value = true }, scene.value.play_delay)
		: startFight.value = true
}

// todo wenn in "brenzligen" Situationen mehr als ein/zweimal Quatsch eingegeben wird, stirbt der Protagonist (Wachen sind dann z.B. herangekommen)
const handleAction = command => {
	if (command.setCondition && !hasCondition(command.setCondition)) {
		conditions.value.push(command.setCondition)
		manageInventory(command.setCondition)
	}

	if (command.action === 'start') {
		resetGame()
	}

	showHint.value = false
	hint.value = ''
	typed.value = ''
	// animated.value = false
	sceneId.value = command.action

	// animateIn()
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
	const input = cleanInput(typed.value)

	// let command
	// if (input === 'weiter') {
	// 	command = scene.value.commands?.find(cmd => !isDisabled(cmd) && cmd.key === 'enter')
	// }

	// if (command === undefined) {
	// 	command = scene.value.commands?.find(cmd => !isDisabled(cmd) && cmd.text.toLowerCase() === input)
	// }
	const command = scene.value.commands?.find(cmd => !isDisabled(cmd) && cmd.text.toLowerCase() === input)

	if (command === undefined) {
		hint.value = scene.value.hint || ''
		showHint.value = true
		return
	}

	handleCommand(command)
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
:root {
	/* --global-font-size: 14px; */
	--global-line-height: 1.375; /* 'leading-snug' */

	/* --spacing:        1em; */
	/* --spacing-medium: calc(var(--spacing) * 2); */
	/* --spacing-large:  calc(var(--spacing) * 3); */

	--blue-light:   #89d3fd;
	--blue-dark:    #067df7;
	--gold:         #ffbd2e;
	--green:        #5ce6cd;
	--papayawhip:   papayawhip;
	--pink:         hotpink;
	--purple-light: #7775A7;
	--purple-dark:  #bd10e0;
	--red:          #ff0080;
}

.white        { color: #fff; }
.blue-light   { color: var(--blue-light); }
.blue-dark    { color: var(--blue-dark); }
.gold         { color: var(--gold); }
.green        { color: var(--green); }
.grey-dark    { color: var(--grey-dark); }
.papayawhip   { color: papayawhip; }
.pink         { color: hotpink; }
.purple-light { color: var(--purple-light); }
.purple-dark  { color: var(--purple-dark); }
.red          { color: var(--red); }

html {
	background-color: #0f0f17;
	color: #cbd5e0;
}

pre:empty,
div:empty,
p:empty {
	margin: 0;
}

button {
	background-color: #1a202c;
	color: cadetblue;
	font-size: 80%;
	border: 1px solid currentColor;
	padding: .5rem 1rem;
	user-select: none;
}
/*
button:disabled {
	opacity: .4;
	cursor: initial;
} */

/* button:focus, */
button:not(:disabled):hover {
	color: #e2e8f0;
}

#app {
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	font-family: Menlo, 'DejaVu Sans Mono', 'Lucida Console', monospace;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	margin: 60px auto 0;
	max-width: 720px;
}

.ascii-drawing {
	font-size: 42px;
}

.ascii-text {
	font-size: 0.8125rem;
	line-height: 1.153846;
}

.scene {
	@apply relative z-10;
}

.story,
.actions {
	@apply my-8;
}

.story {
	line-height: var(--global-line-height);
}

.story p {
	margin-bottom: calc(var(--global-line-height) * 1rem);
}

.text-prewrap {
	@apply block whitespace-pre-wrap text-center;
}
/*
.story .disabled {
	opacity: .35;
} */

.actions {
	@apply text-center;
}

.hint,
.button-wrapper,
.input-wrapper {
	@apply my-4;
}

/*
.delayed {
	visibility: hidden;
	opacity: 0;
	transition: opacity 180ms ease-out;
}

.delayed.animated {
	visibility: visible;
	opacity: 1;
} */
/*
.hint {
	font-style: italic;
} */

.input {
	@apply w-full py-2;
	/* color: #000; */
	background-color: transparent;
	color: inherit;
	outline: 0;
}

.debug {
	font-family: 'Courier New', Courier, monospace;
	text-align: center;
	border: 2px dashed;
	position: fixed;
	z-index: 1;
	bottom: 0;
	width: 100%;
	max-width: 720px;
}

.debug > * {
	margin: .75rem 0;
}

.fade-enter-active {
	transition: opacity 320ms ease-in-out;
}

.fade-enter-from,
.fade-leave-active {
	opacity: 0;
}
</style>
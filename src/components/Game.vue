<template>
	<div class="flex flex-col justify-end h-screen">
		<main class="flex flex-col flex-1" style="max-height:calc(100vh / 1.5);max-height:90vh">
			<div class="scene h-full flex flex-col justify-between">
				<Story
					:story="story"
					:is-disabled="isDisabled"
				/>

				<Battle
					v-if="showBattle && startFight"
					class="flex-1 overflow-y-auto"
					:user-name="userName"
					:health="health"
					:strike-interval="strikeInterval"
					@got-hit="onHit"
					@finish="finishBattle"
				/>

				<!-- v-show="isMusicReady && !onHold" -->
				<section v-show="!onHold" class="actions">
					<div v-show="nextButton" class="button-wrapper">
						<button type="button" class="button" @click.stop="handleCommand(nextButton)">{{ nextButton?.text || 'weiter' }}</button>
					</div>

					<div v-show="hint && showHint" class="hint papayawhip">{{ hint }}</div>
					<div v-show="showInput && !nextButton" class="input-wrapper">
						<input type="text" v-model.trim="typed" ref="input" class="input" :placeholder="inputPlaceholder" @click.stop @keyup.enter="handleInput" />
					</div>
				</section>
			</div>
		</main>

		<aside class="debug text-center">
			<div class="gold">Gold: {{ gold }}</div>
			<div class="pink">Health: {{ health }}</div>
			<pre class="blue-dark"><code v-for="item in inventory">{{ item }} </code></pre>
		</aside>
	</div>
</template>

<script setup>
import burg from '../burg.json'
import Story from './Story.vue'
import Battle from './Battle.vue'
import { ref, computed, watch, onMounted, onUnmounted, defineProps, nextTick } from 'vue'
import useHowler from '../useHowler'
import useCountAnimation from '../useCountAnimation'

// um Props im Script Block zu verwenden:
// const myProps = defineProps( … )
// const { userName } = toRefs(myProps)
defineProps({
	userName: String
})

const { playlist/* , isMusicReady */, loadMusic, playMusic, fadeOutMusic } = useHowler()
const { animateCount } = useCountAnimation()

const input = ref(null)
const focusInput = () => {
	input.value.focus()
}

const sceneId = ref('intro')
// TODO zum Einfärben des Hintergrunds
const isEndDeath = computed(() => sceneId.value.endsWith('_tod'))
const isEndFreedom = computed(() => sceneId.value.endsWith('_ende'))
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
	if (isEndDeath.value) {
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
const inputPlaceholder = computed(() => sceneId.value === 'start' ? 'Fang an zu tippen' : '')
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
	sceneId.value === 'lagerhaus_kampf'
		? setTimeout(() => { animateCount(health, rnd, false) }, scene.value.delayed.delay)
		: animateCount(health, rnd, false)
}
const strikeInterval = ref(1200)
const onHit = points => {
  animateCount(health, points, false, strikeInterval.value)
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
const finishBattle = (val) => {
	conditions.value.push(`battle-${val}`)
}

// TODO wenn in "brenzligen" Situationen mehr als ein/zweimal Quatsch eingegeben wird, stirbt der Protagonist (Wachen sind dann z.B. herangekommen)
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

</style>

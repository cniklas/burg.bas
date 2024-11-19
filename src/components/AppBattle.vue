<script setup lang="ts">
import { useTemplateRef, reactive, computed, watch, onMounted, onBeforeUnmount } from 'vue'
import { useBattle, type Player, type Opponent } from '@/use/battle'
import { useStore } from '@/use/store'
import { animateNumber } from '@/use/countUpAnimation'

const { attackLog, resetAttackLog, randomAction } = useBattle()
const { state, setHealth } = useStore()

const emit = defineEmits<{ finished: [result: string] }>()

const strikeInterval = 1200

const _opponent: Opponent = reactive({
	name: '🧟 UBOLZIO',
	health: 75,
	attack: 0,
	hit: false,
})

const _player: Player = reactive({
	name: `🦸🏼‍♂️ ${state.userName}`,
	health: state.health,
	originHealth: state.health,
	attack: 0,
	hit: false,
	weapon: 'seinem Schwert',
})
watch(
	() => _player.health,
	(val, oldVal) => {
		if (val < _player.originHealth) {
			animateNumber(state.health, oldVal - val, setHealth, false, strikeInterval)
		}
	},
)

const battleResult = computed(() => {
	let message = ''
	switch (true) {
		case _opponent.health <= 0 && _player.health > 0:
			message = `${_opponent.name} erleidet eine Herzattacke und stirbt. 💀`
			emit('finished', 'won')
			break

		case _player.health <= 0 && _opponent.health > 0:
			message = `${_player.name} erliegt seinen Verletzungen und stirbt. 🚑`
			emit('finished', 'lost')
			break

		case _player.health <= 0 && _opponent.health <= 0:
			message = `Beide Opponenten sind tödlich getroffen. 😱`
			emit('finished', 'lost')
			break
	}

	return message
})

const _battle = () => {
	_player.hit = false
	// _player.attack = Math.floor(Math.random() * 16) + 1 // 1 bis 16
	_player.attack = Math.floor(Math.random() * 12) + 1 + 4 // 5 bis 16
	_opponent.hit = false
	_opponent.attack = Math.floor(Math.random() * 12) + 1 + 4

	// bestimmen, wer beginnt
	if (Math.floor(Math.random() * 2) % 2) {
		randomAction(_player, _opponent, true)
		randomAction(_opponent, _player)
	} else {
		randomAction(_opponent, _player, true)
		randomAction(_player, _opponent)
	}

	if (!(_player.health <= 0 || _opponent.health <= 0)) {
		setTimeout(_battle, strikeInterval)
	}
}
onMounted(() => {
	_battle()
})

const timelineEl = useTemplateRef('timelineEl')
const scrollHelperEl = useTemplateRef('scrollHelperEl')
let observer: ResizeObserver | null = null
const _startObserver = () => {
	if (!(timelineEl.value && 'ResizeObserver' in window)) return

	observer = new ResizeObserver(() => {
		scrollHelperEl.value?.scrollIntoView({ block: 'end' })
	})
	observer.observe(timelineEl.value)
}
const _stopObserver = () => {
	observer?.disconnect()
}
onMounted(() => {
	_startObserver()
})
onBeforeUnmount(() => {
	_stopObserver()
	resetAttackLog()
})
</script>

<template>
	<div class="scroll-smooth leading-snug">
		<ol ref="timelineEl">
			<li v-for="(message, i) in attackLog" :key="i" class="battle-strike">
				{{ message }}
			</li>
		</ol>

		<div v-if="battleResult" class="battle-result">{{ battleResult }}</div>
		<div ref="scrollHelperEl"></div>
	</div>
</template>

<style>
:is(.battle-strike:nth-child(2n + 3), .battle-result) {
	margin-top: calc(var(--global-line-height) * 1rem);
}
</style>

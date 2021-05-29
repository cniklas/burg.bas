<template>
	<AppIntro v-if="showIntro" @start="onStart" />
	<AppGame v-else />
</template>

<script setup>
import AppIntro from './components/Intro.vue'
import AppGame from './components/Game.vue'
import { ref } from 'vue'

const showIntro = ref(true)
const onStart = () => {
	showIntro.value = false
}
</script>
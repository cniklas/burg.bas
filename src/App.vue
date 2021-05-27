<template>
	<AppIntro v-if="showIntro" @start="startGame" />
	<AppGame v-else :user-name="userName" />
</template>

<script setup>
import AppIntro from './components/Intro.vue'
import AppGame from './components/Game.vue'
import { ref } from 'vue'

const userName = ref('')

const showIntro = ref(true)
const startGame = (name) => {
	userName.value = name
	showIntro.value = false
}
</script>
<template>
	<Intro v-if="showIntro" @start="startGame" />
	<Game v-else :user-name="userName" />
</template>

<script setup>
import Intro from './components/Intro.vue'
import Game from './components/Game.vue'
import { ref } from 'vue'

const userName = ref('')

const showIntro = ref(true)
const startGame = (name) => {
	userName.value = name
	showIntro.value = false
}
</script>
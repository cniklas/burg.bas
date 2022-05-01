<template>
	<AppModal />
	<AppIntro v-if="showIntro" @start="onStart" />
	<AppGame v-else />
</template>

<script setup>
import AppModal from './components/AppModal.vue'
import AppIntro from './components/AppIntro.vue'
import AppGame from './components/AppGame.vue'
import { ref } from 'vue'

const showIntro = ref(true)
const onStart = () => {
	showIntro.value = false
}
</script>

<script setup lang="ts">
import { ref, defineAsyncComponent } from 'vue'
import AppModal from '@/components/AppModal.vue'
import AppIntro from '@/components/AppIntro.vue'

const AppGame = defineAsyncComponent(() => import('@/components/AppGame.vue'))

const showIntro = ref(true)
const onStart = () => {
	showIntro.value = false
}

const isInert = ref(false)
const onToggleModal = (isOpen: boolean) => {
	isInert.value = isOpen
}
</script>

<template>
	<AppModal @toggle="onToggleModal" />
	<AppIntro v-if="showIntro" @start="onStart" :inert="isInert" />
	<AppGame v-else :inert="isInert" />
</template>

<script setup lang="ts">
import { ref, defineAsyncComponent } from 'vue'
import AppModal from '@/components/AppModal.vue'
import AppIntro from '@/components/AppIntro.vue'

const AppGame = defineAsyncComponent(() => import('@/components/AppGame.vue'))

const showIntro = ref(true)
const onStart = () => {
	showIntro.value = false
}
</script>

<template>
	<AppModal />
	<AppIntro v-if="showIntro" @start="onStart" />
	<AppGame v-else />
</template>

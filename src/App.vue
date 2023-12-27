<script setup lang="ts">
import { defineAsyncComponent } from 'vue'
import AppModal from '@/components/AppModal.vue'
import AppIntro from '@/components/AppIntro.vue'
import { ref } from 'vue'

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

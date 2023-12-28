<script setup lang="ts">
import { useStore } from '@/use/store'
const { state } = useStore()
</script>

<template>
	<aside class="panel h-24 p-3 text-lg/6">
		<div class="gold">Gold: {{ state.gold }}</div>
		<div class="pink">Lebensenergie: {{ state.health }}</div>
		<div class="flex gap-x-2.5">
			<span class="<sm:hidden">Ausrüstung:</span>
			<span v-for="(item, i) in state.inventory" :key="`item-${i}`">{{ item }}</span>
		</div>
	</aside>
</template>

<style>
.panel {
	background-color: hsl(240, 21%, 12%);
	font-family: 'Courier New', Courier, monospace;
}
</style>

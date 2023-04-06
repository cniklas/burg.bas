<script setup>
import { gold, health, inventory } from '../use/store'
</script>

<template>
	<aside class="panel h-24 p-3 text-center">
		<div class="gold">Gold: {{ gold }}</div>
		<div class="pink">Health: {{ health }}</div>
		<div class="flex justify-center gap-x-2.5">
			<span v-for="(item, i) in inventory" :key="`item-${i}`">{{ item }}</span>
		</div>
	</aside>
</template>

<style>
.panel {
	background-color: hsl(240, 21%, 12%);
	font-family: 'Courier New', Courier, monospace;
	font-size: 1.125rem;
	line-height: 1.3333333;
}
</style>

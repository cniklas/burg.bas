<template>
	<aside class="panel p-3 text-center h-24">
		<div class="gold">Gold: {{ gold }}</div>
		<div class="pink">Health: {{ health }}</div>
		<div class="flex justify-center gap-x-2.5"><span v-for="(item, i) in inventory" :key="`item-${i}`">{{ item }}</span></div>
	</aside>
</template>

<script setup>
import useState from '../useState'

const { gold, health, inventory } = useState
</script>

<style>
.panel {
	background-color: hsl(240, 21%, 12%);
	font-family: 'Courier New', Courier, monospace;
	font-size: 1.125rem;
	line-height: 1.3333333;
}
</style>
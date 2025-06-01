<script setup lang="ts">
import { useStore } from '@/use/store'
const { state } = useStore()
</script>

<template>
	<aside class="panel h-24 p-3 text-lg/6">
		<dl class="inline-list">
			<dt class="gold">Gold</dt>
			<dd class="gold">{{ state.gold }}</dd>
			<dt class="pink">Lebensenergie</dt>
			<dd class="pink">{{ state.health }}</dd>
			<dt class="<sm:!hidden">Ausrüstung</dt>
			<dd>{{ state.inventory.join(' ') }}</dd>
		</dl>
	</aside>
</template>

<style>
.panel {
	background-color: oklch(21.62% 0.025 284.1);
	font-family: 'Courier New', Courier, monospace;
}

.inline-list {
	dt,
	dd {
		display: inline;
	}

	dt::after {
		content: ':';
	}

	dd::before {
		content: '\0020';
	}

	dd::after {
		content: '\a';
		white-space: pre;
	}
}
</style>

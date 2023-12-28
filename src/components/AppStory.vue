<script setup lang="ts">
import type { Story } from '@/types/Scene.type'
import { useStore } from '@/use/store'
const { isEnabled } = useStore()

defineProps<{
	story: Story
}>()
</script>

<template>
	<div class="story">
		<transition-group name="story-fade">
			<template v-for="(section, i) in story" :key="`sct${i}`">
				<p v-if="typeof section === 'string'" class="whitespace-pre-line" v-html="section" />

				<template v-else>
					<template v-for="(paragraph, j) in section" :key="`pgr${j}`">
						<p v-show="isEnabled(paragraph)" class="whitespace-pre-line" v-html="paragraph.story" />
					</template>
				</template>
			</template>

			<slot />
		</transition-group>
	</div>
</template>

<style>
.story-fade-enter-active {
	transition: opacity var(--transition-duration) ease-in-out;
}

.story-fade-enter-from {
	opacity: 0;
}

.text-prewrap {
	display: block;
	white-space: pre-wrap;
	text-align: center;
}
</style>

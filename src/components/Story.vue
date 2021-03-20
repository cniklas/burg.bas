<template>
	<article class="story">
		<transition-group name="fade" mode="out-in">
			<template v-for="(section, i) in story" :key="`sct${i}`">
				<p v-if="typeof section === 'string'" class="whitespace-pre-line" v-html="section" />

				<template v-else>
					<template v-for="(paragraph, j) in section" :key="`pgr${j}`">
						<p v-show="!isDisabled(paragraph)" class="whitespace-pre-line" v-html="paragraph.story" />
					</template>
				</template>
			</template>

			<!-- <div v-if="scene.delayed" class="delayed" :class="{animated}" :style="`transition-delay:${scene.delayed.delay}ms`"> -->
		</transition-group>
	</article>
</template>

<script setup>
import { defineProps } from 'vue'

defineProps({
	story: Array,
	isDisabled: Function
})
</script>

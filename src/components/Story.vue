<template>
	<article class="story">
		<transition-group name="story-fade" mode="out-in">
			<template v-for="(section, i) in story" :key="`sct${i}`">
				<p v-if="typeof section === 'string'" class="whitespace-pre-line" v-html="section" />

				<template v-else>
					<template v-for="(paragraph, j) in section" :key="`pgr${j}`">
						<p v-show="!isDisabled(paragraph)" class="whitespace-pre-line" v-html="paragraph.story" />
					</template>
				</template>
			</template>
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

<style>
.story-fade-enter-active/* ,
.story-fade-leave-active */ {
	transition: opacity 320ms ease-in-out;
}

.story-fade-enter-from/* ,
.story-fade-leave-to */ {
	opacity: 0;
}
</style>
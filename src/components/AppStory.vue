<script setup>
defineProps({
	story: {
		type: Array,
		default: () => [],
	},
	// eslint-disable-next-line vue/require-default-prop
	isEnabled: {
		type: Function,
	},
})
</script>

<template>
	<article class="story mb-8">
		<transition-group name="story-fade" mode="out-in">
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
	</article>
</template>

<style lang="postcss">
.story-fade-enter-active {
	transition: opacity var(--transition-duration) ease-in-out;
}

.story-fade-enter-from {
	opacity: 0;
}

.text-prewrap {
	@apply block whitespace-pre-wrap text-center;
}
</style>

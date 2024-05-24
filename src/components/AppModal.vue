<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'

const modalEl = ref<HTMLDivElement | null>(null)
const loadAudio = ref(false)
const isVisible = ref(false)
watch(isVisible, async val => {
	if (!val) return
	loadAudio.value = true
	modalEl.value?.scrollTo({ top: 0 })
})

const closeOnEscape = ({ key }: KeyboardEvent) => {
	if (key === 'Escape') isVisible.value = false
}
onMounted(() => {
	document.addEventListener('keyup', closeOnEscape)
})
</script>

<template>
	<button
		type="button"
		class="button modal-button fixed left-1/2 top-4 z-50 hidden h-8 w-8 select-none items-center justify-center rounded-full border-2 border-current tracking-wider focus:outline-none lg:inline-flex"
		:class="{ 'is-active': isVisible }"
		@click.stop="isVisible = !isVisible"
	>
		{{ isVisible ? '×' : '?' }}
	</button>

	<Teleport to="body">
		<div
			class="backface-hidden fixed left-0 top-0 z-40 flex h-full w-full items-center justify-center"
			:class="isVisible ? 'visible' : 'invisible'"
			@click.stop
		>
			<div ref="modalEl" class="modal overflow-y-auto px-4" :class="{ 'is-visible': isVisible }">
				<h2 class="headline mb-6 text-center text-3xl font-medium">Über dieses Spiel</h2>

				<div class="story">
					<p>
						„Die Burg“ ist ein Textadventure Game à la
						<a href="https://www.c64-wiki.de/wiki/Zauberschlo%C3%9F" rel="noopener">Zauberschloß</a>. Ich habe es 1996
						als 17jähriger programmiert, nachdem mich mein jüngerer Bruder mit
						<a href="https://de.wikipedia.org/wiki/BASIC" rel="noopener">BASIC</a> angesteckt hatte.
					</p>
					<p>
						2021 habe ich das komplette Spiel in JavaScript nachgebaut, so dass es nun im Browser gespielt werden kann.
						Der Aufbau des Spiels ist noch derselbe wie damals; nur die Texte habe ich überarbeitet und aufgefrischt.
					</p>
					<p>
						Die Tracks für das Intro und den Endkampf habe ich um mehr als die Hälfte gekürzt. Hier sind die
						Originalstücke in voller Länge zu hören:
					</p>
					<ul>
						<li class="flex items-center">
							<audio :src="loadAudio ? 'audio/intro-2-o.mp3' : undefined" controls></audio>
							<span class="white ml-4">Intro</span>
						</li>
						<li class="flex items-center">
							<audio :src="loadAudio ? 'audio/intro-1.mp3' : undefined" controls></audio>
							<span class="white ml-4">alternatives Intro</span>
						</li>
						<li class="flex items-center">
							<audio :src="loadAudio ? 'audio/battle-o.mp3' : undefined" controls></audio>
							<span class="white ml-4">Kampf</span>
						</li>
					</ul>
					<p>
						Der ursprüngliche Endkampf war eine simple Wahrscheinlichkeitsrechnung, bei der der Spieler mit einer Chance
						von 2:1 gewonnen hat.<br />
						Nun wird diese alles entscheidende Szene in Form eines etwas schrägen Protokolls wiedergegeben und die
						Aussicht auf Sieg oder Niederlage von vielen Zufällen abhängig gemacht.
					</p>
					<p>
						Die Namensvorschläge für den Spieler stammen aus
						<a href="https://en.wikipedia.org/wiki/SimCity_2000" rel="noopener">SimCity 2000</a>.
					</p>
				</div>
			</div>
		</div>

		<div class="modal-overlay fixed left-0 top-0 z-30 h-full w-full" :class="{ 'is-visible': isVisible }" />
	</Teleport>
</template>

<style>
.modal-button {
	font-family: 'Courier New', Courier, monospace;
	font-size: 1.5rem;
	box-shadow: none;
	transform: translateX(calc(-512px - 50% + 2rem));
	transition:
		color 160ms,
		transform var(--transition-duration);

	&.is-active {
		transform: translateX(-50%);
	}
}

.modal {
	opacity: 0;
	max-width: 44rem;
	max-height: 70%;
	transform: scale(0.8);
	transition-property: transform, opacity, visibility; /* 'visibility' is inherited and needs transition, too */
	transition-duration: var(--transition-duration);

	@media (min-width: 64em) {
		max-width: 47rem;
	}

	&.is-visible {
		opacity: unset;
		transform: scale(1);
	}
}

.modal-overlay {
	visibility: hidden;
	opacity: 0;
	background-color: oklch(16.81% 0.016 284.6 / 80%);
	transition-property: background-color, opacity, visibility;
	transition-duration: var(--transition-duration);

	&.is-visible {
		visibility: unset;
		opacity: unset;
		background-color: var(--bg-color);
	}
}
</style>

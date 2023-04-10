<script setup>
import { ref, watch } from 'vue'

const modal = ref(null)
const isVisible = ref(false)
watch(isVisible, val => {
	val ? document.addEventListener('keyup', closeOnEsc) : document.removeEventListener('keyup', closeOnEsc)
})
const toggleModal = () => {
	if (!isVisible.value) {
		modal.value?.scrollTo({ top: 0 })
	}

	isVisible.value = !isVisible.value
}
const closeOnEsc = e => {
	if (e.keyCode === 27) {
		isVisible.value = false
	}
}
</script>

<template>
	<button
		type="button"
		class="button modal-button fixed left-1/2 top-4 z-50 hidden h-8 w-8 select-none items-center justify-center rounded-full border-2 border-current tracking-wider focus:outline-none lg:inline-flex"
		:class="{ 'is-active': isVisible }"
		@click.stop="toggleModal"
	>
		{{ isVisible ? '×' : '?' }}
	</button>

	<Teleport to="body">
		<section
			class="backface-hidden fixed left-0 top-0 z-40 flex h-full w-full items-center justify-center"
			:class="isVisible ? 'visible' : 'invisible'"
			@click.stop
		>
			<div ref="modal" class="modal overflow-y-auto px-4" :class="{ 'is-visible': isVisible }">
				<h2 class="headline mb-6 text-center text-3xl font-medium">Über dieses Spiel</h2>

				<article class="story">
					<p>
						„Die Burg“ ist ein Textadventure Game à la
						<a href="https://www.c64-wiki.de/wiki/Zauberschlo%C3%9F" class="underline" rel="noopener">Zauberschloß</a>.
						Ich habe es 1996 als 17jähriger programmiert, nachdem mich mein jüngerer Bruder mit
						<a href="https://de.wikipedia.org/wiki/BASIC" class="underline" rel="noopener">BASIC</a> angesteckt hatte.
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
							<audio src="audio/intro-2-o.mp3" controls></audio> <span class="white ml-4">Intro</span>
						</li>
						<li class="flex items-center">
							<audio src="audio/intro-1.mp3" controls></audio> <span class="white ml-4">alternatives Intro</span>
						</li>
						<li class="flex items-center">
							<audio src="audio/battle-o.mp3" controls></audio> <span class="white ml-4">Kampf</span>
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
						<a href="https://en.wikipedia.org/wiki/SimCity_2000" class="underline" rel="noopener">SimCity 2000</a>.
					</p>
				</article>
			</div>
		</section>

		<div class="modal-overlay fixed left-0 top-0 z-30 h-full w-full" :class="{ 'is-visible': isVisible }" />
	</Teleport>
</template>

<style lang="postcss">
.modal-button {
	font-family: 'Courier New', Courier, monospace;
	font-size: 1.5rem;
	box-shadow: none;
	transform: translateX(calc(-512px - 50% + 2rem));
	transition: color 160ms, transform var(--transition-duration);

	&.is-active {
		transform: translateX(-50%);
	}
}

.modal {
	@apply opacity-0;
	max-width: 44rem;
	max-height: 70%;
	transform: scale(0.8);
	transition-property: transform, opacity, visibility; /* 'visibility' is inherited and needs transition, too */
	transition-duration: var(--transition-duration);

	@screen lg {
		max-width: 47rem;
	}

	&.is-visible {
		@apply opacity-100;
		transform: scale(1);
	}
}

.modal-overlay {
	@apply invisible opacity-0;
	background-color: hsla(240, 21%, 7%, 80%);
	transition-property: background-color, opacity, visibility;
	transition-duration: var(--transition-duration);

	&.is-visible {
		@apply visible opacity-100;
		background-color: var(--bg-color);
	}
}
</style>

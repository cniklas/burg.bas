<template>
	<button type="button" class="button modal-button" :class="{'is-active': isVisible}" @click.stop="toggleModal">{{ isVisible ? '×' : '?' }}</button>

	<Teleport to="body">
		<section class="modal-wrapper" :class="{'is-visible': isVisible}" @click.stop>
			<div class="modal" ref="modal">
				<h2 class="headline text-center mb-6">Über dieses Spiel</h2>

				<article class="story">
					<p>
						„Die Burg“ ist ein Textadventure Game à la <a href="https://www.c64-wiki.de/wiki/Zauberschlo%C3%9F" class="underline" rel="noopener">Zauberschloß</a>. Ich habe es 1996 als 17jähriger programmiert, nachdem mich mein jüngerer Bruder mit <a href="https://de.wikipedia.org/wiki/BASIC" class="underline" rel="noopener">BASIC</a> angesteckt hatte.
					</p>
					<p>
						2021 habe ich das komplette Spiel in JavaScript nachgebaut, so dass es nun im Browser gespielt werden kann.
						Der Aufbau des Spiels ist noch derselbe wie damals; nur die Texte habe ich überarbeitet und aufgefrischt.
					</p>
					<p>
						Die Tracks für das Intro und den Endkampf habe ich um mehr als die Hälfte gekürzt. Hier sind die Originalstücke in voller Länge zu hören:
					</p>
					<ul>
						<li class="flex items-center">
							<audio src="audio/intro-2-o.mp3" controls></audio> <span class="ml-4">Intro</span>
						</li>
						<li class="flex items-center">
							<audio src="audio/intro-1.mp3" controls></audio> <span class="ml-4">alternatives Intro</span>
						</li>
						<li class="flex items-center">
							<audio src="audio/battle-o.mp3" controls></audio> <span class="ml-4">Kampf</span>
						</li>
					</ul>
					<p>
						Der ursprüngliche Endkampf war eine simple Wahrscheinlichkeitsrechnung, bei der der Spieler mit einer Chance von 1:1,5 gewonnen hat.<br>
						Nun wird diese alles entscheidende Szene in Form eines etwas schrägen Protokolls wiedergegeben und die Aussicht auf Sieg oder Niederlage von vielen Zufällen abhängig gemacht.
					</p>
					<p>
						Die Namensvorschläge für den Spieler stammen aus <a href="https://en.wikipedia.org/wiki/SimCity_2000" class="underline" rel="noopener">SimCity 2000</a>.
					</p>
				</article>
			</div>
		</section>

		<div class="modal-overlay" />
	</Teleport>
</template>

<script setup>
import { ref, watch } from 'vue'

const modal = ref(null)
const isVisible = ref(false)
watch(isVisible, val => {
	val
		? document.addEventListener('keyup', closeOnEsc)
		: document.removeEventListener('keyup', closeOnEsc)
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

<style lang="postcss" scoped>
.modal-button {
	@apply fixed top-4 left-1/2 z-50 hidden lg:block p-0 w-8 h-8 border-2 rounded-full;
	font-family: 'Courier New', Courier, monospace;
	font-size: 1.5rem;
	line-height: calc(2rem - 4px);
	box-shadow: none;
	transform: translateX(calc(-512px - 50% + 2rem)); /* translateX(calc(-50vw - 50% + 2rem)) */
	transition: color 160ms, transform var(--transition-duration);
}

.modal-button.is-active {
	transform: translateX(-50%);
}

.modal-wrapper {
	@apply fixed flex justify-center items-center w-full h-full top-0 left-0 invisible z-40;
	backface-visibility: hidden;
}

.modal-wrapper.is-visible {
	@apply visible;
}


.modal {
	@apply px-4 opacity-0 overflow-y-auto;
	max-width: 44rem;
	max-height: 70%; /* 61.8% */
	transform: scale(0.8);
	transition-property: transform, opacity, visibility; /* 'visibility' is inherited and needs transition, too */
	transition-duration: var(--transition-duration);
}

@screen lg {
	.modal {
		max-width: 47rem;
	}
}

.is-visible .modal {
	@apply opacity-100;
	transform: scale(1);
}

.modal-overlay {
	@apply fixed w-full h-full top-0 left-0 opacity-0 invisible z-30;
	background-color: hsla(240, 21%, 7%, 80%);
	transition-property: background-color, opacity, visibility;
	transition-duration: var(--transition-duration);
}

.is-visible + .modal-overlay {
	@apply opacity-100 visible;
	background-color: var(--bg-color);
}

.story ul {
	margin-bottom: calc(var(--global-line-height) * 1rem);
}

.story li:nth-last-child(n+2) {
	margin-bottom: calc(var(--global-line-height) * 0.5rem);
}
</style>
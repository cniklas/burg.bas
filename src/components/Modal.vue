<template>
	<button type="button" class="button modal-button" :class="{'is-active': isVisible}" @click.stop="toggleModal">{{ isVisible ? '×' : '?' }}</button>

	<Teleport to="body">
		<section class="modal-wrapper" :class="{'is-visible': isVisible}" @click.stop>
			<div class="modal" ref="modal">
				<h2 class="headline text-center mb-6">Über dieses Spiel</h2>

				<article class="story">
					<p>Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen.</p>

					<p>Manchmal benutzt man Worte wie Hamburgefonts, Rafgenduks oder Handgloves, um Schriften zu testen. Manchmal Sätze, die alle Buchstaben des Alphabets enthalten - man nennt diese Sätze »Pangrams«.</p>

					<p>Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog.</p>

					<p>Oft werden in Typoblindtexte auch fremdsprachige Satzteile eingebaut (AVAIL® and Wefox™ are testing aussi la Kerning), um die Wirkung in anderen Sprachen zu testen. In Lateinisch sieht zum Beispiel fast jede Schrift gut aus.</p>

					<p>Quod erat demonstrandum. Seit 1975 fehlen in den meisten Testtexten die Zahlen, weswegen nach TypoGb. 204 § ab dem Jahr 2034 Zahlen in 86 der Texte zur Pflicht werden.</p>

					<p>Nichteinhaltung wird mit bis zu 245 € oder 368 $ bestraft. Genauso wichtig in sind mittlerweile auch Âçcèñtë, die in neueren Schriften aber fast immer enthalten sind. Ein wichtiges aber schwierig zu integrierendes Feld sind OpenType-Funktionalitäten.</p>

					<p>Je nach Software und Voreinstellungen können eingebaute Kapitälchen, Kerning oder Ligaturen (sehr pfiffig) nicht richtig dargestellt werden.</p>

					<p>Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen.</p>

					<p>Manchmal benutzt man Worte wie Hamburgefonts, Rafgenduks oder Handgloves, um Schriften zu testen. Manchmal Sätze, die alle Buchstaben des Alphabets enthalten - man nennt diese Sätze »Pangrams«.</p>

					<p>Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog.</p>

					<p>Oft werden in Typoblindtexte auch fremdsprachige Satzteile eingebaut (AVAIL® and Wefox™ are testing aussi la Kerning), um die Wirkung in anderen Sprachen zu testen. In Lateinisch sieht zum Beispiel fast jede Schrift gut aus.</p>

					<p>Quod erat demonstrandum. Seit 1975 fehlen in den meisten Testtexten die Zahlen, weswegen nach TypoGb. 204 § ab dem Jahr 2034 Zahlen in 86 der Texte zur Pflicht werden.</p>

					<p>Nichteinhaltung wird mit bis zu 245 € oder 368 $ bestraft. Genauso wichtig in sind mittlerweile auch Âçcèñtë, die in neueren Schriften aber fast immer enthalten sind. Ein wichtiges aber schwierig zu integrierendes Feld sind OpenType-Funktionalitäten.</p>

					<p>Je nach Software und Voreinstellungen können eingebaute Kapitälchen, Kerning oder Ligaturen (sehr pfiffig) nicht richtig dargestellt werden.</p>
				</article>
			</div>
		</section>

		<div class="modal-overlay" />
	</Teleport>
</template>

<script setup>
import { ref } from 'vue'
import useInput from '../useInput'

const { input, focusInput } = useInput()

const modal = ref(null)
const isVisible= ref(false)
const toggleModal = () => {
	if (!isVisible.value) {
		modal.value?.scrollTo({ top: 0 })
	}

	isVisible.value = !isVisible.value
}
</script>

<style lang="postcss" scoped>
.modal-button {
	@apply fixed top-4 left-1/2 z-50 hidden lg:block p-0 w-8 h-8 border-2 rounded-full;
	/* color: hsl(182, 25%, 64%); */
	font-family: 'Courier New', Courier, monospace;
	font-size: 1.5rem;
	line-height: calc(2rem - 4px);
	box-shadow: none;
	/* transform: translateX(calc(-50vw - 50% + 2rem)); */
	transform: translateX(calc(-512px - 50% + 2rem));
	transition: color 160ms, transform var(--modal-transition-duration);
}

/* .modal-button:hover {
	color: hsl(182, 35%, 64%);
} */

.modal-button.is-active {
	transform: translateX(-50%);
}

.modal-wrapper {
	@apply fixed flex justify-center items-center w-full h-full top-0 left-0 invisible z-40; /* py-16 */
	backface-visibility: hidden;
}

.modal-wrapper.is-visible {
	@apply visible;
}


.modal {
	@apply px-4 opacity-0 overflow-y-auto;
	max-width: 44rem;
	max-height: 61.8%;
	transform: scale(0.8);
	transition: all var(--modal-transition-duration);
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
	@apply fixed w-full h-full top-0 left-0 invisible opacity-0 z-30;
	background-color: hsla(240, 21%, 7%, 80%);
	transition: all var(--modal-transition-duration);
}

.is-visible + .modal-overlay {
	@apply opacity-100 visible;
	background-color: var(--bg-color);
}
</style>
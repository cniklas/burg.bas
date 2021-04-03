<template>
<!-- <pre class="ascii-text">
88                                                 88
88                                                 88
88                                                 88
88,dPPYba,  88       88 8b,dPPYba,  ,adPPYb,d8     88,dPPYba,  ,adPPYYba, ,adPPYba,
88P'    "8a 88       88 88P'   "Y8 a8"    `Y88     88P'    "8a ""     `Y8 I8[    ""
88       d8 88       88 88         8b       88     88       d8 ,adPPPPP88  `"Y8ba,
88b,   ,a8" "8a,   ,a88 88         "8a,   ,d88 888 88b,   ,a8" 88,    ,88 aa    ]8I
8Y"Ybbd8"'   `"YbbdP'Y8 88          `"YbbdP"Y8 888 8Y"Ybbd8"'  `"8bbdP"Y8 `"YbbdP"'
                                    aa,    ,88
                                     "Y8bbdP"
</pre> -->
	<section class="actions">
		<div class="input-wrapper">
			<input type="text" v-model.trim="userName" ref="input" class="input" placeholder="Gib einen Namen ein oder drücke ENTER" @click.stop @keyup.enter="createName" />
		</div>

		<transition name="fade" mode="in-out">
			<div v-show="showButton" class="button-wrapper">
				<button type="button" class="button" @click.stop="$emit('start', userName)">Spiel starten</button>
			</div>
		</transition>
	</section>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, defineEmit } from 'vue'
import useHowler from '../useHowler'

defineEmit([
	'start'
])

const { loadMusic } = useHowler

const userName = ref('')
const showButton = computed(() => userName.value.length >= 2)

// const firstNames = [
// 	'Basil',
// 	'Herbert',
// 	'Winston',
// 	'Fredrick',
// 	'Grumpf',
// 	'Wilhelm',
// 	'Theodore',
// 	'Greasus'
// ]
// const lastNames = [
// 	'Berrybrook',
// 	'Deathrump',
// 	'Wellington',
// 	'Bloodlord',
// 	'Firerump',
// 	'Flamebeard',
// 	'the Flatulant IV',
// 	'Thornheart',
// 	'Ragefist',
// 	'Goldtooth',
// 	'Guillemaere'
// ]
const simCityNames = [
	// 'Franz Ausbeuth',
	// 'Holger Ausbunt',
	// 'Wastl Ballwix',
	// 'Michel Bänger',
	'Xaver Birnenschmaus',
	// 'Olaf Bitterbiß',
	// 'Luis Blunzensee',
	'Louis Blunzensee',
	// 'Engelhart Bontz',
	// 'Gerd Böswig',
	'Frieder Brausewitz',
	// 'Peer Brunsen',
	// 'Hans Bullmann',
	// 'Gustav Bürzel',
	// 'Freddi Dollboehr',
	// 'Kaspar Dotterblum',
	'Klaus Drösenklump',
	// 'Pit Dummke',
	// 'Oskar Dünkelhofer',
	// 'Rudi Durchblick',
	'Ernst Eberschneck',
	'Edgar Ellenpohl',
	// 'Paul Ersazki',
	// 'Erwin Fasel',
	// 'Berthold Fatzke',
	// 'Freddi Fiesewetter',
	// 'Reinhard Fitzelbräu',
	// 'Axel Flachmann',
	'Engelbert Flusenberg',
	// 'Sebastian Gallgentritt',
	// 'Egon Gerngroß',
	// 'Igor Grobloch',
	// 'Waldemar Grünspecht',
	// 'Helmut Haslam',
	// 'Willi Haubald',
	'Valentin Haxenpfeffer',
	// 'Wenzeslaus Hitzig',
	// 'Dagobert Holzweg',
	// 'Rudi Karmichel',
	// 'Jockel Katzmauski',
	// 'Till Klecks',
	// 'Wladimir Klugscheit',
	'Karl Knall',
	// 'Wolf Knüppeldieck',
	// 'Helmut Krauth',
	// 'Oskar Lallbeck',
	// 'Ede Langbeen',
	// 'Kalle Langöhr',
	// 'Fritz Lausmann',
	// 'Eddie Metzger',
	'Wolf Nasenstieb',
	// 'Detlef Onemichel',
	// 'Wendelin Pausback',
	// 'Adalgeiß Pikemann',
	'Samuel Plopps',
	'Markus Rinderbrüh',
	// 'Jens Rotlöffel',
	// 'Ödon Ruckmair',
	// 'Albert Schleibich',
	'Martin Schlürfnich',
	// 'Peter Schnutzelwieser',
	// 'Dagobert Schuhlöffel',
	'Tobias Seitenstich',
	// 'Eduard Spürsinn',
	// 'Pluto Stachelski',
	'Gottlieb Stegreif',
	'Botho Sternschnupf',
	// 'Robbie Sterz',
	// 'Piet Stormke',
	// 'Franz Strammbein',
	// 'Heiner Stünkel',
	// 'Erich Treppwitz',
	// 'Philidor Trugschlüß',
	'Ürdü Tüdelüt',
	// 'Dirk Tümper',
	// 'Theo Unbilt',
	// 'Eddie Untenraus',
	'Golo Unterzwerch',
	// 'Arnulf von Achsenbruch',
	'Arnulf von Wannensteg',
	'Hanno von Büsenstreich',
	// 'Blasius Waldschrag',
	// 'Hugo Wamp',
	// 'Fritz Wangengrün',
	// 'Armin Wannensteg',
	// 'Iwan Wasndeppski',
	// 'Emil Watts',
	// 'Holger Weißnitz',
	'Leo Wellblech',
	// 'Konrad Wexelbald',
	// 'Jörg Wiedeborst',
	// 'Gustav Witzbald',
	'Wilhelm Wohlgemuth',
	// 'Rudolf Wolf',
	// 'Florian Wolkenbruch',
	'Trollo Zahnlos',
	// 'Andreas Zahnstein',
	// 'Karol Ersatzki'
]
let names = []
// const randomize = (store) => store[ Math.floor(Math.random() * store.length) ]
const randomSplice = (store) => store.splice( Math.floor(Math.random() * store.length), 1 ).shift()
const createName = () => {
	// userName.value = `${randomize(firstNames)} ${randomize(lastNames)}`
	if (!names.length) {
		names = [...simCityNames]
	}
	userName.value = randomSplice(names)
}

const input = ref(null)
const focusInput = () => {
	input.value.focus()
}
onMounted(() => {
	focusInput()
	document.addEventListener('click', focusInput)
	loadMusic('intro-2')
})
onUnmounted(() => {
	document.removeEventListener('click', focusInput)
})
</script>

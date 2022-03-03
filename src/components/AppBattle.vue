<template>
	<section ref="container" class="battle">
		<ol ref="timeline">
			<li v-for="(attack, i) in attacks" :key="i">
				{{ attack.message }}
			</li>
		</ol>

		<div v-show="battleResult" class="battle-result">{{ battleResult }}</div>
	</section>
</template>

<script setup>
import { ref, reactive, computed, watch, onMounted } from 'vue'

const emit = defineEmits(['finish', 'got-hit'])
const props = defineProps({
	userName: {
		type: String,
		default: '',
	},
	health: {
		type: Number,
		default: 100,
	},
	strikeInterval: {
		type: Number,
		default: 1200,
	},
})

const weapons = [
	'dem Zepter des Titanen',
	'dem Schwert von Couronne',
	'einem Silberlöffel',
	'einer Luftpumpe',
	'einer Zahnbürste',
	'einer Blockflöte',
]
const opponent = reactive({
	name: '🧟 UBOLZIO',
	health: 75,
	attack: 0,
	hit: false,
})

const player = reactive({
	name: `🦸🏼‍♂️ ${props.userName}`,
	health: props.health,
	originHealth: props.health,
	attack: 0,
	hit: false,
	weapon: 'seinem Schwert',
})
watch(
	() => player.health,
	(val, oldVal) => {
		if (val < player.originHealth) {
			emit('got-hit', oldVal - val)
		}
	}
)

const attacks = reactive([])
const battleResult = computed(() => {
	let message = ''
	switch (true) {
		case opponent.health <= 0 && player.health > 0:
			message = `${opponent.name} erleidet eine Herzattacke und stirbt. 💀`
			emit('finish', 'won')
			break

		case player.health <= 0 && opponent.health > 0:
			message = `${player.name} erliegt seinen Verletzungen und stirbt. 🚑`
			emit('finish', 'lost')
			break

		case player.health <= 0 && opponent.health <= 0:
			message = `Beide Opponenten sind tödlich getroffen. 😱`
			emit('finish', 'lost')
			break
	}

	return message
})

const container = ref(null)
const timeline = ref(null)
const _observe = () => {
	const ro = new ResizeObserver(() => {
		container.value.scrollTop = container.value.scrollHeight
	})

	ro.observe(container.value)
	ro.observe(timeline.value)
}
onMounted(_observe)

const _attack = (d20, attacker, defender) => {
	if (d20 <= 2) {
		return `${attacker.name} haut daneben, verliert das Gleichgewicht und beschmutzt sich!`
	} else if (d20 >= 3 && d20 <= 19) {
		const weapon = weapons[Math.floor(Math.random() * weapons.length)]

		defender.hit = true
		defender.health -= attacker.attack
		return `${attacker.name} trifft ${defender.name} mit ${attacker.weapon || weapon}${
			attacker.attack > 10 ? ' an einer empfindlichen Stelle' : ''
		}. Schmerz-Level: ${attacker.attack}`
	} else {
		defender.hit = true
		defender.health -= attacker.attack * 2
		return `${attacker.name} landet einen Treffer und tritt ${defender.name} dabei auf sein Hühnerauge. Das tat doppelt weh!`
	}
}

const _block = (d20, defender, attacker) => {
	if (d20 <= 2) {
		return `${defender.name} versucht vergeblich den Schlag abzuwehren und ${
			defender.hit ? 'wird getroffen' : 'kommt mit einem blauen Auge davon'
		}.`
	} else if (d20 >= 3 && d20 <= 18) {
		// Treffer wird zurückgenommen
		if (defender.hit) {
			defender.health += attacker.attack
		}
		return `${defender.name} pariert ${attacker.name}s Angriff${defender.hit ? ' erfolgreich' : ''}.`
	} else {
		// Treffer wird zurückgenommen
		if (defender.hit) {
			defender.health += attacker.attack
		}
		attacker.health -= attacker.attack * 2
		return `${attacker.name}s Waffe prallt am Schild von ${defender.name} ab und tritt ihn selbst!`
	}
}

const _spell = (d100, attacker, defender) => {
	if (d100 <= 8) {
		defender.health -= attacker.attack
		return `${attacker.name} wendet Polymorphie an, verwandelt sich in ein Schaf und beißt ${defender.name}. Schmerz-Level: ${attacker.attack}`
	} else if (d100 >= 9 && d100 <= 16) {
		attacker.health -= attacker.attack
		return `${attacker.name} wirbelt wilde Zaubersprüche. Eine verirrte Kuh fällt vom Himmel herab und landet auf ${attacker.name}. Schadensbilanz:  ${attacker.attack}`
	} else if (d100 >= 17 && d100 <= 23) {
		return `${attacker.name} wirbelt wilde Zaubersprüche und verwandelt sich in ein leuchtendes Blau.`
	} else if (d100 >= 24 && d100 <= 28) {
		return `${attacker.name} kotzt.`
	} else if (d100 >= 29 && d100 <= 35) {
		return `${attacker.name} spricht einen Verwirrungszauber aus und hat augenblicklich sein Passwort vergessen.`
	} else if (d100 >= 36 && d100 <= 42) {
		return `${attacker.name} wirbelt wilde Zaubersprüche und lässt sich einen ewigen Flammenbart wachsen.`
	} else if (d100 >= 43 && d100 <= 49) {
		return `${attacker.name} spricht einen Schwebezauber aus und geht an die Decke.`
	} else if (d100 >= 50 && d100 <= 56) {
		return `${attacker.name} wirbelt wilde Zaubersprüche und wird achtzig Jahre älter.`
	} else if (d100 >= 57 && d100 <= 63) {
		return `${attacker.name} wirbelt wilde Zaubersprüche. Alles wird mit Glitzer überzogen.`
	} else if (d100 >= 64 && d100 <= 70) {
		return `${attacker.name} wirbelt wilde Zaubersprüche und wird in die Astralebene transportiert, bis die Wirkung nachlässt.`
	} else if (d100 >= 71 && d100 <= 77) {
		return `${attacker.name} wirbelt wilde Zaubersprüche und ist für die nächsten 30 Tage immun gegen die Wirkung berauschender Substanzen.`
	} else if (d100 >= 78 && d100 <= 84) {
		return `${attacker.name} schleudert schlechte Witze auf ${defender.name}.`
	} else if (d100 >= 85 && d100 <= 92) {
		defender.hit = true
		defender.health -= attacker.attack
		return `${attacker.name} singt „Freude, schöner Götterfunken“. Schmerz-Level: ${attacker.attack}.`
	} else {
		attacker.hit = true
		attacker.health -= defender.attack
		return `${attacker.name} wendet Polymorphie an. ${defender.name} verwandelt sich in ein Schaf und beißt ${attacker.name}! Schmerz-Level: ${defender.attack}`
	}
}

const _actions = [_attack, _block, _spell]
const _randomAction = (attacker, defender, isAttack = false) => {
	const i = Math.floor(Math.random() * _actions.length)
	const action = _actions[i]

	// der "Anhieb" des Angreifers kann nicht Verteidigung sein → wiederholen
	if (isAttack && action === _block) {
		return _randomAction(attacker, defender, isAttack)
	}

	const d20 = Math.floor(Math.random() * 20) + 1
	const d100 = Math.floor(Math.random() * 100) + 1
	const dice = action === _spell ? d100 : d20

	// const attackerLog = { name: attacker.name, currentHealth: attacker.health, attack: attacker.attack }
	const message = action(dice, attacker, defender)
	attacks.push({ message /* , attacker: { health: attacker.health, hit: attacker.hit, ...attackerLog } */ })
}

const battle = () => {
	player.hit = false
	// player.attack = Math.floor(Math.random() * 16) + 1 // 1 bis 16
	player.attack = Math.floor(Math.random() * 12) + 1 + 4 // 5 bis 16
	opponent.hit = false
	opponent.attack = Math.floor(Math.random() * 12) + 1 + 4

	// bestimmen, wer beginnt
	if (Math.floor(Math.random() * 2) % 2) {
		_randomAction(player, opponent, true)
		_randomAction(opponent, player)
	} else {
		_randomAction(opponent, player, true)
		_randomAction(player, opponent)
	}

	if (!(player.health <= 0 || opponent.health <= 0)) {
		setTimeout(battle, props.strikeInterval)
	}
}
onMounted(battle)
</script>

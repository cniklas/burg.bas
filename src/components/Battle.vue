<template>
	<section class="battle">
		<ol>
			<li v-for="(attack, i) in attacks" :key="i">
				{{ attack.message }}
			</li>
		</ol>

		<div v-show="battleResult" class="battle-result" v-html="battleResult" />
		<div ref="scroll-to" />
	</section>
</template>

<script>
const weapons = [
	'dem Zepter des Titanen',
	'dem Schwert von Couronne',
	'einem Silberlöffel',
	'einer Luftpumpe',
	'einer Zahnbürste',
	'einer Blockflöte'
]

export default {
	props: {
		userName: String,
		health: Number,
		strikeInterval: Number
	},
	data() {
		return {
			attacks: [],
			player: {
				weapon: 'seinem Schwert'
			},
			opponent: {
				name: '🧟 UBOLZIO',
				health: 75
			},
		}
	},

	computed: {
		playerHealth() {
			return this.player.health
		},

		battleResult() {
			let message = ''
			switch (true) {
				case this.opponent.health <= 0 && this.player.health > 0 :
					message = `${this.opponent.name} erleidet eine Herzattacke und stirbt. 💀`
					this.$emit('finish', 'won')
					break

				case this.player.health <= 0 && this.opponent.health > 0 :
					message = `${this.player.name} erliegt seinen Verletzungen und stirbt. 🚑`
					this.$emit('finish', 'lost')
					break

				case this.player.health <= 0 && this.opponent.health <= 0 :
					message = `Beide Opponenten sind tödlich getroffen. 😱`
					this.$emit('finish', 'lost')
					break
			}

			return message
		}
	},

	methods: {
		battle() {
			this.player.hit = false
			// this.player.attack = Math.floor(Math.random() * 16) + 1 // 1 bis 16
			this.player.attack = (Math.floor(Math.random() * 12) + 1) + 4 // 5 bis 16
			this.opponent.hit = false
			this.opponent.attack = (Math.floor(Math.random() * 12) + 1) + 4

			// bestimmen, wer beginnt
			if (Math.floor(Math.random() * 2) % 2) {
				this._randomMove(this.player, this.opponent, true)
				this._randomMove(this.opponent, this.player)
			}
			else {
				this._randomMove(this.opponent, this.player, true)
				this._randomMove(this.player, this.opponent)
			}

			requestAnimationFrame(() => {
				this.$refs['scroll-to'].scrollIntoView()
			})

			if (!(this.player.health <= 0 || this.opponent.health <= 0)) {
				setTimeout(this.battle, this.strikeInterval)
			}
		},

		_randomMove(attacker, defender, isAttack = false) {
			const moveTypes = ['_attack', '_block', '_spell']
			const moveTypeIndex = Math.floor(Math.random() * moveTypes.length)
			const moveType = moveTypes[moveTypeIndex]

			// der "Anhieb" des Angreifers kann nicht Verteidigung sein → wiederholen
			if (isAttack && moveType === '_block') {
				return this._randomMove(attacker, defender, isAttack)
			}

			const d20 = Math.floor(Math.random() * 20) + 1
			const d100 = Math.floor(Math.random() * 100) + 1
			const dice = moveType === '_spell' ? d100 : d20

			// const attackerLog = { name: attacker.name, currentHealth: attacker.health, attack: attacker.attack }
			const message = this[moveType](dice, attacker, defender)
			this.attacks.push({ message/* , attacker: { health: attacker.health, hit: attacker.hit, ...attackerLog } */ })
		},

		_attack(d20, attacker, defender) {
			if (d20 <= 2) {
				// this.attacks.push({ message: `${attacker.name} misses, is knocked off balance, falls backward and soils himself!` })
				return `${attacker.name} haut daneben, verliert das Gleichgewicht und beschmutzt sich!`
			}
			else if (d20 >= 3 && d20 <= 19) {
				const weapon = weapons[ Math.floor(Math.random() * weapons.length) ]

				defender.hit = true
				defender.health -= attacker.attack
				// this.attacks.push({ message: `${attacker.name} strikes ${defender.name} with ${attacker.weapon} for ${attacker.attack} damage.` })
				return `${attacker.name} trifft ${defender.name} mit ${attacker.weapon || weapon}${attacker.attack > 10 ? ' an einer empfindlichen Stelle' : ''}. Schmerz-Level: ${attacker.attack}`
			}
			else {
				defender.hit = true
				defender.health -= attacker.attack * 2
				// this.attacks.push({ message: `${defender.name} loses his right arm. An artery has been opened by the strike and a sensory nerve has been severed! ${attacker.name} equips the right arm, flails it around wildly and attacks ${defender.name} for ${attacker.attack * 2} damage!` })
				return `${attacker.name} landet einen Treffer und tritt ${defender.name} dabei auf sein Hühnerauge. Das tat doppelt weh!`
			}
		},

		_block(d20, defender, attacker) {
			if (d20 <= 2) {
				// this.attacks.push({ message: `${defender.name} fails to block and takes ${defender.hit ? attacker.attack : 'zero'} damage.` })
				return `${defender.name} versucht vergeblich den Schlag abzuwehren und ${defender.hit ? 'wird getroffen' : 'kommt mit einem blauen Auge davon'}.`
			}
			else if (d20 >= 3 && d20 <= 18) {
				// Treffer wird zurückgenommen
				if (defender.hit) {
					defender.health += attacker.attack
				}
				// this.attacks.push({ message: `${defender.name} blocks ${attacker.name}’s attack.` })
				return `${defender.name} pariert ${attacker.name}s Angriff${defender.hit ? ' erfolgreich' : ''}.`
			}
			else {
				// Treffer wird zurückgenommen
				if (defender.hit) {
					defender.health += attacker.attack
				}
				attacker.health -= attacker.attack * 2
				// this.attacks.push({ message: `${attacker.name}’s attack is deflected by ${defender.name}’s small ${defender.armour} breastplate!` })
				return `${attacker.name}s Waffe prallt am Schild von ${defender.name} ab und tritt ihn selbst!`
			}
		},

		_spell(d100, attacker, defender) {
			if (d100 <= 8) {
				defender.health -= attacker.attack
				// this.attacks.push({ message: `${attacker.name} casts polymorph on himself, turns into a sheep and bites ${defender.name} for ${attacker.attack} damage!` })
				return `${attacker.name} wendet Polymorphie an, verwandelt sich in ein Schaf und beißt ${defender.name}. Schmerz-Level: ${attacker.attack}`
			}
			else if (d100 >= 9 && d100 <= 16) {
				attacker.health -= attacker.attack
				// this.attacks.push({ message: `${attacker.name} casts wild magic. A stray yak cow tumbles from the sky and lands on ${attacker.name} for ${attacker.attack} damage!` })
				return `${attacker.name} wirbelt wilde Zaubersprüche. Eine verirrte Kuh fällt vom Himmel herab und landet auf ${attacker.name}. Schadensbilanz:  ${attacker.attack}`
			}

			else if (d100 >= 17 && d100 <= 23) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and turns a vibrant shade of blue!` })
				return `${attacker.name} wirbelt wilde Zaubersprüche und verwandelt sich in ein leuchtendes Blau.`
			}
			else if (d100 >= 24 && d100 <= 28) {
				// this.attacks.push({ message: `${attacker.name} vomits.` })
				return `${attacker.name} kotzt.`
			}
			else if (d100 >= 29 && d100 <= 35) {
				// this.attacks.push({ message: `${attacker.name} casts confusion centered on himself!` })
				return `${attacker.name} spricht einen Verwirrungszauber aus und hat augenblicklich sein Passwort vergessen.`
			}
			else if (d100 >= 36 && d100 <= 42) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and grows an eternal flaming beard!` })
				return `${attacker.name} wirbelt wilde Zaubersprüche und lässt sich einen ewigen Flammenbart wachsen.`
			}
			else if (d100 >= 43 && d100 <= 49) {
				// this.attacks.push({ message: `${attacker.name} casts levitate on himself and can only shout when they speak!` })
				return `${attacker.name} spricht einen Schwebezauber aus und geht an die Decke.`
			}
			else if (d100 >= 50 && d100 <= 56) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and becomes 80 years older!` })
				return `${attacker.name} wirbelt wilde Zaubersprüche und wird achtzig Jahre älter.`
			}
			else if (d100 >= 57 && d100 <= 63) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic. Illusory butterflies and flower petals flutter in the air!` })
				return `${attacker.name} wirbelt wilde Zaubersprüche. Alles wird mit Glitzer überzogen.`
			}
			else if (d100 >= 64 && d100 <= 70) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and is transported to the Astral Plane until the end of the spells duration!` })
				return `${attacker.name} wirbelt wilde Zaubersprüche und wird in die Astralebene transportiert, bis die Wirkung nachlässt.`
			}
			else if (d100 >= 71 && d100 <= 77) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and is immune to being intoxicated by alcohol for the next 30 days!` })
				return `${attacker.name} wirbelt wilde Zaubersprüche und ist für die nächsten 30 Tage immun gegen die Wirkung berauschender Substanzen.`
			}
			else if (d100 >= 78 && d100 <= 84) {
				// this.attacks.push({ message: `${attacker.name} casts friends on ${defender.name}. It is ineffective!` })
				return `${attacker.name} schleudert schlechte Witze auf ${defender.name}.`
			}
			else if (d100 >= 85 && d100 <= 92) {
				defender.hit = true
				defender.health -= attacker.attack
				// this.attacks.push({ message: `${attacker.name} casts magic missile. ${defender.name} takes ${attacker.attack} fire damage!` })
				return `${attacker.name} singt „Freude, schöner Götterfunken“. Schmerz-Level: ${attacker.attack}.`
			}
			else {
				attacker.hit = true
				attacker.health -= defender.attack
				// this.attacks.push({ message: `${attacker.name} casts polymorph. ${defender.name} turns into a sheep and bites ${attacker.name} for ${defender.attack} damage!` })
				return `${attacker.name} wendet Polymorphie an. ${defender.name} verwandelt sich in ein Schaf und beißt ${attacker.name}! Schmerz-Level: ${defender.attack}`
			}
		},
	},

	created() {
		this.player = {
			...this.player,
			name: `🦸🏼‍♂️ ${this.userName}`,
			health: this.health,
			originHealth: this.health
		}
	},

	mounted() {
		this.battle()
	},

	watch: {
		// 'player.health': (val) => {},
		// player: {
		// 	handler(val) {},
		// 	deep: true
		// }
		playerHealth(val, oldVal) {
			if (val < this.player.originHealth) {
				this.$emit('got-hit', oldVal - val)
			}
		}
	}
}
</script>

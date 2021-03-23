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
export default {
	props: {
		health: Number,
		strikeInterval: Number
	},
	data() {
		return {
			attacks: [],
			player: {
				name: '🦸🏼‍♂️ Hans Wurst', // TODO randomize
				weapon: 'Schwert'
			},
			opponent: {
				name: '🧟 UBOLZIO',
				health: 80,
				weapon: 'Zweihänder' // TODO randomize
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
					message = `<span class="red">${this.opponent.name}</span> erleidet eine Herzattacke und stirbt. 🚑`
					this.$emit('finish', 'won')
					break

				case this.player.health <= 0 && this.opponent.health > 0 :
					message = `${this.player.name} erliegt seinen Verletzungen und stirbt. 💀`
					this.$emit('finish', 'lost')
					break

				case this.player.health <= 0 && this.opponent.health <= 0 :
					message = `Beide Opponenten sind beide tödlich getroffen. 😱`
					this.$emit('finish', 'lost')
					break
			}

			return message
		}
	},

	methods: {
			/**
			 * 🧟 UBOLZIO pariert 🦸🏼‍♂️ Hans Wursts Angriff erfolgreich.
			 * 🦸🏼‍♂️ Hans Wurst pariert 🧟 UBOLZIOs Angriff erfolgreich.
			 * TODO
			 * Häufig kommt "pariert" mit "pariert" zusammen. Das ergibt keinen Sinn und verlängert den Kampf unnötig.
			 * Auch ist "pariert" als Aktion #1 sinnlos, denn es hat keine Auswirkungen, suggeriert aber eine erfolgreiche Abwehr.
			 * Eine Lösung für beide Probleme ist, Aktion #1 zu prüfen und im Falle von "pariert" zu wiederholen.
			 * /!\ ABER dann darf Aktion #1 nicht immer mit Player beginnen (_randomMove)! Sonst wird für Player nie "pariert" ausgeführt.
			 * PRÜFEN: Ist das überhaupt so??
			 * Anscheinend dreht sich die Abfolge auch mal, aber ich bin nicht sicher.
			 * Ggf. ist es eine Verbesserung, auch die Reihenfolge der beiden _randomMove() (1. P/O, 2. O/P) per Zufall festzulegen.
			 */
		battle() {
			this.player.hit = false
			this.player.attack = Math.floor(Math.random() * 16) + 1
			this.opponent.hit = false
			this.opponent.attack = Math.floor(Math.random() * 16) + 1

			this._randomMove(this.player, this.opponent)
			this._randomMove(this.opponent, this.player)

			requestAnimationFrame(() => {
				this.$refs['scroll-to'].scrollIntoView()
			})

			if (!(this.player.health <= 0 || this.opponent.health <= 0)) {
				setTimeout(this.battle, this.strikeInterval)
			}
		},

		_randomMove(attacker, defender) {
			const moveTypes = ['_attack', '_block', '_spell']
			const moveTypeIndex = Math.floor(Math.random() * moveTypes.length)
			const moveType = moveTypes[moveTypeIndex]

			const d20 = Math.floor(Math.random() * 20) + 1
			const d100 = Math.floor(Math.random() * 100) + 1
			const dice = moveType === '_spell' ? d100 : d20

			this[moveType](dice, attacker, defender)
		},

		// TODO detailliert ausloggen, um zu prüfen, ob das alles so stimmen kann (Handlung i.Z. mit health-Wert)
		// TODO Verteilung
		_attack(d20, attacker, defender) {
			if (d20 === 1) {
				// this.attacks.push({ message: `${attacker.name} misses, is knocked off balance, falls backward and soils himself!` })
				this.attacks.push({ message: `${attacker.name} haut daneben, verliert das Gleichgewicht und beschmutzt sich!` })
			}
			else if (d20 >= 2 && d20 <= 19) {
				defender.hit = true
				defender.health -= attacker.attack
				// this.attacks.push({ message: `${attacker.name} strikes ${defender.name} with ${attacker.weapon} for ${attacker.attack} damage.` })
				this.attacks.push({ message: `${attacker.name} trifft ${defender.name} mit sinem ${attacker.weapon} an einer empfindlichen Stelle. Schmerz-Level: ${attacker.attack}` })
			}
			else {
				defender.hit = true
				defender.health -= attacker.attack * 2
				// this.attacks.push({ message: `${defender.name} loses his right arm. An artery has been opened by the strike and a sensory nerve has been severed! ${attacker.name} equips the right arm, flails it around wildly and attacks ${defender.name} for ${attacker.attack * 2} damage!` })
				// this.attacks.push({ message: `${attacker.name} schlägt ${defender.name} den rechten Arm ab. Das tat jetzt echt weh!` })
				this.attacks.push({ message: `${attacker.name} tritt ${defender.name} auf sein Hühnerauge. Das tat weh!` })
			}
		},

		// TODO Verteilung
		_block(d20, attacker, defender) {
			if (d20 === 1) {
				// this.attacks.push({ message: `${attacker.name} fails to block and takes ${attacker.attack} damage.` })
				// this.attacks.push({ message: `${defender.name} fails to block and takes ${defender.hit ? attacker.attack : 'zero'} damage.` })
				// this.attacks.push({ message: `${defender.name} misslingt es, den Schlag seines Gegners abzuwehren, und er wird getroffen. Schaden: ${defender.hit ? attacker.attack : 'nicht der Rede wert'}` })
				this.attacks.push({ message: `${defender.name} versucht ${attacker.name}s Schlag abzuwehren, doch er wird getroffen. Schadensbilanz: ${defender.hit ? attacker.attack : 'nicht der Rede wert'}` })
			}
			else if (d20 >= 2 && d20 <= 19) {
				// defender.health -= attacker.attack
				// Treffer wird zurückgenommen
				if (defender.hit) {
					defender.health += attacker.attack
				}
				// this.attacks.push({ message: `${defender.name} blocks ${attacker.name}’s attack.` })
				this.attacks.push({ message: `${defender.name} pariert ${attacker.name}s Angriff erfolgreich.` })
			}
			else {
				// defender.health -= attacker.attack * 2
				attacker.health -= attacker.attack * 2
				// this.attacks.push({ message: `${attacker.name}’s attack is deflected by ${defender.name}’s small ${defender.armour} breastplate!` })
				this.attacks.push({ message: `${attacker.name}s Schwert prallt am Schild von ${defender.name} ab und tritt ihn selbst!` })
			}
		},

		// TODO Verteilung
		_spell(d100, attacker, defender) {
			if (d100 === 1) {
				// defender.health -= attacker.attack
				// this.attacks.push({ message: `${defender.name} casts polymorph on himself, turns into a sheep and bites ${attacker.name} for ${attacker.attack} damage!` })
				attacker.hit = true
				attacker.health -= defender.attack
				// this.attacks.push({ message: `${defender.name} casts polymorph on himself, turns into a sheep and bites ${attacker.name} for ${defender.attack} damage!` })
				this.attacks.push({ message: `${defender.name} wendet Polymorphie an, verwandelt sich in ein Schaf und beißt ${attacker.name}. Schadensbilanz: ${defender.attack}` })
			}
			else if (d100 >= 2 && d100 <= 5) {
				// defender.health -= attacker.attack
				attacker.health -= attacker.attack
				// this.attacks.push({ message: `${attacker.name} casts wild magic. A stray yak cow tumbles from the sky and lands on ${attacker.name} for ${attacker.attack} damage!` })
				this.attacks.push({ message: `${attacker.name} wirbelt wilde Zaubersprüche. Eine verirrte Kuh fällt vom Himmel herab und landet auf ${attacker.name}.` })
			}

			else if (d100 >= 6 && d100 <= 7) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and turns a vibrant shade of blue!` })
				this.attacks.push({ message: `${attacker.name} wirbelt wilde Zaubersprüche und verwandelt sich in ein leuchtendes Blau.` })
			}
			else if (d100 >= 8 && d100 <= 9) {
				// this.attacks.push({ message: `${attacker.name} vomits.` })
				this.attacks.push({ message: `${attacker.name} kotzt.` })
			}
			else if (d100 >= 10 && d100 <= 19) {
				// this.attacks.push({ message: `${attacker.name} casts confusion centered on himself!` })
				this.attacks.push({ message: `${attacker.name} spricht einen Verwirrungszauber aus und hat augenblicklich sein Passwort vergessen.` })
			}
			else if (d100 >= 20 && d100 <= 29) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and grows an eternal flaming beard!` })
				this.attacks.push({ message: `${attacker.name} wirbelt wilde Zaubersprüche und lässt sich einen ewigen Flammenbart wachsen.` })
			}
			else if (d100 >= 30 && d100 <= 39) {
				// this.attacks.push({ message: `${attacker.name} casts levitate on himself and can only shout when they speak!` })
				this.attacks.push({ message: `${attacker.name} spricht einen Schwebezauber aus und geht an die Decke.` })
			}
			else if (d100 >= 40 && d100 <= 49) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and becomes 80 years older!` })
				this.attacks.push({ message: `${attacker.name} wirbelt wilde Zaubersprüche und wird achtzig Jahre älter.` })
			}
			else if (d100 >= 50 && d100 <= 59) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic. Illusory butterflies and flower petals flutter in the air!` })
				this.attacks.push({ message: `${attacker.name} wirbelt wilde Zaubersprüche. Alles wird mit Glitzer überzogen.` })
			}
			else if (d100 >= 60 && d100 <= 69) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and is transported to the Astral Plane until the end of the spells duration!` })
				this.attacks.push({ message: `${attacker.name} wirbelt wilde Zaubersprüche und wird in die Astralebene transportiert, bis die Wirkung nachlässt.` })
			}
			else if (d100 >= 70 && d100 <= 79) {
				// this.attacks.push({ message: `${attacker.name} casts wild magic and is immune to being intoxicated by alcohol for the next 30 days!` })
				this.attacks.push({ message: `${attacker.name} wirbelt wilde Zaubersprüche und ist für die nächsten 30 Tage immun gegen die Wirkung berauschender Substanzen.` })
			}
			else if (d100 >= 80 && d100 <= 89) {
				// this.attacks.push({ message: `${attacker.name} casts friends on ${defender.name}. It is ineffective!` })
				this.attacks.push({ message: `${attacker.name} schleudert schlechte Witze auf ${defender.name}, doch es zeigt keine Wirkung.` })
			}

			else if (d100 >= 90 && d100 <= 99) {
				defender.hit = true
				defender.health -= attacker.attack
				// this.attacks.push({ message: `${attacker.name} casts magic missile. ${defender.name} takes ${attacker.attack} fire damage!` })
				this.attacks.push({ message: `${attacker.name} singt die „Freude, schöner Götterfunken“. ${defender.name} bekommt Ohrenschmerzen, Stärke ${attacker.attack}.` })
			}
			else {
				// defender.health -= attacker.attack
				attacker.hit = true
				attacker.health -= defender.attack
				// this.attacks.push({ message: `${attacker.name} casts polymorph. ${defender.name} turns into a sheep and bites ${attacker.name} for ${defender.attack} damage!` })
				this.attacks.push({ message: `${attacker.name} wendet Polymorphie an. ${defender.name} verwandelt sich in ein Schaf und beißt ${attacker.name}! Schadensbilanz: ${defender.attack}` })
			}
		},
	},

	created() {
		this.player = {
			...this.player,
			health: this.health,
			originHealth: this.health
		}
	},

	mounted() {
		this.battle()
	},

	watch: {
		// 'player.health': (val) => {
		// 	console.log('watch: player.health', val)
		// },
		// player: {
		// 	handler(val) {
		// 		console.log('watch: player', val)
		// 	},
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

<template>
	<div>
		<ol>
			<li v-for="(attack, i) in attacks" :key="i">
				{{ attack.message }}
			</li>
		</ol>

		<div v-show="battleResult" v-html="battleResult" />

		<div id="scroll-to" />
	</div>
</template>

<script>
export default {
	props: {
		health: Number
	},
	data() {
		return {
			attacks: [],
			player: {
				name: '🦸🏼‍♂️ Hans Wurst',
				// health: 1,
				// originHealth: 1,
				// attack: 0,
				armour: '',
				weapon: 'Schwert'
			},
			opponent: {
				name: '🧟 UBOLZIO',
				health: 80,
				// attack: 0,
				armour: '',
				weapon: 'Zweihänder'
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
					message = `<span class="purple-dark">${this.opponent.name}</span> died from <span class="red">a heart attack</span> 🚑`
					break

				case this.player.health <= 0 && this.opponent.health > 0 :
					message = `${this.player.name} died 💀`
					break

				case this.player.health <= 0 && this.opponent.health <= 0 :
					message = 'Everyone died 😱'
					break
			}

			return message
		}
	},

	methods: {
		battle() {
			const timer = setInterval(() => {
				this.player.hit = false
				this.player.attack = Math.floor(Math.random() * 16) + 1
				this.opponent.hit = false
				this.opponent.attack = Math.floor(Math.random() * 16) + 1
				this._randomMove(this.player, this.opponent)
				this._randomMove(this.opponent, this.player)

				this.$nextTick(() => {
					document.getElementById('scroll-to').scrollIntoView()
				})

				if (this.player.health <= 0 || this.opponent.health <= 0) {
					clearInterval(timer)
				}
			}, 500)
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

		_attack(d20, attacker, defender) {
			if (d20 === 1) {
				this.attacks.push({ message: `${attacker.name} misses, is knocked off balance, falls backward and soils himself!` })
			}
			else if (d20 >= 2 && d20 <= 19) {
				defender.hit = true
				defender.health -= attacker.attack
				this.attacks.push({ message: `${attacker.name} strikes ${defender.name} with ${attacker.weapon} for ${attacker.attack} damage.` })
			}
			else {
				defender.hit = true
				defender.health -= attacker.attack * 2
				this.attacks.push({ message: `${defender.name} loses his right arm. An artery has been opened by the strike and a sensory nerve has been severed! ${attacker.name} equips the right arm, flails it around wildly and attacks ${defender.name} for ${attacker.attack * 2} damage!` })
			}
		},

		_block(d20, attacker, defender) {
			if (d20 === 1) {
				// this.attacks.push({ message: `${attacker.name} fails to block and takes ${attacker.attack} damage.` })
				this.attacks.push({ message: `${defender.name} fails to block and takes ${defender.hit ? attacker.attack : 'zero'} damage.` })
			}
			else if (d20 >= 2 && d20 <= 19) {
				// defender.health -= attacker.attack
				if (defender.hit) {
					defender.health += attacker.attack
				}
				this.attacks.push({ message: `${defender.name} blocks ${attacker.name}’s attack.` })
			}
			else {
				// defender.health -= attacker.attack * 2
				attacker.health -= attacker.attack * 2
				this.attacks.push({ message: `${attacker.name}’s attack is deflected by ${defender.name}’s small ${defender.armour} breastplate!` })
			}
		},

		_spell(d100, attacker, defender) {
			if (d100 === 1) {
				// defender.health -= attacker.attack
				// this.attacks.push({ message: `${defender.name} casts polymorph on himself, turns into a sheep and bites ${attacker.name} for ${attacker.attack} damage!` })
				attacker.hit = true
				attacker.health -= defender.attack
				this.attacks.push({ message: `${defender.name} casts polymorph on himself, turns into a sheep and bites ${attacker.name} for ${defender.attack} damage!` })
			}
			else if (d100 >= 2 && d100 <= 5) {
				// defender.health -= attacker.attack
				attacker.health -= attacker.attack
				this.attacks.push({ message: `${attacker.name} casts wild magic. A stray yak cow tumbles from the sky and lands on ${attacker.name} for ${attacker.attack} damage!` })
			}

			else if (d100 >= 6 && d100 <= 7) {
				this.attacks.push({ message: `${attacker.name} casts wild magic and turns a vibrant shade of blue!` })
			}
			else if (d100 >= 8 && d100 <= 9) {
				this.attacks.push({ message: `${attacker.name} vomits.` })
			}
			else if (d100 >= 10 && d100 <= 19) {
				this.attacks.push({ message: `${attacker.name} casts confusion centered on himself!` })
			}
			else if (d100 >= 20 && d100 <= 29) {
				this.attacks.push({ message: `${attacker.name} casts wild magic and grows an eternal flaming beard!` })
			}
			else if (d100 >= 30 && d100 <= 39) {
				this.attacks.push({ message: `${attacker.name} casts levitate on himself and can only shout when they speak!` })
			}
			else if (d100 >= 40 && d100 <= 49) {
				this.attacks.push({ message: `${attacker.name} casts wild magic and becomes 80 years older!` })
			}
			else if (d100 >= 50 && d100 <= 59) {
				this.attacks.push({ message: `${attacker.name} casts wild magic. Illusory butterflies and flower petals flutter in the air!` })
			}
			else if (d100 >= 60 && d100 <= 69) {
				this.attacks.push({ message: `${attacker.name} casts wild magic and is transported to the Astral Plane until the end of the spells duration!` })
			}
			else if (d100 >= 70 && d100 <= 79) {
				this.attacks.push({ message: `${attacker.name} casts wild magic and is immune to being intoxicated by alcohol for the next 30 days!` })
			}
			else if (d100 >= 80 && d100 <= 89) {
				this.attacks.push({ message: `${attacker.name} casts friends on ${defender.name}. It is ineffective!` })
			}

			else if (d100 >= 90 && d100 <= 99) {
				defender.hit = true
				defender.health -= attacker.attack
				this.attacks.push({ message: `${attacker.name} casts magic missile. ${defender.name} takes ${attacker.attack} fire damage!` })
			}
			else {
				// defender.health -= attacker.attack
				attacker.hit = true
				attacker.health -= defender.attack
				this.attacks.push({ message: `${attacker.name} casts polymorph. ${defender.name} turns into a sheep and bites ${attacker.name} for ${defender.attack} damage!` })
			}
		},
	},

	created() {
		console.log('created', this.health)
		this.player = {
			...this.player,
			health: this.health,
			originHealth: this.health
		}
	},

	mounted() {
		console.log('mounted')
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
			console.log('watch: playerHealth', oldVal, val)
			if (val < this.player.originHealth) {
				this.$emit('got-hit', oldVal - val)
			}
		}
	}
}
</script>

import { reactive, readonly } from 'vue'

const state = reactive({
	gold: 0,
	health: 100,
	conditions: [],
	inventory: []
})

const hasCondition = term => state.conditions.includes(term)
const handleCondition = condition => {
	if (condition && !hasCondition(condition)) {
		state.conditions.push(condition)
		manageInventory(condition)
	}
}

const manageInventory = condition => {
	switch (condition) {
		case 'has-helmet': state.inventory.push('Helm', 'Umhang'); break;
		case 'has-keys': state.inventory.push('Keule', 'Schlüssel'); break;
		case 'has-sword': state.inventory.push('Schwert', 'Seil'); break;
		case 'has-magic-wand': state.inventory.push('Stab'); break;
		case 'discard-mace': state.inventory.splice(state.inventory.indexOf('Keule'), 1); break;
		case 'get-armed': state.inventory.push('Schwert', 'Schild'); break;
		case 'discard-magic-wand': state.inventory.splice(state.inventory.indexOf('Stab'), 1); break;
	}
}

const getArmed = () => {
	if (!hasCondition('has-sword')) {
		if (hasCondition('has-keys')) {
			manageInventory('discard-mace')
		}
		manageInventory('get-armed')
	}
}

const finishBattle = result => {
	state.conditions.push(`battle-${result}`)
}

const resetState = () => {
	state.gold = 0
	state.health = 100
	state.inventory = []
	state.conditions = []
}

export default {
	state: readonly(state),
	hasCondition,
	handleCondition,
	manageInventory,
	getArmed,
	finishBattle,
	resetState
}
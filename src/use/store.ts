import { reactive, readonly } from 'vue'

interface State {
	userName: string
	gold: number
	health: number
	inventory: string[]
	conditions: string[]
}
const state: State = reactive({
	userName: '',
	gold: 0,
	health: 100,
	inventory: [],
	conditions: [],
})

const setUserName = (val: string) => {
	state.userName = val
}
const setGold = (val: number) => {
	state.gold = val
}
const setHealth = (val: number) => {
	state.health = val
}

const hasCondition = (term: string) => state.conditions.includes(term)
const isEnabled = ({ condition, notCondition }: { condition?: string; notCondition?: string }) => {
	if (condition && notCondition) {
		return hasCondition(condition) && !hasCondition(notCondition)
	}
	if (condition) {
		return hasCondition(condition)
	}
	if (notCondition) {
		return !hasCondition(notCondition)
	}

	return true
}
const handleCondition = (condition?: string) => {
	if (condition && !hasCondition(condition)) {
		state.conditions.push(condition)
		manageInventory(condition)
	}
}

const manageInventory = (condition: string) => {
	switch (condition) {
		case 'has-helmet':
			state.inventory.push('Helm', 'Umhang')
			break
		case 'has-keys':
			state.inventory.push('Keule', 'Schlüssel')
			break
		case 'has-sword':
			state.inventory.push('Schwert', 'Seil')
			break
		case 'has-magic-wand':
			state.inventory.push('Stab')
			break
		case 'discard-mace':
			state.inventory.splice(state.inventory.indexOf('Keule'), 1)
			break
		case 'get-armed':
			state.inventory.push('Schwert', 'Schild')
			break
		case 'discard-magic-wand':
			state.inventory.splice(state.inventory.indexOf('Stab'), 1)
			break
	}
}

const getArmed = () => {
	if (hasCondition('has-sword')) return

	if (hasCondition('has-keys')) manageInventory('discard-mace')
	manageInventory('get-armed')
}

const resetState = () => {
	state.gold = 0
	state.health = 100
	state.inventory = []
	state.conditions = []
}

export const useStore = () => ({
	state: readonly(state),
	setUserName,
	setGold,
	setHealth,
	hasCondition,
	isEnabled,
	handleCondition,
	manageInventory,
	getArmed,
	resetState,
})

import { ref } from 'vue'

const userName = ref('')
const setName = name => {
	userName.value = name
}

const gold = ref(0)
const health = ref(100)

const conditions = ref([])
const hasCondition = term => conditions.value.includes(term)
const isEnabled = ({ condition, notCondition }) => {
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
const handleCondition = condition => {
	if (condition && !hasCondition(condition)) {
		conditions.value.push(condition)
		manageInventory(condition)
	}
}

const inventory = ref([])
const manageInventory = condition => {
	switch (condition) {
		case 'has-helmet': inventory.value.push('Helm', 'Umhang'); break;
		case 'has-keys': inventory.value.push('Keule', 'Schlüssel'); break;
		case 'has-sword': inventory.value.push('Schwert', 'Seil'); break;
		case 'has-magic-wand': inventory.value.push('Stab'); break;
		case 'discard-mace': inventory.value.splice(inventory.value.indexOf('Keule'), 1); break;
		case 'get-armed': inventory.value.push('Schwert', 'Schild'); break;
		case 'discard-magic-wand': inventory.value.splice(inventory.value.indexOf('Stab'), 1); break;
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

const resetState = () => {
	gold.value = 0
	health.value = 100
	inventory.value = []
	conditions.value = []
}

export default {
	userName,
	setName,
	gold,
	health,
	conditions,
	hasCondition,
	isEnabled,
	handleCondition,
	inventory,
	manageInventory,
	getArmed,
	resetState
}
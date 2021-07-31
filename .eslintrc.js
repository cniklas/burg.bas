module.exports = {
	root: true,
	env: {
		node: true,
	},
	extends: [
		// https://eslint.vuejs.org/rules/
		// vue3-recommended > vue3-strongly-recommended > vue3-essential > base
		'plugin:vue/vue3-strongly-recommended',
		'eslint:recommended',
		// Add under other rules
		'@vue/prettier',
	],
	rules: {
		// override/add rules settings here, such as:
		// 'vue/no-unused-vars': 'error'
	},
	globals: {
		defineProps: 'readonly',
		defineEmits: 'readonly',
	},
}

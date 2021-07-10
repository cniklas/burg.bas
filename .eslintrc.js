module.exports = {
	root: true,
	env: {
		node: true,
	},
	extends: [
		// https://eslint.vuejs.org/rules/
		'plugin:vue/vue3-essential', // 'plugin:vue/vue3-recommended' > 'plugin:vue/vue3-strongly-recommended' > 'plugin:vue/vue3-essential' > 'plugin:vue/base'
		'eslint:recommended',
		// Add under other rules
		'@vue/prettier',
	],
}

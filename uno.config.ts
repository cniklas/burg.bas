import { defineConfig, presetWind } from 'unocss'

export default defineConfig({
	// theme: {
	// },

	// custom CSS
	// rules: [['class-name', { 'rule-name': 'rule-value' }]],

	// shortcuts: {
	// 	'text-prewrap': 'block whitespace-pre-wrap text-center',
	// },

	// https://unocss.dev/presets/wind
	presets: [presetWind()],
})

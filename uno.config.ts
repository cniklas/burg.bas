import { defineConfig, presetMini } from 'unocss'

export default defineConfig({
	// theme: {
	// },

	// custom CSS
	// missing in presetMini
	rules: [['scroll-smooth', { 'scroll-behavior': 'smooth' }]],

	// shortcuts: {
	// 	'text-prewrap': 'block whitespace-pre-wrap text-center',
	// },

	// https://unocss.dev/presets/wind
	presets: [presetMini()],
})

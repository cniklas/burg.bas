import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import WindiCSS from 'vite-plugin-windicss'
import postcssNested from 'postcss-nested'
import eslintPlugin from 'vite-plugin-eslint' // show ESLint errors in the browser

// https://vitejs.dev/config/
export default defineConfig({
	plugins: [vue(), WindiCSS(), eslintPlugin()],
	css: {
		postcss: {
			plugins: [postcssNested],
		},
	},
})

import { ref } from 'vue'

const isTouch = !window.matchMedia('(hover: hover) and (pointer: fine)').matches

const input = ref(null)
const focusInput = () => {
	if (isTouch) return
	input.value?.focus()
}

const cleanInput = string => {
	const regex = /[!"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]/g
	return string
		.replaceAll(regex, '')
		.toLowerCase()
		.replaceAll('geradeaus', 'weiter')
		.split(' ')
		.filter(word => word.length && !['der', 'die', 'das', 'den', 'dem', 'und', 'mit'].includes(word))
		.join(' ')
}

const button = ref(null)
const blurButton = () => {
	button.value?.blur()
}

export const useInput = () => ({
	isTouch,
	input,
	focusInput,
	cleanInput,
	button,
	blurButton,
})

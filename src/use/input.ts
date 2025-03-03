import { useTemplateRef } from 'vue'

const isTouch = !window.matchMedia('(hover: hover) and (pointer: fine)').matches

const inputEl = useTemplateRef<HTMLInputElement | null>('inputEl')
const focusInput = () => {
	if (isTouch) return
	inputEl.value?.focus()
}

const cleanInput = (input: string): string => {
	const regex = /[!"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]/g
	return input
		.replaceAll(regex, '')
		.toLowerCase()
		.replaceAll('geradeaus', 'weiter')
		.split(' ')
		.filter((word: string) => word.length && !['der', 'die', 'das', 'den', 'dem', 'und', 'mit'].includes(word))
		.join(' ')
}

const buttonEl = useTemplateRef<HTMLButtonElement | null>('buttonEl')
const blurButton = () => {
	buttonEl.value?.blur()
}

export const useInput = () => ({
	isTouch,
	inputEl,
	focusInput,
	cleanInput,
	buttonEl,
	blurButton,
})

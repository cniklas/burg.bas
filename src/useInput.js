import { ref } from 'vue'

export default function() {
	const input = ref(null)
	const focusInput = () => {
		input.value?.focus()
	}

	const cleanInput = string => {
		const regex = /[!"#$%&\'()*+,\-./:;<=>?@[\\\]^_`{\|}~]/g;
		return string
			.replaceAll(regex, '')
			.toLowerCase()
			.replaceAll('geradeaus', 'weiter')
			.split(' ')
			.filter(word => word.length && !['der', 'die', 'das', 'den', 'dem', 'und', 'mit'].includes(word))
			.join(' ')
	}

	return {
		input,
		focusInput,
		cleanInput
	}
}
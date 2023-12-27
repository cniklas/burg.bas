export type Paragraph = {
	condition?: string
	notCondition?: string
	story: string
}

export type Story = (string | Paragraph[])[]

export type Command = {
	key: string
	text: string | string[]
	action: string | null
	message?: string
	condition?: string
	notCondition?: string
	setCondition?: string
}

export type Scene = {
	id: string
	story: Story
	hint?: string
	health?: number
	commands?: Command[]
	continue?: {
		action: string
		delay?: number
	}
	timeout?: {
		action: string
	}
	delayed?: {
		delay: number
		story: Story
	}
	// music?: string
	load_audio?: string
	play?: string
	play_delay?: number
}

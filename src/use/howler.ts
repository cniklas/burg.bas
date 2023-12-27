import { ref } from 'vue'
import { Howl } from 'howler'

let _music: Howl | undefined
const playlist = ref(<{ id: string; audio: Howl }[]>[])

const loadMusic = (id: string, autoplay = false) => {
	console.log(autoplay ? 'load + play' : 'preload', `"${id}"`)
	if (!playlist.value.find(item => item.id === id)) {
		playlist.value.push({
			id,
			audio: new Howl({
				src: `audio/${id}.mp3`,
				// autoplay,
				onload: () => {
					console.log('onload')
				},
				onplay: () => {
					console.log(`onplay "${id}"`)
				},
				onend: () => {
					console.log(`onend "${id}"`)
				},
				onfade: () => {
					console.log(`onfade (end) "${id}"`)
					playlist.value
						.find(item => item.id === id)
						?.audio.stop()
						?.volume(1)
				},
			}),
		})
	}
}

const playMusic = (id: string) => {
	_music = playlist.value.find(item => item.id === id)?.audio
	_music?.play()
}

const fadeOutMusic = () => {
	if (_music && _music.playing()) {
		console.log('fade out')
		_music.fade(1, 0, 800)
	}
}

export { playlist, loadMusic, playMusic, fadeOutMusic }

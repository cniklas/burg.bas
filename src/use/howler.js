import { ref } from 'vue'
import { Howl } from 'howler'

let _music = null
const playlist = ref([])

const loadMusic = (id, autoplay = false) => {
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
					console.log('onfade (end)')
					playlist.value
						.find(item => item.id === id)
						.audio.stop()
						.volume(1)
				},
			}),
		})
	}
}

const playMusic = id => {
	// if (_music && _music.playing()) {
	// 	_music.stop().volume(1)
	// }

	_music = playlist.value.find(item => item.id === id)?.audio ?? null
	_music?.play()
}

const fadeOutMusic = () => {
	if (_music && _music.playing()) {
		console.log('fade out')
		_music.fade(1, 0, 800)
	}
}

export { playlist, loadMusic, playMusic, fadeOutMusic }
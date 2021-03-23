import { ref } from 'vue'
import { Howl } from 'howler'

export default function() {
	let _music = null
	const playlist = []
	const isMusicReady = ref(false)

	const loadMusic = (id, autoplay = false) => {
		console.log(autoplay ? 'load + play' : 'preload', `"${id}"`)
		if (!playlist.find(item => item.id === id)) {
			playlist.push({
				id,
				audio: new Howl({
					src: `audio/${id}.mp3`,
					// autoplay,
					onload: () => {
						console.log('onload')
						isMusicReady.value = true
					},
					onplay: () => { console.log(`onplay "${id}"`) },
					onend: () => { console.log(`onend "${id}"`) },
					onfade: () => {
						console.log('onfade (end)')
						playlist.find(item => item.id === id).audio.stop().volume(1)
					}
				})
			})
		}
	}

	const playMusic = id => {
		// if (_music && _music.playing()) {
		// 	_music.stop().volume(1)
		// }

		_music = playlist.find(item => item.id === id)?.audio ?? null
		_music?.play()
	}

	const fadeOutMusic = () => {
		if (_music && _music.playing()) {
			console.log('fade out')
			_music.fade(1, 0, 800)
		}
	}

	return {
		playlist,
		isMusicReady,
		loadMusic,
		playMusic,
		fadeOutMusic
	}
}

// https://jshakespeare.com/simple-count-up-number-animation-javascript-react/

// calculate how long each ‘frame’ should last if we want to update the animation 60 times per second
const _frameDuration = 1000 / 60
// an ease-out function that slows the count as it progresses
const _easeOutQuad = t => t * (2 - t)

const animateNumber = (oldValue, changeBy, cb, add = false, animationDuration = 2000) => {
	// use that to calculate how many frames we need to complete the animation
	const _totalFrames = Math.round(animationDuration / _frameDuration)

	let number = oldValue
	let frame = 0

	// beim Runterzählen bei 0 stoppen
	if (!add && changeBy > oldValue) {
		changeBy = oldValue
	}

	// start the animation running 60 times per second
	const counter = setInterval(() => {
		frame++
		// calculate our progress as a value between 0 and 1
		// pass that value to our easing function to get our progress on a curve
		const progress = _easeOutQuad(frame / _totalFrames)
		// Use the progress value to calculate the current count
		const currentCount = Math.round(changeBy * progress)

		// if the current count has changed, update the element
		if (number !== currentCount) {
			number = currentCount
			cb?.(add ? oldValue + number : oldValue - number)
		}

		// if we’ve reached our last frame, stop the animation
		if (frame === _totalFrames) {
			clearInterval(counter)
		}
	}, _frameDuration)
}

export { animateNumber }

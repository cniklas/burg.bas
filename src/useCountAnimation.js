// https://jshakespeare.com/simple-count-up-number-animation-javascript-react/
export default function () {
	// const _animationDuration = 2000
	// Calculate how long each ‘frame’ should last if we want to update the animation 60 times per second
	const _frameDuration = 1000 / 60
	// Use that to calculate how many frames we need to complete the animation
	// const _totalFrames = Math.round(_animationDuration / _frameDuration)
	// An ease-out function that slows the count as it progresses
	const _easeOutQuad = t => t * (2 - t)

	const animateCount = (el, changeBy, add = true, animationDuration = 2000) => {
		const _totalFrames = Math.round(animationDuration / _frameDuration)

		const oldValue = el.value
		let number = el.value
		let frame = 0

		// beim Runterzählen bei 0 stoppen
		if (!add && changeBy > oldValue) {
			changeBy = oldValue
		}

		// Start the animation running 60 times per second
		const counter = setInterval(() => {
			frame++
			// Calculate our progress as a value between 0 and 1
			// Pass that value to our easing function to get our progress on a curve
			const progress = _easeOutQuad(frame / _totalFrames)
			// Use the progress value to calculate the current count
			const currentCount = Math.round(changeBy * progress)

			// If the current count has changed, update the element
			if (number !== currentCount) {
				number = currentCount
				el.value = add ? oldValue + number : oldValue - number
			}

			// If we’ve reached our last frame, stop the animation
			if (frame === _totalFrames) {
				clearInterval(counter)
			}
		}, _frameDuration)
	}

	return {
		animateCount,
	}
}

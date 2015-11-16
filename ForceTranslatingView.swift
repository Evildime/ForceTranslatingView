import UIKit

class ForceTranslatingView: UIView {
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		updateViewForTouch(touches.first!)
	}

	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		updateViewForTouch(touches.first!)
	}

	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		layer.transform = CATransform3DIdentity
	}

	private func updateViewForTouch(touch: UITouch) {
		let forcePercentage = touch.maximumPossibleForce > 0 ? touch.force / touch.maximumPossibleForce : 0.5
		let forceWeight = 0.3 + (0.7 * forcePercentage)

		let touchLocation = touch.locationInView(self)

		let halfWidth = (bounds.width / 2)
		let halfHeight = (bounds.height / 2)

		let locationFromCenter = CGPointMake(touchLocation.x - halfWidth, touchLocation.y - halfHeight)

		let x = (0.0002 * forceWeight * locationFromCenter.x / halfWidth)
		let y = (0.0002 * forceWeight * locationFromCenter.y / halfHeight)

		layer.transform = transform3DPerspective(x, y: y)
	}

	func transform3DPerspective(x: CGFloat, y: CGFloat) -> CATransform3D {
		var transform = CATransform3DIdentity
		transform.m14 = x
		transform.m24 = y
		return transform
	}
}

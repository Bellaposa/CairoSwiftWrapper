import Cairo
import Foundation

let filename = "/Users/antonioposabella/Desktop/output.png"

let surface = try Surface(
	size: CGSize(
		width: 800,
		height: 600
	)
)

let context = try Context(surface)

context.setSource(
	color: .green
)

context.setFont(
	size: 100
)

context.moveTo(
	point: CGPoint(
		x: 100.0,
		y: 200.0
	)
)

context.createText(
	"Hello World!"
)

context.saveFile(
	filename
)


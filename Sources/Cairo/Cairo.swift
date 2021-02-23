import CCairo
import Foundation


struct CairoError: Error {
	let status: cairo_status_t

	static func check(
		_ status: cairo_status_t
	) throws {
		guard status == CAIRO_STATUS_SUCCESS else {
			throw CairoError(
				status: status
			)
		}
	}
}

final class Surface {
	let pointer: OpaquePointer
	init(
		filename: String,
		size: CGSize,
		format: _cairo_format = CAIRO_FORMAT_RGB24
	) throws {
		pointer = cairo_image_surface_create(
			format,
			Int32(
				size.width
			),
			Int32(
				size.height
			)
		)

		let status = cairo_surface_status(
			pointer
		)

		try CairoError.check(
			status
		)
	}

	deinit {
		cairo_surface_destroy(
			pointer
		)
	}
}

final class Context {
	let pointer: OpaquePointer
	let surface: Surface

	init(
		_ surface: Surface
	) throws {
		self.surface = surface
		pointer = cairo_create(
			surface.pointer
		)

		try CairoError.check(
			cairo_status(
				pointer
			)
		)
	}

	deinit {
		cairo_destroy(
			pointer
		)
	}

	func setSource(
		color: Color
	) {
		cairo_set_source_rgba(
			pointer,
			color.red,
			color.green,
			color.blue,
			color.alpha
		)
	}

	func createText(
		_ text: String
	) {
		cairo_show_text(
			pointer,
			text
		)
	}

	func setFont(
		_ font: Font = .arial,
		size: Double = 30.0
	) {
		cairo_select_font_face(
			pointer,
			font.rawValue,
			CAIRO_FONT_SLANT_NORMAL,
			CAIRO_FONT_WEIGHT_NORMAL
		)

		cairo_set_font_size(
			pointer,
			size
		)
	}

	func moveTo(
		point: CGPoint
	) {
		cairo_move_to(
			pointer,
			Double(
				point.x
			),
			Double(
				point.y
			)
		)
	}

	func saveFile(
		_ filename: String
	) {
		cairo_surface_write_to_png(
			surface.pointer,
			filename
		)
	}
}

struct Color {
	var red: Double
	var green: Double
	var blue: Double
	var alpha: Double

	static let red = Color(red: 1, green: 0, blue: 0, alpha: 1)
	static let green = Color(red: 0, green: 1, blue: 0, alpha: 1)
	static let blue = Color(red: 0, green: 0, blue: 1, alpha: 1)
}

enum Font: String {
	case sans = "Sans"
	case arial = "Arial"
	case courier = "Courier"
}

public func example(filename: String) throws {
	
	let surface = try Surface(
		filename: filename,
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

}

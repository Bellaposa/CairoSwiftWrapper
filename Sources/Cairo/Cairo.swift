import CCairo
import Foundation


struct CairoError: Error {
	let status: cairo_status_t

	static func check(
		_ status: cairo_status_t
	) throws {
		guard status == CAIRO_STATUS_SUCCESS else {
			throw CairoError(status: status)
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
			Int32(size.width),
			Int32(size.height)
		)

		let status = cairo_surface_status(pointer)
		try CairoError.check(status)
	}

	deinit {
		cairo_surface_destroy(pointer)
	}
}

public func example(filename: String) throws {
	
	let surface = try Surface(
		filename: filename,
		size: CGSize(
			width: 800,
			height: 600
		)
	)

	let context = cairo_create(surface.pointer)!

	cairo_set_source_rgba(
		context,
		1,
		0,
		0,
		1)

	cairo_select_font_face(
		context,
		"Sans",
		CAIRO_FONT_SLANT_NORMAL,
		CAIRO_FONT_WEIGHT_NORMAL)

	cairo_set_font_size(
		context,
		40.0
	)

	cairo_move_to(
		context,
		100.0,
		100.0
	)

	cairo_show_text(
		context,
		"Hello World from Cairo"
	)

	cairo_surface_write_to_png(
		surface.pointer,
		filename //works only with absolute path?
	)

	cairo_destroy(context)
}

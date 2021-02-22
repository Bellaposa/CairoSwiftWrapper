import CCairo
import Foundation

public func example(filename: String) {
	
	let pointer = cairo_image_surface_create(
		CAIRO_FORMAT_RGB24,
		800,
		600
	)

	let context = cairo_create(pointer)!

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
		CAIRO_FONT_WEIGHT_NORMAL);

	cairo_set_font_size(
		context,
		40.0);

	cairo_move_to(
		context,
		100.0,
		100.0);

	cairo_show_text(
		context,
		"Hello World from Cairo");

	cairo_surface_write_to_png(
		pointer,
		filename //works only with absolute path?
	)

	cairo_destroy(context)

	cairo_surface_destroy(pointer)
}

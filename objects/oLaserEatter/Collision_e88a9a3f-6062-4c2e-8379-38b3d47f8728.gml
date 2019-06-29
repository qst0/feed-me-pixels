/// @desc ?
image_xscale+= 0.1;
image_yscale+= 0.1;
show_debug_message(image_xscale)
if image_xscale > 30 {
	room_goto_next()
}
with other {
	instance_destroy()
}
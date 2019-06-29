/// @desc follow
if floor(xTo) - floor(x) == 1 {
	followSpeed = 8;
}

if instance_exists(follow) {
	xTo = follow.x // + xOffset;
	yTo = follow.y + yOffset;
}

x += (xTo - x) / (followSpeed / 2); //this should be slow enough // fast smooth enough.
y += (yTo - y) / followSpeed; 

x = clamp(x, viewWidthHalf, room_width - viewWidthHalf);
y = clamp(y, viewHeightHalf, room_height - viewHeightHalf);

camX = x - viewWidthHalf;
camY = y - (viewHeightHalf + viewHeightHalf / 2);
camera_set_view_pos(cam, camX, camY);
/// @desc ?
//bounce off wall

if place_meeting(x+hsp,y,oSolid){
	hsp = -hsp;
	bounces--;
}
if place_meeting(x,y+vsp,oSolid){
	vsp = -vsp;
	bounces--;
}

if bounces < 1 {
	instance_destroy()
}
x += hsp;
y += vsp;
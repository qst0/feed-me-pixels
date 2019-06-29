/// @desc Controll the player
keyLeft = gamepad_axis_value(0,0) < -.5 || keyboard_check(ord("A"));
keyRight = gamepad_axis_value(0,0) >= .5 || keyboard_check(ord("D"));
keyUp = gamepad_axis_value(0,1) > .5 || keyboard_check(ord("W"));
keyDown = gamepad_axis_value(0,1) <= -.5 || keyboard_check(ord("S"));
keyJump = gamepad_button_check_pressed(0,gp_face1) || keyboard_check_pressed(vk_space);


if device_mouse_check_button_pressed(0, mb_left) {
	laserPixs = 10;
}

if laserPixs > 0 {
	var lz = instance_create_depth(oPlayer.x,oPlayer.y,depth,oLaser)
	with lz {
		image_alpha = c_red;
		hsp = -1
		vsp = 1
	}
	laserPixs--;
}

//SIDE TO SIDE

if step % frictionRate == 0 {
	if hsp != 0 {
		if hsp > 0 {
			hsp -= frictionFactor;
		} else if hsp < 0 {
			hsp += frictionFactor;
		}
	}
}

if step % walkRate == 0 {
	var move = keyRight - keyLeft
	var change = hsp + move * walkSpd
	if change < maxhsp && change > -maxhsp {
		hsp += move * walkSpd
	}
}

if place_meeting(x + hsp, y, oSolid) {
	//All the way to the thing we are going to hit
	while !place_meeting(x + sign(hsp)/10, y, oSolid) {
		x += sign(hsp)/10;
	}
	hsp = 0;
}

x+=hsp;

// UP and DOWN

if step % frictionRate == 0 {
	if vsp != 0 {
		if vsp > 0 {
			vsp -= frictionFactor;
		} else if vsp < 0 {
			vsp += frictionFactor;
		}
	}
}

if vsp < maxvsp {
	vsp += grv
}

//C/P
// jumping on the floor
if place_meeting(x, y + 0.1, oSolid){
	jumpCharges = maxJumpCharges;
	if keyJump {
		vsp = - jumpPow;
	}
}

// Jumpming in the air
if keyJump and jumpCharges {
	vsp = - jumpPow;
	jumpCharges--;
}



// do floor detections. aka falling and rising

if place_meeting(x, y + vsp, oSolid) { // We'll hit a solid
	// Regular Solid
	// So go toward it till we do hit it.
	while !place_meeting(x, y + sign(vsp)/10, oSolid) {
		y += sign(vsp)/10;
	}
	//Then stop.
	vsp = 0;
}

y += vsp;

step++;
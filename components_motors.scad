/*
 * Module: components_motors.scad  holds modules which generate
 *   mounts for motors
 *
 * Project: lib_robo
 * Author(s): Don Korte
 * github: https://github.com/dnkorte/lib_robo.git
 * 
 * note all "components" are designed such that the initial component is 
 *  centered on the origin in the xy plane with the surface that would strike
 *  the "outside" of the box or plate lowermost and at Z=0. (moving "up" in original
 *  orientation represents motion "into" the box/plate
 *
 * each component function should have a "add" mode and a "holes" mode
 *  parameter and it generates appropriate bodies per the call.  
 *
 * note that the mainline program should call each place function twice -- once
 *  for "holes" mode and once for "add" mode.   all the "adds" should happen
 *  BEFORE the corresponding "holes" 
 *  
 * MIT License
 * 
 * Copyright (c) 2023 Don Korte
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/*
 * keep this info about minimum distance box-bottom to shaft for each motor type
 * 
  [7:Geared Stepper, 19:Sparkfun Stepper, 12:Yellow TT Horizontal, 12:Yellow TT Vertical, 12:Blue TT Horizontal, 12:Blue TT Vertical, 12:DFR TT with Encoder H, 12:DFR TT with Encoder V, 12:Pololu MiniPlastic Horizontal, 12:Pololu MiniPlastic Vertical, 7:N20 Geared with Encoder,  22:NEMA 17 Stepper, 12:4 Pololu MiniPlastic Horizontal,  12:4 Pololu MiniPlastic Vertical,  12:4 Pololu MiniPlastic Diagonal, 7:4 N20 Geared with Encoder, 12:4 Yellow TT Horizontal, 12:4 Blue TT Horizontal]
 */


/*
 * ****************************************************************************************
 * small geared stepper motor
 * purchase (16x) :https://www.adafruit.com/product/858
 * purchase (64x): https://www.amazon.com/Longruner-Stepper-Uln2003-arduino-LK67/dp/B015RQ97W8/ 
 * *****************************************************************************************
 */

module component_geared_stepper_motor(mode="holes") {  
    // this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
    
    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) translate([ 0, -8, 0 ]) cylinder( r=(8 / 2), h=body_wall_thickness+0.2 );  // the shaft hole
        translate([ 0, 0, -0.1 ]) translate([ -(35/2), 0, 0 ]) cylinder( r=(screwhole_radius_M30_passthru), h=body_wall_thickness+0.2 );  // mount hole
        translate([ 0, 0, -0.1 ]) translate([ +(35/2), 0, 0 ]) cylinder( r=(screwhole_radius_M30_passthru), h=body_wall_thickness+0.2 );  // mount hole

        translate([ 0, 0, body_wall_thickness ]) cylinder( r=(30 / 2), h=20);    // might make dent in bottom for main motor body
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}


/*
 * ****************************************************************************************
 * Sparkfun Stepper Motor Ungeared 7.5 degrees
 * purchase: https://www.sparkfun.com/products/10551
 * Note mount holes are tapped for M3 screws
 * *****************************************************************************************
 */

module component_sparkfun_stepper_motor(mode="holes") { 
    // this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
    
    // polygon reference https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#polygon
    points = [ [25,4], [4,18], [-4,18], [-25,4], [-25,-4], [-4,-18], [4,-18], [25,-4] ]; 
    
    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) cylinder( r=(12 / 2), h=body_wall_thickness+0.2 );  // the shaft hole
        translate([ -(42/2), 0, -0.1 ]) cylinder( r=(screwhole_radius_M30_passthru), h=body_wall_thickness+0.2 );  // mount hole
        translate([ +(42/2), 0, -0.1 ]) cylinder( r=(screwhole_radius_M30_passthru), h=body_wall_thickness+0.2 );  // mount hole

        translate([ 0, 0, body_wall_thickness ]) cylinder( r=(37 / 2), h=18);    // might make dent in bottom for main motor body     
        translate([ 0, 0, body_wall_thickness ]) linear_extrude(height=8) polygon( points ); // might make dent in bottom for flat plate
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}



/*
 * ****************************************************************************************
 * N20 motor
 * purchase: https://www.adafruit.com/product/4638
 * Note mount holes are tapped for M2 screws
 * *****************************************************************************************
 */

module component_n20_motor(mode="holes") { 
    // this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
    
    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) translate([ 0, 0, 0 ]) cylinder( r=(4 / 2), h=body_wall_thickness+0.2 );  // the shaft hole
        translate([ 0, 0, (body_wall_thickness-1) ]) cylinder( r=(5 / 2), h=1.2 );  // the bearing hole
        translate([ 0, 0, -0.1 ]) roundedbox(12, 2.3, 1, (body_wall_thickness+0.2));    // slot for mounting screws (prints better than 2 teeny holes     
        
        translate([ 0, 0, body_wall_thickness ]) roundedbox(14, 12, 1, 32);    // maybe dig a clearance ditch in box bottom if motor is low
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}

/*
 * ****************************************************************************************
 * TT motors (various options)
 * purchase: https://www.adafruit.com/product/4638
 * "Yellow TT", "Blue TT", "DFR TT with Encoder Straight"
 *
 * purchase (yellow) plastic gears, bidirectional shaft 1:48 200 rpm: 
 *      https://www.adafruit.com/product/3777
 * purchase (blue) metal gears shaft only goes "out" 1:90 120rpm: 
 *      https://www.adafruit.com/product/3802 
 * purchase (with encoder) shaft only goes "out" 1:120 160 rpm: 
 *      https://www.dfrobot.com/product-1457.html
 *
 * Note internal dimensions from https://www.adafruit.com/product/3777
 *    but external dimensions inflated a little bit so it could dig body holes if needed
 *
 * on entry "errorstatus" false = display vis normal color, true = display as "DarkOrange"
 * *****************************************************************************************
 */

module component_TT_blue_motor(mode="holes") { 
    // this is generated in xy plane, with shaft centered at origin and body running "right" (towards +x), 
    // shaft is pointing "down" (towards -z); body builds "up" ("into" the box; towards +z)
    // box outside skin is at z=0 (moving "into" box has +z)
    if (mode == "holes") {
        translate([ 0, 0, -body_wall_thickness-0.1 ]) cylinder( r=(7 / 2), h=body_wall_thickness+0.2 );  // the shaft hole
        translate([ 12, 0, -2 ]) cylinder( d=6, h=2 );  // slot for internal gear shaft 
        translate([ 32, 0, -2 ]) roundedbox(4, 8, radius=1, height=4);  // slot for flexible band clamp 
        translate([ 11.25+8.60, +(17.6/2), -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3
        translate([ 11.25+8.60, -(17.6/2), -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3
        translate([ -(11+2.5), 0, -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3

        // under-hole in case it sits low in box
        translate([ (38/2)-11.5, 0, 0 ])  union() {
            roundedbox(38, 24.5, 2, 21);                                                            // gearbox
            translate([ -(37/2)-5, (-5/2)-1, (19/2)-(3/2)-0.5 ]) cube([ 5, 7, 4]);
        }
        translate([ 37-11-5, 0, (19/2) ]) rotate([ 0, 90, 0 ]) shaft_flat(23.5, 20, 32, "tall");   // motor body 
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}

module component_TT_yellow_motor(mode="holes") { 
    // this is generated in xy plane, with shaft centered at origin and body running "right" (towards +x), 
    // shaft is pointing "down" (towards -z); body builds "up" ("into" the box; towards +z)
    // box outside skin is at z=0 (moving "into" box has +z)
    
    if (mode == "holes") {
        translate([ 0, 0, -body_wall_thickness-0.1 ]) cylinder( r=(7 / 2), h=body_wall_thickness+0.2 );  // the shaft hole
        translate([ 12, 0, -2 ]) cylinder( d=6, h=2 );  // slot for internal gear shaft 
        translate([ 32, 0, -2 ]) roundedbox(4, 8, radius=1, height=4);  // slot for flexible band clamp 
        translate([ 11.25+8.60, +(17.6/2), -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3
        translate([ 11.25+8.60, -(17.6/2), -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3
        translate([ -(11+2.5), 0, -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3

        // under-hole in case it sits low in box
        translate([ (38/2)-11.5, 0, 0 ])  union() {
            roundedbox(38, 24.5, 2, 21);                                                            // gearbox
            translate([ -(37/2)-5, (-5/2)-1, (19/2)-(3/2)-0.5 ]) cube([ 5, 7, 4]);
        }
        translate([ 37-11-5, 0, (19/2) ]) rotate([ 0, 90, 0 ]) shaft_flat(23.5, 20, 32, "tall");   // motor body
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}


module component_TT_DFR_motor(mode="holes") { 
    // this is generated in xy plane, with shaft centered at origin and body running "right" (towards +x), 
    // shaft is pointing "down" (towards -z); body builds "up" ("into" the box; towards +z)
    // box outside skin is at z=0 (moving "into" box has +z)
    
    if (mode == "holes") {
        translate([ 0, 0, -body_wall_thickness-0.1 ]) cylinder( r=(7 / 2), h=body_wall_thickness+0.2 );  // the shaft hole
        translate([ 12, 0, -2 ]) cylinder( d=6, h=2 );  // slot for internal gear shaft 
        translate([ 32, 0, -2 ]) roundedbox(4, 8, radius=1, height=4);  // slot for flexible band clamp 
        translate([ 11.25+8.60, +(17.6/2), -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3
        translate([ 11.25+8.60, -(17.6/2), -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3
        translate([ -(11+2.5), 0, -body_wall_thickness-0.1 ]) 
            cylinder( r=1.5, h=body_wall_thickness+0.2 );    // mount hole M3

        // under-hole in case it sits low in box
        translate([ (38/2)-11.5, 0, 0 ])  union() {
            roundedbox(38, 24.5, 2, 21);                                                            // gearbox
            translate([ -(37/2)-5, (-5/2)-1, (19/2)-(3/2)-0.5 ]) cube([ 5, 7, 4]);
        }
        translate([ 37-11-5, 0, (19/2) ]) rotate([ 0, 90, 0 ]) shaft_flat(23.5, 20, 37, "tall");   // motor body
        translate([ 37-11+10-5, 0, (19/2) ]) rotate([ 0, 90, 0 ]) shaft_d_r(29.5, 10, 24, "tall");   // round part of PCB
        translate([ 37-11-3, -(21/2), 2 ]) cube([31, 21, 31 ]);   // square connector
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}

/*
 * ****************************************
 * TT Motor Clamp (standalone component) 
 * Note that M3 screw holes are 35 mm apart
 * 
 * called with size=="full"  makes full 2-screw clamp
 *		or with size=="half" makes 1-screw partial clamp
 * ****************************************
 */
ttmc_clamp_width = 15;
ttmc_internal_motor_depth = 18.5;
ttmc_internal_motor_width = 23.0;
ttmc_strap_thickness = 2.4;
ttmc_mount_screw_spacing = 35;
ttmc_foot_width = 8;

module part_tt_motor_clamp(flavor="full") {
	if (flavor == "full") {
	    difference() {
	        union() {
	            difference() {
	                translate([ -((ttmc_internal_motor_width + (2*ttmc_strap_thickness))/2), 0, 0 ]) 
	                    cube([ ttmc_internal_motor_width + (2*ttmc_strap_thickness), ttmc_internal_motor_depth + ttmc_strap_thickness, ttmc_clamp_width ]);
	                translate([ -(ttmc_internal_motor_width/2), -0.1, -0.1 ]) 
	                    cube([ ttmc_internal_motor_width, ttmc_internal_motor_depth+0.2, ttmc_clamp_width+0.2 ]);
	            }

	            // add "feet"
	            translate([ -((ttmc_internal_motor_width + (2*ttmc_strap_thickness))/2)-ttmc_foot_width, -0.1, -0.1 ])
	                cube([ ttmc_foot_width, 3, ttmc_clamp_width ]);
	            translate([ ((ttmc_internal_motor_width + (2*ttmc_strap_thickness))/2), -0.1, -0.1 ]) 
	                cube([ ttmc_foot_width, 3, ttmc_clamp_width ]);
	        }               

	        translate([ -(ttmc_mount_screw_spacing/2), -0.2, (ttmc_clamp_width/2) ]) rotate([ -90, 0, 0 ]) union() {
	            cylinder(r=screwhole_radius_M30_selftap, 6);
	            translate([ ttmc_mount_screw_spacing, 0, 0 ]) cylinder(r=screwhole_radius_M30_selftap, 6);
	        }
	    }
	} else {
	    difference() {
	        union() {
	            difference() {
	                translate([ 0, 0, 0 ]) 
	                    cube([ 15 + ttmc_strap_thickness, ttmc_internal_motor_depth + ttmc_strap_thickness, ttmc_clamp_width ]);
	                translate([ -0.1, -0.1, -0.1 ]) 
	                    cube([ 15.2, ttmc_internal_motor_depth+0.2, ttmc_clamp_width+0.2 ]);
	            }

	            // add "foot"
	            translate([ 15, -0.1, -0.1 ]) 
	                cube([ 10, 3, ttmc_clamp_width ]);
	        }               

	        translate([ 20, -0.2, (ttmc_clamp_width/2) ]) 
	        	rotate([ -90, 0, 0 ]) 
	        	cylinder(r=screwhole_radius_M30_selftap, 6);
	    }
	}
}

/*
 * ****************************************
 * Pololu Motor Clamp (standalone component) 
 * Note that M3 screw holes are 30 mm apart to match purchasable Pololu part
 * reference: https://www.pololu.com/product/2680
 * ****************************************
 */

pmc_clamp_width = 13;
pmc_internal_motor_depth = 13.8;
pmc_internal_motor_width = 24.8;
pmc_strap_thickness = 1.6;
pmc_mount_screw_spacing = 30;
pmc_foot_width = 6;

module part_pololu_miniplastic_motor_clamp() {
    difference() {
        union() {
            difference() {
                translate([ -((pmc_internal_motor_width + (2*pmc_strap_thickness))/2), 0, 0 ]) 
                    cube([ pmc_internal_motor_width + (2*pmc_strap_thickness), pmc_internal_motor_depth + pmc_strap_thickness, pmc_clamp_width ]);
                translate([ -(pmc_internal_motor_width/2), -0.1, -0.1 ]) 
                    cube([ pmc_internal_motor_width, pmc_internal_motor_depth+0.2, pmc_clamp_width+0.2 ]);
            }

            // add "feet"
            translate([ -((pmc_internal_motor_width + (2*pmc_strap_thickness))/2)-pmc_foot_width, -0.1, -0.1 ])
                cube([ pmc_foot_width, 3, pmc_clamp_width ]);
            translate([ ((pmc_internal_motor_width + (2*pmc_strap_thickness))/2), -0.1, -0.1 ]) 
                cube([ pmc_foot_width, 3, pmc_clamp_width ]);
        }               

        translate([ -(pmc_mount_screw_spacing/2), -0.2, (pmc_clamp_width/2) ]) rotate([ -90, 0, 0 ]) union() {
            cylinder(r=screwhole_radius_M30_selftap, 6);
            translate([ pmc_mount_screw_spacing, 0, 0 ]) cylinder(r=screwhole_radius_M30_selftap, 6);
        }
    }
}

/*
 * ****************************************************************************************
 * Pololu MiniPlastic DC Motor (Straight/Extended Shaft)
 * purchase: https://www.pololu.com/product/1515/pictures
 * reference: https://www.pololu.com/file/0J824/mini-plastic-gearmotor-90-degree-extended-shaft-dimension-diagram.pdf
 * reference: https://www.pololu.com/file/0J1197/magnetic-encoder-pair-kit-for-mini-plastic-gearmotors-dimension-diagram.pdf
 *
 * note mounting holes for standard pololu clamp are 30mm apart, 38mm back from shaft
 * the entire width of mouting bracket is 39.5mm
 * *****************************************************************************************
 */

module component_pololu_miniplastic_motor(mode="holes") { 
    // this is generated in xy plane, with shaft centered at origin and body running "right" (towards +x), 
    // shaft is pointing "down" (towards -z); body builds "up" ("into" the box; towards +z)
    // box outside skin is at z=0 (moving "into" box has +z)
    
    if (mode == "holes") {
        translate([ 0, 0, -body_wall_thickness-0.1 ]) cylinder( r=(5 / 2), h=body_wall_thickness+0.2 );  // the shaft hole

        // hole for body if it intersects back or bottom of box
        translate([ -11, -(23/2), 0 ]) cube([ 62, 23, 19 ]); 
        translate([ 27, -(26/2), 0 ]) cube([ 6, 26, 18 ]); 

        translate([ 37.5, pmc_mount_screw_spacing/2 , -body_wall_thickness-0.1 ]) cylinder( r=2, h=body_wall_thickness+0.2 );  // mounting hole
        translate([ 37.5, -pmc_mount_screw_spacing/2, -body_wall_thickness-0.1 ]) cylinder( r=2, h=body_wall_thickness+0.2 );  // mounting hole
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}


/*
 * ****************************************************************************************
 * NEMA 17 stepper motor
 * info: https://reprap.org/wiki/NEMA_17_Stepper_motor
 * 4 moounting molts (M3) on 31mm centers; central hub 22mm dia; 5mm shaft 24mm long
 * motor body depth varies per current/torque; 42mm square; typ 47 mm deep
 * *****************************************************************************************
 */

nema17_hub_dia = 22;
nema17_hub_thick = 2;
nema17_shaft_dia = 5;
nema17_shaft_length = 24;
nema17_mount_square = 31;
nema17_body_square = 42;
nema17_body_depth = 47;


module component_nema17_stepper_motor(mode="holes") { 
    // this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
    
    if (mode == "holes") {
        translate([ 0, 0, -0.1 ])  cylinder( r=(nema17_hub_dia / 2)+1, h=body_wall_thickness+0.2 );  // the hub hole 

        translate([ nema17_mount_square/2, nema17_mount_square/2, -0.1 ])  cylinder( r=screwhole_radius_M30_passthru , h=body_wall_thickness+0.2 );  // mounting bolt hole 
        translate([ nema17_mount_square/2, -nema17_mount_square/2, -0.1 ])  cylinder( r=screwhole_radius_M30_passthru , h=body_wall_thickness+0.2 );  // mounting bolt hole 
        translate([ -nema17_mount_square/2, nema17_mount_square/2, -0.1 ])  cylinder( r=screwhole_radius_M30_passthru , h=body_wall_thickness+0.2 );  // mounting bolt hole 
        translate([ -nema17_mount_square/2, -nema17_mount_square/2, -0.1 ])  cylinder( r=screwhole_radius_M30_passthru , h=body_wall_thickness+0.2 );  // mounting bolt hole 


        translate([ 0, 0, body_wall_thickness ]) 
            roundedbox(nema17_body_square+2, nema17_body_square+2, 3, nema17_body_depth+2);    // main motor body 
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}
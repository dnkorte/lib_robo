/*
 * Module: components_switches_and_lights.scad  holds modules which generate
 *   mounts or "holes" for common toggle switches, pushbuttons, rocker/slide switches,
 *   joysticks, LEDs, NeoPixels (in various configurations)
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
 * ****************************************************************************************
 * standard mini toggle switch
 * purchase:  https://www.adafruit.com/product/3220   or equivalent
 * purchase:  https://www.amazon.com/yueton-Terminals-Position-Toggle-Switch/dp/B013DZB6CO/
 * purchase:  https://www.amazon.com/MTS-101-Position-Miniature-Toggle-Switch/dp/B0799LBFNY
 * *****************************************************************************************
 */

module component_mini_toggle_switch(mode="holes") {        
    // makes a hole for standard mini-toggle switch 7.5mm dia
    // this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)

    hole_dia = 6.5;
    hole_radius = hole_dia / 2;
    keyhole_long = 3;
    keyhole_wide = 2;
    keyhole_distance = 6.4; // distance away from center of switch hole
    switch_body_width = 13;
    switch_body_depth = 10; 

    if (mode == "holes") {
        // note through-hole extra thick so if on lid it would go all the way through any board mounts placed over it
        if (mode == "holes") {
            translate([ 0, 0, -0.1 ]) cylinder( r=hole_radius, h=8 );
            translate([ -(keyhole_long/2), (keyhole_distance-(keyhole_wide/2)), -0.1 ]) 
                cube([ keyhole_long, keyhole_wide, 8 ]);
        }
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}

/*
 * ****************************************************************************************
 * adafruit illuminated pushbuttons
 * purchase:  https://www.adafruit.com/product/1440   or equivalent in different colors
 * *****************************************************************************************
 */

module component_adafruit_illuminated_pushbutton(mode="holes") {
    // the hole is 17 mm in dia; and 6mm thick; it has flats on 15.1mm apart
    // it should be DIFFERENCED from the body that it is installed in
    // this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)

    if (mode == "holes") {
        difference() {
            // note through-hole extra thick so if on lid it would go all the way through any board mounts placed over it
            translate([ 0, 0, -0.1 ]) cylinder( r=(17/2), h=8);
            translate([ 0, 0, -0.1 ]) translate([-9,7.55,0]) cube([18,2,6]);
            translate([ 0, 0, -0.1 ]) translate([-9,-9.55,0]) cube([18,2,6]);
        }
    }
    if (mode == "adds") {
        // no adds for this device
    }
}



/*
 * ****************************************************************************************
 * large arcade style pushbutton (really soft push)
 * purchase:  https://www.amazon.com/Original-OBSF-30-Buttons-Arcade-Joystick-Console/dp/B01LYN7MTI/ 
 * *****************************************************************************************
 */

module component_arcade_button(mode="holes") {    
    // makes a hole for standard mini-toggle switch 7.5mm dia
    // note the passthru hole is 30.5, but it has a larger hole (40mm) 2.2mm "in" from outside wall
    //      (this is so that snap-fingers have a 2.2mm push-point)
    // this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
    hole_dia = 30.5;
    finger_hole_dia = 40;
    push_thickness = 2.2;
    switch_body_depth = 19;
    
    if (mode == "holes") {
        // note through-hole extra thick so if on lid it would go all the way through any board mounts placed over it
        translate([ 0, 0, -0.1 ]) cylinder( r=(hole_dia / 2), h=8.2 );  // the pass-through hole
        translate([ 0, 0, push_thickness ]) cylinder( r=(finger_hole_dia / 2), h=8.1 );  // lip for switch fingers
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}


/*
 * ****************************************************************************************
 * sparkfun QWIIC pushbutton
 * purchase:  https://www.sparkfun.com/products/15932
 * this is generated in xy plane with center of SWITCH at origin (not board)
 * putton is "down" (-Z direction) as generated and it is generated so that the flat of
 * the button case is at Z= 2.0 mm (so that it will be 2mm inside the box when placed)
 * mount holes are  at ( -Y ) as generated
 * when placed for a lid it will need to be rotated 180 degrees against Y axis
 *
 * NOTE THAT THIS mounts with M3 passthru bolts to nuts
 * NOTE this is incomplete ======================================
 *
 * *****************************************************************************************
 */
 

qs_board_size = 26;
qs_button_center_from_board_center = 5;
qs_mount_holes_from_board_edge = 2.54;
qs_push_thickness = 2.0;       // how far the square part of switch sits BEHIND panel front
qs_switch_body_size = 12.5;    // the x/y dimension of the square part of the switch
qs_pushbutton_diameter = 10;    // diameter of thruhole for round part of switch
qs_pb_dist_from_board_edge = 8.5; // pushbutton center to board edge in Y direction
qs_wing_length = 16;            // the wing on switch that is part of switch mount
qs_wing_width = 3;            // the wing on switch that is part of switch mount

module component_qwiic_pb_horizontal(mode="holes") {  
   
    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) 
            cylinder( r=(qs_pushbutton_diameter / 2), h=max(body_wall_thickness, lid_thickness)+0.2 );  // the pass-through hole for pushbutton
        
        translate([ -qs_switch_body_size/2, -qs_switch_body_size/2, qs_push_thickness ]) 
            cube([ qs_switch_body_size, qs_switch_body_size, body_wall_thickness  ]);                     // lip for square part (switch body)
        
        translate([ -qs_wing_length/2, -qs_wing_width/2, qs_push_thickness ]) 
            cube([ qs_wing_length, qs_wing_width, max(body_wall_thickness, lid_thickness) ]);                     // lip for wing (switch wing)

        
        translate([ -((qs_board_size/2)-qs_mount_holes_from_board_edge), (qs_pb_dist_from_board_edge-qs_mount_holes_from_board_edge), -0.1 ])
            cylinder(r=screwhole_radius_M30_passthru, h=max(body_wall_thickness, lid_thickness)+0.2);
        
        translate([ ((qs_board_size/2)-qs_mount_holes_from_board_edge), (qs_pb_dist_from_board_edge-qs_mount_holes_from_board_edge), -0.1 ])
             cylinder(r=screwhole_radius_M30_passthru, h=max(body_wall_thickness, lid_thickness)+0.2);
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
}



/*
 * ***************************************************************************
 * this makes a mount for adafruit neopixel flora
 *
 * this is generated in xy plane, centered at origin, box outside skin is at 
 * z=0 (moving "into" box has +z) 
 *
 * purchase link: https://www.adafruit.com/product/1260
 * ***************************************************************************
 */

flora_neopixel_block_size = 5.5;
flora_pcb_dia = 13;
flora_pcb_thick = 1;
flora_mount_hole_spacing = 20;

module component_flora_neopixel(mode="holes") {  

    rotate([ 0, 0, -45 ]) union() {
        if (mode == "holes") {
            // make the hole for the white square part that is the actual neopixel
            translate([ -flora_neopixel_block_size/2, -flora_neopixel_block_size/2, -0.1 ]) 
                cube([flora_neopixel_block_size, flora_neopixel_block_size, body_wall_thickness+0.2 ]);

            translate([ 0, 0, (body_wall_thickness-flora_pcb_thick) ]) 
                cylinder(r=(flora_pcb_dia/2), h=max(body_wall_thickness, lid_thickness)+0.2);

            // make 2 mounting holes on a 45 degree angle from the neopixel so the strap won't hit wires
            translate([ ((flora_mount_hole_spacing/2) * 0.707), ((flora_mount_hole_spacing/2) * 0.707), -0.1 ]) 
                cylinder(r=(screwhole_radius_M30_passthru/2), h=max(body_wall_thickness, lid_thickness)+0.2);

            translate([ -((flora_mount_hole_spacing/2) * 0.707), -((flora_mount_hole_spacing/2) * 0.707), -0.1 ]) 
                cylinder(r=(screwhole_radius_M30_passthru/2), h=max(body_wall_thickness, lid_thickness)+0.2);
        }  

        if (mode == "adds") {
            // nothing to add
        }
    }
}

module part_flora_clamp() {
    clamp_width = 3;
    clamp_length = flora_mount_hole_spacing - 4;

    difference() {
        union() {
            translate([ -clamp_length/2, -clamp_width/2, 0 ]) cube([ clamp_length, clamp_width, 5 ]);
            translate([ -flora_mount_hole_spacing/2, 0, 0 ]) cylinder(r=3, h=7);
            translate([ flora_mount_hole_spacing/2, 0, 0 ]) cylinder(r=3, h=7);
        }
        translate([ -flora_mount_hole_spacing/2, 0, -0.1 ]) cylinder(r=screwhole_radius_M30_selftap, h=7.2);
        translate([ flora_mount_hole_spacing/2, 0, -0.1 ]) cylinder(r=screwhole_radius_M30_selftap, h=7.2);
    }
}




/*
 * ***************************************************************************
 * this makes a mount for adafruit neopixel stick (8 in a straight row)
 *
 * this is generated in xy plane, centered at origin, box outside skin is at 
 * z=0 (moving "into" box has +z) 
 * 
 * this is typically mounted OUTSIDE the box, with a white or translucent 
 *   cap surrounding it on the outside as a bezel and light diffuser
 *   the 2 M2 mounting screws go through the bezel, through the stick and into the box
 *
 * purchase link: https://www.adafruit.com/product/1426
 * dimensions: https://learn.adafruit.com/adafruit-neopixel-uberguide/downloads
 * ***************************************************************************
 */

npxl_stick_mount_spacing = 25.4;
npxl_stick_mount_above_ctr = 2.5;
npxl_stick_pcb_len = 50;
npxl_stick_wireport_x = 8;
npxl_stick_wireport_y = 10;
npxl_stick_wireport_spacing = 38;
npxl_stick_lens_y = 16;
npxl_stick_lens_thick = 4;


module component_neopixel_stick(mode="holes") {  

    // mounting screws do  both "adds" and "holes" and "vis"
        translate([ -npxl_stick_mount_spacing/2, npxl_stick_mount_above_ctr, 0 ]) TI20a_mount(mode, 5);
        translate([ npxl_stick_mount_spacing/2, npxl_stick_mount_above_ctr, 0 ]) TI20a_mount(mode,5);

    if (mode == "holes") {
        // wire ports
        translate([ -(npxl_stick_wireport_spacing/2 + npxl_stick_wireport_x), -npxl_stick_wireport_y/2, -0.1 ]) 
            cube([npxl_stick_wireport_x, npxl_stick_wireport_y, 8 ]);
       
        translate([ npxl_stick_wireport_spacing/2, -npxl_stick_wireport_y/2, -0.1 ]) 
            cube([npxl_stick_wireport_x, npxl_stick_wireport_y, 8 ]);
    }  

    if (mode == "adds") {
        // nothing to add
    }
}

module part_neopixel_stick_bezel() {
    difference() {
        union() {
            translate([ -npxl_stick_pcb_len/2, -npxl_stick_lens_y/2, 0 ]) cube([ npxl_stick_pcb_len, npxl_stick_lens_y, npxl_stick_lens_thick ]);
            translate([ -npxl_stick_pcb_len/2, 0, 0 ]) cylinder( r=npxl_stick_lens_y/2, h=npxl_stick_lens_thick);
            translate([ npxl_stick_pcb_len/2, 0, 0 ]) cylinder( r=npxl_stick_lens_y/2, h=npxl_stick_lens_thick);
        }
        translate([ -npxl_stick_mount_spacing/2, npxl_stick_mount_above_ctr, -0.1 ]) cylinder( r=screwhole_radius_M20_passthru, h=6);
        translate([ npxl_stick_mount_spacing/2, npxl_stick_mount_above_ctr, -0.1 ]) cylinder( r=screwhole_radius_M20_passthru, h=6);
        translate([ -(npxl_stick_pcb_len+2)/2, -(npxl_stick_wireport_y+2)/2,  0.6]) cube([ npxl_stick_pcb_len+2, npxl_stick_wireport_y+2, npxl_stick_lens_thick ]);
    }
}

/*
 * ***************************************************************************
 * this makes a mount for adafruit neopixel jewel 
 *
 * this is generated in xy plane, centered at origin, box outside skin is at 
 * z=0 (moving "into" box has +z) 
 * 
 * this is typically mounted OUTSIDE the box, with a white or translucent 
 *   cap surrounding it on the outside as a bezel and light diffuser
 *   the 2 M2 mounting screws go through the bezel, through the stick and into the box
 *
 * purchase link: https://www.adafruit.com/product/2226
 * dimensions: https://learn.adafruit.com/adafruit-neopixel-uberguide/downloads
 * ***************************************************************************
 */

npxl_jewel_mount_spacing = 19;
npxl_jewel_pcb_dia = 24;        
npxl_jewel_wireport_dia = 14;
npxl_jewel_lens_dia = 28;
npxl_jewel_lens_thick = 4;


module component_neopixel_jewel(mode="holes") {  

    // mounting screws do  both "adds" and "holes" and "vis"
        translate([ -npxl_jewel_mount_spacing/2, 0, -0.1 ]) TI20a_mount(mode, 5);
        translate([ npxl_jewel_mount_spacing/2, 0, -0.1 ]) TI20a_mount(mode,5);

    if (mode == "holes") {
        // wire port
        translate([ 0, 0, -0.1 ]) cylinder( r=npxl_jewel_wireport_dia/2, h=8);
    }  

    if (mode == "adds") {
        // nothing to add
    }
}

module part_neopixel_jewel_bezel() {
    difference() {
        cylinder( r= npxl_jewel_lens_dia/2, h= npxl_jewel_lens_thick);               // the bezel itself
        translate([ 0, 0, 0.6 ]) cylinder( r= npxl_jewel_pcb_dia/2, h=6 );       // internal clearance for board
        translate([ -npxl_jewel_mount_spacing/2, 0, -0.1 ]) cylinder( r=screwhole_radius_M20_passthru, h=6);
        translate([ npxl_jewel_mount_spacing/2, 0, -0.1 ]) cylinder( r=screwhole_radius_M20_passthru, h=6);
    }
}

/*
 * ***************************************************************************
 * this makes a mount for adafruit neopixel ring (12 leds)
 *
 * this is generated in xy plane, centered at origin, box outside skin is at 
 * z=0 (moving "into" box has +z) 
 * 
 * this is typically mounted OUTSIDE the box, with a white or translucent 
 *   cap surrounding it on the outside as a bezel and light diffuser
 *   the 2 M3 mounting screws go through the bezel, through the stick and into the box
 *
 * purchase link: https://www.adafruit.com/product/1643
 * dimensions: https://learn.adafruit.com/adafruit-neopixel-uberguide/downloads
 * ***************************************************************************
 */

npxl_ring12_mount_spacing = 45;
npxl_ring12_pcb_outer_dia = 38;  
npxl_ring12_pcb_inner_dia = 22.5;      
npxl_ring12_wireport_spacing_x = 18.5;     
npxl_ring12_wireport_spacing_y = 31;
npxl_ring12_lens_outer_dia = 42;
npxl_ring12_lens_inner_dia = 18.5;
npxl_ring12_lens_thick = 4;


module component_neopixel_ring12(mode="holes") {  

    // mounting screws do  both "adds" and "holes" and "vis"
        translate([ -npxl_ring12_mount_spacing/2, 0, -0.1 ]) TI30a_mount(mode, 5);
        translate([ npxl_ring12_mount_spacing/2, 0, -0.1 ]) TI30a_mount(mode,5);

    if (mode == "holes") {
        // 4 wire ports 
        rotate([ 0, 0, 60 ]) translate([ 15.5, 0, -0.1 ]) roundedbox( 7, 3, 1, 8);
        rotate([ 0, 0, 120 ]) translate([ 15.5, 0, -0.1 ]) roundedbox( 7, 3, 1, 8);
        rotate([ 0, 0, -60 ]) translate([ 15.5, 0, -0.1 ]) roundedbox( 7, 3, 1, 8);
        rotate([ 0, 0, -120 ]) translate([ 15.5, 0, -0.1 ]) roundedbox( 7, 3, 1, 8);
    }  

    if (mode == "adds") {
        // nothing to add
    }
}

module part_neopixel_ring12_bezel() {

    difference() {
        difference() {      // the main donut (body) of the bezel
            cylinder( r= npxl_ring12_lens_outer_dia/2, h= npxl_ring12_lens_thick);               // the bezel "outer" cylinder
            translate([ 0, 0, -0.1] ) cylinder( r= npxl_ring12_lens_inner_dia/2, h= npxl_ring12_lens_thick+0.2);               // the bezel "inner" cylinder
        }                   // the pcb-sized "hole" that is whittled out of it 
        translate([ 0, 0, 0.6 ]) difference() {
            cylinder( r= npxl_ring12_pcb_outer_dia/2, h= npxl_ring12_lens_thick);               // the bezel "outer" cylinder
            translate([ 0, 0, -0.1] ) cylinder( r= npxl_ring12_pcb_inner_dia/2, h= npxl_ring12_lens_thick+0.2);               // the bezel "inner" cylinder
        }
    }
    translate([ -npxl_ring12_mount_spacing/2, 0, 0 ]) difference() {
        cylinder( r= (8/2), h=npxl_ring12_lens_thick);
        translate([ 0, 0, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=npxl_ring12_lens_thick+0.2 );
    }
    translate([ npxl_ring12_mount_spacing/2, 0, 0 ]) difference() {
        cylinder( r= (8/2), h=npxl_ring12_lens_thick);
        translate([ 0, 0, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=npxl_ring12_lens_thick+0.2 );
    }

}

/*
 * ***************************************************************************
 * this makes a mount for adafruit neopixel ring (16 leds)
 *
 * this is generated in xy plane, centered at origin, box outside skin is at 
 * z=0 (moving "into" box has +z) 
 * 
 * this is typically mounted OUTSIDE the box, with a white or translucent 
 *   cap surrounding it on the outside as a bezel and light diffuser
 *   the 2 M3 mounting screws go through the bezel, through the stick and into the box
 *
 * purchase link: https://www.adafruit.com/product/1463
 * dimensions: https://learn.adafruit.com/adafruit-neopixel-uberguide/downloads
 * ***************************************************************************
 */

npxl_ring16_mount_spacing = 52;
npxl_ring16_pcb_outer_dia = 44.5;  
npxl_ring16_pcb_inner_dia = 29.5; 
npxl_ring16_lens_outer_dia = 48;
npxl_ring16_lens_inner_dia = 25.5;
npxl_ring16_lens_thick = 4;


module component_neopixel_ring16(mode="holes") {  

    // mounting screws do  both "adds" and "holes" and "vis"
        translate([ -npxl_ring16_mount_spacing/2, 0, -0.1 ]) TI30a_mount(mode, 5);
        translate([ npxl_ring16_mount_spacing/2, 0, -0.1 ]) TI30a_mount(mode,5);

    if (mode == "holes") {
        // 4 wire ports 
        offset_port = 0;
        offset_text = offset_port+12;
        rotate([ 0, 0, 0+offset_port ]) translate([ 18.75, 0, -0.1 ]) roundedbox( 7, 3, 1, 8);    // PWR
        rotate([ 0, 0, 90+offset_port ]) translate([ 18.75, 0, -0.1 ]) roundedbox( 7, 3, 1, 8);   // D IN
        rotate([ 0, 0, 90+(360/8)+offset_port ]) translate([ 18.75, 0, -0.1 ]) roundedbox( 7, 3, 1, 8); // D Out
        rotate([ 0, 0, 270+offset_port ]) translate([ 18.75, 0, -0.1 ]) roundedbox( 7, 3, 1, 8); // GND

        rotate([ 0, 0, 0+offset_text ]) translate([18.75, 0, 2 ]) 
            linear_extrude(2) text("+V", size=6,  halign="center", font = "Liberation Sans:style=Bold");    // PWR
        rotate([ 0, 0, 90+offset_text ]) translate([18.75, 0, 2 ]) 
            linear_extrude(2) text("DI", size=6,  halign="center", font = "Liberation Sans:style=Bold");    // D IN
        rotate([ 0, 0, 90+(360/8)+offset_text ]) translate([18.75, 0, 2 ]) 
            linear_extrude(2) text("DO", size=6,  halign="center", font = "Liberation Sans:style=Bold");    // D Out
        rotate([ 0, 0, 270+offset_text ]) translate([18.75, 0, 2 ]) 
            linear_extrude(2) text("G", size=6,  halign="center", font = "Liberation Sans:style=Bold");    // GND
    }  

    if (mode == "adds") {
        // nothing to add
    }
}

module part_neopixel_ring16_bezel() {

    difference() {
        difference() {      // the main donut (body) of the bezel
            cylinder( r= npxl_ring16_lens_outer_dia/2, h= npxl_ring16_lens_thick);               // the bezel "outer" cylinder
            translate([ 0, 0, -0.1] ) cylinder( r= npxl_ring16_lens_inner_dia/2, h= npxl_ring16_lens_thick+0.2);               // the bezel "inner" cylinder
        }                   // the pcb-sized "hole" that is whittled out of it 
        translate([ 0, 0, 0.6 ]) difference() {
            cylinder( r= npxl_ring16_pcb_outer_dia/2+0.5, h= npxl_ring16_lens_thick);               // the bezel "outer" cylinder
            translate([ 0, 0, -0.1] ) cylinder( r= npxl_ring16_pcb_inner_dia/2-0, h= npxl_ring16_lens_thick+0.2);               // the bezel "inner" cylinder
        }
    }
    translate([ -npxl_ring16_mount_spacing/2, 0, 0 ]) difference() {
        cylinder( r= (8/2), h=npxl_ring16_lens_thick);
        translate([ 0, 0, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=npxl_ring12_lens_thick+0.2 );
    }
    translate([ npxl_ring16_mount_spacing/2, 0, 0 ]) difference() {
        cylinder( r= (8/2), h=npxl_ring16_lens_thick);
        translate([ 0, 0, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=npxl_ring12_lens_thick+0.2 );
    }

}


/*
 **************************************************************************
 *
 * standard small non-illuminated pushbutton; 5/16 mounting hole
 * purchase: https://www.amazon.com/Cylewet-Momentary-Button-Switch-CYT1078/dp/B0752RMB7Q
 *
 **************************************************************************
 */

module component_simple_pushbutton(mode="holes") {  

    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) cylinder( d= 7.5, h=4.2);
    }


    if (mode == "adds") {
        // nothing to add
    }
}


/*
 **************************************************************************
 *
 * standard small non-illuminated 12mm pushbutton; 12.5mm mounting hole
 * purchase: https://www.amazon.com/Qiying-Momentary-Button-Switch-Terminals/dp/B08T9X8XJC (green mom)
 * purchase: https://www.amazon.com/Pieces-Electronic-Contact-Waterproof-Momentary/dp/B09KV79XJL/
 * purchase: https://www.amazon.com/Cylewet-12Pcs-Switch-Button-CYT1092/dp/B075VBWFM6/ (non latching)
 * purchase: https://www.amazon.com/Cylewet-Self-Locking-Latching-Button-CYT1091/dp/B075VBV4QH (latching)
 * purchase: https://www.amazon.com/Waterproof-Momentary-Button-Switch-Colors/dp/B07F24Y1TB (dome)
 *
 **************************************************************************
 */

module component_12mm_button(mode="holes") {  

    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) cylinder( d= 13.3, h=4.2);
    }


    if (mode == "adds") {
        // nothing to add
    }
}

/*
 **************************************************************************
 *
 * standard small non-illuminated 15mm pushbutton; 16mm mounting hole
 * purchase: https://www.amazon.com/Twidec-AC250V-Momentary-Pre-soldered-R13-507-5C-X/dp/B08JHVLK84
 * purchase: https://www.amazon.com/Momentary-Button-Switch-Assorted-Self-Resetting/dp/B08SKJ6V7Z
 * purchase: https://www.amazon.com/Twidec-AC250V-Momentary-Pre-soldered-R13-507-5C-X/dp/B08JHVLK84/
 * purchase: https://www.amazon.com/Twidec-AC250V-AC125V-Momentary-R13-507-5C/dp/B07SVTQ7B9
 *
 **************************************************************************
 */

module component_15mm_button(mode="holes") {  

    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) cylinder( d= 16, h=4.2);
    }


    if (mode == "adds") {
        // nothing to add
    }
}


/*
 **************************************************************************
 *
 * standard slide switch
 *
 * purchase link: https://www.amazon.com/uxcell-Position-Panel-Slide-Switch/dp/B008DFYNX4/
 *
 **************************************************************************
 */


module component_slide_switch(mode="holes") {
    window_x = 13;
    window_y = 7;

    hole_dia = 4;
    hole_separation = 28;
    body_x = 35;
    body_y = 13;
    viz_panel_plate_x = 35;
    viz_panel_plate_y = 13;
    viz_body_x = 22;
    viz_body_y = 13;
    viz_body_thick = 9;
 

    if (mode == "holes") {
        translate([ (-window_x / 2), (-window_y / 2), -0.5]) cube([window_x, window_y, max(body_wall_thickness, lid_thickness)+1 ]);
        translate([ (hole_separation / 2), 0, -0.1]) cylinder( d=hole_dia, h=max(body_wall_thickness, lid_thickness)+1 );
        translate([ -(hole_separation / 2), 0, -0.1]) cylinder( d=hole_dia, h=max(body_wall_thickness, lid_thickness)+1 );
    }


    if (mode == "adds") {
        // nothing to add
    }
}


/*
 **************************************************************************
 *
 * "boat" rocker  switch
 * needs 19x13mm hole, per manufacturer's dimensions
 *
 * purchase link: https://www.amazon.com/5Pcs-Rocker-Switch-Position-QTEATAK/dp/B07Y1GDRQG
 *
 **************************************************************************
 */


module component_boat_rocker_switch(mode="holes") {
    window_x = 20;
    window_y = 12.5;

    if (mode == "holes") {
        translate([ (-window_x / 2), (-window_y / 2), -0.5]) cube([window_x, window_y, 5 ]);
    }

    if (mode == "adds") {
        // nothing to add
    }
}

/*
 **************************************************************************
 *
 * module component_joystick() generates mount for adafruit 2-axis thumb joystick with select button
 *
 * this part is generated at origin, starting at z=0 and moving "up" so it makes a full hole
 *   for the joystick cap;  it assumes standard "lid_thickness"
 *
 * purchase link: https://www.adafruit.com/product/512
 *
 **************************************************************************
 */

module component_joystick(mode="holes") {
    stick_window_dia = 31;
    board_to_panel_outer = 14;

    mount_hole_sep = 31;
    viz_body = 39;
 

    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) cylinder( d=stick_window_dia, h=lid_thickness+1 );
        translate([ -mount_hole_sep/2, -mount_hole_sep/2, lid_thickness ]) TI30a_mount(mode, board_to_panel_outer+1);
        translate([ -mount_hole_sep/2,  mount_hole_sep/2, lid_thickness ]) TI30a_mount(mode, board_to_panel_outer+1);
        translate([  mount_hole_sep/2, -mount_hole_sep/2, lid_thickness ]) TI30a_mount(mode, board_to_panel_outer+1);
        translate([  mount_hole_sep/2,  mount_hole_sep/2, lid_thickness ]) TI30a_mount(mode, board_to_panel_outer+1);
    }


    if (mode == "adds") {
        translate([ -mount_hole_sep/2, -mount_hole_sep/2, lid_thickness ]) TI30a_mount(mode, board_to_panel_outer-lid_thickness);
        translate([ -mount_hole_sep/2,  mount_hole_sep/2, lid_thickness ]) TI30a_mount(mode, board_to_panel_outer-lid_thickness);
        translate([  mount_hole_sep/2, -mount_hole_sep/2, lid_thickness ]) TI30a_mount(mode, board_to_panel_outer-lid_thickness);
        translate([  mount_hole_sep/2,  mount_hole_sep/2, lid_thickness ]) TI30a_mount(mode, board_to_panel_outer-lid_thickness);
    }
}



// faceplate for panel-mount slide switch
// it should be DIFFERENCED from the body that it is installed in
// it has 2 2.5mm holes 16 mm apart plus a rectangular hole for slider 4 x 8 mm
// it also has an recess 7 x 22 mm so that the switch sits "inside" the wall a little bit
// this component as-generated is centered on the origin, and is 1mm thicker than box wall, offset -0.5mm down
// to avoid manifold errors
// to place it on various vertical walls, use code like 
// left wall
//   translate([body_wall_thickness,(outer_y/2), z]) rotate([-90,0,90]) slide_switch();
// right wall
//   translate([(outer_x - body_wall_thickness) ,(outer_y/2), z]) rotate([90,0,90]) slide_switch();
// top wall
//   translate([(outer_x/2), (outer_y - body_wall_thickness), z]) rotate([-90, 0, 0]) slide_switch();
// bottom wall
//   translate([(outer_x/2), body_wall_thickness, z]) rotate([90, 0, 0]) slide_switch(); 

module slide_switch_tiny() {
    slider_x = 8;
    slider_y = 4;
    recess_x = 22;
    recess_y = 7;
    hole_radius = 2.5 / 2;
    hole_separation = 16;
    translate([ (-slider_x / 2), (-slider_y / 2), -0.5]) cube([slider_x, slider_y, body_wall_thickness+1]);
    translate([ (-recess_x / 2), (-recess_y / 2), -0.5]) cube([recess_x, recess_y, body_wall_thickness-1 + 0.5]);
    translate([ (hole_separation / 2), 0, -0.5]) cylinder( r=hole_radius, h=body_wall_thickness+1 );
    translate([ -(hole_separation / 2), 0, -0.5]) cylinder( r=hole_radius, h=body_wall_thickness+1 );
}


/*
 **************************************************************************
 *
 * module component_rotary_encoder() generates mount for adafruit stemma rotary encoder board
 *
 * this part is generated at origin, starting at z=0 and moving "up" so it makes a full hole
 *   for the joystick cap;  it assumes standard "lid_thickness"
 *
 * purchase link: https://www.adafruit.com/product/4991
 * info link: https://learn.adafruit.com/adafruit-i2c-qt-rotary-encoder
 *
 **************************************************************************
 */

module component_rotary_encoder(mode="holes") {
    shaft_dia = 8;
    board_to_panel_outer = 10;

    mount_hole_sep = 20.5;
    viz_body = 25.4;
 

    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) cylinder( d=shaft_dia, h=lid_thickness+1 );
        translate([ -mount_hole_sep/2, -mount_hole_sep/2, lid_thickness ]) TI25a_mount(mode, board_to_panel_outer+1);
        translate([ -mount_hole_sep/2,  mount_hole_sep/2, lid_thickness ]) TI25a_mount(mode, board_to_panel_outer+1);
        translate([  mount_hole_sep/2, -mount_hole_sep/2, lid_thickness ]) TI25a_mount(mode, board_to_panel_outer+1);
        translate([  mount_hole_sep/2,  mount_hole_sep/2, lid_thickness ]) TI25a_mount(mode, board_to_panel_outer+1);
    }


    if (mode == "adds") {
        translate([ -mount_hole_sep/2, -mount_hole_sep/2, lid_thickness ]) TI25a_mount(mode, board_to_panel_outer-lid_thickness);
        translate([ -mount_hole_sep/2,  mount_hole_sep/2, lid_thickness ]) TI25a_mount(mode, board_to_panel_outer-lid_thickness);
        translate([  mount_hole_sep/2, -mount_hole_sep/2, lid_thickness ]) TI25a_mount(mode, board_to_panel_outer-lid_thickness);
        translate([  mount_hole_sep/2,  mount_hole_sep/2, lid_thickness ]) TI25a_mount(mode, board_to_panel_outer-lid_thickness);
    }
}



// this makes a mount for piezo buzzer (12mm dia, 10mm deep)
// the mount is 12 x 13.5 x (17.5 above bottom wall)
// the mount is oriented such that the beeper exit hole faces right
// the mount has cylinder that encloses beeper (which sits 0mm higher than box bottom
//    it fits a threaded insert on the top for a M3 screw that applies clamping pressure "down" on beeper 
//    to hold it in place
beeper_dia = 13;
beeper_depth = 12;
beeper_above_floor = 0;
module beeper_mount() {
    difference() {
        cube([beeper_depth, (beeper_dia+2+2), (beeper_dia+beeper_above_floor+4+body_bottom_thickness)]);
        translate([-0.5, (beeper_dia/2)+2, body_bottom_thickness+beeper_above_floor+(beeper_dia/2)]) rotate([0, 90, 0]) cylinder( r=(beeper_dia/2), h=(beeper_depth+1));
        translate([4, (beeper_dia/2)+2, body_bottom_thickness+beeper_above_floor+beeper_dia-1]) cylinder( r=(TI30m_through_hole_diameter/2), h=(beeper_depth+6));
    }
}

module beeper_sound_hole() {
    sound_hole_dia = 5;
    translate([beeper_depth-0.5, (beeper_dia/2)+2, body_bottom_thickness+beeper_above_floor+(beeper_dia/2)]) rotate([0, 90, 0]) cylinder( r=(sound_hole_dia/2), h=(body_wall_thickness+1));
}

/*
 * part_3neopixel_strip_bezel() makes a bezel to hold down 3 neopixel strips
 * purchase: https://www.adafruit.com/product/1426
 */

module part_3neopixel_strip_bezel() {
     translate([ 0, 0, 5.5 ]) rotate([ 180, 0, 0 ]) difference() {
        union() {
            roundedbox( 156+10, 14, 6, 5.5);
            translate([ -40, 9, 0 ]) roundedbox( 10, 10, 3, 5.5 );
            translate([  40, 9, 0 ]) roundedbox( 10, 10, 3, 5.5 );
        }
        translate([ 0, 0, -0.1 ]) roundedbox( 156, 11, 1, 4.6 );
        translate([ -40, 10, -0.1 ]) cylinder( d=M3_throughhole_dia, h=6 );
        translate([  40, 10, -0.1 ]) cylinder( d=M3_throughhole_dia, h=6 );
    }
}

module holes_for_3neopixel_strip(orientation="normal", panel_thickness=8) {
    translate([ -75, 0, 0 ]) roundedbox( 10, 10, 2, panel_thickness);
    if (orientation == "reverse") {
        translate([ -40, -10, 0 ]) cylinder( d=TI30_through_hole_diameter, h=panel_thickness);
        translate([  40, -10, 0 ]) cylinder( d=TI30_through_hole_diameter, h=panel_thickness);
    } else {
        translate([ -40, 10, 0 ]) cylinder( d=TI30_through_hole_diameter, h=panel_thickness);
        translate([  40, 10, 0 ]) cylinder( d=TI30_through_hole_diameter, h=panel_thickness);
    }
}
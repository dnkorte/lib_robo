/*
 * Module: components_power_fuses_connectors.scad  holds modules which generate
 *   fuse holders and basic connectors used in robotics, electronics, and RC projects
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
 * ***************************************************************************
 * this makes a holder for automotive blade type fuses
 *  
 * note this is created such that the connectors run in the +Z direction, 
 * with the "top" in the -Y direction; fuse block is centered at origin, starting at z=0 going up
 * this is made to fit these blade connectors: 
 *     https://www.amazon.com/Baomain-disconnects-Insulated-Connector-Electrical/dp/B01G4POUAU/
 *
 * inspired by: https://www.thingiverse.com/thing:1787609
 *
 * ***************************************************************************
 */
fuseblock_width = 30; 
fuseblock_height = 7;
fuseblock_length = 23; // note this should be (length_of_cavity + 2)

module fuse_holder_block() {
    blade_separation = 10; 
    
        translate([ 0, fuseblock_height/2, fuseblock_length/2 ]) rotate([ 90, 90, 0 ]) difference() {
            // but note its actually GENERATED flat on XY plane with "front" to right (+X)
            translate([ -fuseblock_length/2, -fuseblock_width/2, 0 ]) 
                cube([ fuseblock_length, fuseblock_width, fuseblock_height ]);        
            translate([ 0, -blade_separation/2, 0 ]) fuse_cavity();        
            translate([ 0, +blade_separation/2, 0 ]) fuse_cavity();
            
            // mount holes for lid 
            translate([ -(fuseblock_length/2) + 8, -(fuseblock_width/2)+3, -0.1 ]) 
                cylinder(d=M3_selftap_dia, h=fuseblock_height + 0.2);
            translate([ -(fuseblock_length/2) + 8, +(fuseblock_width/2)-3, -0.1 ]) 
                cylinder(d=M3_selftap_dia, h=fuseblock_height + 0.2);

            // window in front so fuse can seat in "deeper"
            //translate([ (fuseblock_length/2)-2, -1.5, 4 ]) cube([ 3, 3, 4.2 ]);   // removed 1/24
            translate([ (fuseblock_length/2)-2, -1.6, 4 ]) cube([ 3, 3.2, 4.2 ]); 
        }
}

/*
 * module fuse_holder_lid()
 * this creates a hole in the backpanel that accepts fuseblock 
 * this is created in xy plane, centered at origin
 */
module hole_for_fuseblock() {
    window_width = 20;
    window_height = 4;

    //translate([ -fuseblock_width/2, -fuseblock_height/2, -0.1 ]) cube([ fuseblock_width, fuseblock_height, 3.2 ]);  // removed 1/24
    translate([ 0, -2, -0.1 ]) roundedbox( window_width, window_height, (window_height/2), 3.2 );
}

/*
 * this creates a cover (lid) for the fuseblock
 * this is created in xy plane, centered at origin
 */
module fuse_holder_lid() {
    difference() {
        translate([ -((fuseblock_length-5)/2), -(fuseblock_width/2), 0 ]) cube([ (fuseblock_length-5), fuseblock_width, 2 ]); 
        // mount holes for lid
        translate([ -((fuseblock_length-5)/2)+8, -(fuseblock_width/2)+3, -0.1 ]) 
            cylinder(d=M3_throughhole_dia, h=fuseblock_height + 0.2);
        translate([ -((fuseblock_length-5)/2)+8, +(fuseblock_width/2)-3, -0.1 ]) 
            cylinder(d=M3_throughhole_dia, h=fuseblock_height + 0.2);
    }
}

/*
 * module fuse_cavity
 * this is a subcomponent, part of the fuseblock 
 *     it creates one blade cavity
 * this is created in xy plane, centered at origin
 */
module fuse_cavity() {
    width_of_blade = 6.5;
    width_of_blade_cavity = 8.5;
    length_of_cavity = 21; 
    depth_of_cavity_wire_part = 5.5;
    depth_of_cavity_blade_part = 4;
    depth_of_access_hole_blade = 3;
    length_of_blade_part = 8;
    length_of_deep_part = length_of_cavity - length_of_blade_part; 
    front_edge_of_cavity = (fuseblock_length / 2) - 1;
    random_big = 20;
    random_small = 5;
    
    // shelf for bottom of contact (blade)
    translate([ (front_edge_of_cavity - length_of_blade_part), 
                -(width_of_blade_cavity/2), 
                (fuseblock_height - depth_of_cavity_blade_part) ]) 
                    cube([ length_of_blade_part, width_of_blade_cavity, random_big ]);    
    
    translate([ (front_edge_of_cavity - length_of_blade_part), 
                -(width_of_blade_cavity/2), 
                (fuseblock_height - depth_of_cavity_blade_part) ]) 
                    cube([ length_of_blade_part, width_of_blade_cavity, random_big ]);
    
    // shelf for bottom of wire crimp area
    translate([ (front_edge_of_cavity - length_of_cavity), 
                -(width_of_blade_cavity/2), 
                (fuseblock_height - depth_of_cavity_wire_part) ]) 
                    cube([ length_of_deep_part + 0.1, width_of_blade_cavity, random_big ]);
     
     // front access hole for blade
     translate([ front_edge_of_cavity-4, -(width_of_blade+0.5)/2, (fuseblock_height - depth_of_access_hole_blade) ])
        cube([ random_big, (width_of_blade+0.5), random_big ]);
        
     // back access hole for wire
     translate([ -(fuseblock_length/2)-0.1, -(depth_of_cavity_wire_part-1)/2, (fuseblock_height - depth_of_cavity_wire_part) ])
        cube([ random_small, depth_of_cavity_wire_part-1, random_big
        ]);
}







/*
 * ***************************************************************************
 * this makes a mount for Adafruit panel mount 2.1mm barrel jack
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape

 * purchase link: https://www.adafruit.com/product/610
 *
 * ***************************************************************************
 */

module component_barrel_jack(mode="holes") {  

    if (mode == "holes") {
        translate([ 0, 0, -0.1 ]) shaft_flat(13, 11.6, 8 );
    }


    if (mode == "adds") {
        // nothing to add
    }
}




/*
 * ***************************************************************************
 * this makes a mount for Adafruit MicroUSB or USB-C breakout (for power)
 *  
 * this is generated in XY plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated with the USB connector base at origin, with the expected bottom of box in the +y direction
 *
 * purchase link: https://www.adafruit.com/product/1833    (micro USB)
 * purchase link: https://www.adafruit.com/product/4090    (USB-C)
 *
 * ***************************************************************************
 */

usb_width = 24;
usb_depth = 8;
usb_window_width = 13;
usb_window_tall = 10;
usb_mount_spacing = 15;
usb_board_viz_width = 20;
usb_board_viz_depth = 10;
usb_board_viz_screw_offset = 2.5;

wall_keepaway = 2;  // for both micro-usb and usb-c

module component_USB_breakout(mode="holes", height=12) {  

    if (mode == "holes") {
        translate([ -(usb_window_width/2), -(usb_window_tall/2)-1, -0.1 ]) 
            cube([usb_window_width, usb_window_tall, body_wall_thickness+0.2 ]);

            if (TI25_use_threaded_insert) {
                translate ([ -(usb_mount_spacing /2), 1.4, (body_wall_thickness+usb_board_viz_screw_offset + wall_keepaway) ]) 
                    rotate([ -90, 0, 0 ]) 
                    cylinder( d=TI25_through_hole_diameter, h=height+0.2);  
                translate ([ (usb_mount_spacing /2), 1.4, (body_wall_thickness+usb_board_viz_screw_offset + wall_keepaway) ]) 
                    rotate([ -90, 0, 0 ]) 
                    cylinder( d=TI25_through_hole_diameter, h=height+0.2); 
            } else {
                translate ([ -(usb_mount_spacing /2), 1.4, (body_wall_thickness+usb_board_viz_screw_offset + wall_keepaway) ]) 
                    rotate([ -90, 0, 0 ]) 
                    cylinder( r=screwhole_radius_M25_selftap, h=height+0.2);  
                translate ([ (usb_mount_spacing /2), 1.4, (body_wall_thickness+usb_board_viz_screw_offset + wall_keepaway) ]) 
                    rotate([ -90, 0, 0 ]) 
                    cylinder( r=screwhole_radius_M25_selftap, h=height+0.2);
            }
    }


    if (mode == "adds") {
        translate ([ -(usb_width/2), +1.5, body_wall_thickness ]) cube([ usb_width, height, usb_depth ]);
    }
}

usbmb_shell_width = 9;
usbmb_shell_height = 3;

module part_USB_micro_clamp() {
    translate([ 0, 0, 6 ]) rotate([ 0, 180, 0 ]) difference() {
        translate ([ -(usb_width/2), 0, 0 ]) cube([ usb_width, usb_depth, 6 ]);
        translate ([ -(usb_mount_spacing/2), (usb_depth-5), -0.1 ]) cylinder( r=screwhole_radius_M25_passthru, h=6+0.5);  
        translate ([ (usb_mount_spacing/2), (usb_depth-5), -0.1 ]) cylinder( r=screwhole_radius_M25_passthru, h=6+0.5);  
        translate ([ -(usbmb_shell_width/2), -0.1, -0.1 ]) cube([ usbmb_shell_width, usb_depth+0.2, usbmb_shell_height+0.1 ]);
    }
    
}

usbc_shell_width = 10;
usbc_shell_height = 3.2;

module part_USB_C_clamp() {
    translate([ 0, 0, 6 ]) rotate([ 0, 180, 0 ]) difference() {
        translate ([ -(usb_width/2), 0, 0 ]) cube([ usb_width, usb_depth, 6 ]);
        translate ([ -(usb_mount_spacing/2), (usb_depth-5), -0.1 ]) cylinder( r=screwhole_radius_M25_passthru, h=6+0.5);  
        translate ([ (usb_mount_spacing/2), (usb_depth-5), -0.1 ]) cylinder( r=screwhole_radius_M25_passthru, h=6+0.5);  
        translate ([ -(usbc_shell_width/2), -0.1, -0.1 ]) cube([ usbc_shell_width, usb_depth+0.2, usbc_shell_height+0.1 ]);
    }
    
}
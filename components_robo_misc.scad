/*
 * Module: components_camera_rollbar.scad  holds modules which generate
 *   common robotics or RC racer parts not otherwise easily categorized
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
 * hex nut generator, from
 * https://github.com/chrisspen/openscad-extra
 *
 * this version makes a nut that fits properly in the nut receptacle on a 12mm hex RC wheel
 */

module make_hex_nut(w, h, d){
    // d = inner diameter
    // w = width across the flats
    // h = height or thickness
    s = w/sqrt(3);
    $fn = 100;
    
    translate([ 0, 0, h/2 ]) difference(){
        union(){
            for(i=[0:1:2]){
                rotate([0,0,120*i])
                cube([w, s, h], center=true);
            }
        }
        if(d){
            cylinder(d=d, h=h+1, center=true);
        }
    }
}

module make_12mm_hex_nut(w=11.4, h=4, d=4){
    s = w/sqrt(3);
    $fn = 100;
    
    make_hex_nut(w, h, d);
}

// this makes a nut shape for an M3 nut TO BE USED AS A CAVITY
module make_m3_hex_nut(w=5.7, h=2.7, d=0) {
    s = w/sqrt(3);
    $fn = 100;
    
    make_hex_nut(w, h, d);
}

module part_thumbnut(d=20, thick=3, hub_thickness=5, bolt_dia=3.5) {
    difference() {
        union() {
            cylinder( d=(0.85*d), h=thick);
            cylinder( d=9, h=thick+hub_thickness);
            rotate([ 0, 0, 0 ]) roundedbox( (d/8), d, (d/16), thick);       
            rotate([ 0, 0, 30 ]) roundedbox( (d/8), d, (d/16), thick);      
            rotate([ 0, 0, 60 ]) roundedbox( (d/8), d, (d/16), thick);      
            rotate([ 0, 0, 90 ]) roundedbox( (d/8), d, (d/16), thick);      
            rotate([ 0, 0, 120 ]) roundedbox( (d/8), d, (d/16), thick);     
            rotate([ 0, 0, 150 ]) roundedbox( (d/8), d, (d/16), thick); 
        }
        translate([ 0, 0, -0.1 ]) cylinder( d=bolt_dia, h=thick+hub_thickness+0.2);
        translate([ 0, 0, thick+hub_thickness-3 ]) make_m3_hex_nut(h=3.1);
    }
}



/*
 * part_wheel_hub_extender()
 * this is an extender for 12mm wheel hub, typically used to move wheels farther out from chassis
 */

module part_wheel_hub_extender(extension_length=6) {
    translate([ 0, 0, extension_length+5 ]) rotate([ 0, 180, 0 ]) difference() {
        union() {
            // this is the "nut" that actually goes into the tire
            translate([ 0, 0, extension_length ]) make_12mm_hex_nut(w=11.4, h=5, d=4);
            difference() {
                // note this part wraps around the brass adaptor and engages its 12mm nut
                // it is slightly conical so that it can 3d print without supports (nut side down)
                cylinder(d1=18, d2=14, h=extension_length);
                translate([ 0, 0, -0.1 ]) make_12mm_hex_nut(12.4, h=5, d=4);
            }
        }
        translate([ 0, 0, -0.1 ]) cylinder(d=4.2, h=extension_length+4.2);
    }
}



module part_caster_mount() {
    // this is a mount for a 1.5-inch rubber caster wheel from home depot
    // https://www.homedepot.com/p/Everbilt-1-1-2-in-Black-Soft-Rubber-and-Steel-Swivel-Plate-Caster-with-40-lb-Load-Rating-49489/203661072
    // note that the "ground" is 1-7/8 in below the top plate, which means that when using a 96mm rubber rc tire
    // the mount plate should be at the same height as the motor's axle.

    caster_mount_plate_x = 50;
    caster_mount_plate_y = 68;
    caster_mount_plate_thick = 4;
    caster_mount_bolt_sep_x = 1.125 * 25.4;
    caster_mount_bolt_sep_y = 1.375 * 25.4;
    caster_mount_bolt_dia = (0.25 * 25.4) + 1;
    caster_back_block_thick = 10;
    caster_back_block_height = 22;

    difference() {
        union() {
            translate([ -caster_mount_plate_x/2, -caster_mount_plate_y/2, 0 ])
                cube([ caster_mount_plate_x, caster_mount_plate_y, caster_mount_plate_thick ]);
            translate([ -(6/2), -caster_mount_plate_y/2, caster_mount_plate_thick ]) 
                prism( 6, caster_mount_plate_y-caster_back_block_thick, caster_back_block_height-caster_mount_plate_thick);
            translate([ -caster_mount_plate_x/2, (caster_mount_plate_y/2)-caster_back_block_thick, 0 ]) 
                cube([ caster_mount_plate_x, caster_back_block_thick, caster_back_block_height ]);
        }

        // holes to mount caster to the block   
        translate([ 0, -9, 0 ]) union() {
            translate([ caster_mount_bolt_sep_x/2, caster_mount_bolt_sep_y/2, -0.1 ]) 
                cylinder( d=caster_mount_bolt_dia, h=caster_mount_plate_thick+0.2 );
            translate([ caster_mount_bolt_sep_x/2, -caster_mount_bolt_sep_y/2, -0.1 ]) 
                cylinder( d=caster_mount_bolt_dia, h=caster_mount_plate_thick+0.2 );
            translate([ -caster_mount_bolt_sep_x/2, caster_mount_bolt_sep_y/2, -0.1 ]) 
                cylinder( d=caster_mount_bolt_dia, h=caster_mount_plate_thick+0.2 );
            translate([ -caster_mount_bolt_sep_x/2, -caster_mount_bolt_sep_y/2, -0.1 ]) 
                cylinder( d=caster_mount_bolt_dia, h=caster_mount_plate_thick+0.2 );
        }
        // holes to mount this block to the back wall of racer
        translate([ -16, (caster_mount_plate_y/2)-caster_back_block_thick-0.1, 6 ]) 
            rotate([ -90, 0, 0 ]) cylinder( d=TI30_through_hole_diameter, h=caster_back_block_thick+0.2 );
        translate([ 16, (caster_mount_plate_y/2)-caster_back_block_thick-0.1, 6 ]) 
            rotate([ -90, 0, 0 ]) cylinder( d=TI30_through_hole_diameter, h=caster_back_block_thick+0.2 );
        translate([ -16, (caster_mount_plate_y/2)-caster_back_block_thick-0.1, 16 ]) 
            rotate([ -90, 0, 0 ]) cylinder( d=TI30_through_hole_diameter, h=caster_back_block_thick+0.2 );
        translate([ 16, (caster_mount_plate_y/2)-caster_back_block_thick-0.1, 16 ]) 
            rotate([ -90, 0, 0 ]) cylinder( d=TI30_through_hole_diameter, h=caster_back_block_thick+0.2 );
    }
}

module part_beltclip() {
    beltclip_y = 65;
    beltclip_x = 30;
    standoff_y = 25;
    standoff_thick = 7;
    bottom_catch_thick = 2;
    beltclip_thick = 2;

    difference() {
        union() {
            roundedbox( beltclip_x, beltclip_y, 3, beltclip_thick);
            translate([ 0, -(beltclip_y/2)+(standoff_y/2), beltclip_thick ]) roundedbox( beltclip_x, standoff_y, 3, standoff_thick);
            translate([ 0, (beltclip_y/2)-1.5, beltclip_thick ]) roundedbox( beltclip_x-6, 3, 1, bottom_catch_thick);
        }
        translate([ 0, -(beltclip_y/2)+(standoff_y/2), -0.1 ]) component_beltclip_mount(TI30_through_hole_diameter);
    }
}


module component_beltclip_mount(hole_dia=M3_throughhole_dia) {
    translate([ -beltclip_hole_sep_x/2, -beltclip_hole_sep_y/2, 0 ]) cylinder( d=hole_dia, h=12);
    translate([ -beltclip_hole_sep_x/2, beltclip_hole_sep_y/2, 0 ]) cylinder( d=hole_dia, h=12);
    translate([ beltclip_hole_sep_x/2, -beltclip_hole_sep_y/2, 0 ]) cylinder( d=hole_dia, h=12);
    translate([ beltclip_hole_sep_x/2, beltclip_hole_sep_y/2, 0 ]) cylinder( d=hole_dia, h=12);
} 



tt02mountbracket_thick = 12;
module part_tt02mountbracket_pillar() {
    // this is post that mounts plate to TT02 chassis

    tt02mountbracket_carmount_screw_sep = 15;
    tt02mountbracket_cavity_dia = 6.8;
    tt02mountbracket_cavity_depth = 1;
    tt02mountbracket_cavity_depth_deep = 3;
    tt02mountbracket_X = 25;

    tt02mountbracket_wing_span = 75;
    tt02mountbracket_wing_thick = 7;

    dia_passhole_for_carmount_screw_head = 7;
    mount_screw_thrust_thickness = 3;   // thickess between top of "cavity" and bottom of mounting bolt

    difference() {      
        union() {
            translate([ -tt02mountbracket_X/2, 0, 0 ]) cube([ tt02mountbracket_X, tt02mountbracket_height, tt02mountbracket_thick ]);
            translate([ -tt02mountbracket_wing_span/2, (tt02mountbracket_height-tt02mountbracket_wing_thick), 0 ]) 
                cube([ tt02mountbracket_wing_span, tt02mountbracket_wing_thick, tt02mountbracket_thick ]);
        }

        // pass screw -- bottom of block
        translate([ -tt02mountbracket_carmount_screw_sep/2, -0.1, tt02mountbracket_thick/2 ]) 
            rotate([ -90, 0, 0 ]) cylinder( d=M3_throughhole_dia, h=tt02mountbracket_height + 0.2 );
        translate([  tt02mountbracket_carmount_screw_sep/2, -0.1, tt02mountbracket_thick/2 ]) 
            rotate([ -90, 0, 0 ]) cylinder( d=M3_throughhole_dia, h=tt02mountbracket_height + 0.2 );

            // small inset at bottom to help center over tt02 chassis pylons
            translate([ -tt02mountbracket_carmount_screw_sep/2, -0.1, tt02mountbracket_thick/2 ]) 
                rotate([ -90, 0, 0 ]) cylinder( d=tt02mountbracket_cavity_dia, h=tt02mountbracket_cavity_depth_deep + 0.1 );
            translate([  tt02mountbracket_carmount_screw_sep/2, -0.1, tt02mountbracket_thick/2 ]) 
                rotate([ -90, 0, 0 ]) cylinder( d=tt02mountbracket_cavity_dia, h=tt02mountbracket_cavity_depth_deep + 0.1 );

            // large diameter tunnel to pass mount screw
            translate([ -tt02mountbracket_carmount_screw_sep/2, (mount_screw_thrust_thickness+tt02mountbracket_cavity_depth_deep), tt02mountbracket_thick/2 ]) 
                rotate([ -90, 0, 0 ]) cylinder( d=dia_passhole_for_carmount_screw_head, h=tt02mountbracket_height + 0.1 );
            translate([  tt02mountbracket_carmount_screw_sep/2, (mount_screw_thrust_thickness+tt02mountbracket_cavity_depth_deep), tt02mountbracket_thick/2 ]) 
                rotate([ -90, 0, 0 ]) cylinder( d=dia_passhole_for_carmount_screw_head, h=tt02mountbracket_height + 0.1 );

            // also with deep cavity we must knock off a bit of the corner of the pillar to prevent interference with differential
            translate([ tt02mountbracket_X/2+0.1, -0.1, tt02mountbracket_thick-2 ]) rotate([ 90, 0, 180 ]) 
                prism(tt02mountbracket_X+0.2, 2.2, 4.2);

            // finally windows to facilitate access to screw
            //translate([ -(tt02mountbracket_carmount_screw_sep+6)/2, 8, -0.1 ]) cube([ tt02mountbracket_carmount_screw_sep+6, 18, tt02mountbracket_thick/2 ]);
            translate([ -((tt02mountbracket_carmount_screw_sep)/2)-(dia_passhole_for_carmount_screw_head/2), 8, -0.1 ]) 
                cube([ dia_passhole_for_carmount_screw_head, 18, tt02mountbracket_thick/2 ]);
            translate([ ((tt02mountbracket_carmount_screw_sep)/2)-(dia_passhole_for_carmount_screw_head/2), 8, -0.1 ]) 
                cube([ dia_passhole_for_carmount_screw_head, 18, tt02mountbracket_thick/2 ]);

        // these are the the holes used to mount the top plate to this pillar
        translate([ -pillars_lr_sep[chassis][0]/2, -0.1, tt02mountbracket_thick/2 ]) 
            rotate([ -90, 0, 0 ]) cylinder( d=TI30_through_hole_diameter, h=tt02mountbracket_height + 0.2 );
        translate([  pillars_lr_sep[chassis][0]/2, -0.1, tt02mountbracket_thick/2 ]) 
            rotate([ -90, 0, 0 ]) cylinder( d=TI30_through_hole_diameter, h=tt02mountbracket_height + 0.2 );    
    }        
}

/*
 * terminal block "mount"
 * note this makes a small plate that can be added to design to show where block goes
 * but mostly it makes the mounting holes.  note that for this part the 
 * holes extend 6mm above and below the plate to accomodate usage variations
 */
module component_terminal_block_2to4(mode="holes") {
    block_long = (1.65 * 25.4);
    block_wide4 = (1.02 * 25.4);
    block_wide2 = (0.55 * 25.4);
    mount_sep = (0.78 * 25.4);
    mounts_from_edge = (1.02 * 25.4);

    if (mode == "adds") {
        roundedbox(block_long, block_wide4, 2, 1);
    }

    if (mode == "holes") {
        translate([ -(block_long/2) + mounts_from_edge, (mount_sep/2), -6 ]) cylinder(d=M3_throughhole_dia, h=12);
        translate([ -(block_long/2) + mounts_from_edge, -(mount_sep/2), -6 ]) cylinder(d=M3_throughhole_dia, h=12);
    }
}

pwr_panel_tall = 40;
pwr_panel_extra_height = 10;
pwr_panel_extension_width = 75;
pwr_panel_tall_dualfuse = pwr_panel_tall + pwr_panel_extra_height;

/*
 * part_hanging_power_hub() generates a hanging sidewall with power components
 */

module part_hanging_power_hub() {
    panel_wide = pwrhub_mount_sep + 20;
    panel_thick = 3;
    body_lip_width = 15;     

    centerline_for_tmnblk = (pwr_panel_tall/2) - 4;
    centerline_for_switches = pwr_panel_tall/2;
    centerline_for_fuse = 3;

    // pwrhub_mount_sep = 120;  // (this now in mainline)

    difference() {
        union() {
            translate([ -panel_wide/2, 0, pwr_panel_tall-panel_thick ]) cube([ panel_wide, body_lip_width, panel_thick ]);
            translate([ -panel_wide/2, 0, 0 ]) cube([ panel_wide, panel_thick, pwr_panel_tall ]);
            translate([ 48, panel_thick+1, centerline_for_tmnblk ]) rotate([ 90, 0, 0 ]) component_terminal_block_2to4("adds");
            translate([ -45, panel_thick+1, centerline_for_tmnblk ]) rotate([ 90, 0, 0 ]) roundedbox(37, 32, 2, 1); // for ESC

            // tubes for mounting holes (threaded inserts)
            translate([ pwrhub_mount_sep/2, body_lip_width/2, pwr_panel_tall-7 ]) cylinder(d=TI30_mount_diameter, h=7);
            translate([ -pwrhub_mount_sep/2, body_lip_width/2, pwr_panel_tall-7 ]) cylinder(d=TI30_mount_diameter, h=7);
        }
        translate([ 48, panel_thick+1, centerline_for_tmnblk ]) rotate([ 90, 0, 0 ]) component_terminal_block_2to4("holes");


        if (switch == "Toggle Switch (notch up)") {
            translate([ -10, 0, centerline_for_switches ]) rotate([ 90, 0, 180 ]) component_mini_toggle_switch("holes");
            translate([ +10, 0, centerline_for_switches ]) rotate([ 90, 0, 180 ]) component_mini_toggle_switch("holes");
        } else if (switch == "Toggle Switch (notch down)") {
            translate([ -10, 0+panel_thick, centerline_for_switches ]) rotate([ -90, 0, 180 ]) component_mini_toggle_switch("holes");
            translate([ +10, 0+panel_thick, centerline_for_switches ]) rotate([ -90, 0, 180 ]) component_mini_toggle_switch("holes");
        } else {
            translate([ +10, 0, centerline_for_switches+2 ]) rotate([ -90, 90, 0 ]) component_boat_rocker_switch("holes");
            translate([ -10, 0, centerline_for_switches+2 ]) rotate([ -90, 90, 0 ]) component_boat_rocker_switch("holes");
        }

        // hole for fuseblock
        translate([ 0, 0, centerline_for_fuse ]) rotate([ -90, 0, 0 ]) hole_for_fuseblock();

        // mounting holes
        translate([ pwrhub_mount_sep/2, body_lip_width/2, pwr_panel_tall-7.1 ]) cylinder(d=TI30_through_hole_diameter, h=7.2);
        translate([ -pwrhub_mount_sep/2, body_lip_width/2, pwr_panel_tall-7.1 ]) cylinder(d=TI30_through_hole_diameter, h=7.2);
    }

    // add the fuseblock
    translate([ 0, 0+panel_thick, centerline_for_fuse ]) rotate([ -90, 0, 0 ]) fuse_holder_block();
}


/*
 * part_hanging_power_hub_2fuses() generates a hanging sidewall with 2 fuses
 * and wago 5-terminal block for ground wires, plus switches and fuses.
 * it has a shortened front hanging section so that it will clear the front wheels
 * when steering
 */

module part_hanging_power_hub_2fuses() {

    //panel_wide = pwrhub_mount_sep + 20;
    mountbracket_wide = pwrhub_mount_sep + 20;
    panel_wide = 120;
    panel_thick = 3;
    body_lip_width = 15;     

    centerline_for_tmnblk = (pwr_panel_tall/2) - 4 + pwr_panel_extra_height;
    centerline_for_switches = (pwr_panel_tall/2) + pwr_panel_extra_height;
    centerline_for_fuse = 3;

    difference() {
        union() {
            translate([ -mountbracket_wide/2, 0, pwr_panel_tall_dualfuse-panel_thick ]) cube([ mountbracket_wide, body_lip_width, panel_thick ]);

            if (pwrhub_side == "right") {
            translate([ -(mountbracket_wide/2), 0, pwr_panel_extra_height ]) 
                cube([ panel_wide, panel_thick, pwr_panel_tall ]);
                translate([ 38, panel_thick+1, centerline_for_tmnblk ]) rotate([ 90, 0, 0 ]) color([1,0,0]) roundedbox(20, 30, 2, 1); // for Wago
                translate([ -50, panel_thick+1, centerline_for_tmnblk ]) rotate([ 90, 0, 0 ]) color([1,0,0]) roundedbox(37, 32, 2, 1); // for ESC
            } else {
            translate([ (mountbracket_wide/2) - panel_wide, 0, pwr_panel_extra_height ]) 
                cube([ panel_wide, panel_thick, pwr_panel_tall ]);
                translate([ -38, panel_thick+1, centerline_for_tmnblk ]) rotate([ 90, 0, 0 ]) color([1,0,0]) roundedbox(20, 30, 2, 1); // for Wago
                translate([ +50, panel_thick+1, centerline_for_tmnblk ]) rotate([ 90, 0, 0 ]) color([1,0,0]) roundedbox(37, 32, 2, 1); // for ESC
            }

            translate([ -pwr_panel_extension_width/2, 0, 0 ]) cube([ pwr_panel_extension_width, panel_thick, pwr_panel_extra_height ]);
        }    

        if (switch == "Toggle Switch (notch up)") {
            translate([ -15, 0, centerline_for_switches ]) rotate([ 90, 0, 180 ]) component_mini_toggle_switch("holes");
            translate([ +5, 0, centerline_for_switches ]) rotate([ 90, 0, 180 ]) component_mini_toggle_switch("holes");
        } else if (switch == "Toggle Switch (notch down)") {
            translate([ -15, 0+panel_thick, centerline_for_switches ]) rotate([ -90, 0, 180 ]) component_mini_toggle_switch("holes");
            translate([ +5, 0+panel_thick, centerline_for_switches ]) rotate([ -90, 0, 180 ]) component_mini_toggle_switch("holes");
        } else {
            translate([ +5, 0, centerline_for_switches+2 ]) rotate([ -90, 90, 0 ]) component_boat_rocker_switch("holes");
            translate([ -15, 0, centerline_for_switches+2 ]) rotate([ -90, 90, 0 ]) component_boat_rocker_switch("holes");
        }


        // holes for fuseblocks
        translate([ -15, 0, centerline_for_fuse ]) rotate([ -90, 0, 0 ]) hole_for_fuseblock();
        translate([ 20, 0, centerline_for_fuse ]) rotate([ -90, 0, 0 ]) hole_for_fuseblock();

        // mounting holes
        translate([ pwrhub_mount_sep/2, body_lip_width/2, pwr_panel_tall_dualfuse-7.1 ]) cylinder(d=TI30_through_hole_diameter, h=7.2);
        translate([ -pwrhub_mount_sep/2, body_lip_width/2, pwr_panel_tall_dualfuse-7.1 ]) cylinder(d=TI30_through_hole_diameter, h=7.2);
    }

    // add the fuseblocks
    translate([ -15, 0+panel_thick, centerline_for_fuse ]) rotate([ -90, 0, 0 ]) fuse_holder_block();
    translate([ 20, 0+panel_thick, centerline_for_fuse ]) rotate([ -90, 0, 0 ]) fuse_holder_block();
}



/* 
 * component_dukedoks_front_stub()
 * note this is returned centered on y axis,
 * but positioned so left edge (the "back" edge) is at -20mm (so it can be placed at the edge of chassis plate)
 */
module component_dukedoks_front_stub(stub_thick = 4) {
    mount_sep_x = 6;
    mount_sep_y = 54;

    stub_width = 64;
    stub_length = 100;
    first_hole_from_front = 11;

    front_hole_x = (stub_length/2) - first_hole_from_front;

    translate([ (stub_length/2) - 20, 0, 0 ])
        difference() {
            roundedbox(stub_length, stub_width, 6, stub_thick);
            translate([ front_hole_x, mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x, -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);

            translate([ front_hole_x-(1*mount_sep_x), mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x-(1*mount_sep_x), -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);

            translate([ front_hole_x-(2*mount_sep_x), mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x-(2*mount_sep_x), -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);

            translate([ front_hole_x-(3*mount_sep_x), mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x-(3*mount_sep_x), -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);

            translate([ front_hole_x-(4*mount_sep_x), mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x-(4*mount_sep_x), -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);

            translate([ front_hole_x-(5*mount_sep_x), mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x-(5*mount_sep_x), -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);

            translate([ front_hole_x-(6*mount_sep_x), mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x-(6*mount_sep_x), -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);

            translate([ front_hole_x-(7*mount_sep_x), mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x-(7*mount_sep_x), -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);

            translate([ front_hole_x-(8*mount_sep_x), mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
            translate([ front_hole_x-(8*mount_sep_x), -mount_sep_y/2, -0.1 ]) cylinder(d=M3_throughhole_dia, h=stub_thick+0.2);
        }
}

// flex mount screw separation for back stub
flex_mount_sep_y_back = 45;
flex_mount_sep_y_front = 55;
riser_x = 12;
riser_y = flex_mount_sep_y_front + 12;


// note this is returned centered on y axis, 
// but positioned so right edge (the "forward" edge) is at +20mm (so it can be placed at the edge of chassis plate)
module component_dukedoks_back_stub(mode="adds", stub_thick = 4) {
    flex_mount_sep_x = 92;
    riser_lift = 3.5;
    riser_x = 12;
    riser_y = flex_mount_sep_y_front + 12;

    stub_width = 80;
    stub_length = 110;
    first_hole_from_back = 6;

    inner_insets_sep_y = 56;
    inner_insets_sep_x = 52;
    inner_insets_from_back = 26;

    outer_insets_sep_y = 72;
    outer_insets_sep_x = 48;
    outer_insets_from_back = 26;

    inset_x = 11;
    inset_y = 6;
    inset_depth = 2;

    back_hole_x = -(stub_length/2) + first_hole_from_back;
    back_inner_inset_x = -(stub_length/2) + inner_insets_from_back;
    back_outer_inset_x = -(stub_length/2) + outer_insets_from_back;

    
    if (mode == "adds") {
        translate([ -(stub_length/2)+20, 0, 0 ]) union() {
            roundedbox(stub_length, stub_width, 6, stub_thick);

            // lifted parts for flex mount
            translate([ back_hole_x, 0, stub_thick ]) roundedbox( riser_x, riser_y, 3, riser_lift);
            translate([ back_hole_x + flex_mount_sep_x, 0, stub_thick ]) roundedbox( riser_x, riser_y, 3, riser_lift);
        }
    }

    if (mode == "holes") {            
        translate([ -(stub_length/2)+20, 0, 0 ]) union() {
            translate([ back_hole_x, flex_mount_sep_y_back/2, -0.1 ]) 
                cylinder(d=M3_throughhole_dia, h=stub_thick+riser_lift+0.2);
            translate([ back_hole_x, -flex_mount_sep_y_back/2, -0.1 ]) 
                cylinder(d=M3_throughhole_dia, h=stub_thick+riser_lift+0.2);

            translate([ back_hole_x + flex_mount_sep_x, flex_mount_sep_y_front/2, -0.1 ]) 
                cylinder(d=M3_throughhole_dia, h=stub_thick+riser_lift+0.2);
            translate([ back_hole_x + flex_mount_sep_x, -flex_mount_sep_y_front/2, -0.1 ]) 
                cylinder(d=M3_throughhole_dia, h=stub_thick+riser_lift+0.2);

            // inner insets
            translate([ (back_inner_inset_x), (inner_insets_sep_y/2), (stub_thick-inset_depth) ]) 
                roundedbox( inset_x, inset_y, 1, inset_depth+0.1);
            translate([ (back_inner_inset_x), -(inner_insets_sep_y/2), (stub_thick-inset_depth) ]) 
                roundedbox( inset_x, inset_y, 1, inset_depth+0.1);

            translate([ (back_inner_inset_x+inner_insets_sep_x), (inner_insets_sep_y/2), (stub_thick-inset_depth) ]) 
                roundedbox( inset_x, inset_y, 1, inset_depth+0.1);
            translate([ (back_inner_inset_x+inner_insets_sep_x), -(inner_insets_sep_y/2), (stub_thick-inset_depth) ]) 
                roundedbox( inset_x, inset_y, 1, inset_depth+0.1);

            // outer insets 
            translate([ (back_outer_inset_x), (outer_insets_sep_y/2), (stub_thick-inset_depth) ]) 
                roundedbox( inset_x, inset_y, 1, inset_depth+0.1);
            translate([ (back_outer_inset_x), -(outer_insets_sep_y/2), (stub_thick-inset_depth) ]) 
                roundedbox( inset_x, inset_y, 1, inset_depth+0.1);

            translate([ (back_outer_inset_x+outer_insets_sep_x), (outer_insets_sep_y/2), (stub_thick-inset_depth) ]) 
                roundedbox( inset_x, inset_y, 1, inset_depth+0.1);
            translate([ (back_outer_inset_x+outer_insets_sep_x), -(outer_insets_sep_y/2), (stub_thick-inset_depth) ]) 
                roundedbox( inset_x, inset_y, 1, inset_depth+0.1);

        }
    }
}

module part_back_flex_clamp() {
    difference() {
        roundedbox(riser_x, flex_mount_sep_y_back + 10, 2, 4);
        translate([ 0, (flex_mount_sep_y_back/2), -0.1 ]) cylinder(d=M3_throughhole_dia, h=4);
        translate([ 0, -(flex_mount_sep_y_back/2), -0.1 ]) cylinder(d=M3_throughhole_dia, h=4);
        translate([ 0, (flex_mount_sep_y_back/2), 2 ]) rotate([ 0, 0, 90 ]) make_m3_hex_nut();
        translate([ 0, -(flex_mount_sep_y_back/2), 2 ]) rotate([ 0, 0, 90 ]) make_m3_hex_nut();
    }

}
module part_front_flex_clamp() {
    difference() {
        roundedbox(riser_x, flex_mount_sep_y_front + 8, 2, 4);
        translate([ 0, (flex_mount_sep_y_front/2), -0.1 ]) cylinder(d=M3_throughhole_dia, h=4);
        translate([ 0, -(flex_mount_sep_y_front/2), -0.1 ]) cylinder(d=M3_throughhole_dia, h=4);
        translate([ 0, (flex_mount_sep_y_front/2), 2 ]) rotate([ 0, 0, 90 ]) make_m3_hex_nut();
        translate([ 0, -(flex_mount_sep_y_front/2), 2 ]) rotate([ 0, 0, 90 ]) make_m3_hex_nut();
    }

}

// this generates a part which is the "hole" that should be subtracted
// from a body to hold a servo horn for MG996 servo
// (note that this one makes through holes for the center axle and attachment screws)
// (it is assumed that the horn would be "behind" a wall and the axle sticks through
//     with the servo itself on the "other" side of the wall)
//     note also that this makes holes for a 2-ended full horn)
//
// this is generated with axle at origin, with holes on xy plane and 
// pocket starting 1.5mm (pocket_bottom_z) above them. the arm extends in +x direction
module component_horn996_thru_holes(body_thick = 3) {
    $fn = 24;
    servo_axle_x = 0;
    horn_shaft_dia = 9;
    hole1_sep_x = 21;
    hole2_sep_x = 33;

    translate([ 0, 0, -0.1 ]) cylinder( d=horn_shaft_dia, h=body_thick + 0.2 );

    translate([ hole1_sep_x/2, 0, -0.1 ]) cylinder( d=M2_throughhole_dia, h=body_thick + 0.2);
    translate([ -hole1_sep_x/2, 0, -0.1 ]) cylinder( d=M2_throughhole_dia, h=body_thick + 0.2);

    translate([ hole2_sep_x/2, 0, -0.1 ]) cylinder( d=M2_throughhole_dia, h=body_thick + 0.2);
    translate([ -hole2_sep_x/2, 0, -0.1 ]) cylinder( d=M2_throughhole_dia, h=body_thick + 0.2);
}



// @parameter direction = "LC" for left / center bins, "R" for right side bin
module draw_door_catch(direction="LC") {
    $fn = 24;
    arm_w = 10;
    arm_thick = 3;
    servo_axle_x = 5;
    horn_shaft_dia = 8;
    pocket_bottom_z = 1.5;
    pocket_axle_to_end_x = 18;
    pocket_width = 6;
    catch_from_axle = 25;
    catch_width = 5;
    catch_length = 20;
    arm_l = servo_axle_x + catch_from_axle + catch_width;
    hole1_x = 6.5;
    hole2_x = 13.0;

    difference() {
        union() {
            translate([ -servo_axle_x, -arm_w/2, 0 ])  cube([ arm_l, arm_w, arm_thick ]);
            if (direction == "LC") {
                translate([ catch_from_axle, -arm_w/2, 0 ]) cube([ catch_width, catch_length, arm_thick ]);
            } else {
                translate([ catch_from_axle, ((arm_w/2) - catch_length), 0 ]) cube([ catch_width, catch_length, arm_thick ]);
            }
       }
       translate([ 0, 0, -0.1 ]) cylinder( d=M3_throughhole_dia, h=arm_thick + 0.2 );
       translate([ 0, 0, pocket_bottom_z ]) cylinder( d=horn_shaft_dia, h=arm_thick );
       translate([ 0, -pocket_width/2, pocket_bottom_z]) 
            cube([ pocket_axle_to_end_x, pocket_width, arm_thick ]);
        translate([ hole1_x, 0, -0.1 ]) cylinder( d=M2_throughhole_dia, h=arm_thick + 0.2);
        translate([ hole2_x, 0, -0.1 ]) cylinder( d=M2_throughhole_dia, h=arm_thick + 0.2);
    }
}
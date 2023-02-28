/*
 * Module: components_camrera_rollbar.scad  holds modules which generate
 *   camera mount pillars, handles, rollbar arches as used in DonKCar 
 *   racer projects
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

// global parameters for rollbar / handle
handle_radius = 52;
handle_mount_thick = 12;
handle_height_above_base = 115;
handle_mount_lift = 10;      // distance from handle mount bottom to actual handle bottom
handle_mount_behind_pillar_center = 37;

dbl_rb_mount_sep  = 32;
dbl_rb_mount_lift = 8; 
ctr_rb_mount_lift = 18; 

arch_inner_dia = arch_mount_width - 8;    
arch_outer_dia = arch_mount_width + 8;
arch_leg_length = handle_height_above_base - (arch_inner_dia/2);

arch_thickness = 25;
arch_tft_lift = arch_thickness - 10;  // should be close enough to front to allow access to SD card
arch_tft_below_peak = 12;  

module component_pillar(myText, wantSlot=false) {
    difference() {
        roundedbox(80, 48, 3, 3);
        translate([ -32, -16, -0.1 ]) cylinder(d=M3_throughhole_dia, 3.2 );
        translate([ -32,  16, -0.1 ]) cylinder(d=M3_throughhole_dia, 3.2 );
        translate([  32, -16, -0.1 ]) cylinder(d=M3_throughhole_dia, 3.2 );
        translate([  32,  16, -0.1 ]) cylinder(d=M3_throughhole_dia, 3.2 );
    }

    translate([ 0, 0, 2 ]) rotate([ 15, 0, 0 ])
        difference() {
            roundedbox(55, 15, 3, 120);

            if (wantSlot) {
                translate([ 0, 8, 80 ]) rotate([ 90, 0, 0 ]) roundedbox( 25, 6, 2, 16);
            }
            if (cameraPillarAccessory == "RPi Cam") {
                translate([ 0, 8, 10 ]) rotate([ 90, 0, 0 ]) roundedbox( 25, 6, 2, 16);
            }
        }

    translate([0, 19, 2]) rotate([ 0, 0, 180 ]) linear_extrude(2) text(myText, 
        size=6,  halign="center", font = "Liberation Sans:style=Bold");
}

module component_openmv_mount() {
    base_thickness = 8;
    mount_height = 4;
    camera_mount_sep_x = 30;  // distance between mount holes
    camera_mount_offset = 18; // distance of holes from longway center of camera

    difference() {
        union() {
            roundedbox(44, 55, 3, base_thickness);
            translate([ 0, 8, 0 ]) roundedbox(10, 60, 3, (base_thickness+mount_height));

            translate([ -(camera_mount_sep_x/2), +camera_mount_offset, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));
            translate([ +(camera_mount_sep_x/2), +camera_mount_offset, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));
        }
        translate([ -(camera_mount_sep_x/2), +camera_mount_offset, -0.1 ]) 
            cylinder(d=TI25_through_hole_diameter, h=(base_thickness+mount_height+0.2));
        translate([ +(camera_mount_sep_x/2), +camera_mount_offset, -0.1 ]) 
            cylinder(d=TI25_through_hole_diameter, h=(base_thickness+mount_height+0.2));
    }
    translate([ -16, -6, 7]) rotate([ 0, 0, -90 ]) linear_extrude(2) text("OpenMV", 
        size=6,  halign="center", font = "Liberation Sans:style=Bold");
    translate([ 16, -6, 7]) rotate([ 0, 0, 90 ]) linear_extrude(2) text("M2.5", 
        size=6,  halign="center", font = "Liberation Sans:style=Bold");
}

module component_rpicam_mount() {
    base_thickness = 8;
    mount_height = 4;
    camera_mount_sep_x = 21;  // distance between mount holes
    camera_mount_sep_y = 13;  // distance between mount holes

    difference() {
        union() {
            roundedbox(44, 36, 3, base_thickness);

            translate([ -(camera_mount_sep_x/2), +camera_mount_sep_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));
            translate([ +(camera_mount_sep_x/2), +camera_mount_sep_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));

            translate([ -(camera_mount_sep_x/2), -camera_mount_sep_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));
            translate([ +(camera_mount_sep_x/2), -camera_mount_sep_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));

            translate([0, 17, base_thickness]) rotate([ 0, 0, 180 ]) linear_extrude(1) text("M2", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, -11, base_thickness]) rotate([ 0, 0, 180 ]) linear_extrude(1) text("RPi Cam", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
        }
        translate([ -(camera_mount_sep_x/2), +camera_mount_sep_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
        translate([ +(camera_mount_sep_x/2), +camera_mount_sep_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));

        translate([ -(camera_mount_sep_x/2), -camera_mount_sep_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
        translate([ +(camera_mount_sep_x/2), -camera_mount_sep_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
    }
}


module component_smallmint_mount_vertical() {
    base_thickness = 8;
    mount_height = 4;
    board_smallmintproto_screw_y = 45.5;
    board_smallmintproto_screw_x = 25.4;    

    difference() {
        union() {
            roundedbox(38, 60, 3, base_thickness);

            translate([ -(board_smallmintproto_screw_x/2), +board_smallmintproto_screw_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));
            translate([ +(board_smallmintproto_screw_x/2), +board_smallmintproto_screw_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));

            translate([ -(board_smallmintproto_screw_x/2), -board_smallmintproto_screw_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));
            translate([ +(board_smallmintproto_screw_x/2), -board_smallmintproto_screw_y/2, base_thickness ]) 
                cylinder(d1=12, d2=7, h=(mount_height));

            translate([0, -8, base_thickness]) rotate([ 0, 0, 180 ]) linear_extrude(1) text("Small", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, 1, base_thickness]) rotate([ 0, 0, 180 ]) linear_extrude(1) text("Mint", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, 10, base_thickness]) rotate([ 0, 0, 180 ]) linear_extrude(1) text("Proto", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, 19, base_thickness]) rotate([ 0, 0, 180 ]) linear_extrude(1) text("M3", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
        }
        translate([ -(board_smallmintproto_screw_x/2), +board_smallmintproto_screw_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
        translate([ +(board_smallmintproto_screw_x/2), +board_smallmintproto_screw_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));

        translate([ -(board_smallmintproto_screw_x/2), -board_smallmintproto_screw_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
        translate([ +(board_smallmintproto_screw_x/2), -board_smallmintproto_screw_y/2, -0.1 ]) 
            cylinder(d=TI20_through_hole_diameter, h=(base_thickness+mount_height+0.2));
    }
}

module component_front_rollbar_mount() {
    $fn = 64;
    translate([ 0, 0, handle_mount_lift ]) rotate([ -90, 0, 0 ])
        union() {
            translate ([ -handle_radius/2, 0, 0 ]) cube([ handle_radius, handle_mount_lift, handle_mount_thick ]);
            translate([ 0, 0, 0 ]) rotate([ 0, 0, 0 ]) difference() {
                cylinder( d= handle_radius, h=handle_mount_thick);
                translate([ -handle_radius/2, 0, -0.1 ]) cube([ handle_radius, handle_radius/2, handle_mount_thick+0.2 ]); 
                translate([ -dbl_rb_mount_sep/2, -dbl_rb_mount_lift, -0.1 ]) cylinder(d=4, h=handle_mount_thick+0.2); 
                translate([ +dbl_rb_mount_sep/2, -dbl_rb_mount_lift, -0.1 ]) cylinder(d=4, h=handle_mount_thick+0.2); 
                translate([ 0, -ctr_rb_mount_lift, -0.1 ]) cylinder(d=4, h=handle_mount_thick+0.2); 
            }
        }

}

module part_handle(length) { 
        $fn = 64;
        union() {
            translate([ 0, 0, 0 ]) rotate([ -90, 0, 0 ]) difference() {
                cylinder( d= handle_radius, h=length);
                translate([ -handle_radius/2, 0, -0.1 ]) cube([ handle_radius, handle_radius/2, length+0.2 ]); 

                translate([ -dbl_rb_mount_sep/2, -dbl_rb_mount_lift, -0.1 ]) cylinder(d=TI30_through_hole_diameter, h=9.2); 
                translate([ +dbl_rb_mount_sep/2, -dbl_rb_mount_lift, -0.1 ]) cylinder(d=TI30_through_hole_diameter, h=9.2); 
                translate([ 0, -ctr_rb_mount_lift, -0.1 ]) cylinder(d=TI30_through_hole_diameter, h=9.2);  

                translate([ -dbl_rb_mount_sep/2, -dbl_rb_mount_lift, length-9 ]) cylinder(d=TI30_through_hole_diameter, h=9.2); 
                translate([ +dbl_rb_mount_sep/2, -dbl_rb_mount_lift, length-9 ]) cylinder(d=TI30_through_hole_diameter, h=9.2); 
                translate([ 0, -ctr_rb_mount_lift, length-9 ]) cylinder(d=4, h=9.2); 
            }
        }
}

module part_back_arch(wantTFT=false) {
    $fn = 64;

    mount_offset_x = (arch_inner_dia/2) + (arch_outer_dia - arch_inner_dia)/4;
    tft_plate_x = 50;
    tft_plate_y = 50;
    
    difference() {
        union() {
            // this much makes the half-circle arch part
            difference() {
                difference() {
                    cylinder(d=arch_outer_dia, h=arch_thickness);
                    translate([ 0, 0, -0.1]) cylinder(d=arch_inner_dia, h=arch_thickness+0.2);
                }
                translate([ -(arch_outer_dia/2)-0.1, -(arch_outer_dia+0.2), -0.1 ])
                    cube([ arch_outer_dia+0.2, arch_outer_dia+0.2, arch_thickness+0.2 ]);
            }

            translate([ 0, arch_inner_dia/2, handle_mount_thick ]) rotate([ -90, 0, 0 ]) component_front_rollbar_mount();

            translate([ arch_inner_dia/2, -arch_leg_length, 0 ])
                cube([ (arch_outer_dia-arch_inner_dia)/2, arch_leg_length, arch_thickness ]);
            translate([ -arch_outer_dia/2, -arch_leg_length, 0 ])
                cube([ (arch_outer_dia-arch_inner_dia)/2, arch_leg_length, arch_thickness ]);
        }

        // mount holes (mount rollbar to chassis plate)
        translate([ mount_offset_x, -arch_leg_length-0.1, 5 ]) rotate([ -90, 0, 0 ])
            cylinder( d=TI30_through_hole_diameter, h=9);
        translate([ -mount_offset_x, -arch_leg_length-0.1, 5 ]) rotate([ -90, 0, 0 ])
            cylinder( d=TI30_through_hole_diameter, h=9);
        translate([ mount_offset_x, -arch_leg_length-0.1, arch_thickness-5 ]) rotate([ -90, 0, 0 ])
            cylinder( d=TI30_through_hole_diameter, h=9);
        translate([ -mount_offset_x, -arch_leg_length-0.1, arch_thickness-5 ]) rotate([ -90, 0, 0 ])
            cylinder( d=TI30_through_hole_diameter, h=9);
    }

    if (wantTFT) {
        translate([ 0, (arch_inner_dia/2)-arch_tft_below_peak-(tft_plate_y/2), arch_tft_lift ]) 
            part_1x54_TFT_flat_mount_plate(); 
        translate([ 0, (arch_inner_dia/2)-((tft_plate_y/2)+(arch_tft_below_peak/2) ), 0 ]) 
            roundedbox( tft_plate_x, (tft_plate_y+arch_tft_below_peak), 2, arch_tft_lift );
    }

    //if ((wantLogo == "arch") || (wantLogo == "split")) {
    //    translate([ 0, (arch_outer_dia/2)+1, handle_mount_thick ])  
    //        linear_extrude(1) text(carIdent, size=6, halign="center");
    //}
}

/*
 * note it is (handle_mount_behind_pillar_center) mm  from the center of the pillar mount to the surface
 * of the handle mount plate (by default, this is 37 mm).
 * for a standard arch, its center is (arch_thickness/2) (typ 12.5) from its forward handle-mount surface
 * so when designing chassis with pillar and a standard arch, the handle length is
 * (distance between mount centers (arch, pillar)) - handle_mount_behind_pillar_center - (arch_thickness/2)
 */
module part_openmv_pillar(wantRollbar=false) {
    $fn = 64;  
    component_pillar(str("Cam ", cameraDownAngle, " deg"), false);

    if (wantRollbar) {
        translate([ 0, -handle_mount_behind_pillar_center, handle_height_above_base ]) component_front_rollbar_mount();
    }

    // mount for openMV cam
    if (cameraDownAngle == 5) {
        translate([ 0, -17, 101 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_openmv_mount();
    }
    if (cameraDownAngle == 10) {
        translate([ 0, -14, 101 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_openmv_mount();
    }
    if (cameraDownAngle == 12) {
        translate([ 0, -13, 101 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_openmv_mount();
    }
    if (cameraDownAngle == 15) {
        translate([ 0, -11, 101 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_openmv_mount();
    }
    if (cameraDownAngle == 17) {
        translate([ 0, -10, 101 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_openmv_mount();
    }

    // mount bracket for accessory (typically esp32cam OpenMVcam or RPicam for viewing or obstacle avoidance) 
    if (cameraPillarAccessory == "OpenMV Cam") {
        translate([ 0, -2, 38 ]) rotate([ -90, 0, 0 ]) component_openmv_mount();
    }
    if (cameraPillarAccessory == "RPi Cam") {
        translate([ 0, -5, 38 ]) rotate([ -90, 0, 0 ]) component_rpicam_mount();
    }
    if (cameraPillarAccessory == "SmallMint Proto") {
        translate([ 0, -2, 38 ]) rotate([ -90, 0, 0 ]) component_smallmint_mount_vertical();
    }
}

/*
 * note it is (handle_mount_behind_pillar_center) mm  from the center of the pillar mount to the surface
 * of the handle mount plate (by default, this is 37 mm).
 * for a standard arch, its center is (arch_thickness/2) (typ 12.5) from its forward handle-mount surface
 * so when designing chassis with pillar and a standard arch, the handle length is
 * (distance between mount centers (arch, pillar)) - handle_mount_behind_pillar_center - (arch_thickness/2)
 */
module part_rpi_pillar(wantRollbar=false) {
    $fn = 64;
    //component_pillar("RPI Cam", true);    
    component_pillar(str("Cam ", cameraDownAngle, " deg"), true);

    if (wantRollbar) {
        translate([ 0, -handle_mount_behind_pillar_center, handle_height_above_base ]) component_front_rollbar_mount();
    }

    // mount for rpi cam
    if (cameraDownAngle == 5) {
        translate([ 0, -22, 110 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_rpicam_mount();
    }
    if (cameraDownAngle == 10) {
        translate([ 0, -20, 110 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_rpicam_mount();
    }
    if (cameraDownAngle == 12) {
        translate([ 0, -20, 110 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_rpicam_mount();
    }
    if (cameraDownAngle == 15) {
        translate([ 0, -19, 110 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_rpicam_mount();
    }
    if (cameraDownAngle == 17) {
        translate([ 0, -19, 110 ]) rotate([ (-90-cameraDownAngle), 0, 0 ]) component_rpicam_mount();
    }

    // mount bracket for accessory (typically esp32cam OpenMVcam or RPicam for viewing or obstacle avoidance) 
    if (cameraPillarAccessory == "OpenMV Cam") {
        translate([ 0, -2, 38 ]) rotate([ -90, 0, 0 ]) component_openmv_mount();
    }
    if (cameraPillarAccessory == "RPi Cam") {
        translate([ 0, -5, 38 ]) rotate([ -90, 0, 0 ]) component_rpicam_mount();
    }
    if (cameraPillarAccessory == "SmallMint Proto") {
        translate([ 0, -2, 38 ]) rotate([ -90, 0, 0 ]) component_smallmint_mount_vertical();
    }
}

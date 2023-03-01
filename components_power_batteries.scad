/*
 * Module: components_power_batteries.scad  holds modules which generate
 *   mounting plates or boxes for common LiPo and NiMH batteries
 *   used in electronics, robotics, or RC projects
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
 *
 * ***************************************************************************************
 * 
 * Included batteries:
 * 
 * module draw_battbox_powerextra3600 draws a battery box for PowerExtra 3600 mAH 7.2v NiMH battery
 * purchase: https://www.amazon.com/Powerextra-Capacity-Connectors-Compatiable-Helicopter/dp/B06WD5VRYZ
 * 
 * module draw_battbox_zeee5200 draws a battery box for zeee 5200 mAH 7.4v LiPo battery
 * purchase: https://smile.amazon.com/dp/B0925W1BN7
 *
 * module draw_battbox_zeee2200 draws a battery box for zeee 2200 mAH 11.1v LiPo battery
 * purchase: https://www.amazon.com/Zeee-Batteries-Quadcopter-Helicopter-Multi-Motor/dp/B07CQPLC3T
 *
 * module draw_battbox_anker13000 draws a battery box for anker 13000 PowerCore USB Power Bank
 * purchase: https://www.amazon.com/gp/product/B00Z9QVE4Q
 *
 * module draw_battbox_anker6700 draws a battery box for anker 6700 USB Power Bank
 * purchase: https://www.amazon.com/Anker-PowerCore-Compact-Portable-Smartphones/dp/B07211V9XG
 *
 * module component_battbox_lipo_500_flat draws a battery box for 500 mA flat LiPo cell 3.7v
 * purchase: https://www.adafruit.com/product/1578
 *
 * module component_battbox_lipo_1200_flat draws a battery box for 1200 mA flat LiPo cell 3.7v
 * purchase: https://www.adafruit.com/product/258
 *
 * module component_battbox_lipo_2500_flat draws a battery box for 2500 mA flat LiPo cell 3.7v
 * purchase: https://www.adafruit.com/product/328
 *
 */


/*
 * **************************************************************************
 * LiPo Battery boxes (for small flatpack adafruit batteries)
 * note the _pocket version makes a pocket in the lid which you
 *   can drop the battery into; the _flat version makes an enclosure
 *   that goes on box bottom, and requires a lid.  the lid is held on
 *   by M3 bolts, self-tapped
 * **************************************************************************
 */

battbox_wall_thickness = 2;
battbox_lid_thickness = 3;

/*
 * module component_battbox_lipo_1200_flat draws a battery box for 1200 mA flat LiPo cell 3.7v
 * purchase: https://www.adafruit.com/product/258
 */

batt_lipo_1200_width = 35;
batt_lipo_1200_length = 63;
batt_lipo_1200_thick = 4.5;

module component_battbox_lipo_1200_flat(mode="holes") {
    bolt_x = ((batt_lipo_1200_width+1)/2) + 2.5;
    if (mode=="adds") {
        translate([ -(batt_lipo_1200_width+11)/2, -(batt_lipo_1200_length+6)/2, 0 ]) 
            cube([  (batt_lipo_1200_width+11), (batt_lipo_1200_length+6),batt_lipo_1200_thick]);
    }

    if (mode=="holes") {
        translate([ -(batt_lipo_1200_width+1)/2, -((batt_lipo_1200_length+6)/2)-0.1, -0.1]) 
            cube([ batt_lipo_1200_width+1, batt_lipo_1200_length+1, batt_lipo_1200_thick + 1 ]);

        translate([ -bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_1200_thick + 0.2);
        translate([  bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_1200_thick + 0.2);
        translate([ -bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_1200_thick + 0.2);
        translate([  bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_1200_thick + 0.2);
    }
}

module component_battbox_lipo_1200_flat_lid(mode="holes") {
    bolt_x = ((batt_lipo_1200_width+1)/2) + 2.5;
    difference() {
        translate([ -(batt_lipo_1200_width+11)/2, -(batt_lipo_1200_length+6)/2, 0 ]) 
            cube([  (batt_lipo_1200_width+11), (batt_lipo_1200_length+6), 2 ]);

        translate([ -bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_1200_thick + 0.2);
        translate([  bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_1200_thick + 0.2);
        translate([ -bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_1200_thick + 0.2);
        translate([  bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_1200_thick + 0.2);
    }
}

/*
 * module component_battbox_lipo_500_flat draws a battery box for 500 mA flat LiPo cell 3.7v
 * purchase: https://www.adafruit.com/product/1578
 */

batt_lipo_500_width = 30;
batt_lipo_500_length = 37;
batt_lipo_500_thick = 5.75;

module component_battbox_lipo_500_flat(mode="holes") {
    bolt_x = ((batt_lipo_500_width+1)/2) + 2.5;
    if (mode=="adds") {
        translate([ -(batt_lipo_500_width+11)/2, -(batt_lipo_500_length+6)/2, 0 ]) 
            cube([  (batt_lipo_500_width+11), (batt_lipo_500_length+6),batt_lipo_500_thick]);
    }

    if (mode=="holes") {
        translate([ -(batt_lipo_500_width+1)/2, -((batt_lipo_500_length+6)/2)-0.1, -0.1]) 
            cube([ batt_lipo_500_width+1, batt_lipo_500_length+1, batt_lipo_500_thick + 1 ]);

        translate([ -bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_500_thick + 0.2);
        translate([  bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_500_thick + 0.2);
        translate([ -bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_500_thick + 0.2);
        translate([  bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_500_thick + 0.2);
    }
}

module component_battbox_lipo_500_flat_lid(mode="holes") {
    bolt_x = ((batt_lipo_500_width+1)/2) + 2.5;
    difference() {
        translate([ -(batt_lipo_500_width+11)/2, -(batt_lipo_500_length+6)/2, 0 ]) 
            cube([  (batt_lipo_500_width+11), (batt_lipo_500_length+6), 2 ]);

        translate([ -bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_500_thick + 0.2);
        translate([  bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_500_thick + 0.2);
        translate([ -bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_500_thick + 0.2);
        translate([  bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_500_thick + 0.2);
    }
}


/*
 * module component_battbox_lipo_2500_flat draws a battery box for 2500 mA flat LiPo cell 3.7v
 * purchase: https://www.adafruit.com/product/328
 */

batt_lipo_2500_width = 51;
batt_lipo_2500_length = 61;
batt_lipo_2500_thick = 8;

module component_battbox_lipo_2500_flat(mode="holes") {
    bolt_x = ((batt_lipo_500_width+1)/2) + 2.5;
    if (mode=="adds") {
        translate([ -(batt_lipo_2500_width+11)/2, -(batt_lipo_2500_length+6)/2, 0 ]) 
            cube([  (batt_lipo_2500_width+11), (batt_lipo_2500_length+6),batt_lipo_2500_thick]);
    }

    if (mode=="holes") {
        translate([ -(batt_lipo_2500_width+1)/2, -((batt_lipo_2500_length+6)/2)-0.1, -0.1]) 
            cube([ batt_lipo_2500_width+1, batt_lipo_2500_length+1, batt_lipo_2500_thick + 1 ]);

        translate([ -bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_2500_thick + 0.2);
        translate([  bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_2500_thick + 0.2);
        translate([ -bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_2500_thick + 0.2);
        translate([  bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_selftap, h=batt_lipo_2500_thick + 0.2);
    }
}

module component_battbox_lipo_2500_flat_lid(mode="holes") {
    bolt_x = ((batt_lipo_2500_width+1)/2) + 2.5;
    difference() {
        translate([ -(batt_lipo_2500_width+11)/2, -(batt_lipo_2500_length+6)/2, 0 ]) 
            cube([  (batt_lipo_2500_width+11), (batt_lipo_2500_length+6), 2 ]);

        translate([ -bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_2500_thick + 0.2);
        translate([  bolt_x, 15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_2500_thick + 0.2);
        translate([ -bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_2500_thick + 0.2);
        translate([  bolt_x, -15, 0 ])
            cylinder( r=screwhole_radius_M30_passthru, h=batt_lipo_2500_thick + 0.2);
    }
}




/*
 **************************************************************************************************************
 **************************************************************************************************************
 * functions to build lidded boxes to hold rectanglar LiPo batteries of the
 * type typically used in RC cars; also for USB power banks
 **************************************************************************************************************
 ************************************************************************************************************** 
 */


/*
 * module draw_battbox_anker6700() draws a battery box for anker 6700 USB Power Bank
 * purchase: https://www.amazon.com/Anker-PowerCore-Compact-Portable-Smartphones/dp/B07211V9XG
 */
module draw_battbox_anker6700(lidmount="pins") {
    draw_battboxH_biglipo(43+1, 23+1, 70, 96+1, 5, lidmount);
}

module draw_battbox_anker6700_lid(batt_lid_attach="pins") {
    draw_battboxH_lid_biglipo(43+1, 70, batt_lid_attach);
}

/*
 * module draw_battbox_anker13000() draws a battery box for anker 13000 PowerCore USB Power Bank
 * purchase: https://www.amazon.com/gp/product/B00Z9QVE4Q
 */
module draw_battbox_anker13000(lidmount="pins") {
    draw_battboxH_biglipo(81+1, 23+1, 70, 97+1, 5, lidmount);
}

module draw_battbox_anker13000_lid(batt_lid_attach="pins") {
    draw_battboxH_lid_biglipo(81+1, 70, batt_lid_attach);
}


/*
 * module draw_battbox_zeee2200() draws a battery box for zeee 2200 mAH 11.1v LiPo battery
 * purchase: https://www.amazon.com/Zeee-Batteries-Quadcopter-Helicopter-Multi-Motor/dp/B07CQPLC3T
 */

module draw_battbox_zeee2200(lidmount="pins") {
    draw_battboxH_biglipo(35+1, 25+1, 70, 105, 5, lidmount);
}

module draw_battbox_zeee2200_lid(batt_lid_attach="pins") {
    draw_battboxH_lid_biglipo(35+1, 70, batt_lid_attach);
}


/*
 * module draw_battbox_zeee5200() draws a battery box for zeee 5200 mAH 7.4v LiPo battery
 * purchase: https://smile.amazon.com/dp/B0925W1BN7
 */

module draw_battbox_zeee5200(lidmount="pins") {
    draw_battboxH_biglipo(47+1, 25+1, 100, 139, 5, lidmount="pins");
}

module draw_battbox_zeee5200_lid(batt_lid_attach="pins") {
    draw_battboxH_lid_biglipo(47+1, 100, batt_lid_attach);
}


/*
 * module draw_battbox_urgenex2000() draws a battery box for urgenex 2000 mAH 7.4v LiPo battery
 * purchase: https://www.amazon.com/URGENEX-Battery-Capacity-Batteries-Chargers/dp/B08XZP4CDJ
 * (or many similar 2 cell side-by-side LiPo)
 */

module draw_battbox_urgenex2000(lidmount="pins") {
    draw_battboxH_biglipo(37+1, 18+1, 55, 70, 8, lidmount="pins");
}

module draw_battbox_urgenex2000_lid(batt_lid_attach="pins") {
    draw_battboxH_lid_biglipo(37+1, 55, batt_lid_attach);
}


/*
 * module draw_battbox_powerextra3600() draws a battery box for PowerExtra 3600 mAH 7.2v NiMH battery
 * purchase: https://www.amazon.com/Powerextra-Capacity-Connectors-Compatiable-Helicopter/dp/B06WD5VRYZ
 */

module draw_battbox_powerextra3600(, lidmount="pins") {
    draw_battboxH_biglipo(47+1, 22+1, 130, 135, 5, lidmount);
}

module draw_battbox_powerextra3600_lid(batt_lid_attach="pins") {
    draw_battboxH_lid_biglipo(47+1, 130, batt_lid_attach);
}

/*
 * module draw_battbox_nimh2200_72() draws a battery box for 6-cell 7.2v 2200 mAH NiMh battery
 * purchase: https://www.amazon.com/Blomiky-2200mAh-Rechargeable-Battery-Excavator/dp/B07Q2H4X1J/
 */

module draw_battbox_nimh2200_72(lidmount="pins") {
    draw_battboxH_biglipo(50.5+1, 14.5+1, 75, 85, 6, lidmount="pins");
}

module draw_battbox_nimh2200_72_lid(batt_lid_attach="pins") {
    draw_battboxH_lid_biglipo(50.5+1, 55, batt_lid_attach);
}

/*
 * module draw_battbox_biglipo() draws a battery box of specified size, typically for LiPo rectangular RC batteries
 * batt_x and batt_y are basic battery dimensions; clip_distance is full length of battery
 * which determines where restraining clip lives;  box_len is box length, which may be shorter
 * than clip_distance
 * if clip_tall is -1 (or omitted), it is half the height of the battery
 * if lidmount is "pins" it makes pins for RC Clip pins, if "bolts" it generates holes for M3 threaded inserts
 */
module draw_battboxH_biglipo(batt_width, batt_thick, box_len, clip_distance, clip_tall= -1, lidmount="pins") {
    bottom_thick = 5;
    wall_thick = 2;
    clip_thick = 2;
    clip_width = 15;
    outerwidth  = batt_width + (2*wall_thick);
    centerline = outerwidth / 2;

    difference() {
        union() {
            cube([ (box_len + wall_thick), outerwidth,  batt_thick + bottom_thick ]);  
            translate([ wall_thick, centerline - (clip_width/2), 0 ]) 
                cube([ (clip_distance), clip_width,  bottom_thick ]);
            if (clip_tall < 0) {
                translate([ (clip_distance + wall_thick), centerline - (clip_width/2), 0 ]) 
                cube([ 2, clip_width,  ((batt_thick/2) + bottom_thick) ]); 
            } else {
                translate([ (clip_distance + wall_thick), centerline - (clip_width/2), 0 ]) 
                cube([ 2, clip_width,  (clip_tall + bottom_thick) ]); 
            }
        }
        translate([ wall_thick, wall_thick, bottom_thick ]) cube([ box_len+0.1, batt_width, batt_thick+0.1 ]);  

        // mount holes  
        //translate([ wall_thick + 10, centerline, -0.1]) cylinder(r=screwhole_radius_M30_passthru, h=(bottom_thick+0.2)); 
        //translate([ wall_thick + 10 + 48, centerline, -0.1]) cylinder(r=screwhole_radius_M30_passthru, h=(bottom_thick+0.2)); 
        //translate([ wall_thick + 10 + 80, centerline, -0.1]) cylinder(r=screwhole_radius_M30_passthru, h=(bottom_thick+0.2));

        // mount holes (counterbore for head)
        //translate([ wall_thick + 10, centerline, (bottom_thick-3) ]) cylinder(d=7, h=(bottom_thick+0.2)); 
        //translate([ wall_thick + 10 + 48, centerline, (bottom_thick-3) ]) cylinder(d=7, h=(bottom_thick+0.2)); 
        //translate([ wall_thick + 10 + 80, centerline, (bottom_thick-3) ]) cylinder(d=7, h=(bottom_thick+0.2));

    }
    // mount holes for lid
    if (lidmount == "pins") {
        translate([ wall_thick + 8, -2, 0 ]) bb_mount_pillar_pinstyle(batt_thick+bottom_thick);
        translate([ wall_thick + 8, outerwidth + 2, 0 ]) bb_mount_pillar_pinstyle(batt_thick+bottom_thick);
        translate([ box_len + wall_thick - 8, -2, 0 ]) bb_mount_pillar_pinstyle(batt_thick+bottom_thick);
        translate([ box_len + wall_thick - 8, outerwidth + 2, 0 ]) bb_mount_pillar_pinstyle(batt_thick+bottom_thick);
    } else {
        translate([ wall_thick + 8, -2, 0 ]) bb_mount_pillar(batt_thick+bottom_thick);
        translate([ wall_thick + 8, outerwidth + 2, 0 ]) bb_mount_pillar(batt_thick+bottom_thick);
        translate([ box_len + wall_thick - 8, -2, 0 ]) bb_mount_pillar(batt_thick+bottom_thick);
        translate([ box_len + wall_thick - 8, outerwidth + 2, 0 ]) bb_mount_pillar(batt_thick+bottom_thick);
    }
}  

/*
 * module draw_battbox_biglipo() draws a battery box lid of specified size, typically for LiPo rectangular RC batteries
 * batt_x and batt_y are basic battery dimensions; clip_distance is full length of battery
 * which determines where restraining clip lives;  box_len is box length, which may be shorter
 * than clip_distance
 */
module draw_battboxH_lid_biglipo(batt_width, box_len, lidmount="pins") {
    wall_thick = 2;
    lid_thick = 2;

    outerwidth  = batt_width + (2*wall_thick);
    centerline = outerwidth / 2;

    difference() {
        union() {
            cube([ (box_len + wall_thick), outerwidth,  lid_thick ]);
            if (lidmount == "pins") {
                translate([ wall_thick + 8, -2, 0 ]) bb_mount_lid_pinstyle(lid_thick, "adds");
                translate([ wall_thick + 8, outerwidth + 2, 0 ]) bb_mount_lid_pinstyle(lid_thick, "adds");
                translate([ box_len + wall_thick - 8, -2, 0 ]) bb_mount_lid_pinstyle(lid_thick, "adds");
                translate([ box_len + wall_thick - 8, outerwidth + 2, 0 ]) bb_mount_lid_pinstyle(lid_thick, "adds");
            } else {        
                translate([ wall_thick + 8, -2, 0 ]) bb_mount_lid(lid_thick, "adds");
                translate([ wall_thick + 8, outerwidth + 2, 0 ]) bb_mount_lid(lid_thick, "adds");
                translate([ box_len + wall_thick - 8, -2, 0 ]) bb_mount_lid(lid_thick, "adds");
                translate([ box_len + wall_thick - 8, outerwidth + 2, 0 ]) bb_mount_lid(lid_thick, "adds");
            }
        }
        if (lidmount == "pins") {
            translate([ wall_thick + 8, -2, 0 ]) bb_mount_lid_pinstyle(lid_thick, "holes");
            translate([ wall_thick + 8, outerwidth + 2, 0 ]) bb_mount_lid_pinstyle(lid_thick, "holes");
            translate([ box_len + wall_thick - 8, -2, 0 ]) bb_mount_lid_pinstyle(lid_thick, "holes");
            translate([ box_len + wall_thick - 8, outerwidth + 2, 0 ]) bb_mount_lid_pinstyle(lid_thick, "holes");
        } else {        
            translate([ wall_thick + 8, -2, 0 ]) bb_mount_lid(lid_thick, "holes");
            translate([ wall_thick + 8, outerwidth + 2, 0 ]) bb_mount_lid(lid_thick, "holes");
            translate([ box_len + wall_thick - 8, -2, 0 ]) bb_mount_lid(lid_thick, "holes");
            translate([ box_len + wall_thick - 8, outerwidth + 2, 0 ]) bb_mount_lid(lid_thick, "holes");
        }
    }
}

module bb_mount_pillar(height) {
    difference() {
        roundedbox(7, 7, 2, height);
        translate([ 0, 0, 4 ]) cylinder(d=TI30_through_hole_diameter, h=height);
    }
}

module bb_mount_lid(thick, mode="adds") {
    if (mode == "adds") {
        roundedbox(7, 7, 2, thick);
    } else {
        translate([ 0, 0, -0.1 ]) cylinder(d=M3_throughhole_dia, h=thick+0.2);
    }
}


module bb_mount_pillar_pinstyle(height) {
    peg_dia = 5.5;
    peg_height = 5;
    hole_dia = 2;
    hole_height = 2.5 + (hole_dia/2);   // thickness of plate that will go on top + clearance + half the hole dia

    difference() {
        union() {
            roundedbox(7, 7, 2, height);
            translate([ 0, 0, height ]) cylinder(d=peg_dia, h=peg_height);
            translate([ 0, 0, height+peg_height ]) sphere(d=peg_dia);
        }
        translate([ 0, (peg_dia/2)+0.1, height+hole_height ]) rotate([ 90, 0, 0 ]) cylinder( d=hole_dia, h=peg_dia+0.2);
    }
}

module bb_mount_lid_pinstyle(thick, mode="adds") {
    if (mode == "adds") {
        roundedbox(11, 11, 2, thick);
    } else {
        translate([ 0, 0, -0.1 ]) cylinder(d=6.5, h=thick+0.2);
    }
}






/*
 **************************************************************************************************************
 **************************************************************************************************************
 * functions to build vertical pocket boxes to hold rectanglar LiPo batteries of the
 * type typically used in RC cars.  these might be installed on the back wall of a 
 * rectangular box chassis.
 **************************************************************************************************************
 ************************************************************************************************************** 
 */


/*
 * module draw_battbox_zeee2200_vertical_pocket() draws a battery box for zeee 2200 mAH battery
 * purchase: https://www.amazon.com/Zeee-Batteries-Quadcopter-Helicopter-Multi-Motor/dp/B07CQPLC3T
 */

module draw_battbox_zeee2200_vertical_pocket(batt_x, batt_y, batt_h) {
    draw_battbox_biglipo_vertical_pocket(35+1, 25+1, 70);
}


/*
 * module draw_battbox_biglipo() draws a battery box of specified size, typically for LiPo rectangular RC batteries
 */
module draw_battbox_biglipo_vertical_pocket(batt_x, batt_y, batt_h) {
    back_thick = 5;
    wall_thick = 2;
    
    difference() {
        roundedbox((batt_x + (2*wall_thick)), (batt_y + back_thick + wall_thick), 3, batt_h);
        translate([ 0, (back_thick - wall_thick)/2, wall_thick ]) roundedbox(batt_x, batt_y, 3, batt_h);
        
        translate([ 0, -((batt_y + back_thick + wall_thick)/2)-0.1, 25 ]) 
            rotate([ -90, 0, 0 ]) battbox_mount_holes((screwhole_radius_M30_selftap*2), (back_thick+0.2));
    }
}  

/*
 * this draws 4 mount holes centered on standard grid dimension (16 mm separation)
 * mount pattern is centered at 0, 0 on xy plane
 * it is assumed that this will be differenced from the body
 * @param dia    is diameter of mount holes
 * @param height is the height of holes
 */
module battbox_mount_holes(dia, height) {
    translate([ (standard_grid_spacing/2), (standard_grid_spacing/2), 0 ]) cylinder(d=dia, h=height);
    translate([ -(standard_grid_spacing/2), (standard_grid_spacing/2), 0 ]) cylinder(d=dia, h=height);
    translate([ (standard_grid_spacing/2), -(standard_grid_spacing/2), 0 ]) cylinder(d=dia, h=height);
    translate([ -(standard_grid_spacing/2), -(standard_grid_spacing/2), 0 ]) cylinder(d=dia, h=height);
}





/*
 **************************************************************************************************************
 **************************************************************************************************************
 * functions to build parts related to small plastic-wrapped NiMH battery packs
 * the packs are clamped to a base plate
 **************************************************************************************************************
 ************************************************************************************************************** 
 */


/*
 * ****************************************
 * module part_nimh_clamp_wide generates a clamp for nimh battery 
 *
 * Note that the specific battery pack used is user choice, and dimensions are configurable below
 * reference: https://www.amazon.com/Powerextra-Capacity-Connectors-Compatiable-Helicopter/dp/B06WD5VRYZ
 * ****************************************
 */

// this for 6v 2200 mAH NIMH battery pack, similar to Blomiky
// https://www.amazon.com/Blomiky-2200mAh-Rechargerable-Battery-Vehicles/dp/B08CY41TTL
nimh_pack_width = 51;
nimh_pack_thick = 13.5;
nimh_pack_clamp_separation = 41;
// note wrapped nimh AA cells often have wire lump on pigtail end; clamp doesn't fit
nimh_pack_clamp_offset_from_center = 5; // (can offset clamps to avoid the lump...)
nimh_pack_overall_length = 71;          // (for visualization)


// this for 7.2v 2200 mAH NIMH battery pack, similar to Blomiky
//https://www.amazon.com/Blomiky-2200mAh-Rechargeable-Battery-Excavator/dp/B07Q2H4X1J/
//nimh_pack_width = 51;
//nimh_pack_thick = 14;
//nimh_pack_clamp_separation = 48;
// note wrapped nimh AA cells often have wire lump on pigtail end; clamp doesn't fit
//nimh_pack_clamp_offset_from_center = 5;   // (can offset clamps to avoid the lump...)
//nimh_pack_overall_length = 85;        // (for visualization)

// this for 7.2v 3600 mAH NIMH battery pack, similar to PowerExtra
// https://www.amazon.com/Powerextra-Capacity-Connectors-Compatiable-Helicopter/dp/B06WD5VRYZ
//nimh_pack_width = 45;
//nimh_pack_thick = 23;
//nimh_pack_clamp_separation = 80;
// note wrapped nimh AA cells often have wire lump on pigtail end; clamp doesn't fit
//nimh_pack_clamp_offset_from_center = 0;   // (can offset clamps to avoid the lump...)
//nimh_pack_overall_length = 135;       // (for visualization)

nimh_clamp_thickness = 3;
nimh_clamp_foot_width = 12;
nimh_clamp_screw_spacing_wide = nimh_pack_width + nimh_clamp_foot_width + (2*nimh_clamp_thickness);
nimh_clamp_screw_spacing_tall = nimh_pack_thick + nimh_clamp_foot_width + (2*nimh_clamp_thickness);

module part_nimh_clamp_wide() {
    difference() {
        union() {
            difference() {
                translate([ -((nimh_pack_width + (2*nimh_clamp_thickness))/2), 0, 0 ]) 
                    cube([ nimh_pack_width + (2*nimh_clamp_thickness), nimh_pack_thick + nimh_clamp_thickness, nimh_clamp_foot_width ]);
                translate([ -(nimh_pack_width/2), -0.1, -0.1 ]) 
                    cube([ nimh_pack_width, nimh_pack_thick+0.2, nimh_clamp_foot_width+0.2 ]);
            }

            // add "feet"
            translate([ -((nimh_pack_width + (2*nimh_clamp_thickness))/2)-nimh_clamp_foot_width, -0.1, -0.1 ])
                cube([ nimh_clamp_foot_width, 3, nimh_clamp_foot_width ]);
            translate([ ((nimh_pack_width + (2*nimh_clamp_thickness))/2), -0.1, -0.1 ]) 
                cube([ nimh_clamp_foot_width, 3, nimh_clamp_foot_width ]);
        }               

        translate([ -(nimh_clamp_screw_spacing_wide/2), -0.2, (nimh_clamp_foot_width/2) ]) rotate([ -90, 0, 0 ]) union() {
            cylinder(r=screwhole_radius_M30_selftap, 6);
            translate([ nimh_clamp_screw_spacing_wide, 0, 0 ]) cylinder(r=screwhole_radius_M30_passthru, 6);
        }
    }
}


module part_nimh_clamp_tall() {
    difference() {
        union() {
            difference() {
                translate([ -((nimh_pack_thick + (2*nimh_clamp_thickness))/2), 0, 0 ]) 
                    cube([ nimh_pack_thick + (2*nimh_clamp_thickness), nimh_pack_width + nimh_clamp_thickness, nimh_clamp_foot_width ]);
                translate([ -(nimh_pack_thick/2), -0.1, -0.1 ]) 
                    cube([ nimh_pack_thick, nimh_pack_width+0.2, nimh_clamp_foot_width+0.2 ]);
            }

            // add "feet"
            translate([ -((nimh_pack_thick + (2*nimh_clamp_thickness))/2)-nimh_clamp_foot_width, -0.1, -0.1 ])
                cube([ nimh_clamp_foot_width, 3, nimh_clamp_foot_width ]);
            translate([ ((nimh_pack_thick + (2*nimh_clamp_thickness))/2), -0.1, -0.1 ]) 
                cube([ nimh_clamp_foot_width, 3, nimh_clamp_foot_width ]);
        }               

        translate([ -(nimh_clamp_screw_spacing_tall/2), -0.2, (nimh_clamp_foot_width/2) ]) rotate([ -90, 0, 0 ]) union() {
            cylinder(r=screwhole_radius_M30_selftap, 6);
            translate([ nimh_clamp_screw_spacing_tall, 0, 0 ]) cylinder(r=screwhole_radius_M30_passthru, 6);
        }
    }
}

/*
 * ***************************************************************************
 * this makes a mount for Ni-MH battery pack
 *
 * Note that the specific battery pack used is user choice, and dimensions are configurable in config_local.scad
 * reference: https://www.amazon.com/Powerextra-Capacity-Connectors-Compatiable-Helicopter/dp/B06WD5VRYZ
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 *
 * ***************************************************************************
 */

module component_nimh_battery_wide(mode="adds") {    
    if (mode == "holes") {
        translate([ -nimh_pack_clamp_separation/2 + nimh_pack_clamp_offset_from_center, nimh_clamp_screw_spacing_wide/2, -4 ]) 
            cylinder(r=screwhole_radius_M30_passthru, h=4.1);
        translate([ -nimh_pack_clamp_separation/2 + nimh_pack_clamp_offset_from_center, -nimh_clamp_screw_spacing_wide/2, -4 ]) 
            cylinder(r=screwhole_radius_M30_passthru, h=4.1);
        translate([ nimh_pack_clamp_separation/2 + nimh_pack_clamp_offset_from_center, nimh_clamp_screw_spacing_wide/2, -4 ]) 
            cylinder(r=screwhole_radius_M30_passthru, h=4.1);
        translate([ nimh_pack_clamp_separation/2 + nimh_pack_clamp_offset_from_center, -nimh_clamp_screw_spacing_wide/2, -4 ]) 
            cylinder(r=screwhole_radius_M30_passthru, h=4.1);
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
 }

module component_nimh_battery_tall(mode="adds") {
    
    if (mode == "holes") {
        translate([ -nimh_pack_clamp_separation/2, nimh_clamp_screw_spacing_tall/2, -4 ]) cylinder(r=screwhole_radius_M30_passthru, h=4.1);
        translate([ -nimh_pack_clamp_separation/2, -nimh_clamp_screw_spacing_tall/2, -4 ]) cylinder(r=screwhole_radius_M30_passthru, h=4.1);
        translate([ nimh_pack_clamp_separation/2, nimh_clamp_screw_spacing_tall/2, -4 ]) cylinder(r=screwhole_radius_M30_passthru, h=4.1);
        translate([ nimh_pack_clamp_separation/2, -nimh_clamp_screw_spacing_tall/2, -4 ]) cylinder(r=screwhole_radius_M30_passthru, h=4.1);
    }
    
    if (mode == "adds") {
        // no adds for this device
    }
 }
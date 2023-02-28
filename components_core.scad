/*
 * Module: components_core.scad  holds modules which generate
 *   the most basic components and pieces for boxmaking and robot projects.
 *   most of the functions included here are actually subcomponents for
 *   other functions (ie the mounting pillars that are part of most board mounts)
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
 * this generates a box with rounded corners
 * the box is centered on the origin, running "up" from z=0
 * reference: https://hackaday.com/2018/02/13/openscad-tieing-it-together-with-hull/
 */
module roundedbox(x, y, radius=3, height=3) {
    left_x = -(x/2) + radius;
    right_x = (x/2) - radius;
    bottom_y = -(y/2) + radius;
    top_y = +(y/2) - radius;
    
    points = [ [left_x, bottom_y,0], [left_x, top_y,0], [right_x, top_y,0], [right_x, bottom_y,0] ]; 
    hull() {
        for (p=points) {
            translate(p) cylinder(r=radius, h=height);
        }
    }
}

/*
 * this makes a mount for a threaded insert M3 
 * note that depending on user-set configuration these might be just self-tap holes
 */

// this one makes a full component that is a cylinder with an internal hole; ignoring "mode"
module TI30_mount(mount_height = TI30_default_height) {    
    if (TI30_use_threaded_insert) {
        difference() {
            cylinder(r=((TI30_mount_diameter / 2) + 0.05), h=mount_height);
            translate([ 0, 0, -0.1 ]) cylinder(r=(TI30_through_hole_diameter / 2), h=mount_height + 0.2); 
        }
    } else {
        difference() {
            cylinder(r=((TI30_mount_diameter / 2) + 0.05), h=mount_height);
            translate([ 0, 0, -0.1 ]) cylinder(r=screwhole_radius_M30_selftap, h=mount_height + 0.2); 
        }
    } 
}

// this one produces a component that honors "mode", and thus can create througholes in baseplate 
module TI30a_mount(mode="adds", mount_height = TI30_default_height) {  
    if (mode == "holes") {
        if (TI30_use_threaded_insert) {
            translate([ 0, 0, -(mount_hole_extra_depth+0.1) ]) 
                cylinder(r=(TI30_through_hole_diameter / 2), h=mount_height + (mount_hole_extra_depth+4)); 
        } else {
            translate([ 0, 0, -(mount_hole_extra_depth+0.1) ]) 
                cylinder(r=screwhole_radius_M30_selftap, h=mount_height + (mount_hole_extra_depth+4)); 
        } 

    }

    if (mode == "adds"){  
        if (TI30_use_threaded_insert) {
            cylinder(r=((TI30_mount_diameter / 2) + 0.05), h=mount_height);
        } else {
            cylinder(r=((TI30_mount_diameter / 2) + 0.05), h=mount_height);
        } 
    }
}


/*
 * this makes a mount for a threaded insert M2 
 * note that depending on user-set configuration these might be just self-tap holes
 */

// this one makes a full component that is a cylinder with an internal hole; ignoring "mode"
module TI20_mount(mount_height = TI20_default_height) {    
    if (TI20_use_threaded_insert) {
        difference() {
            cylinder(r=((TI20_mount_diameter / 2) + 0.05), h=mount_height);
            translate([ 0, 0, -0.1 ]) cylinder(r=(TI20_through_hole_diameter / 2), h=mount_height + 0.2); 
        }
    } else {
        difference() {
            cylinder(r=((TI20_mount_diameter / 2) + 0.05), h=mount_height);
            translate([ 0, 0, -0.1 ]) cylinder(r=screwhole_radius_M20_selftap, h=mount_height + 0.2); 
        }
    } 
}

// this one produces a component that honors "mode", and thus can create througholes in baseplate 
module TI20a_mount(mode="adds", mount_height = TI20_default_height) {  
    if (mode == "holes") {
        if (TI20_use_threaded_insert) {
            translate([ 0, 0, -(mount_hole_extra_depth+0.1) ]) 
                cylinder(r=(TI20_through_hole_diameter / 2), h=mount_height + (mount_hole_extra_depth+4)); 
        } else {
            translate([ 0, 0, -(mount_hole_extra_depth+0.1) ]) 
                cylinder(r=screwhole_radius_M20_selftap, h=mount_height + (mount_hole_extra_depth+4)); 
        } 

    }

    if (mode == "adds"){  
        if (TI30_use_threaded_insert) {
            cylinder(r=((TI20_mount_diameter / 2) + 0.05), h=mount_height);
        } else {
            cylinder(r=((TI20_mount_diameter / 2) + 0.05), h=mount_height);
        } 
    }
}



/*
 * this makes a mount for a threaded insert M2.5 
 * note that depending on user-set configuration these might be just self-tap holes
 */

// this one makes a full component that is a cylinder with an internal hole; ignoring "mode"
module TI25_mount(mount_height = TI25_default_height) {    
    if (TI25_use_threaded_insert) {
        difference() {
            cylinder(r=((TI25_mount_diameter / 2) + 0.05), h=mount_height);
            translate([ 0, 0, -0.1 ]) cylinder(r=(TI25_through_hole_diameter / 2), h=mount_height + 0.2); 
        }
    } else {
        difference() {
            cylinder(r=((TI25_mount_diameter / 2) + 0.05), h=mount_height);
            translate([ 0, 0, -0.1 ]) cylinder(r=screwhole_radius_M25_selftap, h=mount_height + 0.2); 
        }
    } 
}

// this one produces a component that honors "mode", and thus can create througholes in baseplate 
module TI25a_mount(mode="adds", mount_height = TI25_default_height) {  
    if (mode == "holes") {
        if (TI25_use_threaded_insert) {
            translate([ 0, 0, -(mount_hole_extra_depth+0.1) ]) 
                cylinder(r=(TI25_through_hole_diameter / 2), h=mount_height + (mount_hole_extra_depth+4));
        } else {
            translate([ 0, 0, -(mount_hole_extra_depth+0.1) ]) 
                cylinder(r=screwhole_radius_M25_selftap, h=mount_height + (mount_hole_extra_depth+4)); 
        } 

    }

    if (mode == "adds"){  
        if (TI25_use_threaded_insert) {
            cylinder(r=((TI25_mount_diameter / 2) + 0.05), h=mount_height);
        } else {
            cylinder(r=((TI25_mount_diameter / 2) + 0.05), h=mount_height);
        } 
    }
}



// this makes a smaller diameter support mount equiv to the above mounts but no screw 
// the mount stud is 5mm in diameter (supports boards without bumping into bottom solder/etc)

module support_stud(mount_height = TI30_default_height) {
    cylinder(r=(5 / 2), h=mount_height);
}

// this makes a smaller diameter mount that self-taps for M2.5 and is only 5mm tall 
// this would work for a M2.5 screw 6mm long going through a PCB
// it is ONLY made for self-tapping screw

module M25_short_mount(mode, mount_height = 5) {

    if (mode == "holes") {
        translate([ 0, 0, -(mount_hole_extra_depth+0.1) ]) 
            cylinder(r=screwhole_radius_M25_selftap, h=mount_height + mount_hole_extra_depth + 0.2); 
    }

    if (mode == "adds") {
        cylinder(r=((5 / 2) + 0.05), h=mount_height);
    }
}


/*
 * module prism generates a basic "wedge" shape that can be used vertically to make support-less
 * 3d-printable shelves; this is defined in openSCAD documentation at:
 *      https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids
 */

module prism(x, y, z) {
   polyhedron(
           points=[[0,0,0], [x,0,0], [x,y,0], [0,y,0], [0,y,z], [x,y,z]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}

module prism_lwh(l, w, h) {
   polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}

/*
 * multiple lid supports can be used on the box in lieu of having a lip on the lid.
 * in this case, the top of the lid_support is at the top of the box body, and it has
 * vertical screw hole (threaded insert) that matches holes in the lid itself (these
 * replace the horizontal lid-mounting holes).  this allows the lid to be printed top-side "up"
 * to that it can have parts printed on its top (outside) surface
 *
 * the lid support is 15mm tall, 20mm wide, and 8mm "thick"
 * it is generated "central" on xy axis so it can be rotated freely to any box edge
 * and moved 4mm "away" from box inner wall.  its z-axis position has 0 at the bottom
 */
module component_lid_support() {
    translate([ 0, 4, 0 ]) difference() {
        union() {
            translate([ -10, 0, 12 ]) rotate([180, 0, 0 ]) prism(20, 8, 12);
            translate([ -10, -8, 12 ]) cube([20, 8, 3 ]);
        }
        translate([ 0, -4, -0.1 ]) cylinder( r=(TI30_through_hole_diameter/2), h=15.2);
    }
}

/*
 * ***************************************************************************
 * module shaft_flat() makes a flattened shaft
 * this is a round cylinder, with flats on 2 sides (ie for a TT motor)
 *  
 * this is generated in xy plane, centered at origin, pointed "up" (towards + Z)
 * it should be "added" to design, there are no holes needed at placement level
 *
 * parameters:
 *      diameter    diameter of round part of shaft, in mm
 *      flatwidth   dimension across flat part in mm (flat-to-flat)
 *      length      length (or height) of shaft
 *      orientation "tall" or "wide" 
 *          (for tall, initial flats are on left/right (+/- x sides))
 * ***************************************************************************
 */
module shaft_flat(diameter, flatwidth, length, orientation="tall") {
    remove_from_each_side = (diameter - flatwidth) / 2;

    if (orientation == "tall") {
        difference() {
            cylinder(r=(diameter/2), h=length);
            translate([ -(diameter/2), -(diameter/2), -0.1 ]) 
                cube([ remove_from_each_side, diameter, length+0.2 ]);
            translate([ (diameter/2)-remove_from_each_side, -(diameter/2), -0.1 ]) 
                cube([ remove_from_each_side, diameter, length+0.2 ]);
        }
    } else {
        rotate([ 0, 0, -90 ]) difference() {
            cylinder(r=(diameter/2), h=length);
            translate([ -(diameter/2), -(diameter/2), -0.1 ]) 
                cube([ remove_from_each_side, diameter, length+0.2 ]);
            translate([ (diameter/2)-remove_from_each_side, -(diameter/2), -0.1 ]) 
                cube([ remove_from_each_side, diameter, length+0.2 ]);
        }
    }
}

/*
 * ***************************************************************************
 * module shaft_d() makes a d-shaft
 * this is a round cylinder, with flat on 1 side
 *  
 * this is generated in xy plane, centered at origin, pointed "up" (towards + Z)
 * it should be "added" to design, there are no holes needed at placement level
 *
 * parameters:
 *      diameter        diameter of round part of shaft, in mm
 *      fractionremoved  portion of diameter removed (ie 0.1 - 0.9)
 *      length          length (or height) of shaft
 *      orientation     "tall" or "wide" 
 *          (for tall, initial flats are on left/right (+/- x sides))
 * ***************************************************************************
 */
module shaft_d(diameter, fractionremoved, length, orientation="tall") {
    remove_amount = (diameter * fractionremoved);

    if (orientation == "tall") {
        difference() {
            cylinder(r=(diameter/2), h=length);
            translate([ (diameter/2)-remove_amount, -(diameter/2), -0.1 ]) 
                cube([ remove_amount, diameter, length+0.2 ]);
        }
    } else {
        rotate([ 0, 0, -90 ]) difference() {
            cylinder(r=(diameter/2), h=length);
            translate([ (diameter/2)-remove_amount, -(diameter/2), -0.1 ])  
                cube([ remove_amount, diameter, length+0.2 ]);
        }
    }
}

/*
 * ***************************************************************************
 * module shaft_d_r() makes a d-shaft
 * this is a round cylinder, with flat on 1 side
 *  
 * this is generated in xy plane, centered at origin, pointed "up" (towards + Z)
 * it should be "added" to design, there are no holes needed at placement level
 *
 * parameters:
 *      diameter        diameter of round part of shaft, in mm
 *      flat_radius     radius to flat wall on cutoff side
 *      length          length (or height) of shaft
 *      orientation     "tall" or "wide" 
 *          (for tall, initial flats are on left/right (+/- x sides))
 * ***************************************************************************
 */
module shaft_d_r(diameter, flat_radius, length, orientation="tall") {
    remove_amount = ((diameter/2) - flat_radius);

    if (orientation == "tall") {
        difference() {
            cylinder(r=(diameter/2), h=length);
            translate([ (diameter/2)-remove_amount, -(diameter/2), -0.1 ]) 
                cube([ remove_amount, diameter, length+0.2 ]);
        }
    } else {
        rotate([ 0, 0, -90 ]) difference() {
            cylinder(r=(diameter/2), h=length);
            translate([ (diameter/2)-remove_amount, -(diameter/2), -0.1 ])  
                cube([ remove_amount, diameter, length+0.2 ]);
        }
    }
}

module part_calibrate_TI() {
    panel_TI("y");
    translate([ 0, 23, 0]) rotate([90,0,0]) panel_TI();
}

module panel_TI(wantNums="n") {
    difference() {
        cube([ 125, 23, 3 ]);
        union() {
            for ( i = [0 : 11] ) {
                translate([ (7+(i*10)), 12, -0.1] ) cylinder(r=(3.5+(i/10))/2, h=3.2);
            }
        }
    }
    if (wantNums == "y") {
        translate([7, 2, 2]) linear_extrude(2) text("3.5",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([57, 2, 2]) linear_extrude(2) text("4.0",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([107, 2, 2]) linear_extrude(2) text("4.5",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

module part_calibrate_bolt() {
    panel_bolt("y");
    translate([ 0, 23, 0]) rotate([90,0,0]) panel_bolt();
}

module panel_bolt(wantNums="n") {
    difference() {
        cube([ 125, 23, 3 ]);
        union() {
            for ( i = [0 : 14] ) {
                translate([ (7+(i*8)), 12, -0.1] ) cylinder(r=(2.0+(i/10))/2, h=3.2);
            }
        }
    }
    if (wantNums == "y") {
        translate([7, 2, 2]) linear_extrude(2) text("2.0",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([47, 2, 2]) linear_extrude(2) text("2.5",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([87, 2, 2]) linear_extrude(2) text("3.0",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([117, 2, 2]) linear_extrude(2) text("3.4",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}



/*
 * hole for drywall screw (for mounting plates on wood)
 * the mount is 7mm tall
 */
drywall_mount_height = 6;

module part_drywall_screw_hole(mode="adds") {
    if (mode=="adds") {
        cylinder(d=12, h=drywall_mount_height);
    }
    if (mode == "holes") {
        translate([ 0, 0, (drywall_mount_height - 3) ]) cylinder( d1=4.5, d2=9, h=3.1 );
        translate([ 0, 0, -0.1 ]) cylinder( d=4.5, h=drywall_mount_height+0.2 );
    }
}

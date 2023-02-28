/*
 * Module: config_box.scad  holds configuration parameters related to 
 * boxmaking for electronic projects.  this module should be included in
 * all projects which make boxes
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
 * ******************************************************************
 * basic box construction parameters, rarely changed 
 * ******************************************************************
 */

// mm clearance between inner wall of box bottom and outer edge of lid lip
lid_clearance=0.4;  

// thickness of lip in mm (width of its "wall")
lid_lip_thickness = 2;

// height of lip in mm
lid_lip_height = 6; 

// thickness of lid in mm
lid_thickness = 3;   

// thickness of body wall in mm
body_wall_thickness = 2.4; 

// bottom usually same as wall, but may be different
body_bottom_thickness = body_wall_thickness; 

// radius of inside corners on box (1=rectangular inside; default (box_corner_radius-2)
box_corner_inner_radius = box_corner_radius - 2; 

// radius of outside corners on lip on the lid; default (box_corner_inner_radius)
lip_corner_radius = box_corner_inner_radius;  

// if a box side is longer than this, then (2) mounting holes are generated
mount_side_length_threshold = 150;

// correct for potential non-manifold errors if the lip height is same as mount dia  
use_lid_lip_height = (TI30_mount_diameter == lid_lip_height) ? (lid_lip_height + 0.1) : lid_lip_height;

// and ensure that mount is at least "far enough" away from lid panel that it can be fully round
mount_center_offset_from_boxtop = (lid_lip_height < TI30_mount_diameter) ? (TI30_mount_diameter/2) : (use_lid_lip_height / 2);
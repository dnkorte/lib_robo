/*
 * Module: simple_box_and_lid.scad
 * this module has functions which can be used to generate a simple box 
 * and lid for electronics projects. *
 *
 * Project: lib_robo
 * Author(s): Don Korte
 * github: https://github.com/dnkorte/lib_robo.git
 * 
 * note that all projects using this module should also include basic
 *   box sizing parameters in their mainline file,  these parameters
 *   should be included BEFORE the includes for the other library modules
 *      box_length = 80;
 *      box_width = 120;
 *      box_height = 35;
 *      box_corner_radius = 8;
 *
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
 * *************************************************************
 * calculate these working parameters
 * (the base parameters should be defined in the main module)
 * *************************************************************
 */


// x,y location of box and lid walls (remember that lid is generated "upside down"
box_front_x = -(box_length/2);
box_back_x = +(box_length/2);
box_L_y = -(box_width/2);
box_R_y = +(box_width/2);

box_west_x = box_front_x;
box_east_x = box_back_x;
box_north_y = box_R_y;
box_south_y = box_L_y;

lid_front_x = +(box_length/2);
lid_back_x = -(box_length/2);
lid_L_y = -(box_width/2);
lid_R_y = +(box_width/2);

/*
 ***********************************************************
 * the library functions
 ***********************************************************
 */


module lip() {
    lip_box_length = box_length - (2 * (body_wall_thickness + lid_clearance));
    lip_box_width = box_width - (2 * (body_wall_thickness + lid_clearance));
    lip_inner_x = lip_box_length - (2 * lid_lip_thickness);
    lip_inner_y = lip_box_width - (2 * lid_lip_thickness);
    TI30_mount_radius = TI30_mount_diameter / 2;
    
    // calculate potential positions for the mount holes
    locY_ctr = 0;
    locX_ctr = 0;
  
    union() {
        difference() {
            // create the basic lip
            roundedbox(lip_box_length, lip_box_width, lip_corner_radius, use_lid_lip_height);
            roundedbox(lip_inner_x, lip_inner_y, lip_corner_radius-2, use_lid_lip_height+1);
            
            // cut holes in lip for threaded insert mounts to go into (y side)
            // note that we make the radius slightly smaller than the mount to avoid non-manifold errors
            translate([ -(lip_box_length/2)-1,locY_ctr, mount_center_offset_from_boxtop]) rotate([0,90,0]) 
                cylinder(r=(TI30_mount_radius - 0.1), h=(lip_box_length+2));
            
            // cut holes in lip for threaded insert mounts to go into (x side)
            // note that we make the radius slightly smaller than the mount to avoid non-manifold errors
            translate([locX_ctr, -(lip_box_width/2)-1, mount_center_offset_from_boxtop]) rotate([270,0,0])
                cylinder(r=(TI30_mount_radius - 0.1), h=(lip_box_width+2));
        }
        
        // now put in the threaded insert mounts (x side; front/back)
        translate([ -(lip_box_length/2), locY_ctr, mount_center_offset_from_boxtop]) rotate([0,90,0]) 
            TI30_mount();
        translate([ +(lip_box_length/2), locY_ctr, mount_center_offset_from_boxtop]) rotate([0,270,0]) 
            TI30_mount();
        
        // now put in the threaded insert mounts (y side; L/R)
        translate([locX_ctr, +(lip_box_width/2), mount_center_offset_from_boxtop]) rotate([90,0,0])
            TI30_mount();
        translate([locX_ctr, -(lip_box_width/2), mount_center_offset_from_boxtop]) rotate([270,0,0])
            TI30_mount();
    }
}

/*
 * this makes a lip that runs extra tall (like for a box that needs a little more
 * internal room).  the lip raises to the height specified as parameter
 * and the "outer dimension" of the box is retained for xxx
 */
module lip_tall(extra_height = 0) {
    lip_box_length = box_length - (2 * (body_wall_thickness + lid_clearance));
    lip_box_width = box_width - (2 * (body_wall_thickness + lid_clearance));
    lip_inner_x = lip_box_length - (2 * lid_lip_thickness);
    lip_inner_y = lip_box_width - (2 * lid_lip_thickness);
    TI30_mount_radius = TI30_mount_diameter / 2;
    
    // calculate potential positions for the mount holes
    locY_ctr = 0;
    locX_ctr = 0;
  
    union() {
        difference() {
            // create the basic lip
            roundedbox(lip_box_length, lip_box_width, lip_corner_radius, use_lid_lip_height + extra_height);
            roundedbox(lip_inner_x, lip_inner_y, lip_corner_radius-2, use_lid_lip_height+extra_height+1);
            
            // cut holes in lip for threaded insert mounts to go into (y side)
            // note that we make the radius slightly smaller than the mount to avoid non-manifold errors
            translate([ -(lip_box_length/2)-1,locY_ctr, mount_center_offset_from_boxtop+extra_height]) rotate([0,90,0]) 
                cylinder(r=(TI30_mount_radius - 0.1), h=(lip_box_length+2));
            
            // cut holes in lip for threaded insert mounts to go into (x side)
            // note that we make the radius slightly smaller than the mount to avoid non-manifold errors
            translate([locX_ctr, -(lip_box_width/2)-1, mount_center_offset_from_boxtop+extra_height]) rotate([270,0,0])
                cylinder(r=(TI30_mount_radius - 0.1), h=(lip_box_width+2));
        }
        
        // now put in the threaded insert mounts (x side; front/back)
        translate([ -(lip_box_length/2), locY_ctr, mount_center_offset_from_boxtop+extra_height]) rotate([0,90,0]) 
            TI30_mount();
        translate([ +(lip_box_length/2), locY_ctr, mount_center_offset_from_boxtop+extra_height]) rotate([0,270,0]) 
            TI30_mount();
        
        // now put in the threaded insert mounts (y side; L/R)
        translate([locX_ctr, +(lip_box_width/2), mount_center_offset_from_boxtop+extra_height]) rotate([90,0,0])
            TI30_mount();
        translate([locX_ctr, -(lip_box_width/2), mount_center_offset_from_boxtop+extra_height]) rotate([270,0,0])
            TI30_mount();
    }
}


/*
 * **********************************************************************************************************************
 * Template modules that must be copied into project mainline and renamed appropriately
 * **********************************************************************************************************************
 */


// copy this module into the mainline generator for this project, and
// add calls to all functions needed to generate needed holes or add-on parts

module SAMPLE_box() {
    difference() {
        union() {
          // the basic hollow box
          difference() {
            roundedbox(box_length, box_width, box_corner_radius, box_height);
            translate([0, 0, body_bottom_thickness])  
                roundedbox((box_length - 2*body_wall_thickness), 
                           (box_width - 2*body_wall_thickness), 
                           box_corner_inner_radius, 
                           (box_height - body_wall_thickness+1));
          }

          /*
           ************************************************************************
           * here enter all the parts that are added to the box
           ************************************************************************
           */
                    
        }

        // create mounting holes along y side (by removal...)
        translate([-(box_length/2)-0.1, 0, (box_height - mount_center_offset_from_boxtop)]) rotate([0,90,0])  
          cylinder(h=box_length+0.2, r=screwhole_radius_M30_passthru);
      
        // create mounting holes along x side
        translate([0, -(box_width/2)-0.1, (box_height - mount_center_offset_from_boxtop)]) rotate([0,90,90])  
              cylinder(h=box_width+0.2, r=screwhole_radius_M30_passthru);
        
        /*
         ************************************************************************
         * here enter all the parts that are removed from the box
         ************************************************************************
        */
       
    }


}

// copy this module into the mainline generator for this project, and
// add calls to all functions needed to generate needed holes or add-on parts

module SAMPLE_lid() {  
    difference() {

        union() {
            roundedbox(box_length, box_width, box_corner_radius, lid_thickness);
            translate([0, 0, lid_thickness]) lip();  

            /*
             ************************************************************************
             * here enter all the parts that are added to the box
             ************************************************************************
             */

        }
        
        /*
         ************************************************************************
         * here enter all the parts that are removed from the box
         ************************************************************************
         */

    }
}

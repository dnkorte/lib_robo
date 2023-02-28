/*
 * Module: config_core.scad  holds the basic configuration parameters
 * that would be used in all projects in a user's library.  mostly
 * these are parameters related to hole sizes for various bolts, etc
 * which may need to be customized for the user's 3d printer.  this file
 * should be included in all projects.
 *
 * Project: lib_robo
 * Author(s): Don Korte
 * github: https://github.com/dnkorte/lib_robo.git
 * 
 * Note that most components and parts that need mounting bolts/screws
 * are designed to use EITHER brass threaded heat-set inserts or self-tapping
 * screws to accomplish the fastening.  parameters in this library:
 *      TI30_use_threaded_insert = true;
 *      TI25_use_threaded_insert = true;
 *      TI20_use_threaded_insert = true;
 * are used to control which option is slected (on a global basis).  in all
 * cases, "true" means to generate a threaded insert, "false" means to use
 * a self-tapping screw of the appropriate size.  Threaded inserts are recommended
 * in all cases, and are thus the default.  Note that because they are generally
 * the author's preference there are some modules which exclusively use threaded
 * inserts, but i am trying to go back through and adjust these modules to honor
 * the flags as shown above.  
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
 * ***********************************************************************
 * basic user preference parameters (3d printer specific), rarely changed 
 * ***********************************************************************
 */

// depth of screw/TI hole below component base (typically used to allow extra
// room for the screw to pass into or through the box bottom or lid panel; default 4)
mount_hole_extra_depth = 2;			// was origninally 4 but this makes the lid messy if boards inside

// parameters for holes that will be "self-tapped" by screws
// these may be fine-tuned for your printer
screwhole_radius_M30_passthru = 2;  
screwhole_radius_M30_selftap = 1.40;  // was 1.45
screwhole_radius_M25_passthru = 1.8;  
screwhole_radius_M25_selftap = 1.25; 
screwhole_radius_M20_passthru = 1.5;  
screwhole_radius_M20_selftap = 1.0;  

M3_selftap_dia = (2 * screwhole_radius_M30_selftap);       
M3_throughhole_dia = (2 * screwhole_radius_M30_passthru);   
M2_selftap_dia = (2 * screwhole_radius_M20_selftap);         
M2_throughhole_dia = (2 * screwhole_radius_M20_passthru);    
M25_selftap_dia = (2 * screwhole_radius_M25_selftap); 

// parameters for threaded insert mount (M3; McMaster-Carr)
// note if TI_30_use_threaded_insert == false then self-tap holes are generated
TI30_use_threaded_insert = true;
TI30_mount_diameter = 7;
TI30_through_hole_diameter = 4.2;  
TI30_default_height = 6.0;

// parameters for threaded insert mount (M2.5; Amazon)
// note if TI_25_use_threaded_insert == false then self-tap holes are generated
TI25_use_threaded_insert = true;
TI25_mount_diameter = 7;
TI25_through_hole_diameter = 4.1;  
TI25_default_height = 6.0;

// parameters for threaded insert mount (M2; McMaster-Carr)
// note if TI_20_use_threaded_insert == false then self-tap holes are generated
TI20_use_threaded_insert = true;
TI20_mount_diameter = 6;
TI20_through_hole_diameter = 3.7; 
TI20_default_height = 6.0; 

// thickness of printed circuit board for (itsybitsy, qtpy, adafruit level shifter)
board_thickness = 1.6;

// standard spacing for mounting grids
standard_grid_spacing = 16;




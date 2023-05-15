/*
 * Module: components_boards.scad  holds modules which generate
 *   mounts for standard electronics and microprocessor boards
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
 * this makes a base for red tindie protoboard (small;  50 x 26mm)
 * its base is 1mm thick, and 52 x 28 mm
 * it has 4 M3 threaded insert mounts 43mm x 20.5mm spacing
 * 
 * the standard function uses 4 mount screws, lifted standard mount height
 * the _lifted function uses 2 (long axis) mounts + one small support on 
 *      other edge (no screws).  the whole assembly is lefted by "lift" mm
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.tindie.com/products/DrAzzy/1x2-prototyping-board/
 * ***************************************************************************
 */

board_redproto_length = 52;
board_redproto_width = 28;
vis_redproto_length = 50;
vis_redproto_width = 26;
board_redproto_screw_x = 43;
board_redproto_screw_y = 20.5;

module component_small_red_protoboard(mode="adds") {


    // the "mount" itself handles the add/holes issues
    translate([ -(board_redproto_screw_x/2), -(board_redproto_screw_y/2), 1]) TI30a_mount(mode); 
    translate([ -(board_redproto_screw_x/2), +(board_redproto_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_redproto_screw_x/2), -(board_redproto_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_redproto_screw_x/2), +(board_redproto_screw_y/2), 1]) TI30a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_redproto_length, board_redproto_width, 2, 1);
           
        translate([0, 0, 0]) linear_extrude(2) text("Red Proto", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("Proto M3",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


module component_small_red_protoboard_lifted(mode="adds", lift=17) {
    if (lift < 8) {
        component_small_red_protoboard(mode);

    } else {

        // the "mount" itself handles the add/holes issues
        translate([ -(board_redproto_screw_x/2), (board_redproto_screw_y/2), 1]) TI30a_mount(mode, lift); 
        translate([ +(board_redproto_screw_x/2), (board_redproto_screw_y/2), 1]) TI30a_mount(mode, lift);


        if (mode == "holes") {
            // no holes for this component
        }

        if (mode == "adds") {
            roundedbox(board_redproto_length, board_redproto_width, 2, 1);

            translate([ 0, -12, 1]) roundedbox(10, 3, 1, lift); 
            
            translate([0, 0, 0]) linear_extrude(2) text("Red Proto", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, -8, 0]) linear_extrude(2) text("Proto M3",
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
        }
    }
}

/*
 * ********************************************************************************
 * this makes a base for adafruit small mint tin size protoboard 
 * its base is 1mm thick, and 54 x 33 mm
 * it has 4 M3 threaded insert mounts 45.5mm x 25.4mm spacing
 * 
 * the standard function uses 4 mount screws, lifted standard mount height
 * the _lifted function uses 2 (long axis) mounts + one small support on 
 *      other edge (no screws).  the whole assembly is lefted by "lift" mm
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/1214
 * ********************************************************************************
 */
board_smallmintproto_length = 54;
board_smallmintproto_width = 33;
board_smallmintproto_screw_x = 45.5;
board_smallmintproto_screw_y = 25.4;

module component_smallmint_protoboard(mode="adds") {

    // the "mount" itself handles the add/holes issues        
    translate([ -(board_smallmintproto_screw_x/2), -(board_smallmintproto_screw_y/2), 1]) TI30a_mount(mode); 
    translate([ -(board_smallmintproto_screw_x/2), +(board_smallmintproto_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_smallmintproto_screw_x/2), -(board_smallmintproto_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_smallmintproto_screw_x/2), +(board_smallmintproto_screw_y/2), 1]) TI30a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_smallmintproto_length, board_smallmintproto_width, 2, 1);
        
        translate([0, 0, 0]) linear_extrude(2) text("Small Mint", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("Proto M3",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }


}

module component_smallmint_protoboard_lifted(mode="adds", lift=17) {
    if (lift < 8) {
        component_smallmint_protoboard(mode);

    } else {

        // the "mount" itself handles the add/holes issues
        translate([ -(board_smallmintproto_screw_x/2), (board_smallmintproto_screw_y/2), 1]) TI30a_mount(mode, lift); 
        translate([ +(board_smallmintproto_screw_x/2), (board_smallmintproto_screw_y/2), 1]) TI30a_mount(mode, lift);



        if (mode == "holes") {
            // no holes for this component
        }

        if (mode == "adds") {

            roundedbox(board_smallmintproto_length, board_smallmintproto_width, 2, 1);
            
            translate([ 0, -15, 1]) roundedbox(10, 3, 1, lift); 
            
            translate([0, 0, 0]) linear_extrude(2) text("Small Mint", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, -8, 0]) linear_extrude(2) text("Proto M3",
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
        }       
    }
}


/*
 * ***************************************************************************
 * this makes a base for adafruit stemma size board with 0.5 x 0.8 mount spacing
 * it has 4 M2.5 threaded insert mounts 12.7 x 20.32 (0.5 x 0.8 in) spacing
 * if flavor == "pins"; it generates small posts to snap board onto; else it uses M2.5 threaded insert
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 * ***************************************************************************
 */

board_stemma5_length = 28;
board_stemma5_width = 20;
vis_stemma5_length = 28;
vis_stemma5_width = 20;
board_stemma5_screw_x = 20.32;
board_stemma5_screw_y = 12.7;

module component_stemma5(mode="adds", flavor="pins") {

    if (flavor != "pins") {
        // the "mount" itself handles the add/holes issues
        translate([ -(board_stemma5_screw_x/2), -(board_stemma5_screw_y/2), 1]) TI25_mount(); 
        translate([ -(board_stemma5_screw_x/2), +(board_stemma5_screw_y/2), 1]) TI25_mount();
        translate([ +(board_stemma5_screw_x/2), -(board_stemma5_screw_y/2), 1]) TI25_mount();
        translate([ +(board_stemma5_screw_x/2), +(board_stemma5_screw_y/2), 1]) TI25_mount(); 
    }

    if (mode == "holes") {
        // no holes for this component 
    }

    if (mode == "adds") {
        roundedbox(board_stemma5_length, board_stemma5_width, 2, 1);
           
        translate([0, 0, 0]) linear_extrude(2) text("Stm5", 
            size=5,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("M2.5",
            size=5,  halign="center", font = "Liberation Sans:style=Bold");

        if (flavor == "pins") {
            translate([ -(board_stemma5_screw_x/2), -(board_stemma5_screw_y/2), 1]) cylinder(d=5, h=3); 
            translate([ -(board_stemma5_screw_x/2), +(board_stemma5_screw_y/2), 1]) cylinder(d=5, h=3);
            translate([ +(board_stemma5_screw_x/2), -(board_stemma5_screw_y/2), 1]) cylinder(d=5, h=3);
            translate([ +(board_stemma5_screw_x/2), +(board_stemma5_screw_y/2), 1]) cylinder(d=5, h=3); 

            translate([ -(board_stemma5_screw_x/2), -(board_stemma5_screw_y/2), 1]) cylinder(d=2.2, h=6); 
            translate([ -(board_stemma5_screw_x/2), +(board_stemma5_screw_y/2), 1]) cylinder(d=2.2, h=6);
            translate([ +(board_stemma5_screw_x/2), -(board_stemma5_screw_y/2), 1]) cylinder(d=2.2, h=6);
            translate([ +(board_stemma5_screw_x/2), +(board_stemma5_screw_y/2), 1]) cylinder(d=2.2, h=6);
        }
    }
}

/*
 * ***************************************************************************
 * this makes a base for adafruit stemma size board with 0.6 x 0.8 mount spacing
 * it has 4 M2.5 threaded insert mounts 15.24 x 20.32 (0.6 x 0.8 in) spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * dimensions: https://www.raspberrypi-spy.co.uk/2015/11/introducing-the-raspberry-pi-zero/
 * ***************************************************************************
 */

board_stemma6_length = 28;
board_stemma6_width = 22;
vis_stemma6_length = 28;
vis_stemma6_width = 20;
board_stemma6_screw_x = 20.32;
board_stemma6_screw_y = 15.24;

module component_stemma6(mode="adds") {


    // the "mount" itself handles the add/holes issues
    translate([ -(board_stemma6_screw_x/2), -(board_stemma6_screw_y/2), 1]) TI25a_mount(mode); 
    translate([ -(board_stemma6_screw_x/2), +(board_stemma6_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_stemma6_screw_x/2), -(board_stemma6_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_stemma6_screw_x/2), +(board_stemma6_screw_y/2), 1]) TI25a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component 
    }

    if (mode == "adds") {
        roundedbox(board_stemma6_length, board_stemma6_width, 2, 1);
           
        translate([0, 0, 0]) linear_extrude(2) text("Stm6", 
            size=5,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("M2.5",
            size=5,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ***************************************************************************
 * this makes a base for raspberry pi zero (65 x 30mm)
 * its base is 1mm thick, and 65 x 30 mm
 * it has 4 M2.5 threaded insert mounts 58mm x 23mm spacing
 * 
 * the standard function uses 4 mount screws, lifted standard mount height
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * dimensions: https://www.raspberrypi-spy.co.uk/2015/11/introducing-the-raspberry-pi-zero/
 * ***************************************************************************
 */

board_pizero_length = 65;
board_pizero_width = 30;
vis_pizero_length = 65;
vis_pizero_width = 30;
board_pizero_screw_x = 58;
board_pizero_screw_y = 23;

module component_pizero(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ -(board_pizero_screw_x/2), -(board_pizero_screw_y/2), 1]) TI25a_mount(mode); 
    translate([ -(board_pizero_screw_x/2), +(board_pizero_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_pizero_screw_x/2), -(board_pizero_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_pizero_screw_x/2), +(board_pizero_screw_y/2), 1]) TI25a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component 
    }

    if (mode == "adds") {
        roundedbox(board_pizero_length, board_pizero_width, 2, 1);
           
        translate([0, 0, 0]) linear_extrude(2) text("RPi Zero W", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("Proto M2.5",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ***************************************************************************
 * this makes a base for raspberry pi 3b (65 x 30mm)
 * its base is 1mm thick, and 65 x 30 mm
 * it has 4 M2.5 threaded insert mounts 58mm x 23mm spacing
 * 
 * the standard function uses 4 mount screws, lifted standard mount height
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * dimensions: https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_3bplus.pdf
 * ***************************************************************************
 */

board_pi3_length = 85;
board_pi3_width = 56;
vis_pi3_length = 85;
vis_pi3_width = 56;
board_pi3_screw_x_left = -39;
board_pi3_screw_x_right = 19;
board_pi3_screw_y = 49/2;

module component_pi3(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ board_pi3_screw_x_left, -board_pi3_screw_y, 1]) TI25a_mount(mode); 
    translate([ board_pi3_screw_x_left, +board_pi3_screw_y, 1]) TI25a_mount(mode);
    translate([ board_pi3_screw_x_right, -board_pi3_screw_y, 1]) TI25a_mount(mode);
    translate([ board_pi3_screw_x_right, +board_pi3_screw_y, 1]) TI25a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component 
    }

    if (mode == "adds") {
        roundedbox(board_pi3_length, board_pi3_width, 2, 1);
           
        translate([0, 0, 0]) linear_extrude(2) text("Raspberry Pi 3", 
            size=8,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -10, 0]) linear_extrude(2) text("M2.5",
            size=8,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ***************************************************************************
 * this makes a base for jetson nano B01 (100 x 80mm)
 * its base is 1mm thick, and 100 x 80 mm
 * it has 4 M3 threaded insert mounts 81.4mm x 59.4mm spacing
 * 
 * the standard function uses 4 mount screws, lifted standard mount height
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * dimensions: 
 * info: https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#intro
 * info: https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-nano-developer-kit/
 * info: https://developer.download.nvidia.com/assets/embedded/secure/jetson/Nano/docs/NV_Jetson_Nano_Developer_Kit_User_Guide.pdf
 * info: https://elinux.org/Jetson_Nano
 * purchase: https://www.sparkfun.com/products/16271
 * purchase: https://www.amazon.com/NVIDIA-Jetson-Nano-Developer-945-13450-0000-100/dp/B084DSDDLT
 * purchase: https://www.amazon.com/Studio-Jetson-Developer-Computer-Development/dp/B09CPYR31L
 * ***************************************************************************
 */

board_jetnano_length = 100;
board_jetnano_width = 80;
jetnano_screwsep_x =  81.4;
jetnano_screwsep_y = 59.4;
screw_origin_x = -(board_jetnano_length/2) + 4;
screw_origin_y = -(board_jetnano_width/2) + 4;

module component_jetson_nano(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ screw_origin_x, screw_origin_y, 1]) TI30a_mount(mode); 
    translate([ screw_origin_x, screw_origin_y+jetnano_screwsep_y, 1]) TI30a_mount(mode); 
    translate([ screw_origin_x+jetnano_screwsep_x, screw_origin_y, 1]) TI30a_mount(mode); 
    translate([ screw_origin_x+jetnano_screwsep_x, screw_origin_y+jetnano_screwsep_y, 1]) TI30a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component 
    }

    if (mode == "adds") {
        roundedbox(board_jetnano_length, board_jetnano_width, 2, 1);
           
        translate([0, 0, 0]) linear_extrude(2) text("Jetson Nano B01", 
            size=8,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -10, 0]) linear_extrude(2) text("M3",
            size=8,  halign="center", font = "Liberation Sans:style=Bold");
    }
}



/*
 * ********************************************************************************
 * this makes a base for Dons Tech Stuff singlesize stacking board
 * its base is 1mm thick, and 54 x 33 mm
 * it has 4 M3 threaded insert mounts 45.5mm x 25.4mm spacing
 * 
 * the standard function uses 4 mount screws, lifted standard mount height
 * the _lifted function uses 2 (long axis) mounts + one small support on 
 *      other edge (no screws).  the whole assembly is lefted by "lift" mm
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/1214
 * ********************************************************************************
 */
board_dts_length = 57;
board_dts_width = 40;
board_dts_screw_x = 48;
board_dts_screw_y = 32;

module component_dts_singleboard(mode="adds") {

    // the "mount" itself handles the add/holes issues        
    translate([ -(board_dts_screw_x/2), -(board_dts_screw_y/2), 1]) TI30a_mount(mode); 
    translate([ -(board_dts_screw_x/2), +(board_dts_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_dts_screw_x/2), -(board_dts_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_dts_screw_x/2), +(board_dts_screw_y/2), 1]) TI30a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_dts_length, board_dts_width, 2, 1);
        
        translate([0, -4, 0]) linear_extrude(2) text("DTS M3", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        //translate([0, -8, 0]) linear_extrude(2) text("M3",
        //    size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

module component_dts_singleboard_lifted(mode="adds", lift=17) {
    if (lift < 8) {
        component_dts_singleboard(mode);

    } else {

        // the "mount" itself handles the add/holes issues
        translate([ -(board_dts_screw_x/2), (board_dts_screw_y/2), 1]) TI30a_mount(mode, lift); 
        translate([ +(board_dts_screw_x/2), (board_dts_screw_y/2), 1]) TI30a_mount(mode, lift);



        if (mode == "holes") {
            // no holes for this component
        }

        if (mode == "adds") {

            roundedbox(board_dts_length, board_dts_width, 2, 1);
            
            translate([ 0, -15, 1]) roundedbox(10, 3, 1, lift); 
            
            translate([0, 0, 0]) linear_extrude(2) text("DTS Single", 
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
            translate([0, -8, 0]) linear_extrude(2) text("M3",
                size=6,  halign="center", font = "Liberation Sans:style=Bold");
        }
    }
}


/*
 * ********************************************************************************
 * this makes a base for adafruit permaproto half-size protoboard 
 * its base is 1mm thick, and 83 x 51 mm 
 *      (note permaproto is only 81 long; 83 allows room for end supports)
 * it has 2 M3 threaded insert mounts 73.7 mm apart
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/1609
 * ********************************************************************************
 */
board_permaprotohalf_length = 81;
board_permaprotohalf_width = 51;
board_permaprotohalf_screw_x = 73.7;

module component_permaprotohalf(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ +(board_permaprotohalf_screw_x/2), 0, 1]) TI30a_mount(mode); 
    translate([ -(board_permaprotohalf_screw_x/2), 0, 1]) TI30a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_permaprotohalf_length, board_permaprotohalf_width, 2, 1);
        
        translate([ 0, 0, 1]) difference() {
            roundedbox(board_permaprotohalf_length, board_permaprotohalf_width, 2, TI30_default_height);
            roundedbox(board_permaprotohalf_length-4, board_permaprotohalf_width-4, 2, TI30_default_height+0.1);
        }
        
        translate([0, +7, 0]) linear_extrude(2) text("PermaProto", 
            size=6, , halign="center");
        translate([0, -2, 0]) linear_extrude(2) text("Half-Size", 
            size=6, , halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -12, 0]) linear_extrude(2) text("M3", 
            size=6, , halign="center", font = "Liberation Sans:style=Bold");
    }
}



/*
 * ********************************************************************************
 * this makes a base for adafruit feather and feather protoboard
 * its base is 1mm thick, and 52 x 25mm (note feather itself is 50.8 x 22.86 mm)
 * it has 4 M2.5 threaded insert mounts 45.5mm x 25.4mm spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/2884
 * guide: https://learn.adafruit.com/featherwing-proto-and-doubler/overview
 * ********************************************************************************
 */
board_feather_length = 52;
board_feather_width = 25;
vis_feather_length = 50.8;
vis_feather_width = 22.86;
board_feather_screw_x = 45.72;
board_feather_screw_y = 17.78;

module component_feather(mode="adds") {

    // the "mount" itself handles the add/holes issues
        translate([ -(board_feather_screw_x/2), -(board_feather_screw_y/2), 1]) TI25a_mount(mode); 
        translate([ -(board_feather_screw_x/2), +(board_feather_screw_y/2), 1]) TI25a_mount(mode);
        translate([ +(board_feather_screw_x/2), -(board_feather_screw_y/2), 1]) TI25a_mount(mode);
        translate([ +(board_feather_screw_x/2), +(board_feather_screw_y/2), 1]) TI25a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_feather_length, board_feather_width, 2, 1);
        
        translate([0, 1, 0]) linear_extrude(2) text("Feather", 
            size=6, halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("M2.5", 
            size=6, halign="center", font = "Liberation Sans:style=Bold");
    }
}


module component_feather_lifted(mode, lift=17) {
    if (lift < 8) {
        component_feather(mode);

    } else {

        // the "mount" itself handles the add/holes issues
        translate([ -(board_feather_screw_x/2), (board_feather_screw_y/2), 1]) TI25a_mount(mode, lift); 
        translate([ +(board_feather_screw_x/2), (board_feather_screw_y/2), 1]) TI25a_mount(mode, lift);


        if (mode == "adds") {
            roundedbox(board_feather_length, board_feather_width, 2, 1);

            translate([ 0, -10, 1]) roundedbox(10, 3, 1, lift); 
            
            translate([0, 1, 0]) linear_extrude(2) text("Feather", 
                size=6, halign="center", font = "Liberation Sans:style=Bold");
            translate([0, -8, 0]) linear_extrude(2) text("M2.5", 
                size=6, halign="center", font = "Liberation Sans:style=Bold");
        }
    }
}

/*
 * ********************************************************************************
 * this makes a base for adafruit reverse feather (TFT)
 * this is similar to normal feather but 2 of its mounting holes are only 2mm
 *     diameter, so the screw mounts are replaced by pegs in this board mount
 *
 * its base is 1mm thick, and 52 x 25mm (note feather itself is 50.8 x 22.86 mm)
 * it has 4 M2.5 threaded insert mounts 45.5mm x 25.4mm spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/5345
 * ********************************************************************************
 */

module component_reverse_feather(mode="adds", mount_height=TI25_default_height) {

    // the "mount" itself handles the add/holes issues

    if (mode == "holes") {
        // make clearance for esp32 module
        translate([ -(board_feather_length/2), -(17/2), 1 ]) cube([ 8, 17, mount_height ]);
    }

    if (mode == "adds") {
        roundedbox(board_feather_length, board_feather_width, 2, 1);
        translate([ -(board_feather_screw_x/2), -(board_feather_screw_y/2), 1]) {
            cylinder( d=5, h=mount_height);
            cylinder( d=1.8, h=mount_height+2);
        } 
        translate([ -(board_feather_screw_x/2), +(board_feather_screw_y/2), 1]) {
            cylinder( d=5, h=mount_height);
            cylinder( d=1.8, h=mount_height+2);
        }
        translate([ +(board_feather_screw_x/2), -(board_feather_screw_y/2), 1]) TI25a_mount(mode, mount_height=mount_height);
        translate([ +(board_feather_screw_x/2), +(board_feather_screw_y/2), 1]) TI25a_mount(mode, mount_height=mount_height); 
        
        translate([0, 1, 0]) linear_extrude(2) text("Feather", 
            size=6, halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("M2.5", 
            size=6, halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ********************************************************************************
 * this makes a base for adafruit feather doubler protoboard
 * its base is 1mm thick, and 49 x 52mm (note the doubler itself is 45.72 x 46.99 mm)
 * it has 4 M2.5 threaded insert mounts + 2 support mounts between "boards"
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/2890
 * guide: https://learn.adafruit.com/featherwing-proto-and-doubler/overview
 * ********************************************************************************
 */
board_feather_doubler_length = 49;   
board_feather_doubler_width = 52;
board_feather_doubler_screws_x = 21;
board_feather_doubler_studs_x = 0;
board_feather_doubler_screw_y = 45.72;

module component_feather_doubler(mode="adds") {


    // the "mount" itself handles the add/holes issues
    translate([ -(board_feather_doubler_screws_x), -(board_feather_doubler_screw_y/2), 1]) TI25a_mount(mode); 
    translate([ -(board_feather_doubler_screws_x), +(board_feather_doubler_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_feather_doubler_screws_x), -(board_feather_doubler_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_feather_doubler_screws_x), +(board_feather_doubler_screw_y/2), 1]) TI25a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_feather_doubler_length, board_feather_doubler_width, 2, 1);
                
        translate([ -(board_feather_doubler_studs_x), -(board_feather_doubler_screw_y/2), 1]) support_stud(); 
        translate([ +(board_feather_doubler_studs_x), +(board_feather_doubler_screw_y/2), 1]) support_stud(); 
        
        translate([0, +8, 0]) linear_extrude(2) text("Feather", 
            size=8, , halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -4, 0]) linear_extrude(2) text("Doubler", 
            size=8, , halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -16, 0]) linear_extrude(2) text("M2.5", 
            size=8, , halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ********************************************************************************
 * this makes a base for adafruit feather tripler protoboard
 * its base is 1mm thick, and 73 x 52mm (note the doubler itself is 71.12 x 46.99 mm)
 * it has 4 M2.5 threaded insert mounts + 4 support mounts between "boards"
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/2890
 * guide: https://learn.adafruit.com/featherwing-proto-and-doubler/overview
 * ********************************************************************************
 */
board_feather_tripler_length = 73;   
board_feather_tripler_width = 52;
board_feather_tripler_screws_x = 33;
board_feather_tripler_studs_x = 12;
board_feather_tripler_screw_y = 45.72;

module component_feather_tripler(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ -(board_feather_tripler_screws_x), -(board_feather_tripler_screw_y/2), 1]) TI25a_mount(mode); 
    translate([ -(board_feather_tripler_screws_x), +(board_feather_tripler_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_feather_tripler_screws_x), -(board_feather_tripler_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_feather_tripler_screws_x), +(board_feather_tripler_screw_y/2), 1]) TI25a_mount(mode);

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_feather_tripler_length, board_feather_tripler_width, 2, 1);
                
        translate([ -(board_feather_tripler_studs_x), -(board_feather_tripler_screw_y/2), 1]) support_stud(); 
        translate([ -(board_feather_tripler_studs_x), +(board_feather_tripler_screw_y/2), 1]) support_stud();
        translate([ +(board_feather_tripler_studs_x), -(board_feather_tripler_screw_y/2), 1]) support_stud();
        translate([ +(board_feather_tripler_studs_x), +(board_feather_tripler_screw_y/2), 1]) support_stud(); 
           
        translate([0, +8, 0]) linear_extrude(2) text("Feather", 
            size=8, , halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -4, 0]) linear_extrude(2) text("Tripler", 
            size=8, , halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -16, 0]) linear_extrude(2) text("M2.5", 
            size=8, , halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ***************************************************************************
 * this makes a base for Adafruit TB6612 H-Bridge module
 * its base is 1mm thick, and 30 x 22mm (note the TB6612 itself is 26.67 x 19.05 mm)
 * it has 2 M25 threaded insert mounts 21.95mm spacing (2.54 off edge)
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase:  https://www.adafruit.com/product/2448
 * reference: https://learn.adafruit.com/adafruit-tb6612-h-bridge-dc-stepper-motor-driver-breakout/overview
 * these drive (1) stepper, or (2) DC brushed motors; 2.7-5v logic, 4.5-13.5v motor; 1.2 A per channel
 * ***************************************************************************
 */
board_tb6612_length = 30;
board_tb6612_width = 22;
vis_tb6612_length = 26.67;
vis_tb6612_width = 19.05;
board_tb6612_screw_x = 21.59;
board_tb6612_screw_y = 6.985;

module component_tb6612(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ -(board_tb6612_screw_x/2), board_tb6612_screw_y, 1]) TI25a_mount(mode);
    translate([ +(board_tb6612_screw_x/2), board_tb6612_screw_y, 1]) TI25a_mount(mode);

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_tb6612_length, board_tb6612_width, 2, 1);

        translate([ +12, -3, 1]) support_stud();
        translate([ -12, -3, 1]) support_stud();
           
        translate([0, -2, 0]) linear_extrude(2) text("6612", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -9, 0]) linear_extrude(2) text("M2.5",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ***************************************************************************
 * this makes a base for red L298N motor driver board
 * its base is 1mm thick, and 44 x 44 mm
 * it has 4 M3 threaded insert mounts 37.5 x 37.5 mm spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.amazon.com/dp/B01J39FAK8/   or equivalent
 * this drives (1) stepper, or (2) DC brushed motors; up to 46v, 2A, max 25W
 * ***************************************************************************
 */
board_L298motor_length = 44;
board_L298motor_width = 44;
board_L298motor_screw_x = 37.5;
board_L298motor_screw_y = 37.5;

module component_L298motor_driver(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ -(board_L298motor_screw_x/2), -(board_L298motor_screw_y/2), 1]) TI30a_mount(mode); 
    translate([ -(board_L298motor_screw_x/2), +(board_L298motor_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_L298motor_screw_x/2), -(board_L298motor_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_L298motor_screw_x/2), +(board_L298motor_screw_y/2), 1]) TI30a_mount(mode);

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_L298motor_length, board_L298motor_width, 2, 1);
           
        translate([0, 4, 0]) linear_extrude(2) text("L298 Motor", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -4, 0]) linear_extrude(2) text("Driver", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -12, 0]) linear_extrude(2) text("M3",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ***************************************************************************
 * this makes a base for Sparkfun QWIIC (I2C) motor driver board
 * its base is 1mm thick, and 44 x 44 mm
 * it has 4 M3 threaded insert mounts 37.5 x 37.5 mm spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.sparkfun.com/products/15451
 * reference: https://learn.sparkfun.com/tutorials/hookup-guide-for-the-qwiic-motor-driver
 * this drives (2) DC brushed motors; up to 1.2A
 * ***************************************************************************
 */
board_qwiic_motor_length = 28;
board_qwiic_motor_width = 28;
board_qwiic_motor_screw_x = 20.3;
board_qwiic_motor_screw_y = 20.3;

module component_qwiic_motor_driver(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ -(board_qwiic_motor_screw_x/2), -(board_qwiic_motor_screw_y/2), 1]) TI30a_mount(mode); 
    translate([ -(board_qwiic_motor_screw_x/2), +(board_qwiic_motor_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_qwiic_motor_screw_x/2), -(board_qwiic_motor_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_qwiic_motor_screw_x/2), +(board_qwiic_motor_screw_y/2), 1]) TI30a_mount(mode);

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_qwiic_motor_length, board_qwiic_motor_width, 2, 1);
           
        translate([0, 4, 0]) linear_extrude(2) text("QWIIC", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -4, 0]) linear_extrude(2) text("MotDrv", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -12, 0]) linear_extrude(2) text("M3",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ***************************************************************************
 * this makes a base for Arduino proto board
 * its base is 1mm thick, and 44 x 44 mm
 * it has 4 M3 threaded insert mounts asymetrically placed
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * dimensions: https://www.flickr.com/photos/johngineer/5484250200/sizes/o/in/photostream/
 *
 * purchase: https://www.amazon.com/Electronics-Salon-Prototype-Arduino-Shield-CZH-LABS/dp/B01J1KM3RM/  
 * 
 * ***************************************************************************
 */
board_arduino_length = 68;
board_arduino_width = 54;

// the following are offsets to LOWER LEFT CORNER
board_arduino_LL_X = -board_arduino_length/2;
board_arduino_LL_Y = -board_arduino_width/2;

board_arduino_holeA_X = 14.05;
board_arduino_holeA_Y = 51;

board_arduino_holeB_X = 64.85;
board_arduino_holeB_Y = 7.6;
board_arduino_holeC_X = 64.85;
board_arduino_holeC_Y = 35.5;

board_arduino_holeD_X = 14.0;
board_arduino_holeD_Y = 2.5;

module component_arduino(mode="adds") {

    if (mode == "holes") {
        translate([ (board_arduino_LL_X +board_arduino_holeB_X), (board_arduino_LL_Y +board_arduino_holeB_Y), 1]) 
            TI30a_mount(mode); 
        translate([ (board_arduino_LL_X +board_arduino_holeC_X), (board_arduino_LL_Y +board_arduino_holeC_Y), 1]) 
            TI30a_mount(mode); 
        translate([ (board_arduino_LL_X +board_arduino_holeD_X), (board_arduino_LL_Y +board_arduino_holeD_Y), 1]) 
            TI30a_mount(mode);
    }

    if (mode == "adds") {
        roundedbox(board_arduino_length, board_arduino_width, 2, 1);

        // the "special" mount that is a peg instead of a bolt-hole because no room for a bolt due to header   
        translate([ (board_arduino_LL_X +board_arduino_holeA_X), (board_arduino_LL_Y +board_arduino_holeA_Y), 1])     
            cylinder(d=2.7, h=TI30_default_height+3);
        translate([ (board_arduino_LL_X +board_arduino_holeA_X), (board_arduino_LL_Y +board_arduino_holeA_Y), 1]) 
            difference() {
                cylinder(d=TI30_mount_diameter, h=TI30_default_height);
                translate([1.5, -3.5, 4 ]) cube([ 7, 7, 3 ]);
            }

        translate([ (board_arduino_LL_X +board_arduino_holeB_X), (board_arduino_LL_Y +board_arduino_holeB_Y), 1]) 
            TI30a_mount(mode); 
        translate([ (board_arduino_LL_X +board_arduino_holeC_X), (board_arduino_LL_Y +board_arduino_holeC_Y), 1]) 
            TI30a_mount(mode); 
        translate([ (board_arduino_LL_X +board_arduino_holeD_X), (board_arduino_LL_Y +board_arduino_holeD_Y), 1]) 
            TI30a_mount(mode);
           
        translate([0, 4, 0]) linear_extrude(2) text("Arduino", 
            size=8,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -12, 0]) linear_extrude(2) text("M3",
            size=8,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ***************************************************************************
 * this makes a base for geared stepper driver board
 * its base is 1mm thick, and 35 x 32 mm
 * it has 4 M3 threaded insert mounts 29.5 x 26.5 mm spacing
 * 
 * the "upper" version is for a stacked upper board with only 2 screws (cantilevered mount)  
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase:  https://www.amazon.com/Longruner-Stepper-Uln2003-arduino-LK67/dp/B015RQ97W8/  or equivalent
 * reference: http://www.4tronix.co.uk/arduino/Stepper-Motors.php
 * this drives (1) small unipolar stepper
 * ***************************************************************************
 */
board_gearedstepper_length = 35;
board_gearedstepper_width = 32;
board_gearedstepper_screw_x = 29.5;
board_gearedstepper_screw_y = 26.5;

module component_gearedstepper_driver(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ -(board_gearedstepper_screw_x/2), -(board_gearedstepper_screw_y/2), 1]) TI30a_mount(mode); 
    translate([ -(board_gearedstepper_screw_x/2), +(board_gearedstepper_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_gearedstepper_screw_x/2), -(board_gearedstepper_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_gearedstepper_screw_x/2), +(board_gearedstepper_screw_y/2), 1]) TI30a_mount(mode);

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_gearedstepper_length, board_gearedstepper_width, 2, 1);
                   
        translate([0, 4, 0]) linear_extrude(2) text("Geared", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -4, 0]) linear_extrude(2) text("Stepper", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -12, 0]) linear_extrude(2) text("M3",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
    
}

module component_gearedstepper_driver_upper(mode="adds") {
    lift_amount = 26;

    // the "mount" itself handles the add/holes issues
    translate([ -(board_gearedstepper_screw_x/2), -(board_gearedstepper_screw_y/2), 1]) TI30a_mount(mode, lift_amount); 
    translate([ -(board_gearedstepper_screw_x/2), +(board_gearedstepper_screw_y/2), 1]) TI30a_mount(mode, lift_amount);
    translate([ +(board_gearedstepper_screw_x/2), -(board_gearedstepper_screw_y/2), 1]) TI30a_mount(mode, lift_amount);

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {

        roundedbox(board_gearedstepper_length, board_gearedstepper_width, 2, 1);
                   
        translate([0, 4, 0]) linear_extrude(2) text("Geared", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -4, 0]) linear_extrude(2) text("Stepper", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -12, 0]) linear_extrude(2) text("M3",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ***************************************************************************
 * this makes a base for sparkfun_easydriver board
 * its base is 1mm thick, and 48.26 x 24.13 mm
 * it has 2 M3 threaded insert mounts at (-8.89, 0) and (15.24, 3.81)
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase:  https://www.sparkfun.com/products/12779
 * reference: http://www.schmalzhaus.com/EasyDriver/
 * this drives (1) small bipolar stepper
 * ***************************************************************************
 */
board_easydriver_length = 48.26;
board_easydriver_width = 24.13;


module component_easydriver(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ -8.89, 0, 1]) TI30a_mount(mode); 
    translate([ 15.24, 3.81, 1]) TI30a_mount(mode);

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_easydriver_length, board_easydriver_width, 2, 1);
           
        translate([-5, 5, 0]) linear_extrude(2) text("Sparkfun", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([+4, -3, 0]) linear_extrude(2) text("M3", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -10, 0]) linear_extrude(2) text("EasyDriver", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ********************************************************************************
 * this makes a base for Wit-Motion 16 Channel Servo PWM board
 * its base is 1mm thick, and 54 x 33 mm
 * it has 4 M3 threaded insert mounts 45.5mm x 25.4mm spacing
 * 
 * the standard function uses 4 mount screws, lifted standard mount height
 * the _lifted function uses 2 (long axis) mounts + one small support on 
 *      other edge (no screws).  the whole assembly is lefted by "lift" mm
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.amazon.com/dp/B07VMDFTVR
 * reference: htttp://www.wit-motion.com/English.php
 * reference: https://drive.google.com/drive/folders/1_8WjpV0vP6PcNjnTY1cnOyp-oYPYiWO4
 * ********************************************************************************
 */
board_wit16_length = 43.5;
board_wit16_width = 36;
board_wit16_screw_x = 37;
board_wit16_screw_y = 30;

module component_wit16_servo_controller(mode="adds") {

    // the "mount" itself handles the add/holes issues        
    translate([ -(board_wit16_screw_x/2), -(board_wit16_screw_y/2), 1]) TI30a_mount(mode); 
    translate([ -(board_wit16_screw_x/2), +(board_wit16_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_wit16_screw_x/2), -(board_wit16_screw_y/2), 1]) TI30a_mount(mode);
    translate([ +(board_wit16_screw_x/2), +(board_wit16_screw_y/2), 1]) TI30a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_wit16_length, board_wit16_width, 2, 1);
        
        translate([0, 0, 0]) linear_extrude(2) text("ServoCont", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("M3",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ********************************************************************************
 * this makes a base for Adafruit 16 Channel Servo PWM board
 * its base is 1mm thick, and 62.2 x 25 mm
 * it has 4 M2.5 threaded insert mounts 55.9mm x 19mm spacing
 * 
 * the standard function uses 4 mount screws, lifted standard mount height
 * the _lifted function uses 2 (long axis) mounts + one small support on 
 *      other edge (no screws).  the whole assembly is lefted by "lift" mm
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/815
 * reference: https://learn.adafruit.com/16-channel-pwm-servo-driver/downloads
 * ********************************************************************************
 */
board_adaservo_length = 62.2;
board_adaservo_width = 25;
board_adaservo_screw_x = 55.9;
board_adaservo_screw_y = 19;

module component_ada_servo_controller(mode="adds") {

    // the "mount" itself handles the add/holes issues        
    translate([ -(board_adaservo_screw_x/2), -(board_adaservo_screw_y/2), 1]) TI25a_mount(mode); 
    translate([ -(board_adaservo_screw_x/2), +(board_adaservo_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_adaservo_screw_x/2), -(board_adaservo_screw_y/2), 1]) TI25a_mount(mode);
    translate([ +(board_adaservo_screw_x/2), +(board_adaservo_screw_y/2), 1]) TI25a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_adaservo_length, board_adaservo_width, 2, 1);
        
        translate([0, 0, 0]) linear_extrude(2) text("ServoCont", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -8, 0]) linear_extrude(2) text("M2.5",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * module component_amplified_speaker() generates a mount plate for Adafruit Class D Amp + Speaker
 * 
 * this has no underlying "plate" -- it should be placed at the inner surface of the wall or lid 
 * that it sits on.
 *
 * @param soundhole_pattern: 0/none, 1/inline 5, 2/inline 3/cross 3, 4/two slots
 * @param soundhole_x: soundhole pattern displacement from board center in x (long) dimension
 * @param soundhole_y: soundhole pattern displacement from board center in y (short) dimension
 *
 * purchase:  https://www.adafruit.com/product/3885
 * 
 */

board_aspkr_length = 37;
board_aspkr_width = 30;
board_aspkr_screw_x = 32;
board_aspkr_screw_y = 25;

module component_amplified_speaker(mode="holes", soundhole_pattern=3, soundhole_x=0, soundhole_y=0) {

    // the "mount" itself handles the add/holes issues
        translate([ +(board_aspkr_screw_x/2), -(board_aspkr_screw_y/2), 1]) TI20a_mount(mode, 6);
        translate([ +(board_aspkr_screw_x/2), +(board_aspkr_screw_y/2), 1]) TI20a_mount(mode, 6); 

    if (mode == "holes") {
        // no holes for this component
        translate([ soundhole_x, soundhole_y, 0 ]) component_spkr_holes(soundhole_pattern);
    }

    if (mode == "adds") {
        roundedbox(board_aspkr_length, board_aspkr_width, 2, 1);
        translate([ -(board_aspkr_screw_x/2), -(board_aspkr_screw_y/2), 1]) support_stud(6); 
        translate([ -(board_aspkr_screw_x/2), +(board_aspkr_screw_y/2), 1]) support_stud(6);
    }
    
}


// subcomponent_spkr_holes generates holes for sound outlet for audio speaker
// @param: pattern = 1/inline 5, 2/inline 3/cross 3, 4/two slots

module component_spkr_holes(pattern=3) {
   if (pattern == 1) { 
        translate([ 0, 5, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, 0, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, -5, -5 ]) cylinder( d=3, h=9 );
    }
   if (pattern == 2) { 
        translate([ 0, 10, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, 5, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, 0, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, -5, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, -10, -5 ]) cylinder( d=3, h=9 );
    }
   if (pattern == 3) { 
        translate([ -5, 0, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, 5, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, 0, -5 ]) cylinder( d=3, h=9 );
        translate([ 0, -5, -5 ]) cylinder( d=3, h=9 );
        translate([ 5, 0, -5 ]) cylinder( d=3, h=9 );
    }
   if (pattern == 4) { 
        translate([ -4, 0, -5 ]) roundedbox( 2.5, 8, 1, h=9 );
        translate([ 4, 0, -5 ]) roundedbox( 2.5, 8, 1, h=9 );
    }
}


/*
 * module part_dts_plate() generates a mount plate for a singlewide DTS board 
 * that fits on a lid grid (16 x 16 mm);  the M3 mounting holes for a DTS
 * board are on 32 x 48 mm centers; the mount studs are passthru M3 with
 * the intention that an M3 bolt goes through the board, through the mount
 * and threads into the grid (use M3 x 8mm)
 */

module part_dts_plate() {
    difference() {
        union() {
            roundedbox(48+8, 32+8, 2, 1);
            translate([ -24, 16, 1]) cylinder( r=(TI30_mount_diameter/2), h=3);
            translate([ -24, -16, 1]) cylinder( r=(TI30_mount_diameter/2), h=3);
            translate([ 24, 16, 1]) cylinder( r=(TI30_mount_diameter/2), h=3);
            translate([ 24, -16, 1]) cylinder( r=(TI30_mount_diameter/2), h=3);
        }
        union() {
            translate([ -24, 16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
            translate([ -24, -16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
            translate([ 24, 16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
            translate([ 24, -16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        }
    }
}


/*
 * module part_itsy_plate() generates a mount plate for a ItsyBitsy or Teensy 4.0 board 
 * that fits on a lid grid (16 x 16 mm);  the M3 mounting holes for a DTS
 * board are on 32 x 48 mm centers; the mount studs are passthru M3 with
 * the intention that an M3 bolt goes through the board, through the mount
 * and threads into the grid (use M3 x 8mm)
 */

module part_itsy_plate() {
    difference() {
        union() {
            roundedbox(48+8, 32+8, 2, 1);
            rotate([ 0, 0, 90]) component_itsy("adds");
        }
        rotate([ 0, 0, 90]) component_itsy("holes");
        translate([ -24, 16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ -24, -16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ 24, 16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ 24, -16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        
    }
}


/*
 * module part_pico_plate() generates a mount plate for a Raspberry Pi Pico board 
 * that fits on a lid grid (16 x 16 mm);  the M3 mounting holes for a DTS
 * board are on 32 x 48 mm centers; the mount studs are passthru M3 with
 * the intention that an M3 bolt goes through the board, through the mount
 * and threads into the grid (use M3 x 8mm)
 */

module part_pico_plate() {
    difference() {
        union() {
            roundedbox(64+8, 32+8, 2, 1);
            rotate([ 0, 0, 90]) component_pico("adds");
        }
        rotate([ 0, 0, 90]) component_pico("holes");
        translate([ -32, 16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ -32, -16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ 32, 16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ 32, -16, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        
    }
}

/*
 * module part_stemma5_plate() generates a mount plate for a Stemma 0.5 x 0.8 board 
 * that fits on a lid grid (16 x 16 mm);  the M3 mounting holes for a DTS
 * board are on 32 x 48 mm centers; the mount studs are passthru M3 with
 * the intention that an M3 bolt goes through the board, through the mount
 * and threads into the grid (use M3 x 8mm)
 */

module part_stemma5_plate() {
    difference() {
        union() {
            roundedbox(32+8, 16+8, 2, 1);
            component_stemma5("adds");
        }
        component_stemma5("holes");
        translate([ -16, 8, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ -16, -8, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ 16, 8, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ 16, -8, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        
    }
}


/*
 * module part_stemma6_plate() generates a mount plate for a Stemma 0.65 x 0.8 board 
 * that fits on a lid grid (16 x 16 mm);  the M3 mounting holes for a DTS
 * board are on 32 x 48 mm centers; the mount studs are passthru M3 with
 * the intention that an M3 bolt goes through the board, through the mount
 * and threads into the grid (use M3 x 8mm)
 */

module part_stemma6_plate() {
    difference() {
        union() {
            roundedbox(32+8, 16+8, 2, 1);
            component_stemma6("adds");
        }
        component_stemma6("holes");
        translate([ -16, 8, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ -16, -8, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ 16, 8, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        translate([ 16, -8, -1]) cylinder( r=screwhole_radius_M30_passthru, h=6);
        
    }
}


/*
 * friction mount for ItsyBitsy or Teensy 4.0
 * note that this should be placed with z axis 0 aligned to outside wall of box or lid (not on inside surface)
 */

itsy_bd_x = 18;
itsy_bd_y = 36.5;           // later put this in config.py file because its such tight tolerance
itsy_uses_headers = false;  // this too

// note parameter "board_thickness" comes from config file

itsy_lip_width = (itsy_uses_headers) ? 1.5 : 2;
itsy_mountblock_x = itsy_bd_x + itsy_lip_width + 9;
itsy_mountblock_y = itsy_bd_y + itsy_lip_width + itsy_lip_width;
itsy_board_raise = 4;   // height of board lip above clamp slider surface (gap for underboard wire clearance)
itsy_mountblock_thick = 5 + itsy_board_raise;
itsy_screw_spacing = 24;

module component_itsy(mode="adds") {

    if (mode=="holes") {
        translate([ (itsy_mountblock_x/2) - 3, +itsy_screw_spacing/2, -1 ]) 
            cylinder( d=TI30_through_hole_diameter, h=itsy_mountblock_thick+1.1);
        translate([ (itsy_mountblock_x/2) - 3, -itsy_screw_spacing/2, -1 ]) 
            cylinder( d=TI30_through_hole_diameter, h=itsy_mountblock_thick+1.1);

        if (!itsy_uses_headers) {
            translate([ -((itsy_mountblock_x/2)-itsy_lip_width-0.1), 0, itsy_mountblock_thick-board_thickness]) 
                rotate([ 0, 0, 180 ]) 
                board_groove(itsy_bd_y);
        }
    }

    if (mode == "adds") {
        difference() {
            roundedbox(itsy_mountblock_x, itsy_mountblock_y, 1, itsy_mountblock_thick);       

            translate([ -((itsy_mountblock_x/2)-itsy_lip_width), -(itsy_bd_y/2), (itsy_mountblock_thick-itsy_board_raise) ]) 
                cube([ itsy_bd_x + 12, itsy_bd_y, 5.1 ]);
        }

        // board "rest" surfaces (pedestals to support bottom of board)
        translate([ -4, -(itsy_bd_y/2)+6, 0 ])
            roundedbox(itsy_bd_x-8, 4, 1, itsy_mountblock_thick-board_thickness);
        translate([ -4, (itsy_bd_y/2)-2, 0 ])
            roundedbox(itsy_bd_x-8, 4, 1, itsy_mountblock_thick-board_thickness);

        // if the board DOESN'T use headers, make left edge taller so it can accept a board groove
        if (!itsy_uses_headers) {
            translate([ -(itsy_mountblock_x/2- itsy_lip_width/2), 0, itsy_mountblock_thick ]) 
                roundedbox ( itsy_lip_width, itsy_mountblock_y, 1, 3 );
        }
    }
}

module part_itsy_clamp() {
    if (itsy_uses_headers) {
        // cannot use groove for PCB because of headers.  just a flat push block.
        difference() {
            union() {
                translate([ 0, -(itsy_bd_y-2)/2, 0 ]) cube([ 10, itsy_bd_y-2, 1 ]);
                translate([ 0, -(itsy_bd_y-2)/2, 0 ]) cube([ itsy_lip_width, itsy_bd_y-2, itsy_mountblock_thick-3 ]);
            }
            translate([ itsy_lip_width+4, +itsy_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            translate([ itsy_lip_width+4, -itsy_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
        }
    } else {
        // no headers, so can make walls a little taller/thicker and add a groove for PCB
        difference() {
            union() {
                translate([ 0, -(itsy_bd_y-2)/2, 0 ]) cube([ itsy_lip_width+8.5, itsy_bd_y-2, 1 ]);
                translate([ 0, -(itsy_bd_y-2)/2, 0 ]) cube([ itsy_lip_width, itsy_bd_y-2, itsy_mountblock_thick-1 ]);
            }
            translate([ itsy_lip_width+4, +itsy_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            translate([ itsy_lip_width+4, -itsy_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            // this is the PCB groove (to remove...)
             translate([ 0, 0, itsy_board_raise - board_thickness]) board_groove(itsy_bd_y-2);
        }
    }
}


/*
 * friction mount for Raspberry Pi Pico
 * note that this should be placed with z axis 0 aligned to outside wall of box or lid (not on inside surface)
 */

pico_bd_x = 21;
pico_bd_y = 52;           // later put this in config.py file because its such tight tolerance
pico_uses_headers = false;  // this too

// note parameter "board_thickness" comes from config file

pico_lip_width = (pico_uses_headers) ? 1.5 : 2;
pico_mountblock_x = pico_bd_x + pico_lip_width + 9;
pico_mountblock_y = pico_bd_y + pico_lip_width + pico_lip_width;
pico_board_raise = 4;   // height of board lip above clamp slider surface (gap for underboard wire clearance)
pico_mountblock_thick = 5 + pico_board_raise;
pico_screw_spacing = 24;

module component_pico(mode="adds") {

    if (mode=="holes") {
        translate([ (pico_mountblock_x/2) - 3, +pico_screw_spacing/2, -1 ]) 
            cylinder( d=TI30_through_hole_diameter, h=pico_mountblock_thick+1.1);
        translate([ (pico_mountblock_x/2) - 3, -pico_screw_spacing/2, -1 ]) 
            cylinder( d=TI30_through_hole_diameter, h=pico_mountblock_thick+1.1);

        if (!pico_uses_headers) {
            translate([ -((pico_mountblock_x/2)-pico_lip_width-0.1), 0, pico_mountblock_thick-board_thickness]) 
                rotate([ 0, 0, 180 ]) 
                board_groove(pico_bd_y);
        }
    }

    if (mode == "adds") {
        difference() {
            roundedbox(pico_mountblock_x, pico_mountblock_y, 1, pico_mountblock_thick);       

            translate([ -((pico_mountblock_x/2)-pico_lip_width), -(pico_bd_y/2), (pico_mountblock_thick-pico_board_raise) ]) 
                cube([ pico_bd_x + 12, pico_bd_y, 5.1 ]);
        }

        // board "rest" surfaces (pedestals to support bottom of board)
        translate([ -4, -(pico_bd_y/2)+6, 0 ])
            roundedbox(pico_bd_x-8, 4, 1, pico_mountblock_thick-board_thickness);
        translate([ -4, (pico_bd_y/2)-2, 0 ])
            roundedbox(pico_bd_x-8, 4, 1, pico_mountblock_thick-board_thickness);

        // if the board DOESN'T use headers, make left edge taller so it can accept a board groove
        if (!pico_uses_headers) {
            translate([ -(pico_mountblock_x/2- pico_lip_width/2), 0, pico_mountblock_thick ]) 
                roundedbox ( pico_lip_width, pico_mountblock_y, 1, 3 );
        }
    }
}

module part_pico_clamp() {
    if (pico_uses_headers) {
        // cannot use groove for PCB because of headers.  just a flat push block.
        difference() {
            union() {
                translate([ 0, -(pico_bd_y-2)/2, 0 ]) cube([ 10, pico_bd_y-2, 1 ]);
                translate([ 0, -(pico_bd_y-2)/2, 0 ]) cube([ pico_lip_width, pico_bd_y-2, pico_mountblock_thick-3 ]);
            }
            translate([ pico_lip_width+4, +pico_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            translate([ pico_lip_width+4, -pico_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
        }
    } else {
        // no headers, so can make walls a little taller/thicker and add a groove for PCB
        difference() {
            union() {
                translate([ 0, -(pico_bd_y-2)/2, 0 ]) cube([ pico_lip_width+8.5, pico_bd_y-2, 1 ]);
                translate([ 0, -(pico_bd_y-2)/2, 0 ]) cube([ pico_lip_width, pico_bd_y-2, pico_mountblock_thick-1 ]);
            }
            translate([ pico_lip_width+4, +pico_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            translate([ pico_lip_width+4, -pico_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            // this is the PCB groove (to remove...)
             translate([ 0, 0, pico_board_raise - board_thickness]) board_groove(pico_bd_y-2);
        }

    }
}



/*
 * friction mount for QTPy
 * note that this should be placed with z axis 0 aligned to outside wall of box or lid (not on inside surface)
 */

qtpy_bd_x = 20;     // was 18
qtpy_bd_y = 21;             // later put this in config.py file because its such tight tolerance
qtpy_uses_headers = false;  // this too

// note parameter "board_thickness" comes from config file
// note parameter "full" refers to board supports (rest) between board and base
//      "separated", "full", or "none" 

qtpy_lip_width = (qtpy_uses_headers) ? 1.5 : 2;
qtpy_mountblock_x = qtpy_bd_x + qtpy_lip_width + 9;
qtpy_mountblock_y = qtpy_bd_y + qtpy_lip_width + qtpy_lip_width;
qtpy_board_raise = 4;   // height of board lip above clamp slider surface (gap for underboard wire clearance)
qtpy_mountblock_thick = 5 + qtpy_board_raise;
qtpy_screw_spacing = 0;

module component_qtpy(mode="adds", pillar="separated") {

    if (mode=="holes") {
        translate([ (qtpy_mountblock_x/2) - 5, +qtpy_screw_spacing/2, -6 ]) 
            cylinder( d=TI30_through_hole_diameter+0.1, h=qtpy_mountblock_thick+7.1);
        translate([ (qtpy_mountblock_x/2) - 5, -qtpy_screw_spacing/2, -6 ]) 
            cylinder( d=TI30_through_hole_diameter+0.1, h=qtpy_mountblock_thick+7.1);

        if (!qtpy_uses_headers) {
            translate([ -((qtpy_mountblock_x/2)-qtpy_lip_width-0.1), 0, qtpy_mountblock_thick-board_thickness]) 
                rotate([ 0, 0, 180 ]) 
                board_groove(qtpy_bd_y);
        }
    }

    if (mode == "adds") {
        difference() {
            roundedbox(qtpy_mountblock_x, qtpy_mountblock_y, 1, qtpy_mountblock_thick);       

            translate([ -((qtpy_mountblock_x/2)-qtpy_lip_width), -(qtpy_bd_y/2), (qtpy_mountblock_thick-qtpy_board_raise) ]) 
                cube([ qtpy_bd_x + 12, qtpy_bd_y, 5.1 ]);
        }

        if (pillar == "separated") {
            // board "rest" surfaces (pedestals to support bottom of board)
            translate([ -4, -(qtpy_bd_y/2)+2, 0 ])
                roundedbox(qtpy_bd_x-8, 4, 1, qtpy_mountblock_thick-board_thickness);
            translate([ -4, (qtpy_bd_y/2)-2, 0 ])
                roundedbox(qtpy_bd_x-8, 4, 1, qtpy_mountblock_thick-board_thickness);
        } 
        if (pillar == "full") {
            // board "rest" surface (pedestal to support bottom of board)
            translate([ -4, 0, 0 ])
                roundedbox(qtpy_bd_x-8, (qtpy_bd_y), 1, qtpy_mountblock_thick-board_thickness);
        } 


        // if the board DOESN'T use headers, make left edge taller so it can accept a board groove
        if (!qtpy_uses_headers) {
            translate([ -(qtpy_mountblock_x/2- qtpy_lip_width/2), 0, qtpy_mountblock_thick ]) 
                roundedbox ( qtpy_lip_width, qtpy_mountblock_y, 1, 3 );
        }
    }
}

module part_qtpy_clamp() {
    if (qtpy_uses_headers) {
        // cannot use groove for PCB because of headers.  just a flat push block.
        difference() {
            union() {
                translate([ 0, -(qtpy_bd_y-2)/2, 0 ]) cube([ 10, qtpy_bd_y-2, 1 ]);
                translate([ 0, -(qtpy_bd_y-2)/2, 0 ]) cube([ qtpy_lip_width, qtpy_bd_y-2, qtpy_mountblock_thick-3 ]);
            }
            translate([ qtpy_lip_width+4, +qtpy_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            translate([ qtpy_lip_width+4, -qtpy_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
        }
    } else {
        // no headers, so can make walls a little thicker and add a groove for PCB
        difference() {
            union() {
                translate([ 0, -(qtpy_bd_y-2)/2, 0 ]) cube([ qtpy_lip_width+8.5, qtpy_bd_y-2, 1 ]);
                translate([ 0, -(qtpy_bd_y-2)/2, 0 ]) cube([ qtpy_lip_width, qtpy_bd_y-2, qtpy_mountblock_thick-3 ]);
            }
            translate([ qtpy_lip_width+4, +qtpy_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            translate([ qtpy_lip_width+4, -qtpy_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            // this is the PCB groove (to remove...)
            translate([ 0, 0, qtpy_board_raise - board_thickness]) board_groove(qtpy_bd_y-2);
        }
    }
}


/*
 * friction mount for Adafruit I2C-safe BiDirectional Level Shifter
 * purchas link: https://www.adafruit.com/product/757
 * note that this should be placed with z axis 0 aligned to outside wall of box or lid (not on inside surface)
 */

levshift_bd_x = 20.5;
levshift_bd_y = 16.2;              // later put this in config.py file because its such tight tolerance
levshift_uses_headers = false;      // this too

// note parameter "board_thickness" comes from config file

levshift_lip_width = (levshift_uses_headers) ? 1.5 : 2;
levshift_mountblock_x = levshift_bd_x + levshift_lip_width + 9;
levshift_mountblock_y = levshift_bd_y + levshift_lip_width + levshift_lip_width;
levshift_board_raise = 4;   // height of board lip above clamp slider surface (gap for underboard wire clearance)
levshift_mountblock_thick = 5 + levshift_board_raise;
levshift_screw_spacing = 0;

module component_levshift(mode="adds") {

    if (mode=="holes") {
        translate([ (levshift_mountblock_x/2) - 3, +levshift_screw_spacing/2, -1 ]) 
            cylinder( d=TI30_through_hole_diameter, h=levshift_mountblock_thick+1.1);
        translate([ (levshift_mountblock_x/2) - 3, -levshift_screw_spacing/2, -1 ]) 
            cylinder( d=TI30_through_hole_diameter, h=levshift_mountblock_thick+1.1);

        if (!levshift_uses_headers) {
            translate([ -((levshift_mountblock_x/2)-levshift_lip_width-0.1), 0, levshift_mountblock_thick-board_thickness]) 
                rotate([ 0, 0, 180 ]) 
                board_groove(levshift_bd_y);
        }
    }

    if (mode == "adds") {
        difference() {
            roundedbox(levshift_mountblock_x, levshift_mountblock_y, 1, levshift_mountblock_thick);       

            translate([ -((levshift_mountblock_x/2)-levshift_lip_width), -(levshift_bd_y/2), (levshift_mountblock_thick-levshift_board_raise) ]) 
                cube([ levshift_bd_x + 12, levshift_bd_y, 5.1 ]);
        }

        // board "rest" surfaces (pedestals to support bottom of board)
        translate([ -4, -(levshift_bd_y/2)+2, 0 ])
            roundedbox(levshift_bd_x-8, 4, 1, levshift_mountblock_thick-board_thickness);
        translate([ -4, (levshift_bd_y/2)-2, 0 ])
            roundedbox(levshift_bd_x-8, 4, 1, levshift_mountblock_thick-board_thickness);


        // if the board DOESN'T use headers, make left edge taller so it can accept a board groove
        if (!levshift_uses_headers) {
            translate([ -(levshift_mountblock_x/2- levshift_lip_width/2), 0, levshift_mountblock_thick ]) 
                roundedbox ( levshift_lip_width, levshift_mountblock_y, 1, 3 );
        }
    }
}

module part_levshift_clamp() {
    if (levshift_uses_headers) {
        // cannot use groove for PCB because of headers.  just a flat push block.
        difference() {
            union() {
                translate([ 0, -(levshift_bd_y-2)/2, 0 ]) cube([ 10, levshift_bd_y-2, 1 ]);
                translate([ 0, -(levshift_bd_y-2)/2, 0 ]) cube([ levshift_lip_width, levshift_bd_y-2, levshift_mountblock_thick-3 ]);
            }
            translate([ levshift_lip_width+4, +levshift_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            translate([ levshift_lip_width+4, -levshift_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
        }
    } else {
        // no headers, so can make walls a little thicker and add a groove for PCB
        difference() {
            union() {
                translate([ 0, -(levshift_bd_y-2)/2, 0 ]) cube([ levshift_lip_width+8.5, levshift_bd_y-2, 1 ]);
                translate([ 0, -(levshift_bd_y-2)/2, 0 ]) cube([ levshift_lip_width, levshift_bd_y-2, levshift_mountblock_thick-3 ]);
            }
            translate([ levshift_lip_width+4, +levshift_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            translate([ levshift_lip_width+4, -levshift_screw_spacing/2, -0.1 ]) 
                roundedbox( 6, 3.2, 1, 1.2 );
            // this is the PCB groove (to remove...)
            translate([ 0, 0, levshift_board_raise - board_thickness]) board_groove(levshift_bd_y-2);
        }
    }
}



// note parameter "board_thickness" comes from config file

module board_groove(length) {

    translate([ -0.1, -(length+0.2)/2, 0 ]) cube([ 1, length+0.2, board_thickness ]);
    translate([ 1, -(length+0.2)/2, board_thickness ]) rotate([ 0, 0, 90 ]) prism(length+0.2, 1, 1);
}

/*
*************************************************************************
* part_esp32 dev module_mount_plate()
* this is the lid-mounting plate that holds esp32 devkit board (30 pin)
* param: style = "2hole" or "4hole" for mounting plate
* purchase: https://www.amazon.com/dp/B08D5ZD528/ref=cm_sw_r_apa_i_ZMJX2R0827SVEJP5NDCP_0?th=1
*************************************************************************
 */

module part_esp32_dev_module_mount_plate() {
    esp_screw_sep = 23.5;
    esp_pillar_width = 18;
    board_esp32_width = 30;

    mount_psn_y = 6;
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    plate_width_Y = 25;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12 + 8; // total length of plate in mm (X)


    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 3);
        translate([ -mount_length_X/2, mount_psn_y, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_psn_y, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }

    translate([ 0, -plate_width_Y/2, 0 ]) difference() {
        union() {
            // bottom wide part
            translate([ -(board_esp32_width+4)/2, 0, 0 ]) cube([ board_esp32_width+4, 6, 10 ]);

            // raised tab to provide additional vertical support and backstop for board
            translate([ -7.5, 0, 0 ]) cube([ 15, 6, 60 ]);

            // top wide part
            //translate([ -(board_esp32_width+4)/2, 0, 52 ]) cube([ board_esp32_width+4, 6, 8 ]);

            translate([1, 5, 30]) rotate([ 90, -90, 180 ]) linear_extrude(2) text("ESP32 Devkit", size=6,  halign="center", font = "Liberation Sans:style=Bold");

            translate([-6, 5, 30]) rotate([ 90, -90, 180 ]) linear_extrude(2) text("30-pin", size=6,  halign="center", font = "Liberation Sans:style=Bold");
        }

        // screw holes (or thermal insert holes)
        //if (TI30_use_threaded_insert) {
        //    translate([ esp_screw_sep/2, -0.1, 56 ]) rotate([ -90, 0, 0 ]) 
        //        cylinder( d=TI30_through_hole_diameter, h=6.2);
        //    translate([ -esp_screw_sep/2, -0.1, 56 ]) rotate([ -90, 0, 0 ]) 
        //        cylinder( d=TI30_through_hole_diameter, h=6.2);
        //} else {
            translate([ esp_screw_sep/2, -0.1, 7 ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=6.2);
            translate([ -esp_screw_sep/2, -0.1, 7 ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=6.2);
        //}
    }
  
    //translate([0, 4, 1]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("ESP32", 
    //    size=6,  halign="center", font = "Liberation Sans:style=Bold");

}



/*
*************************************************************************
* part_qtpy_vertical_mount_plate()
* this is the lid-mounting plate that holds a QTPy
* purchase: 
*************************************************************************
 */

module part_qtpy_vertical_mount_plate() {
    board_qtpy_width = 30;

    mount_psn_y = 6;
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    plate_width_Y = 25;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12 + 8; // total length of plate in mm (X)


    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 3);
        translate([ -mount_length_X/2, mount_psn_y, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_psn_y, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }

    translate([ 0, -plate_width_Y/2, 0 ]) difference() {
        union() {
            // tall vertical tab
            translate([ -(board_qtpy_width+4)/2, 0, 0 ]) cube([ board_qtpy_width+4, 5, 40 ]);

            // shorter vertical tab (for print support)
            translate([ -(board_qtpy_width+4)/2, 0, 0 ]) cube([ board_qtpy_width+4, 14, 8 ]);

            translate([ 0, 2, 22 ]) rotate([ -90, -90, 0 ]) 
                component_qtpy(mode="adds", pillar="full");
        }
        translate([ 0, 2, 22 ]) rotate([ -90, -90, 0 ]) 
                component_qtpy(mode="holes", pillar="full");
    }
  
    translate([0, 9, 2]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("QTPy", 
        size=6,  halign="center", font = "Liberation Sans:style=Bold");

}


/*
*************************************************************************
* part_smallmint_vertical_landscape()
* this is the lid-mounting plate that holds a Small Mint Tin board in landscape orientation
* purchase: 
*************************************************************************
 */

module part_smallmint_vertical_landscape() {
    board_width_x = 64;

    mount_psn_y = 6;
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    plate_width_Y = 25;  // total width of plate in mm (Y)
    plate_length_X = board_width_x + 8; // total length of plate in mm (X)


    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 3);
        translate([ -mount_length_X/2, mount_psn_y, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_psn_y, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }

    translate([ 0, -plate_width_Y/2, 0 ]) difference() {
        union() {
            // tall vertical tab
            translate([ -(board_width_x+4)/2, 0, 0 ]) cube([ board_width_x+4, 5, 40 ]);
            translate([ 0, 5, 22 ]) rotate([ -90, 180, 0 ])    
                component_smallmint_protoboard("adds");
        }
        translate([ 0, 5, 22 ]) rotate([ -90, 180, 0 ])
            component_smallmint_protoboard("holes");
    }
  
    //translate([0, 9, 2]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("Small Mint", 
    //    size=6,  halign="center", font = "Liberation Sans:style=Bold");

}

/*
*************************************************************************
* part_smallmint_dual_vertical_landscape()
* this is the lid-mounting plate that holds a Small Mint Tin board in landscape orientation
* purchase: 
*************************************************************************
 */

module part_smallmint_dual_vertical_landscape() {
    board_width_x = 64;

    mount_psn_y = 6;
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    plate_width_Y = 25;  // total width of plate in mm (Y)
    plate_length_X = board_width_x + 8; // total length of plate in mm (X)


    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 3);
        translate([ -mount_length_X/2, mount_psn_y, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_psn_y, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }

    translate([ 0, -plate_width_Y/2, 0 ]) difference() {
        union() {
            // tall vertical tab
            translate([ -(board_width_x+4)/2, 0, 0 ]) cube([ board_width_x+4, 5, 76 ]);
            translate([ 0, 5, 22 ]) rotate([ -90, 180, 0 ])    
                component_smallmint_protoboard("adds");
            translate([ 0, 5, 58 ]) rotate([ -90, 180, 0 ])    
                component_smallmint_protoboard("adds");
        }
        translate([ 0, 5, 22 ]) rotate([ -90, 180, 0 ])
            component_smallmint_protoboard("holes");
            translate([ 0, 5, 58 ]) rotate([ -90, 180, 0 ])    
                component_smallmint_protoboard("holes");
    }
  
    //translate([0, 9, 2]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("Small Mint", 
    //    size=6,  halign="center", font = "Liberation Sans:style=Bold");

}

/*
*************************************************************************
* part_rpizero_spycam_mount_plate()
* this is the lid-mounting plate that holds pivot for rpizero_spycam
*************************************************************************
 */

module part_rpizero_spycam_mount_plate() {
    mount_width_Y = 2 * 16;          // mm separation of mount holes (Y)
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    plate_width_Y = mount_width_Y + 12;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12 + 8; // total length of plate in mm (X)

    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 1);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
    }

    translate([ 0, -4, 0 ]) difference() {
        // mount block for pi zero
        translate([ -(board_pizero_width+4)/2, -5, 0 ]) cube([ board_pizero_width+4, 6, 20 ]);

        // screw holes (or thermal insert holes)
        if (TI30_use_threaded_insert) {
            translate([ board_pizero_screw_y/2, -5.1, 16 ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=6.2);
            translate([ -board_pizero_screw_y/2, -5.1, 16 ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=6.2);
        } else {
            translate([ board_pizero_screw_y/2, -5.1, 16 ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=6.2);
            translate([ -board_pizero_screw_y/2, -5.1, 16 ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=6.2);
        }
    }
    // raised tab to provide additional vertical support and backstop for camera
    translate([ -7.5, -9, 0 ]) cube([ 15, 6, 50 ]);
  
    translate([0, 11, 0]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("RPi Zero", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}

/*
 * part_rpizero_vertical_with_smallmint()
 */

module part_rpizero_vertical_with_smallmint() {
    mount_width_Y = 2 * 16;          // mm separation of mount holes (Y)
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    plate_width_Y = mount_width_Y + 12;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12 + 8; // total length of plate in mm (X)

    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 1);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
    }

    translate([ 0, -4, 0 ]) difference() {
        // mount block for pi zero
        translate([ -(board_pizero_width+4)/2, -5, 0 ]) cube([ board_pizero_width+4, 8, 20 ]);

        // screw holes (or thermal insert holes)
        if (TI30_use_threaded_insert) {
            translate([ board_pizero_screw_y/2, -5.1, 16 ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=8.2);
            translate([ -board_pizero_screw_y/2, -5.1, 16 ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=8.2);
        } else {
            translate([ board_pizero_screw_y/2, -5.1, 16 ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=8.2);
            translate([ -board_pizero_screw_y/2, -5.1, 16 ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=8.2);
        }
    }
    // raised tab to provide additional vertical support and backstop for camera
    translate([ -7.5, -9, 0 ]) cube([ 15, 8, 70 ]);


    translate([ 0, -4, 46 ]) rotate([ 90, 0, 0 ]) difference() {  
        union() {  
            roundedbox(board_smallmintproto_width, board_smallmintproto_length, 2, 5);
            translate([ -(board_smallmintproto_screw_y/2), -(board_smallmintproto_screw_x/2), 5]) 
                cylinder(d1=9, d2=7, h=2);
            translate([ -(board_smallmintproto_screw_y/2), +(board_smallmintproto_screw_x/2), 5]) 
                cylinder(d1=9, d2=7, h=2);
            translate([ +(board_smallmintproto_screw_y/2), -(board_smallmintproto_screw_x/2), 5]) 
                cylinder(d1=9, d2=7, h=2);
            translate([ +(board_smallmintproto_screw_y/2), +(board_smallmintproto_screw_x/2), 5]) 
                cylinder(d1=9, d2=7, h=2);
        }
        translate([ -(board_smallmintproto_screw_y/2), -(board_smallmintproto_screw_x/2), -1]) 
            cylinder(d=TI30_through_hole_diameter, h=12); 
        translate([ -(board_smallmintproto_screw_y/2), +(board_smallmintproto_screw_x/2), -1]) 
            cylinder(d=TI30_through_hole_diameter, h=12);
        translate([ +(board_smallmintproto_screw_y/2), -(board_smallmintproto_screw_x/2), -1]) 
            cylinder(d=TI30_through_hole_diameter, h=12);
        translate([ +(board_smallmintproto_screw_y/2), +(board_smallmintproto_screw_x/2), -1]) 
            cylinder(d=TI30_through_hole_diameter, h=12); 
    }
  
    translate([0, 11, 0]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("RPi Zero", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");
    translate([0, -18, 0]) rotate([ 0, 0, 0 ]) linear_extrude(2) text("Mint", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}


/*
 * part_tft_and_smallmint_vert() is a vertical mount (similar to part_rpizero_vertical_with_smallmint())
 * that mounts a SmallMint protoboard (typ for qtpy) on one side, and has holes for a (part_1x54_TFT_tilty_mount_plate)
 * on the other side
 */

module part_tft_and_smallmint_vert() {
    mount_width_Y = 2 * 16;          // mm separation of mount holes (Y)
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    plate_width_Y = mount_width_Y + 12;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12 + 8; // total length of plate in mm (X)

    tft_plate_mount_delta = 8;      // mount holes are on 16mm centers, so 16/2 = 8 dist from center
    tft_plate_ctr_z = 48;

    // plate that mounts this to robot
    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 1);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
    }

    translate([ 0, -4, 0 ]) difference() {
        // tall vertical pedestal
        union() {
            // the tall vertical pedestal itself
            translate([ -(board_pizero_width+4)/2, -5, 0 ]) cube([ board_pizero_width+4, 8, 73 ]);

            // mounting pedestals for smallmint board
            translate([ 0, -4, 46 ]) rotate([ 90, 0, 0 ]) difference() {  
                union() {  
                    translate([ -(board_smallmintproto_screw_y/2), -(board_smallmintproto_screw_x/2), 1]) 
                        cylinder(d1=9, d2=7, h=2);
                    translate([ -(board_smallmintproto_screw_y/2), +(board_smallmintproto_screw_x/2), 1]) 
                        cylinder(d1=9, d2=7, h=2);
                    translate([ +(board_smallmintproto_screw_y/2), -(board_smallmintproto_screw_x/2), 1]) 
                        cylinder(d1=9, d2=7, h=2);
                    translate([ +(board_smallmintproto_screw_y/2), +(board_smallmintproto_screw_x/2), 1]) 
                        cylinder(d1=9, d2=7, h=2);
                }
            }
        }

        // mount holes for TFT angled bracket
        if (TI30_use_threaded_insert) {
            translate([ tft_plate_mount_delta, -5.1, (tft_plate_ctr_z - tft_plate_mount_delta) ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=8.2);
            translate([ -tft_plate_mount_delta, -5.1, (tft_plate_ctr_z - tft_plate_mount_delta) ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=8.2);
            translate([ tft_plate_mount_delta, -5.1, (tft_plate_ctr_z + tft_plate_mount_delta) ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=8.2);
            translate([ -tft_plate_mount_delta, -5.1, (tft_plate_ctr_z + tft_plate_mount_delta) ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=8.2);
        } else {
            translate([ tft_plate_mount_delta, -5.1, (tft_plate_ctr_z - tft_plate_mount_delta) ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=8.2);
            translate([ -tft_plate_mount_delta, -5.1, (tft_plate_ctr_z - tft_plate_mount_delta) ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=8.2);
            translate([ tft_plate_mount_delta, -5.1, (tft_plate_ctr_z + tft_plate_mount_delta) ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=8.2);
            translate([ -tft_plate_mount_delta, -5.1, (tft_plate_ctr_z + tft_plate_mount_delta) ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=8.2);
        }
        // the holes for the smallmint board
        translate([ 0, -4, 46 ]) rotate([ 90, 0, 0 ]) union() {  
            translate([ -(board_smallmintproto_screw_y/2), -(board_smallmintproto_screw_x/2), -8]) 
                cylinder(d=TI30_through_hole_diameter, h=12); 
            translate([ -(board_smallmintproto_screw_y/2), +(board_smallmintproto_screw_x/2), -8]) 
                cylinder(d=TI30_through_hole_diameter, h=12);
            translate([ +(board_smallmintproto_screw_y/2), -(board_smallmintproto_screw_x/2), -8]) 
                cylinder(d=TI30_through_hole_diameter, h=12);
            translate([ +(board_smallmintproto_screw_y/2), +(board_smallmintproto_screw_x/2), -8]) 
                cylinder(d=TI30_through_hole_diameter, h=12);
        }
    }
  
    translate([0, 18, 0]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("TFT", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");
    translate([0, -18, 0]) rotate([ 0, 0, 0 ]) linear_extrude(2) text("Mint", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}

/*
*************************************************************************
* part_esp32cam_mount_plate()
* this is the lid-mounting plate that holds esp32cam
*************************************************************************
 */

module part_esp32cam_mount_plate() {
    mount_width_Y = 2 * 16;          // mm separation of mount holes (Y)
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    plate_width_Y = mount_width_Y + 12;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12 + 8; // total length of plate in mm (X)

    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 1);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
    }

    translate([ 0, -4, 0 ]) difference() {
        // mount block for small mint permaproto
        translate([ -(board_smallmintproto_width+4)/2, -5, 0 ]) cube([ board_smallmintproto_width+4, 6, 20 ]);

        // screw holes (or thermal insert holes)
        if (TI30_use_threaded_insert) {
            translate([ board_smallmintproto_screw_y/2, -5.1, 6 ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=6.2);
            translate([ -board_smallmintproto_screw_y/2, -5.1, 6 ]) rotate([ -90, 0, 0 ]) 
                cylinder( d=TI30_through_hole_diameter, h=6.2);
        } else {
            translate([ board_smallmintproto_screw_y/2, -5.1, 6 ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=6.2);
            translate([ -board_smallmintproto_screw_y/2, -5.1, 6 ]) rotate([ -90, 0, 0 ]) 
                cylinder( r=screwhole_radius_M30_selftap, h=6.2);
        }

        // cutout for possible adafruit level shifter mounted on back of permaproto
        translate([ -10, -5.1, 10 ]) cube([ 20, 6.2, 10.1 ]);
    }
  
    translate([0, 8, 0]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("ESP32", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");
    translate([0, 18, 0]) rotate([ 0, 0, 180 ]) linear_extrude(2) text("Cam", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}


/*
*************************************************************************
* part_pixycam_mount_plate()
* reference: https://pixycam.com/
* reference: https://docs.pixycam.com/wiki/doku.php?id=wiki:v2:start
* reference: https://docs.pixycam.com/wiki/doku.php?id=wiki:v2:assembling_pantilt_mechanism
* this is the lid-mounting plate that holds PiXY2 camera on panner
*************************************************************************
 */

module part_pixycam_mount_plate(mode) {
    mount_width_Y = 3 * 16;          // mm separation of mount holes (Y)
    mount_length_X = 4 * 16;         // mm separation of mount holes (X)

    plate_width_Y = 70;  // total width of plate in mm (Y)
    plate_length_X = 80; // total length of plate in mm (X)

    panner_mount_X = 38;
    panner_mount_Y = 52;

    if (mode == "adds") {
        difference() {
            translate ([ -12, 0, 0 ]) roundedbox(plate_length_X, plate_width_Y, 2, 1);
            translate([ -mount_length_X/2 - 12, mount_width_Y/2 + 6, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
            translate([ -mount_length_X/2 - 12, -mount_width_Y/2 + 6, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
            translate([ mount_length_X/2 - 12, mount_width_Y/2 + 6, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
            translate([ mount_length_X/2 - 12, -mount_width_Y/2 + 6, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        }

        // mount posts for panner board
        translate([ -panner_mount_X/2, -panner_mount_Y/2 - 4, -0.1 ]) TI30_mount();
        translate([ -panner_mount_X/2, panner_mount_Y/2 - 4, -0.1 ]) TI30_mount();
        translate([ panner_mount_X/2, -panner_mount_Y/2 - 4, -0.1 ]) TI30_mount();
        translate([ panner_mount_X/2, panner_mount_Y/2 - 4, -0.1 ]) TI30_mount();
      
        translate([ 15, 0, 0]) rotate([ 0, 0, 90 ]) linear_extrude(2) text("Panner", 
            size=8,  halign="center", font = "Liberation Sans:style=Bold");

        translate([ 4, 0, 0]) rotate([ 0, 0, 90 ]) linear_extrude(2) text("Pixy2 Cam", 
            size=8,  halign="center", font = "Liberation Sans:style=Bold");

        translate([ -12, 0, 0]) rotate([ 0, 0, 90 ]) linear_extrude(2) text("(all M3)", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }

    // mount for Adafruit Level Shifter
    translate([ -41, 4, 0 ]) rotate([ 0, 0, 90 ]) component_levshift(mode);
}



/*
*************************************************************************
* part_0x96_OLED_mount_plate()
* this is a mounting plate for Adafruit 1.3in 128x64 Stemma OLED
* this mounts flat with 16mm mounting grid
* purchase: https://www.adafruit.com/product/938
*************************************************************************
 */

module part_1x3_OLED_mount_plate() {
    mount_width_Y = 16;          // mm separation of mount holes (Y)
    mount_length_X = 16;         // mm separation of mount holes (X)

    tft_mount_X = 30.5;         // mm separation TFT mount holes (Y)
    tft_mount_Y = 28;         // mm separation TFT mount holes (X)

    plate_width_Y = 40;  // total width of plate in mm (Y)
    plate_length_X = 50; // total length of plate in mm (X)

    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 2);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }


    translate([ -tft_mount_X/2, (tft_mount_Y/2), -0.1 ]) 
        TI25_mount(mount_height = 9);
    translate([ -tft_mount_X/2, -(tft_mount_Y/2), -0.1 ]) 
        TI25_mount(mount_height = 9);
    translate([ tft_mount_X/2, (tft_mount_Y/2), -0.1 ]) 
        TI25_mount(mount_height = 9);
    translate([ tft_mount_X/2, -(tft_mount_Y/2), -0.1 ]) 
        TI25_mount(mount_height = 9);

  
    translate([0, -4, 1]) rotate([ 0, 0, 0 ]) linear_extrude(2) text("OLED", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}

/*
*************************************************************************
* part_1x3_OLED_tilty_mount_plate()
* this is a mounting plate for Adafruit 1.3in 128x64 Stemma OLED
* this mounts at an angle (for best use on robot back wall) with 16mm mounting grid
* purchase: https://www.adafruit.com/product/938
*************************************************************************
 */

module part_1x3_OLED_tilty_mount_plate() {
    mount_width_Y = 16;          // mm separation of mount holes (Y)
    mount_length_X = 16;         // mm separation of mount holes (X)

    tft_mount_X = 30.5;         // mm separation TFT mount holes (Y)
    tft_mount_Y = 28;         // mm separation TFT mount holes (X)

    plate_width_Y = 40;  // total width of plate in mm (Y)
    plate_length_X = 50; // total length of plate in mm (X)

    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 2);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }

    difference() {
        translate([0, -5, -8 ]) rotate([ -25, 0, 0]) union() {
            translate([ -tft_mount_X/2, (tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 25);
            translate([ -tft_mount_X/2, -(tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 25);
            translate([ tft_mount_X/2, (tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 25);
            translate([ tft_mount_X/2, -(tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 25);
        }
        translate([ 0, 0, -20 ]) roundedbox(60, 60, 2, 20);
    }
      
    translate([0, -4, 1]) rotate([ 0, 0, 0 ]) linear_extrude(2) text("OLED", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}

/*

/*
*************************************************************************
* part_1x54_TFT_tilty_mount_plate()
* this is a mounting plate for Adafruit 1.54in TFT 240x240 pix
* this mounts at an angle (for best use on robot back wall) with 16mm mounting grid
* purchase: https://www.adafruit.com/product/3787
*************************************************************************
 */

module part_1x54_TFT_tilty_mount_plate() {
    mount_width_Y = 16;          // mm separation of mount holes (Y)
    mount_length_X = 16;         // mm separation of mount holes (X)

    tft_mount_X = (1.52 * 25.4);         // mm separation TFT mount holes (Y)
    tft_mount_Y = (1.45 * 25.4);         // mm separation TFT mount holes (X)

    plate_width_Y = 50;  // total width of plate in mm (Y)
    plate_length_X = 50; // total length of plate in mm (X)

    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 2);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }

    difference() {
        translate([0, -5, -8 ]) rotate([ -25, 0, 0]) union() {
            translate([ -tft_mount_X/2, (tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 25);
            translate([ -tft_mount_X/2, -(tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 25);
            translate([ tft_mount_X/2, (tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 25);
            translate([ tft_mount_X/2, -(tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 25);
        }
        translate([ 0, 0, -20 ]) roundedbox(60, 60, 2, 20);
    }
      
    translate([0, -4, 1]) rotate([ 0, 0, 0 ]) linear_extrude(2) text("1.54 TFT", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}
/*
*************************************************************************
* part_1x54_TFT_flat_mount_plate()
* this is a mounting plate for Adafruit 1.54in TFT 240x240 pix
* this mounts at an angle (for best use on robot back wall) with 16mm mounting grid
* purchase: https://www.adafruit.com/product/3787
*************************************************************************
 */

module part_1x54_TFT_flat_mount_plate() {
    mount_width_Y = 16;          // mm separation of mount holes (Y)
    mount_length_X = 16;         // mm separation of mount holes (X)

    tft_mount_X = (1.52 * 25.4);         // mm separation TFT mount holes (Y)
    tft_mount_Y = (1.45 * 25.4);         // mm separation TFT mount holes (X)

    plate_width_Y = 50;  // total width of plate in mm (Y)
    plate_length_X = 50; // total length of plate in mm (X)

    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 2);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }

    difference() {
        translate([0, 0, 2 ]) union() {
            translate([ -tft_mount_X/2, (tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 7);
            translate([ -tft_mount_X/2, -(tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 7);
            translate([ tft_mount_X/2, (tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 7);
            translate([ tft_mount_X/2, -(tft_mount_Y/2), -0.1 ]) 
                TI25_mount(mount_height = 7);
        }
    }
      
    translate([0, -4, 1]) rotate([ 0, 0, 0 ]) linear_extrude(2) text("1.54 TFT", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}

/*
*************************************************************************
* part_1x54_TFT_mount_plate()
* this is the lid-mounting plate that holds an Adafruit 1.54in TFT
*************************************************************************
 */

module part_1x54_TFT_mount_plate() {
    mount_width_Y = 2 * 16;          // mm separation of mount holes (Y)
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    tft_mount_X = 37;         // mm separation TFT mount holes (Y)
    tft_mount_Y = 38.5;         // mm separation TFT mount holes (X)
    tft_display_X = 32.5;              // width of TFT display window
    tft_display_Y = 36.5;             // length of TFT display window

    plate_width_Y = mount_width_Y + 12;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12 + 8; // total length of plate in mm (X)

    difference() {
        roundedbox(plate_length_X, plate_width_Y, 2, 3);
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=3.2);
    }

    translate([ 0, 1, 26 ]) rotate([ 70, 0, 0 ])
        difference() {
            roundedbox(50, 55, 2, 4);
            translate([ -tft_mount_X/2, (tft_mount_Y/2)+3, -0.1 ]) cylinder( r=screwhole_radius_M25_selftap, h=4.2);
            translate([ -tft_mount_X/2, -(tft_mount_Y/2)+1.5, -0.1 ]) cylinder( r=screwhole_radius_M25_selftap, h=4.2);
            translate([ tft_mount_X/2, (tft_mount_Y/2)+3, -0.1 ]) cylinder( r=screwhole_radius_M25_selftap, h=4.2);
            translate([ tft_mount_X/2, -(tft_mount_Y/2)+1.5, -0.1 ]) cylinder( r=screwhole_radius_M25_selftap, h=4.2);
            translate([ -tft_display_X/2, -(tft_display_Y/2)+3+1, -0.1 ]) cube([ tft_display_X, tft_display_Y, 4.2 ]);
        }

  
    translate([0, -20, 2]) rotate([ 0, 0, 0 ]) linear_extrude(2) text("TFT", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}


module part_tft_clamp() {
    difference() {
        translate([ -45/2, -7/2, 0 ]) cube([ 45, 7, 5 ]);
        translate([ -20/2, -7.2/2, 2.5 ]) cube([ 20, 7.2, 4 ]);
        translate([ -16, 0, -0.1 ]) cylinder( d=4, h=5.2 );
        translate([ 16, 0, -0.1 ]) cylinder( d=4, h=5.2 );
    }
}



/*
*************************************************************************
* part_1x54_TFT_mount_plate()
* this is the lid-mounting plate that holds pa tft
*************************************************************************
 */


module part_1x54_TFT_horiz_mount_base() {
    mount_width_Y = 2 * 16;          // mm separation of mount holes (Y)
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    tft_mount_X = 37;         // mm separation TFT mount holes (Y)
    tft_mount_Y = 38.5;         // mm separation TFT mount holes (X)
    tft_display_X = 32.5;              // width of TFT display window
    tft_display_Y = 36.5;             // length of TFT display window

    plate_width_Y = mount_width_Y + 12;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12 + 8; // total length of plate in mm (X)

           
    difference() {
        union() {
            roundedbox(plate_length_X, plate_width_Y, 2, 2);
            translate([ 0, -17, 0 ]) roundedbox(plate_length_X, 10, 2, 8);
        }
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=12.2);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=12.2);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=12.2);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=12.2);
    }

  
    translate([0, -2, 1]) rotate([ 0, 0, 0 ]) linear_extrude(2) text("TFT", 
        size=8,  halign="center", font = "Liberation Sans:style=Bold");

}

module part_1x54_TFT_bezel() {
    mount_width_Y = 2 * 16;          // mm separation of mount holes (Y)
    mount_length_X = 2 * 16;         // mm separation of mount holes (X)

    tft_mount_X = 37;         // mm separation TFT mount holes (Y)
    tft_mount_Y = 38.5;         // mm separation TFT mount holes (X)
    tft_display_X = 32.5;              // width of TFT display window
    tft_display_Y = 36.5;             // length of TFT display window

    plate_width_Y = mount_width_Y + 12;  // total width of plate in mm (Y)

        difference() {
            roundedbox(50, 60, 2, 4);
            translate([ -tft_mount_X/2, (tft_mount_Y/2)+8, -0.1 ]) cylinder( r=screwhole_radius_M25_selftap, h=4.2);
            translate([ -tft_mount_X/2, -(tft_mount_Y/2)+6.5, -0.1 ]) cylinder( r=screwhole_radius_M25_selftap, h=4.2);
            translate([ tft_mount_X/2, (tft_mount_Y/2)+8, -0.1 ]) cylinder( r=screwhole_radius_M25_selftap, h=4.2);
            translate([ tft_mount_X/2, -(tft_mount_Y/2)+6.5, -0.1 ]) cylinder( r=screwhole_radius_M25_selftap, h=4.2);
            translate([ -tft_display_X/2, -(tft_display_Y/2)+8+1, -0.1 ]) cube([ tft_display_X, tft_display_Y, 4.2 ]);

            translate([ -mount_length_X/2, -plate_width_Y/2-3, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=12.2);
            translate([ mount_length_X/2, -plate_width_Y/2-3, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=12.2);
        }

}


/*
 * module component_pyportal_pynt() generates mount pillars and screen "hole" for a pyportal
 * NOTE this is intended to mount with M3 bolts (using threaded insert by default)
 * it is assumed that the bolts will be inserted from the "back" of the display board
 * and they will NOT extend through the front panel -- use M3-6mm bolts
 *
 * purchase: https://www.adafruit.com/product/4465
 * info: https://learn.adafruit.com/adafruit-pyportal/downloads
 */
module component_pyportal_pynt(mode="adds") {
    
    mount_hole_sep_x = (2.43 * 25.4);
    mount_hole_sep_y = (1.89 * 25.4);
    tft_offset_x = (7 / 2);
    tft_x = 62;
    tft_y = 43;
    viz_x = (2.63 * 25.4);
    viz_y = (2.10 * 25.4);
    board_to_panel_outer = 6;
 

    if (mode == "holes") {
        translate([ -(tft_x/2)-tft_offset_x, -(tft_y/2), -0.1 ]) cube([ tft_x, tft_y, board_to_panel_outer+1 ]);
        translate([ -mount_hole_sep_x/2, -mount_hole_sep_y/2, mount_hole_extra_depth+1 ]) 
            TI30a_mount(mode, board_to_panel_outer+1);
        translate([ -mount_hole_sep_x/2,  mount_hole_sep_y/2, mount_hole_extra_depth+1 ]) 
            TI30a_mount(mode, board_to_panel_outer+1);
        translate([  mount_hole_sep_x/2, -mount_hole_sep_y/2, mount_hole_extra_depth+1 ]) 
            TI30a_mount(mode, board_to_panel_outer+1);
        translate([  mount_hole_sep_x/2,  mount_hole_sep_y/2, mount_hole_extra_depth+1 ]) 
            TI30a_mount(mode, board_to_panel_outer+1);
    }


    if (mode == "adds") {
        translate([ -mount_hole_sep_x/2, -mount_hole_sep_y/2, 0 ]) 
            TI30a_mount(mode, board_to_panel_outer);
        translate([ -mount_hole_sep_x/2, mount_hole_sep_y/2, 0 ]) 
            TI30a_mount(mode, board_to_panel_outer);
        translate([  mount_hole_sep_x/2, -mount_hole_sep_y/2, 0 ]) 
            TI30a_mount(mode, board_to_panel_outer);
        translate([  mount_hole_sep_x/2,  mount_hole_sep_y/2, 0 ]) 
            TI30a_mount(mode, board_to_panel_outer);
    }
}


/*
 * module component_lid_plate() generates a bare mount plate for use on lid;
 * this is typically called during the formation of custom / alacarte
 * plates
 * @param: numX, numY  size of plate in X, Y directions, in number of grid spaces (16mm each)
 * @param: holestyle   "normal" has M3 passthru holes; "drywall" has drywall mounts
 */

module component_lid_plate(mode="adds", numX=2, numY=2, holestyle="normal") {
    mount_width_Y = numY * 16;          // mm separation of mount holes (Y)
    mount_length_X = numX * 16;         // mm separation of mount holes (X)

    plate_width_Y = mount_width_Y + 12;  // total width of plate in mm (Y)
    plate_length_X = mount_length_X + 12; // total length of plate in mm (X)

    if (mode == "adds") {
        difference() {
            roundedbox(plate_length_X, plate_width_Y, 2, 1);
            translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
            translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
            translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
            translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=1.2);
        }
    }  

    if (holestyle == "drywall") {
        translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) part_drywall_screw_hole(mode);
        translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) part_drywall_screw_hole(mode);
        translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) part_drywall_screw_hole(mode);
        translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) part_drywall_screw_hole(mode);
    }  
}

/*
 * module component_lid_mount_holes() generates a 4-hole grid used for mounting stuff
 * it has ONLY "holes" mode
 *
 * this is typically called during the formation of custom / alacarte plates
 * @param: numX, numY  size of plate in X, Y directions, in number of grid spaces (16mm each)
 * @param: holestyle   "normal" has M3 passthru holes; "drywall" has drywall mounts
 */

module component_lid_mount_holes(numX=2, numY=2, height=6) {
    mount_width_Y = numY * 16;          // mm separation of mount holes (Y)
    mount_length_X = numX * 16;         // mm separation of mount holes (X)

    translate([ -mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=height);
    translate([ -mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=height);
    translate([ mount_length_X/2, mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=height);
    translate([ mount_length_X/2, -mount_width_Y/2, -0.1 ]) cylinder( r=screwhole_radius_M30_passthru, h=height);
}
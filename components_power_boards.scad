/*
 * Module: components_power_boards.scad  holds modules which generate
 *   mounts for boards related to "power" functions -- voltage regulators
 *   boost and buck modules, and battery chargers
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
 * this makes a base for schmartboard power distribution stripboard
 * its base is 1mm thick, and 12.7mm x 50.8mm (0.5 x 2in) 
 * it has 2 M3 threaded insert mounts on 43.2mm (1.7in) spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.tindie.com/products/Schmart/through-hole-power-ground-strip-05x2-grid/
 * purchase: https://www.digikey.com/en/products/detail/schmartboard-inc/201-0100-01/9559296
 * ***************************************************************************
 */
board_schmart_length = 50.8;
board_schmart_width = 12.7;
board_schmart_mount_spacing = 43.2;

module component_schmart(mode="adds") {

    // the "mount" itself handles the add/holes issues 
    translate([ -(board_schmart_mount_spacing/2), 0, 1]) TI30a_mount(mode);
    translate([ +(board_schmart_mount_spacing/2), 0, 1]) TI30a_mount(mode);
    
    if (mode == "holes") {
        // no holes for this device
    }
    
    if (mode == "adds") {
        roundedbox(board_schmart_length, board_schmart_width, 2, 1);
           
        translate([0, -3, 0]) linear_extrude(2) text("Buss M3", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ***************************************************************************
 * this makes a base for DTS power distribution stripboard
 * its base is 1mm thick, and 12.7mm x 50.8mm (0.5 x 2in) 
 * it has 2 M3 threaded insert mounts on 48mm  spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 * ***************************************************************************
 */
board_dts_pwrdist_length = 57;
board_dts_pwrdist_width = 18;
board_dts_pwrdist_mount_spacing = 48;

module component_dts_pwrdist(mode="adds") {

    // the "mount" itself handles the add/holes issues 
    translate([ -(board_dts_pwrdist_mount_spacing/2), 0, 1]) TI30a_mount(mode);
    translate([ +(board_dts_pwrdist_mount_spacing/2), 0, 1]) TI30a_mount(mode);
    
    if (mode == "holes") {
        // no holes for this device
    }
    
    if (mode == "adds") {
        roundedbox(board_dts_pwrdist_length, board_dts_pwrdist_width, 2, 1);
           
        translate([0, -3, 0]) linear_extrude(2) text("Buss M3", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ***************************************************************************
 * this makes a base for amazon adjustable boost converter
 * its base is 1mm thick, and 22mm x 44mm 
 * it has 2 M3 threaded insert mounts diagonally on 15mm x 30mm spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.amazon.com/Converter-Voltage-Adjustable-Step-up-Circuit/dp/B07XG323G8 or equiv
 *
 * ***************************************************************************
 */
board_amazon_boost_length = 44;
board_amazon_boost_width = 22;
mount_amazon_boost_x = 30;
mount_amazon_boost_y = 15;

module component_amazon_boost(mode="adds") {

    // the "mount" itself handles the add/holes issues 
    translate([ -mount_amazon_boost_x/2, mount_amazon_boost_y/2, 1]) TI30a_mount(mode);
    translate([ mount_amazon_boost_x/2, -mount_amazon_boost_y/2, 1]) TI30a_mount(mode);
    
    if (mode == "holes") {
        // no holes for this device
    }
    
    if (mode == "adds") {
        roundedbox(board_amazon_boost_length, board_amazon_boost_width, 2, 1);
           
        translate([ 4, +2, 0]) linear_extrude(2) text("Amazon", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([-2, -6, 0]) linear_extrude(2) text("Boost M3", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


/*
 * ***************************************************************************
 * this makes a base for pololu boost converter
 * its base is 1mm thick, and 15.24mm x 40.64mm (0.6in x 1.6in)
 * it has 2 M2 threaded insert mounts diagonally on 10.9mm x 36.3 spacing
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.amazon.com/Converter-Voltage-Adjustable-Step-up-Circuit/dp/B07XG323G8 or equiv
 *
 * ***************************************************************************
 */
board_pololu_boost_length = 42;
board_pololu_boost_width = 17;
mount_pololu_boost_x = 36.3;
mount_pololu_boost_y = 10.9;

module component_pololu_boost(mode="adds") {

    // the "mount" itself handles the add/holes issues 
    translate([ -mount_pololu_boost_x/2, mount_pololu_boost_y/2, 1]) TI20a_mount(mode);
    translate([ mount_pololu_boost_x/2, -mount_pololu_boost_y/2, 1]) TI20a_mount(mode);
    
    if (mode == "holes") {
        // no holes for this device
    }
    
    if (mode == "adds") {
        roundedbox(board_pololu_boost_length, board_pololu_boost_width, 2, 1);
           
        translate([ 4, +2, 0]) linear_extrude(2) text("Pololu", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([-2, -6, 0]) linear_extrude(2) text("Boost M2", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        
    }
}


/*
 * ***************************************************************************
 * this makes a base for adafruit buck converter (3.3v output)
 * its base is 1mm thick, and 17mm x 10mm 
 * it has 1 M2.5 threaded insert mount centered at one end
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/4711   3.3v buck 1.2A from 3.4 - 5.5v input
 * purchase: https://www.adafruit.com/product/4683   3.3v buck 1.2A from 4.5 - 21v input
 *
 * ***************************************************************************
 */
board_adafruit_minibuck_length = 19;
board_adafruit_minibuck_width = 11;

module component_adafruit_minibuck(mode="adds") {

    // the "mount" itself handles the add/holes issues     
    translate([ -7, 0, 1]) M25_short_mount(mode, 5);
    
    if (mode == "holes") {
        // no holes for this device
    }
    
    if (mode == "adds") {
        roundedbox(board_adafruit_minibuck_length, board_adafruit_minibuck_width, 2, 1);
           
        translate([2, -3, 0]) linear_extrude(2) text("M25", 
            size=5,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ***************************************************************************
 * this makes a base for adafruit boost converter (5v output)
 * its base is 1mm thick, and 18mm x 11.3mm 
 * it has 1 M2.5 threaded insert mount at left edge of one end
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/4654  5v boost 1.0A from 2-5v input
 *
 * ***************************************************************************
 */
board_adafruit_miniboost_length = 20;
board_adafruit_miniboost_width = 12;

module component_adafruit_miniboost(mode="adds") {

    // the "mount" itself handles the add/holes issues 
    translate([ -7, -3, 1]) M25_short_mount(mode, 5);
    
    if (mode == "holes") {
        // no holes for this device
    }
    
    if (mode == "adds") {
        roundedbox(board_adafruit_miniboost_length, board_adafruit_miniboost_width, 2, 1);
           
        translate([2, -3, 0]) linear_extrude(2) text("M25", 
            size=5,  halign="center", font = "Liberation Sans:style=Bold");
    }
}

/*
 * ***************************************************************************
 * this makes a base for Adafruit Powerboost 500 Lipo Charger / Boost Converter
 * this also works for Adafruit Powerboost 1000 Lipo Charger / Boost Converter
 * its base is 1mm thick, and 1.4 x 0.85 in
 * it has 4 M2.5 threaded insert mounts asymetrically placed
 *  
 * this is generated in xy plane, centered at origin, box outside skin is at z=0 (moving "into" box has +z)
 * it is generated in "landscape" shape
 * it should be "added" to design, there are no holes needed at placement level
 *
 * purchase: https://www.adafruit.com/product/1944          
 * info:  https://learn.adafruit.com/adafruit-powerboost-500-plus-charger/downloads 
 * purchase: https://www.adafruit.com/product/2465  
 * 
 * ***************************************************************************
 */
board_pboost500_length = 1.4 * 25.4;
board_pboost500_width = 0.85 * 25.4;

// the following dimensions are hole locations, relative to LOWER LEFT CORNER
pboost500_mount_x = 1.2 * 25.4;
pboost500_mount_y_usbside = 0.65 * 25.4;
pboost500_mount_y_otherside = 0.525 * 25.4;

module component_pboost500(mode="adds") {

    // the "mount" itself handles the add/holes issues
    translate([ -(pboost500_mount_x/2), -(pboost500_mount_y_usbside/2), 1]) 
        TI25a_mount(mode); 
    translate([ -(pboost500_mount_x/2), (pboost500_mount_y_usbside/2), 1]) 
        TI25a_mount(mode); 
    translate([ (pboost500_mount_x/2), -(pboost500_mount_y_otherside/2), 1]) 
        TI25a_mount(mode); 
    translate([ (pboost500_mount_x/2), (pboost500_mount_y_otherside/2), 1]) 
        TI25a_mount(mode); 

    if (mode == "holes") {
        // no holes for this component
    }

    if (mode == "adds") {
        roundedbox(board_pboost500_length, board_pboost500_width, 2, 1);
           
        translate([0, -2, 0]) linear_extrude(2) text("PBst500", 
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([0, -9, 0]) linear_extrude(2) text("M25",
            size=6,  halign="center", font = "Liberation Sans:style=Bold");
        translate([-3, 5, 0]) linear_extrude(2) text("<USB",
            size=5,  halign="center", font = "Liberation Sans:style=Bold");
    }
}


include <Butt_Hinge.scad>;

// GOAL: Parameterized Enclosure Door
DEBUG = false;

// REQUIREMENTS:
//  1) Be able to generate a single pane or a dual pane door
//  2) Optionally allow for hinges or fixed mounts


// CONFIGURATION:
//  1) length, width, thickness of pane
pane_width                  = 300;
pane_length                 = 600;
pane_thickness              = 0.18;

//  2) length, width, angle of hinge
mounting_hinge_width        = 40;
mounting_hinge_length       = 60;
mounting_hinge_gauge        = 4;
mounting_hinge_angle        = 0.0;


//  3) single or dual door
//  4) fixed or hinge based mount (per side)




// =======================================================================================
//                                 TEST AREA 
// =======================================================================================
door_pane(  pane_length,pane_width,pane_thickness, 
            mounting_hinge_width, mounting_hinge_length, mounting_hinge_gauge, mounting_hinge_angle);









module door_pane(length, width, thickness, hinge_width = 0, hinge_length = 0, hinge_gauge = 0, hinge_angle = 0.0)
{
    l_hinge_width            = ( hinge_width == 0 ) ? mounting_hinge_width : hinge_width;
    l_hinge_length           = ( hinge_length == 0 ) ? mounting_hinge_length : hinge_length;
    l_hinge_angle            = ( hinge_angle == 0 ) ? mounting_hinge_angle : hinge_angle;

    
    if(DEBUG)
    {
        echo("Door Pane:" ,length, width, thickness);
    }



    
    // Main acrylic Pane
    %rotate([hinge_angle,0,0])cube([length, width, thickness]);
    
    // Left side hinges
    translate([l_hinge_length/2,0,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
    translate([-l_hinge_length/2+length,0,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
    
}

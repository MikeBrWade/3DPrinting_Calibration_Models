include <Butt_Hinge.scad>;
$fn = 128;
// GOAL: Parameterized Enclosure Door
DEBUG = false;

// REQUIREMENTS:
//  1) Be able to generate a single pane or a dual pane door
//  2) Optionally allow for hinges, fixed mounts, or magneticly mounted


// CONFIGURATION:
//  1) length, width, thickness of pane
pane_width                      = 12*2*25.4;
pane_length                     = 24*25.4;
pane_thickness                  = 0.25;

//  2) length, width, angle of hinge (Magnetic Parameters)
mounting_hinge_width            = 40;
mounting_hinge_length           = 60;
mounting_hinge_gauge            = 4;
mounting_hinge_angle            = 0.0;
mounting_hinge_magnet_radius    = 7.5;
mounting_hinge_magnet_thickness = 4;

//  3) Door handle length, width, thickness
door_handle_length              = 100;
door_handle_width               = 30;
door_handle_base_thickness      = 3;

//  4) fixed or hinge based mount (0 invalid and will be defaulted to "3")
C_DOOR_TYPE_HALF_PANE_HINGE     = 1;
C_DOOR_TYPE_FULL_PANE_HINGE     = 2;
C_DOOR_TYPE_STATIC_MOUNT        = 3;
C_DOOR_TYPE_MAGNETIC_REMOVABLE  = 4;
enclosure_door_type             = C_DOOR_TYPE_MAGNETIC_REMOVABLE; 






// =======================================================================================
//                                 TEST AREA 
// =======================================================================================
//door_pane(  pane_length,pane_width,pane_thickness);
//door_handle(door_handle_length, door_handle_width, door_handle_base_thickness);
//door_magnetic_mount(    mounting_hinge_width,mounting_hinge_width,mounting_hinge_gauge,
//                        20,pane_thickness,mounting_hinge_magnet_radius,mounting_hinge_magnet_thickness);
/*
door_pane(  pane_length,pane_width,pane_thickness,
            door_type = enclosure_door_type);

/*
door_pane(  pane_length,pane_width,pane_thickness,
            enclosure_door_type,
            mounting_hinge_length, mounting_hinge_width, mounting_hinge_gauge, mounting_hinge_angle,
            door_handle_length, door_handle_width, door_handle_base_thickness);
/**/

module door_pane(   length, width, thickness, 
                    door_type = 0,
                    hinge_length = 0, hinge_width = 0, hinge_gauge = 0, hinge_angle = 0,
                    handle_length = 0, handle_width = 0, handle_base_thickness = 0)
{
    l_door_type              = ( door_type              == 0 ) ? enclosure_door_type        : door_type;
    
    l_hinge_length           = ( hinge_length           == 0 ) ? mounting_hinge_length      : hinge_length;
    l_hinge_width            = ( hinge_width            == 0 ) ? mounting_hinge_width       : hinge_width;
    l_hinge_gauge            = ( hinge_gauge            == 0 ) ? mounting_hinge_gauge       : hinge_gauge;
    l_hinge_angle            = ( hinge_angle            == 0 ) ? mounting_hinge_angle       : hinge_angle;
    
    l_handle_length          = ( handle_length          == 0 ) ? door_handle_length         : handle_length;
    l_handle_width           = ( handle_width           == 0 ) ? door_handle_width          : handle_width;
    l_handle_base_thickness  = ( handle_base_thickness  == 0 ) ? door_handle_base_thickness : handle_base_thickness;
      
    if(DEBUG)
    {
        
    //  Depending on the selected door "type" we need to render a different configuration
            
        echo("Door Pane:" ,l_hinge_length, l_hinge_width, l_hinge_gauge);
        
    }
        
    
    // If the door type is a half door with hinges
    if(l_door_type == C_DOOR_TYPE_HALF_PANE_HINGE)
    {
        // Main acrylic Pane (LEFT)
        %translate([0,-width/4,0])rotate([l_hinge_angle,0,0])cube([length, width/2-.5, thickness], center = true);
        // Main acrylic Pane (RIGHT)
        %translate([0,width/4+1,0])rotate([l_hinge_angle,0,0])cube([length, width/2-.5, thickness], center = true);
        
        // Left side hinge set
        translate([-length/2+l_hinge_length/2,-width/2,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        translate([+length/2-l_hinge_length/2,-width/2,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        // Right side hinge set
        translate([-length/2+l_hinge_length/2,+width/2+1,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        translate([+length/2-l_hinge_length/2,+width/2+1,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        
        // Door Handle (LEFT)
        translate([0,-l_handle_width,thickness])door_handle(l_handle_length,l_handle_width,l_handle_base_thickness);    
        // Door Handle (RIGHT)
        translate([0,+l_handle_width+1,thickness])door_handle(l_handle_length,l_handle_width,l_handle_base_thickness);    
        
    }
    // If the door type is a full door with hinges
    if(l_door_type == C_DOOR_TYPE_FULL_PANE_HINGE)
    {
        // Main acrylic Pane
        %rotate([l_hinge_angle,0,0])cube([length, width, thickness], center = true);
        
        // Left side hinge set
        translate([-length/2+l_hinge_length/2,-width/2,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        translate([+length/2-l_hinge_length/2,-width/2,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        // Door Handle
        translate([0,width/2-l_handle_width,thickness])door_handle(l_handle_length,l_handle_width,l_handle_base_thickness);    
        
    }
    
    // If the door type is a full pane statically mounted
    if(l_door_type == C_DOOR_TYPE_STATIC_MOUNT)
    {
        // Main acrylic Pane)
        %rotate([l_hinge_angle,0,0])cube([length, width, thickness], center = true);
        
        // Hinge Set (LEFT)
        translate([-length/2+l_hinge_length/2,-width/2,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        translate([+length/2-l_hinge_length/2,-width/2,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        // Hinge Set (RIGHT)
        translate([-length/2+l_hinge_length/2,+width/2,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();
        translate([+length/2-l_hinge_length/2,+width/2,mounting_hinge_gauge+thickness])rotate([0,0,90])butt_hinge();    
        
    }
       
    // If the door type is a full pane statically mounted
    if(l_door_type == C_DOOR_TYPE_MAGNETIC_REMOVABLE)
    {
        // Main acrylic Pane
        %rotate([l_hinge_angle,0,0])cube([length, width, thickness], center = true);
        
        // Magnetic Mount TL
        translate([-length/2+l_hinge_length/2-20,-width/2+20/2,-l_hinge_gauge/2])rotate([0,0,0])
        door_magnetic_mount(    l_hinge_width, l_hinge_width, l_hinge_gauge,
                                20, thickness,
                                mounting_hinge_magnet_radius,mounting_hinge_magnet_thickness);
        // Magnetic Mount TR
        translate([-length/2+l_hinge_length/2-20,+width/2-20/2,-l_hinge_gauge/2])rotate([0,0,-90])
        door_magnetic_mount(    l_hinge_width, l_hinge_width, l_hinge_gauge,
                                20, thickness,
                                mounting_hinge_magnet_radius,mounting_hinge_magnet_thickness);
        
        // Magnetic Mount BL        
        translate([+length/2-l_hinge_length/2+20,-width/2+20/2,-l_hinge_gauge/2])rotate([0,0,90])
        door_magnetic_mount(    l_hinge_width, l_hinge_width, l_hinge_gauge,
                                20, thickness,
                                mounting_hinge_magnet_radius,mounting_hinge_magnet_thickness);
        
        // Magnetic Mount BR        
        translate([+length/2-l_hinge_length/2+20,+width/2-20/2,-l_hinge_gauge/2])rotate([0,0,180])
        door_magnetic_mount(    l_hinge_width, l_hinge_width, l_hinge_gauge,
                                20, thickness,
                                mounting_hinge_magnet_radius,mounting_hinge_magnet_thickness);
    }
}


module door_handle(handle_length, handle_width, handle_base_thickness)
{
    difference()
    {
        // Main Handle body
        scale([1,handle_width/(handle_length/2)/2,.5])sphere(handle_length/2, center = true);
        
        // cut out for hand, and chopping off the bottom of the handle base.
        union()
        {
            translate([0,0,-handle_length/4])
            {   cube([handle_length,handle_length/2,handle_length/2], center = true);
            }
            scale([.8,1.25,.3])sphere(max(handle_length,handle_width)/2, center = true);    
        }
    }
    
    // Handle Base
    cube([handle_length,handle_width,handle_base_thickness], center = true);
        
    
}

module door_magnetic_mount( mount_length,mount_width,mount_thickness,
                            tslot_width,panel_thickness,
                            magnet_radius,magnet_height)
{
    // Base of the mount
    cube([mount_length+tslot_width,mount_width+tslot_width,mount_thickness], center = true);
    
    // Next Layer of mount, with pane corner cutout
    translate([0,0,mount_thickness/2+panel_thickness/2])
    difference()
    {
        // Pane Layer
        cube([mount_length+tslot_width,mount_width+tslot_width,panel_thickness], center = true);
        
        // Pane Cutout
        translate([tslot_width/2+.1,tslot_width/2+.1,0])
        {
            cube([mount_length+.1,mount_width+.1,panel_thickness+.1], center = true);
        }
    }
    
    // Bottom layer with magnetic "cut outs"
    translate([0,0,mount_thickness/2+panel_thickness/2+magnet_height+.1])
    difference()
    {
        cube([mount_length+tslot_width,mount_width+tslot_width,mount_thickness+magnet_height], center = true);
        
        // Magnet Hole x2
        union()
        {
            translate([tslot_width/2,-mount_width/2,mount_thickness/2])
            cylinder(h = magnet_height+.1, r = magnet_radius, center = true);
            
            translate([-tslot_width,mount_width/3,mount_thickness/2])
            cylinder(h = magnet_height+.1, r = magnet_radius, center = true);
        }

    }
    
    
    
}



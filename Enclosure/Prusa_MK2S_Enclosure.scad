include <T-Slot.scad>;
$fn = 200;

// High level Design: 
//  1)  Encase the Prusa i3 MK2S & MMU attachment fully
//  2)  Provide filtered air exhaust
//  3)  Provide Octoprint control of print functions
//  4)  Make the overall dimensions parameterized
//  5)  Stand alone operation not requiring a table or surface.
//  6)  Provide storage and organization for 32 spools of filament
//  7)  Swing open door with handle & magnetic lock
//  8)  External panels are removable, or some way to easily remove the 
//      printer for tough to release prints OR other maintenance issues like recabling
//  9)  Fully 3D Printable, except 2020 frame and buts/bolts
// 10)  


// STRETCH:
//  1s) Allow for LED control via Octopi
//  2s) Allow for UPS control and status via Octopi
//  3s) Allow for power switching via Octopi
//  4s) Expandablity for N printers (Could just make N instances of the case)



// ================== CONFIG ==================================
enclosure_frame_t_slot_size_in_mm         = 20;
enclosure_printer_area_width_in_mm        = 600;
enclosure_printer_area_length_in_mm       = 650;
enclosure_printer_area_height_in_mm       = 700;
enclosure_base_height_in_mm               = 500;
enclosure_filament_storage_height_in_mm   = 200;
enclosure_total_height_in_mm              = enclosure_base_height_in_mm+enclosure_filament_storage_height_in_mm+enclosure_printer_area_height_in_mm+(enclosure_frame_t_slot_size_in_mm*4);
echo("Total Fixture Height : ", enclosure_total_height_in_mm, enclosure_total_height_in_mm/10/2.54);
echo("Total Fixture Width  : ", enclosure_printer_area_width_in_mm,enclosure_printer_area_width_in_mm/10/2.54);
echo("Total Fixture Depth  : ", enclosure_printer_area_length_in_mm,enclosure_printer_area_length_in_mm/10/2.54);
// ============================================================


// Primary Prusa i3 MK2S

create_2020_framed_box( enclosure_printer_area_length_in_mm,
                        enclosure_printer_area_width_in_mm,
                        enclosure_printer_area_height_in_mm,
                        enclosure_frame_t_slot_size_in_mm,
                        1, 1);
               
// Base of the Enclosure                        
translate([0,0,(-enclosure_base_height_in_mm)+enclosure_frame_t_slot_size_in_mm])
{
    create_2020_framed_box( enclosure_printer_area_length_in_mm,
                            enclosure_printer_area_width_in_mm,
                            enclosure_base_height_in_mm,
                            enclosure_frame_t_slot_size_in_mm,
                            1, 0);
}

// Top Filament Spool Holder
translate([0,0,(+enclosure_printer_area_height_in_mm)-enclosure_frame_t_slot_size_in_mm])
{
    create_2020_framed_box( enclosure_printer_area_length_in_mm,
                            enclosure_printer_area_width_in_mm,
                            enclosure_base_height_in_mm,
                            enclosure_frame_t_slot_size_in_mm,
                            0, 1);
    // Create the "Set" of printer spools
    translate([0,0,200])
    {
        create_printer_spool_set();
    }

}

// Import the Prusa i3 MK2 Model just to check for fit etc
rotate([0,0,90])translate([-135,-475,85])import("Prusa-i3-MK2-full.stl");

module create_printer_spool_set()
{
  spool_seperation = 10;
    rotate([0,90,90])
    {
        translate([0,-120,0])
        {
            translate([0,0,0])                          {hatchbox_printer_spool();}
            translate([0,0,(68+spool_seperation)])      {hatchbox_printer_spool();}
            translate([0,0,(68+spool_seperation)*2])    {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)])     {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)*2])   {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)*3])   {hatchbox_printer_spool();}
        }
        translate([0,-320,0])
        {
            translate([0,0,0])                          {hatchbox_printer_spool();}
            translate([0,0,(68+spool_seperation)])      {hatchbox_printer_spool();}
            translate([0,0,(68+spool_seperation)*2])    {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)])     {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)*2])   {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)*3])   {hatchbox_printer_spool();}
        }
        translate([0,-520,0])
        {
            translate([0,0,0])                          {hatchbox_printer_spool();}
            translate([0,0,(68+spool_seperation)])      {hatchbox_printer_spool();}
            translate([0,0,(68+spool_seperation)*2])    {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)])     {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)*2])   {hatchbox_printer_spool();}
            translate([0,0,-(68+spool_seperation)*3])   {hatchbox_printer_spool();}
        }
    }
}


module hatchbox_printer_spool()
{
    // Standard Hatchbox Size Paramters
    // FIXME: WADE - I could make these all parameterized so you could have a combination
    // of spools, but right now hatchbox represents 13 of my 16 spools HA.
    spool_hole_diameter_in_mm       = 55;
    spool_inside_diameter_in_mm     = 80;
    spool_outside_diameter_in_mm    = 200;
    spool_outside_thickness_in_mm   = 4;
    spool_outside_seperation_in_mm  = 68;
    
    // Create Spool
    create_printer_spool(   spool_hole_diameter_in_mm,
                            spool_inside_diameter_in_mm,
                            spool_outside_diameter_in_mm,
                            spool_outside_thickness_in_mm,
                            spool_outside_seperation_in_mm);
}

module create_printer_spool(hole_d, inner_d, outer_d, outer_thickness, outer_height)
{
    // Render Spool Outside Set
    difference()
    {
        // Exterior Wall
        cylinder(h = outer_thickness, r = outer_d/2, center = true);
        // Mount Hole
        cylinder(h = outer_thickness, r = hole_d/2, center = true);
    }
    translate([0,0,outer_height-outer_thickness])
    {
        difference()
        {
            // Exterior Wall
            cylinder(h = outer_thickness, r = outer_d/2, center = true);
            // Mount Hole
            cylinder(h = outer_thickness, r = hole_d/2, center = true);
        }
    }
    // Render internal spool
    translate([0,0,(outer_height/2)-outer_thickness])
    difference()
    {
        // Exterior Wall
        cylinder(h = outer_height-(outer_thickness), r = inner_d/2, center = true);
        // Mount Hole
        cylinder(h = outer_height-(outer_thickness), r = hole_d/2, center = true);
    }
}

module create_2020_framed_box(length,width,height,frame_size,enable_bottom,enable_top)
{
    // Bottom Frame
    if(enable_bottom == 1)
    {
        rotate([90,0,0])
        {
            frame_piece( length, width, frame_size);
        }
    }
    
    // Top Frame
    if(enable_top == 1)
    {
        rotate([90,0,0])translate([0,height-frame_size,0])
        {
            frame_piece( length, width, frame_size);
        }
    }
    
    // Height Frame Supports
    // Back-Left
    translate([ 0, (-width/2)+(frame_size/2), (height/2)-(frame_size/2)])
    {
        2020Profile( height-(frame_size*2), core = ProfileCore);
        echo("BL-2020: ",height, "mm");
    }
    // Back-Right
    translate([ 0, (width/2)-(frame_size/2), (height/2)-(frame_size/2)])
    {
        2020Profile( height-(frame_size*2), core = ProfileCore);
        echo("BR-2020: ",height, "mm");
    }
    // Front-Right
    translate([ length, (width/2)-(frame_size/2), (height/2)-(frame_size/2)])
    {
        2020Profile(height-(frame_size*2), core = ProfileCore);
        echo("FR-2020: ",height, "mm");
    }
    // Front-Left
    translate([ length, (-width/2)+(frame_size/2), (height/2)-(frame_size/2)])
    {
        2020Profile(height-(frame_size*2), core = ProfileCore);
        echo("FL-2020: ",height, "mm");
    }
}

module frame_piece(length, width, extrusion_size)
{
    
    
        // Back
        2020Profile(width, core = ProfileCore);echo("B-2020: ",width, "mm");
        // Front
        translate([length,0,0]){2020Profile(width, core = ProfileCore);echo("F-2020: ",width, "mm");}
    
    
        // Sides (Left and Right)
        rotate([0,90,0])
        {
            // Left
            translate([-width/2+(extrusion_size/2),0,length/2]){2020Profile(length-(extrusion_size), core = ProfileCore);echo("L-2020: ",length-(extrusion_size), "mm");}
            // Right
            translate([(width/2)-(extrusion_size/2),0,length/2]){2020Profile(length-(extrusion_size), core = ProfileCore);echo("R-2020: ",length-(extrusion_size), "mm");}
        }
}

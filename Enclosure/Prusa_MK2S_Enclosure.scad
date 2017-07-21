include <T-Slot_Extrusions.scad>;
include <T-Slot_Mounting_Pieces.scad>;
include <T-Slot_Framing.scad>;
include <Printer-Spool.scad>;
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
//  9)  Fully 3D Printable, except 2020 frame and nuts/bolts
// 10)  ...


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

/*
// Primary Prusa i3 MK2S Enclosure Area
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
%rotate([0,0,90])translate([-135,-475,85])import("Prusa-i3-MK2-full.stl");
*/

tslot_corner_support_brace(50, 20, 5, 1, 5.8, 0.10);


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

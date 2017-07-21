// Create a spool to use for sizing modeling, along with the various types of spools 
// Hatchbox, eSun, ProtoPasta etc

//hatchbox_printer_spool();


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
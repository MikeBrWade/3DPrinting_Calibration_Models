// Parameterized tslot brace set


// 90 degree angle corder brace with adjustable tslot size, hole cut out, depth and width for the guide rail
// as well as overall size for more rigidity and thickness of the wall structure.
module tslot_corner_support_brace(size, tslot_size, hole_diameter, guide_depth, guide_width, cutout_wall_thickness)
{
    // Create the main body of the angle brace
    difference()
    {
        // 90 Degree Angle, and the groove that slot into the tslot piece
        union()
        {            
            cube([size, size, tslot_size]);
            translate([size, 0, (tslot_size/2)-(guide_width/2)])cube([guide_depth, size, guide_width]);
            translate([0, -guide_depth, (tslot_size/2)-(guide_width/2)])cube([size, guide_depth, guide_width]);
        }
        
        // Cross Section Removing 45 degree angle cube slice
        // NOTE: In the preview when you have differences exactly line up you get rendering artifacts, 
        // by expanding another 100um on each side you get a cleaner view.  The "full render" isn't affected
        // by this though.
        rotate([0,0,45]) translate([0,0,-0.1]) cube([sqrt((size*size)+(size*size)), sqrt((size*size)+(size*size))/2, tslot_size+0.2]);
        
        // Internal Cross Section, to make the inside of the bracket
        translate([size*(cutout_wall_thickness/2),size*(cutout_wall_thickness/2),(tslot_size/3)/2]) cube([size*(1-cutout_wall_thickness), size*(1-cutout_wall_thickness), (tslot_size/3)*2]);
        
        // Bolt Hole Cutouts
        rotate([0,90,0]) translate([-tslot_size/2,size/3,0]) cylinder(h=size+guide_depth+.1, r=hole_diameter/2);
        rotate([0,90,0]) translate([-tslot_size/2,size/3*2,0]) cylinder(h=size+guide_depth+.1, r=hole_diameter/2);
        
        rotate([90,0,0]) translate([size/3,tslot_size/2,-size]) cylinder(h=size+guide_depth+.1, r=hole_diameter/2);
        rotate([90,0,0]) translate([size/3*2,tslot_size/2,-size]) cylinder(h=size+guide_depth+.1, r=hole_diameter/2);
                

    }
}
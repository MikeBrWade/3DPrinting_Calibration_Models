$fn = 200;					// So the cylinders are smooth

// ================ Wrent Configuration Parameters ================ 
nut_diameter                = 17 + 0.25; // Most seem to have .25 slack in them
nut_thickness               = 6.25;
wrench_handle_length        = 82;
wrench_nut_overlap_percent  = 0.10; // "extra" to grip the nut
// =================================================================


// Calculate some nice values
wrench_thickness = (1+wrench_nut_overlap_percent) * nut_thickness; 

// Something to make wrench heads for us
module wrench_head(thickness, nut_d, head_extra, open_ended) 
{
	difference() 
    {
        // Main "head" shape that we will subtract from to get the closed
        // or open ended ends.
        translate([0, 0, -thickness / 2]) 
        {
			cylinder(h = thickness, r = (nut_d + head_extra) / 2);
		}

        // Hex nuts go in at a 30 degree angle
		rotate(30) 
        {
			hexagon(nut_d, thickness*1.01); // 1% fudge factor for rendering the subtraction
		}

        // Move to cender of the nut, and subtract the end box for open ended
        if(open_ended)
        {
            translate([0, nut_d / 2, 0]) 
            {
                // Create box, removing head extra/8th to account for nut shape
                box(nut_d-(head_extra/8), nut_d + head_extra / 2, thickness * 1.01);// 1% fudge factor for rendering the subtraction
			}
		}
	}
}

// Put us flat on the bed
translate([0, 0, wrench_thickness / 2]) 
{
	// The handle
	box(nut_diameter, wrench_handle_length, wrench_thickness);

	// Make the closed head
	translate([0, -((wrench_handle_length + nut_diameter) / 2), 0]) 
    {
		wrench_head(wrench_thickness, nut_diameter, nut_diameter, false);
	}

	// And the open head
	translate([0, (wrench_handle_length + nut_diameter) / 2, 0]) 
    {
		wrench_head(wrench_thickness, nut_diameter, nut_diameter, true);
	}
}

module hexagon(diameter, thickness) 
{
    // Just a cylinder with a resolution of 6 (ie 6 sides)
    cylinder(r = diameter / 2, h = thickness, $fn = 6, center = true);
}

module box(b_width, b_length, b_thick) 
{
    cube([b_width, b_length, b_thick], center = true);
}
// Smooth Shapes
$fn = 100;

// The goal of this test is create a single cube that has a label on each face for the axis
// it represents, with parameterized driving configuration.

// Requirements
// 1) Size of the cube
cube_dimensions_length       = 25;
cube_dimensions_width        = 25;
cube_dimensions_height       = 25;

// 2) Allow the font size, and depth to be configurable.
cube_font                               = "Courier New:style=Bold";
cube_font_size                          = min(cube_dimensions_length,cube_dimensions_width);
cube_font_depth                         = min(cube_dimensions_length,cube_dimensions_width,cube_dimensions_height)/14;

// =============================================================================================================
// Generate the cube
embossed_cube(          cube_dimensions_length,
                        cube_dimensions_width,
                        cube_dimensions_height,
                        cube_font_depth);
                        

// =============================================================================================================
//                                  Support Functions
// =============================================================================================================
module embossed_cube(length, width, height, text_depth)
{
    difference()
    {
        cube([length, width, height] , center=true);
        // Front and Back
        rotate([90,0,90])
        {
                translate([0,0,(length/2)-cube_font_depth+.01])embossed_string("Y", text_depth);
                translate([0,0,-(length/2)+cube_font_depth-.01])rotate([0,180,0])embossed_string("Y", text_depth);
        }      
        // Left and Right
        rotate([90,0,180])
        {
                translate([0,0,(length/2)-cube_font_depth+.01])embossed_string("X", text_depth);
                translate([0,0,-(length/2)+cube_font_depth-.01])rotate([0,180,0])embossed_string("X", text_depth);
        }      
        // Top and Bottom
        rotate([180,0,-90])
        {
                translate([0,0,(length/2)-cube_font_depth+.01])embossed_string("Z", text_depth);
                translate([0,0,-(length/2)+cube_font_depth-.01])rotate([0,180,0])embossed_string("Z", text_depth);
        }       
        
    }    
}
module embossed_string(string_text, depth) 
{
	linear_extrude(height = depth) 
    {
		text(string_text, size = cube_font_size, font = cube_font, halign = "center", valign = "center", $fn = 16);
	}
}



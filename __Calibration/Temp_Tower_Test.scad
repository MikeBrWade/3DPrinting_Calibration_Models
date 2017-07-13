// Smooth Shapes
$fn = 100;

// The goal of this test is to build a set of towers of different sized "cubes"
// This tower will then have a process associated with each cube for 
// a different temp, which can be used to "tune" the temp settings 
// for a filament.

// Requirements
// 1) Size of the cubes, and spaces between them need to be parameterized
cube_dimensions_length       = 20;
cube_dimensions_width        = 20;
cube_dimensions_height       = 20;
cube_seperation_height       = 4;

// 2) Distance between cubes, with recessed "colars" between them needs to be parameterized
distance_between_towers         = 50;
cube_colar_depth                = 4;

// 3) Make each cube, a customizable temp and overlay that temp into the cube for easy identification (ordered from bottom to top)
cube_font                       = "Courier New:style=Bold";
cube_font_size                  = 8;
cube_font_depth                 = cube_dimensions_width/4;
//cube_temp_configuration_array   = ["250","225","215","210","205","200","195","190","180"];
cube_temp_configuration_array   = ["260","230","210","195","170"];
number_of_cubes_in_the_tower    = len(cube_temp_configuration_array);

// 4) Base of the towers need to be trapazoidal and the colar size configurable
tower_base_height                   = 4;
tower_base_additional_colar_size    = 2;

// =============================================================================================================
// Generate the "twin" tower set, for each temp listed, for the sizes configured, and for the distance configured
for(cube_in_stack = [0:number_of_cubes_in_the_tower-1])
{
    // Left Size tower set
    temp_cube_and_colar(    cube_dimensions_length,
                            cube_dimensions_width,
                            cube_dimensions_height,
                            cube_colar_depth,
                            cube_seperation_height,
                            0,
                            0,
                            (cube_dimensions_height+cube_seperation_height/2)*cube_in_stack,
                            cube_temp_configuration_array[cube_in_stack]);
    
    // Overhang/Bridge
    translate([0,cube_dimensions_width/2,(cube_dimensions_height+cube_seperation_height/2)*cube_in_stack]) 
    {
        overhang(cube_dimensions_width,(distance_between_towers/2)-(cube_dimensions_width/2));
    }

    // Right side tower Set
    translate([0,distance_between_towers,0])
    {   
        temp_cube_and_colar(cube_dimensions_length,
                            cube_dimensions_width,
                            cube_dimensions_height,
                            cube_colar_depth,cube_seperation_height,
                            0,
                            0,
                            (cube_dimensions_height+cube_seperation_height/2)*cube_in_stack,
                            cube_temp_configuration_array[cube_in_stack]);
        
        rotate([0,0,180])
        {
            translate([0,cube_dimensions_width/2,(cube_dimensions_height+cube_seperation_height/2)*cube_in_stack]) 
            {
                overhang(cube_dimensions_width,(distance_between_towers/2)-(cube_dimensions_width/2));
            }
        }
    }
}

// Generate the base structure
// FIXME: For now I am making this simply a big cube, but I want it to be a trapazoidal "pretty" base
tower_base( cube_dimensions_width*2+tower_base_additional_colar_size,
            distance_between_towers+(2*cube_dimensions_length)+(2*tower_base_additional_colar_size),
            tower_base_height,
            -(cube_dimensions_width)-tower_base_additional_colar_size,
            -cube_dimensions_length-tower_base_additional_colar_size,
            -tower_base_height-(cube_dimensions_height/2)-cube_seperation_height/2);


// =============================================================================================================
//                                  Support Functions
// =============================================================================================================
module tower_base(length,width,height,x_off,y_off,z_off)
{
    translate([x_off,y_off,z_off])
    {
        cube([length, width, height]);
    }
}

module temp_cube_and_colar(length,width,height,colar_depth,sep_height,x_off,y_off,z_off,temp)
{
    translate([x_off,y_off,z_off])
    {
        // Build the cube, and then its bottom colar
        embossed_temp_cube(length,width,height,temp);
        translate([0,0,-height/2])
        {
            temp_cube_colar(length-colar_depth,width-colar_depth,sep_height);
        }   
    }
}

module embossed_temp_cube(length, width, height, temp)
{
    difference()
    {
        cube([length, width, height] , center=true);
        // FIXME: Implement other sides, only using front and back for now, or have it be selectable
        rotate([90,0,90])
        {
                translate([0,0,(length/2)-cube_font_depth+.01])embossed_string(temp);
                translate([0,0,-(length/2)+cube_font_depth-.01])rotate([0,180,0])embossed_string(temp);
        }           
    }    
}
module temp_cube_colar(length, width, height)
{
    cube([length, width, height] , center=true);
}
module embossed_string(string_text) 
{
	linear_extrude(height = cube_font_depth) 
    {
		text(string_text, size = cube_font_size, font = cube_font, halign = "center", valign = "center", $fn = 16);
	}
}

module overhang(width, seperation_width) 
{
    triangle_points =[[0,0],[width/2,0],[0,width/2],[width/2,width/2]];
    triangle_paths =[[0,1,2],[3,4,5]];
    translate([0,0,(width/2)-2]) 
    {
        rotate([0,90,0]) 
        {
            linear_extrude(height = width, center = true, convexity = width, twist = 0)
            polygon(triangle_points,triangle_paths,0);
        }
    }   
    translate([-width/2, 0, width/4])
    cube([width, seperation_width, width/6]);
}


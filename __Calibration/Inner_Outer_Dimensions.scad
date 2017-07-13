// The purpose of this model is to test the thickness of walls, the outer dimensions of various
// shapes, and the internal dimensions of holes created inside shapes

//======================================================================================
test_platform_base_width        = 100;
test_platform_base_length       = 100;
test_platform_base_height       = 2;

test_feature_height             = [1,2,4,8,16,32];
test_feature_width              = [1,2,4,8,16,32];

//======================================================================================


// Generate the platform base
translate([-(test_platform_base_width/2),-(test_platform_base_length/2),0])
{
    cube([test_platform_base_width,test_platform_base_length,test_platform_base_height]);
}

// Generate a set of bars

// Generate a sex of X's

// Generate a set of Full Boxes

// Generate a set of Hollow Boxes

// Generate a set of Cylinders

// Generate a set of Hollow Cylinders

// Generate a set of Half Spheres

// Generate a set of Half Hollow Spheres

// Generate a set of Cubes, with holes along the X axis

// Generate a set of Cubes, with holes along the Y axis

// Generate a set of Cubes, with holes along the Z axis

//======================================================================================
module test_bar(x,y,z,x_off,y_off,z_off)
{
    translate([x_off,y_off,z_off])
    {
        cube([x,y,z],center=true);
    }
}
module test_box(x,y,z,x_off,y_off,z_off)
{
    
}
module test_box_hollow(x,y,z,x_off,y_off,z_off)
{
    
}
module test_cylinder(r,h,x_off,y_off,z_off)
{
    
}
module test_cylinder_hollow(r,h,r_2,x_off,y_off,z_off)
{
    
}
module test_cross(x,y,z,x_off,y_off,z_off)
{
    
}


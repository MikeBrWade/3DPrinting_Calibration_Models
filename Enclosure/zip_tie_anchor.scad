// GOAL: Design a parameterized zip tie anchor to be used for cable management
$fn = 128;
DEBUG_ENABLED = false;

// FEATURES:
//  1) Print with no supports (maintain <45 degree angles, or short bridges)
//  2) Standard zipties need to fit
//  3) PLA should be strong enough without having to use ABS or PETG (though I can default to that if need be)
//  4) Should take as parameters the "configuration" items, but default in the case where they are not provided or are zero
//  5) 


// CONFIGURATION NEEDS:
//  1) length/width/base height 
zip_tie_anchor_length           = 20;
zip_tie_anchor_width            = 20;
zip_tie_anchor_base_height      = 2;
zip_tie_anchor_base_edge_radius = 1;

//  2) height/width/gap of anchor "Cross" (Length is durived from base)
zip_tie_cross_height            = 4;
zip_tie_cross_width             = 3;
zip_tie_cross_gap_length        = 5;


zip_tie_anchor();

module zip_tie_anchor(length = 0 ,width = 0 ,base_height = 0 ,base_edge_radius = 0 ,cross_height = 0,cross_width = 0 ,cross_gap_length = 0 )
{
    // If the provided parameters are not present use the defaults
    l_zip_tie_anchor_length             = ( length == 0 ) ? zip_tie_anchor_length : length;
    l_zip_tie_anchor_width              = ( width == 0 ) ? zip_tie_anchor_width : width;
    l_zip_tie_anchor_base_height        = ( base_height == 0 ) ? zip_tie_anchor_base_height : base_height;
    l_zip_tie_anchor_base_edge_radius   = ( base_edge_radius == 0 ) ? zip_tie_anchor_base_edge_radius : base_edge_radius;
    l_zip_tie_cross_height              = ( cross_height == 0 ) ? zip_tie_cross_height : cross_height;
    l_zip_tie_cross_width               = ( cross_width == 0 ) ? zip_tie_cross_width : cross_width;
    l_zip_tie_cross_length              = sqrt(pow(l_zip_tie_anchor_length,2)+pow(l_zip_tie_anchor_width,2))-l_zip_tie_anchor_base_edge_radius+l_zip_tie_cross_width/2;

    // Output the config used for this ZTA if requested
    if ( DEBUG_ENABLED )
    {
        echo ( l_zip_tie_anchor_length                  = l_zip_tie_anchor_length );
        echo ( l_zip_tie_anchor_width                   = l_zip_tie_anchor_width );
        echo ( l_zip_tie_anchor_base_height             = l_zip_tie_anchor_base_height );
        echo ( l_zip_tie_cross_height                   = l_zip_tie_cross_height );
        echo ( l_zip_tie_cross_width                    = l_zip_tie_cross_width );
    }
    
    // Base
    cube([l_zip_tie_anchor_length+l_zip_tie_cross_width,l_zip_tie_anchor_width+l_zip_tie_cross_width,l_zip_tie_anchor_base_height],center = true);
    
    // Cross for ziptie
    
    difference()
    {
        // Cross
        union()
        {   
            translate([0,0,l_zip_tie_anchor_base_height])
            {
                // Main Cross/Arm
                rotate([0,0,45])
                cube([l_zip_tie_cross_length,l_zip_tie_cross_width,l_zip_tie_cross_height], center = true);
                
                // Set of 2 "filler" boxes for each corner to make the corners solid
                translate([l_zip_tie_anchor_length/2,l_zip_tie_anchor_width/2,0])
                cube([l_zip_tie_cross_width,l_zip_tie_cross_width,l_zip_tie_cross_height], center = true);
                
                translate([-l_zip_tie_anchor_length/2,-l_zip_tie_anchor_width/2,0])
                cube([l_zip_tie_cross_width,l_zip_tie_cross_width,l_zip_tie_cross_height], center = true);
            
                // Main Cross/Arm
                rotate([0,0,-45])
                cube([l_zip_tie_cross_length,l_zip_tie_cross_width,l_zip_tie_cross_height], center = true);
                
                // Set of 2 "filler" boxes for each corner to make the corners solid
                translate([-l_zip_tie_anchor_length/2,l_zip_tie_anchor_width/2,0])
                cube([l_zip_tie_cross_width,l_zip_tie_cross_width,l_zip_tie_cross_height], center = true);
                
                translate([l_zip_tie_anchor_length/2,-l_zip_tie_anchor_width/2,0])
                cube([l_zip_tie_cross_width,l_zip_tie_cross_width,l_zip_tie_cross_height], center = true);
                
                // Center Holding Box
                cube([l_zip_tie_anchor_length/3,l_zip_tie_anchor_width/3,l_zip_tie_cross_height], center = true);
                
            }
        }
        
        // Center Cutouts for zip ties
        union()
        {
            translate([0,0,l_zip_tie_anchor_base_height])
            {
                rotate([0,0,0])
                #cube([l_zip_tie_anchor_length/2,3.5,2],center = true);
        
                rotate([0,0,90])
                #cube([l_zip_tie_anchor_length/2,3.5,2],center = true);
            }
        }
        
        
    }
    
}

// Creation of a Box with X/Y/Z size, and rounded
// corners with R width
module RoundedCube(xdim ,ydim,zdim,rdim)
{
    hull()
    {
        translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);
        translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
    }
}

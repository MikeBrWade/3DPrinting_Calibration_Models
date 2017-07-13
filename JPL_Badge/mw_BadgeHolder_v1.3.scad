$fn=60;
// ====================== CONFIG ======================
badge_width                                 = 56;
badge_length                                = 87;
badge_thickness                             = 2.5;//1.2;
badge_rounding                              = 2;
// ----------------------------------------------------
badge_holder_thickness                      = 2;
badge_holder_rounding                       = 2;
badge_holder_lanyard_length                 = 10;
// ----------------------------------------------------
badge_holder_lanyard_clip_width             = 25;
badge_holder_lanyard_clip_thickness         = 4;
badge_holder_lanyard_hole_width             = 14;
badge_holder_lanyard_hole_length            = 5;
badge_holder_lanyard_hole_y_offset          = 2.5;
// ----------------------------------------------------
//badge_holder_logo_picture                   = "jpl.png";
badge_holder_logo_text                      = "JPL";
badge_holder_logo_text_size                 = 18;
badge_holder_logo_text_font                 = "Calibri:style=Bold";
badge_holder_logo_yoffset                   = 65;
badge_holder_logo_xoffset                   = 35;
// ----------------------------------------------------
badge_holder_bar_code_length                = 60;
badge_holder_bar_code_width                 = 14;
badge_holder_bar_code_yoffset               = 21;
badge_holder_bar_code_xoffset               = 38;
// ----------------------------------------------------
badge_holder_side_bracket_top_thickness     = 1;
badge_holder_side_bracket_yoffset           = 20;
badge_holder_side_bracket_length            = 55;
badge_holder_side_bracket_width             = 3;
badge_holder_side_bracket_top_width         = 6;
// ----------------------------------------------------
badge_holder_bottom_clip_peg_base_radius    = 2;
badge_holder_bottom_clip_peg_base_height    = 1;
badge_holder_bottom_clip_peg_length         = 2;
badge_holder_bottom_clip_peg_width          = 5;
badge_holder_bottom_clip_peg_height         = 4;
badge_holder_bottom_clip_length             = 14;
badge_holder_bottom_clip_width              = 8;
badge_holder_bottom_clip_roundness          = 1;
badge_holder_bottom_clip_cutout_length      = badge_holder_bottom_clip_length;
badge_holder_bottom_clip_cutout_width       = 3;
badge_holder_bottom_clip_cutout_rounding    = 1;
// ----------------------------------------------------
badge_holder_width                  = badge_width + (2*badge_holder_side_bracket_width);
badge_holder_length                 = badge_length + badge_holder_lanyard_length + badge_holder_bottom_clip_peg_length;
badge_holder_lanyard_hole_x_offset  = (badge_holder_width/2)-(badge_holder_lanyard_hole_width/2);
// =================================


// Badge
%translate([badge_holder_lanyard_length,
            badge_holder_side_bracket_width,
            badge_holder_thickness])
{
    RoundedCube(    badge_length,
                    badge_width,
                    badge_thickness,
                    badge_rounding);
}

// ------------ Badge Holder ------------
// Main Body w/ Cut Outs
difference()
{
    // Primary Backing
    RoundedCube(    badge_holder_length,
                    badge_holder_width,
                    badge_holder_thickness,
                    badge_holder_rounding);
    
    // Lanyard hole in primary backing
    translate([badge_holder_lanyard_hole_y_offset,badge_holder_lanyard_hole_x_offset,0])
    {
        cube([  badge_holder_lanyard_hole_length,
                badge_holder_lanyard_hole_width,
                badge_holder_thickness]); 
    }
    // Subtract out the JPL logo Text
    translate([badge_holder_logo_yoffset,badge_holder_logo_xoffset,0])
    {
        rotate([180,180,0])
        {
            // For some reason I have to add .1 mm to the text to ensure it full slices out
            // of the background shape
            #linear_extrude(badge_holder_thickness+.1)
            {
                //surface(file=badge_holder_logo_picture,invert=true); 
                //import(badge_holder_logo_picture); 
                text(   badge_holder_logo_text, 
                        size = badge_holder_logo_text_size, 
                        font = badge_holder_logo_text_font );
            }
        }
    }
    // Scannable Hole
    translate([badge_holder_bar_code_yoffset,badge_holder_bar_code_xoffset,0])
    {
        cube([  badge_holder_bar_code_length,
                badge_holder_bar_code_width,
                badge_holder_thickness]); 
    }
    
    // Bottom Clip Bracket Cutouts (RIGHT&LEFT)
    translate([ badge_holder_length - badge_holder_bottom_clip_cutout_length + badge_holder_bottom_clip_cutout_rounding,
                (badge_holder_width/2)-(badge_holder_bottom_clip_width/2)-(badge_holder_bottom_clip_cutout_width/2),
                0])
    {
        RoundedCube(    badge_holder_bottom_clip_cutout_length,
                        badge_holder_bottom_clip_cutout_width,
                        badge_holder_thickness,
                        badge_holder_bottom_clip_roundness);
    }
    translate([ badge_holder_length - badge_holder_bottom_clip_cutout_length + badge_holder_bottom_clip_cutout_rounding,
                (badge_holder_width/2)+(badge_holder_bottom_clip_width/2)-(badge_holder_bottom_clip_cutout_width/2),
                0])
    {
        RoundedCube(    badge_holder_bottom_clip_cutout_length,
                        badge_holder_bottom_clip_cutout_width,
                        badge_holder_thickness,
                        badge_holder_bottom_clip_roundness);
    }
}
// JPL "P" Bridge
// FIXME: WADE - This is just a 3D printing patch due to the "P" having a gap
// internal to the letter that we need to bridge so it sticks to the rest of the 
// part   
translate([49,18,0])cube([2,badge_holder_logo_text_size,1]);



// Badge Side Holder Bracket (LEFT)
translate([ badge_holder_side_bracket_yoffset,
            0,
            badge_holder_thickness])
{
    cube([  badge_holder_side_bracket_length,
            badge_holder_side_bracket_width,
            badge_thickness]); 
}
translate([ badge_holder_side_bracket_yoffset,
            0,
            badge_holder_thickness+badge_thickness])
{
    cube([  badge_holder_side_bracket_length,
            badge_holder_side_bracket_top_width,
            badge_holder_side_bracket_top_thickness]);
}
// Badge Side Holder Bracket (RIGHT)
translate([ badge_holder_side_bracket_yoffset,
            badge_holder_width-badge_holder_side_bracket_width,
            badge_holder_thickness])
{
    cube([  badge_holder_side_bracket_length,
            badge_holder_side_bracket_width,
            badge_thickness]); 
}
translate([ badge_holder_side_bracket_yoffset,
            badge_holder_width-badge_holder_side_bracket_width-(badge_holder_side_bracket_top_width/2),
            badge_holder_thickness+badge_thickness])
{
    cube([  badge_holder_side_bracket_length,
            badge_holder_side_bracket_top_width,
            badge_holder_side_bracket_top_thickness]);
}



// Badge Bottom Clip Bracket
translate([badge_holder_length,badge_holder_width/2,0])
{
    cylinder(h=badge_holder_bottom_clip_peg_base_height,r=badge_holder_bottom_clip_peg_base_radius);     
    translate([0,-(badge_holder_bottom_clip_peg_width/2),0])
    {
        rotate([0,0,90])
        {
            // Create the "stopper" Peg
            cube([  badge_holder_bottom_clip_peg_width,
                    badge_holder_bottom_clip_peg_length,
                    badge_holder_bottom_clip_peg_height]);
        }
    }
}

/**/
// Lanyard Location
translate([ badge_holder_lanyard_length,
            (badge_holder_width/2)+(badge_holder_lanyard_clip_width/2),
            badge_holder_thickness])
{
    // Build the Trapazoidal Lanyard Clip & Whole
    difference()
    {
        rotate([0,0,-180])
        {
            prism(badge_holder_lanyard_clip_width,badge_holder_lanyard_length,badge_holder_lanyard_clip_thickness);
        }
        rotate([0,0,-180])
        {
            translate([badge_holder_lanyard_hole_y_offset,(badge_holder_lanyard_clip_width-badge_holder_lanyard_hole_width)/2,0])
            {
                cube([  badge_holder_lanyard_hole_length,
                        badge_holder_lanyard_hole_width,
                        badge_holder_lanyard_clip_thickness]); 
            }
        }
    }
}
// Creation of a Box with X/Y/Z size, and rounded
// corners with R width
module RoundedCube(xdim ,ydim ,zdim,rdim)
{
    hull()
    {
        translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);
        translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
    }
}

// Used for Trapazoid "wedges"
module prism(l, w, h) 
{
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}


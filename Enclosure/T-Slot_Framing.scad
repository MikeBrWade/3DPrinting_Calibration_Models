include <T-Slot_Extrusions.scad>;
include <T-Slot_Mounting_Pieces.scad>;

// Allow for different frame items to be constructed out of tslot sets
brace_guide_depth_in_mm                 = 1;
brace_guide_width_in_mm                 = 5.8;  // Based on 2020 extrusion measured width
brace_bracket_wall_thickenss_in_percent = 0.10; // Increase for strength

// test rendering
//create_2020_framed_box( 200, 300, 200, 20, 50, 5, 1, 1);


// Make the l/w/h all parameterized, also ensure that top and bottom sections can be 
// turned on and off for modeling stacked configurations
module create_2020_framed_box(length,width,height,frame_size,brace_length,mount_hole_size,enable_bottom,enable_top)
{
    // Bottom Frame
    if(enable_bottom == 1)
    {
        rotate([90,0,0])
        {
            frame_piece( length, width, frame_size, brace_length, mount_hole_size);
        }
    }
    
    // Top Frame
    if(enable_top == 1)
    {
        rotate([90,0,0])translate([0,height-frame_size,0])
        {
            frame_piece( length, width, frame_size, brace_length, mount_hole_size);
        }
    }
    
    // Height Frame Supports
    // Back-Left
    translate([ 0, (-width/2)+(frame_size/2), (height/2)-(frame_size/2)])rotate([0,0,0])
    {
        frame_verticle_strut(height-(frame_size*2),frame_size, brace_length, mount_hole_size);
    }
    // Back-Right
    translate([ 0, (width/2)-(frame_size/2), (height/2)-(frame_size/2)])rotate([0,0,-90])
    {
        frame_verticle_strut(height-(frame_size*2),frame_size, brace_length, mount_hole_size);
    }
    // Front-Right
    translate([ length, (width/2)-(frame_size/2), (height/2)-(frame_size/2)])rotate([0,0,180])
    {
        frame_verticle_strut(height-(frame_size*2),frame_size, brace_length, mount_hole_size);
    }
    // Front-Left
    translate([ length, (-width/2)+(frame_size/2), (height/2)-(frame_size/2)])rotate([0,0,90])
    {
        frame_verticle_strut(height-(frame_size*2),frame_size, brace_length, mount_hole_size);
    }
    
}

module frame_verticle_strut(height, extrusion_size, brace_length, mount_hole_size)
{
    echo("Strut-2020: ",height, "mm");
    // Main Strut Body
    if( RENDER_ALL_PARTS == true)
        2020Profile(height , core = ProfileCore);
    
    // Top Pair of Brackets
    translate([extrusion_size/2,-extrusion_size/2,(height/2)-brace_length])rotate([-90,-90,0])
    {
        tslot_corner_support_brace( brace_length, 
                                    extrusion_size, 
                                    mount_hole_size, 
                                    brace_guide_depth_in_mm, 
                                    brace_guide_width_in_mm, 
                                    brace_bracket_wall_thickenss_in_percent);
    }
    translate([(extrusion_size/2),(extrusion_size/2), height/2-brace_length])rotate([0,-90,0])
    {
        tslot_corner_support_brace( brace_length, 
                                    extrusion_size, 
                                    mount_hole_size, 
                                    brace_guide_depth_in_mm, 
                                    brace_guide_width_in_mm, 
                                    brace_bracket_wall_thickenss_in_percent);
    }
    
    // Bottom pair of Brackets

    translate([brace_length+(extrusion_size/2),-extrusion_size/2,(-height/2)])rotate([-90,180,0])
    {
        tslot_corner_support_brace( brace_length, 
                                    extrusion_size, 
                                    mount_hole_size, 
                                    brace_guide_depth_in_mm, 
                                    brace_guide_width_in_mm, 
                                    brace_bracket_wall_thickenss_in_percent);
    }
    translate([-extrusion_size/2,extrusion_size/2,-height/2+brace_length])rotate([0,90,0])
    {
        tslot_corner_support_brace( brace_length, 
                                    extrusion_size, 
                                    mount_hole_size, 
                                    brace_guide_depth_in_mm, 
                                    brace_guide_width_in_mm, 
                                    brace_bracket_wall_thickenss_in_percent);
    }

    
}


// This is a "box" that has all 4 pieces and is used to create the base of a structure
module frame_piece(length, width, extrusion_size, brace_length,mount_hole_size)
{   
    
    if( RENDER_ALL_PARTS == true)
    {
            // Back
            2020Profile(width, core = ProfileCore);echo("B-2020: ",width, "mm");
            // Front
            translate([length,0,0]){2020Profile(width, core = ProfileCore);echo("F-2020: ",width, "mm");}
    }
    
    if( RENDER_ALL_PARTS == true)
    {
        // Sides (Left and Right)
        rotate([0,90,0])
        {
            // Left
            translate([-width/2+(extrusion_size/2),0,length/2]){2020Profile(length-(extrusion_size), core = ProfileCore);echo("L-2020: ",length-(extrusion_size), "mm");}
            // Right
            translate([(width/2)-(extrusion_size/2),0,length/2]){2020Profile(length-(extrusion_size), core = ProfileCore);echo("R-2020: ",length-(extrusion_size), "mm");}
        }
    }
        
        // Generate the braces
        // Back-Left Brace
        rotate([-90,-90,0])translate([(width/2)-extrusion_size-brace_length,extrusion_size/2,-extrusion_size/2])
        tslot_corner_support_brace(brace_length, extrusion_size, mount_hole_size, brace_guide_depth_in_mm, brace_guide_width_in_mm, brace_bracket_wall_thickenss_in_percent);
        
        // Back-Right Brace
        rotate([90,90,0])translate([(width/2)-extrusion_size-brace_length,extrusion_size/2,-extrusion_size/2])
        tslot_corner_support_brace(brace_length, extrusion_size, mount_hole_size, brace_guide_depth_in_mm, brace_guide_width_in_mm, brace_bracket_wall_thickenss_in_percent);
        
        // Front-Right Brace
        translate([(length-extrusion_size/2),-(extrusion_size/2),(-width/2)+brace_length+extrusion_size])rotate([0,90,90])
        tslot_corner_support_brace(brace_length, extrusion_size, mount_hole_size, brace_guide_depth_in_mm, brace_guide_width_in_mm, brace_bracket_wall_thickenss_in_percent);
        
        // Front-Left Brace
        translate([(length-extrusion_size/2),(extrusion_size/2),(width/2)-brace_length-extrusion_size])rotate([0,-90,90])
        tslot_corner_support_brace(brace_length, extrusion_size, mount_hole_size, brace_guide_depth_in_mm, brace_guide_width_in_mm, brace_bracket_wall_thickenss_in_percent);
}

// Allow for different frame items to be constructed out of tslot sets



// Make the l/w/h all parameterized, also ensure that top and bottom sections can be 
// turned on and off for modeling stacked configurations
module create_2020_framed_box(length,width,height,frame_size,enable_bottom,enable_top)
{
    // Bottom Frame
    if(enable_bottom == 1)
    {
        rotate([90,0,0])
        {
            frame_piece( length, width, frame_size);
        }
    }
    
    // Top Frame
    if(enable_top == 1)
    {
        rotate([90,0,0])translate([0,height-frame_size,0])
        {
            frame_piece( length, width, frame_size);
        }
    }
    
    // Height Frame Supports
    // Back-Left
    translate([ 0, (-width/2)+(frame_size/2), (height/2)-(frame_size/2)])
    {
        2020Profile( height-(frame_size*2), core = ProfileCore);
        echo("BL-2020: ",height, "mm");
    }
    // Back-Right
    translate([ 0, (width/2)-(frame_size/2), (height/2)-(frame_size/2)])
    {
        2020Profile( height-(frame_size*2), core = ProfileCore);
        echo("BR-2020: ",height, "mm");
    }
    // Front-Right
    translate([ length, (width/2)-(frame_size/2), (height/2)-(frame_size/2)])
    {
        2020Profile(height-(frame_size*2), core = ProfileCore);
        echo("FR-2020: ",height, "mm");
    }
    // Front-Left
    translate([ length, (-width/2)+(frame_size/2), (height/2)-(frame_size/2)])
    {
        2020Profile(height-(frame_size*2), core = ProfileCore);
        echo("FL-2020: ",height, "mm");
    }
}

module frame_piece(length, width, extrusion_size)
{
    
    
        // Back
        2020Profile(width, core = ProfileCore);echo("B-2020: ",width, "mm");
        // Front
        translate([length,0,0]){2020Profile(width, core = ProfileCore);echo("F-2020: ",width, "mm");}
    
    
        // Sides (Left and Right)
        rotate([0,90,0])
        {
            // Left
            translate([-width/2+(extrusion_size/2),0,length/2]){2020Profile(length-(extrusion_size), core = ProfileCore);echo("L-2020: ",length-(extrusion_size), "mm");}
            // Right
            translate([(width/2)-(extrusion_size/2),0,length/2]){2020Profile(length-(extrusion_size), core = ProfileCore);echo("R-2020: ",length-(extrusion_size), "mm");}
        }
}

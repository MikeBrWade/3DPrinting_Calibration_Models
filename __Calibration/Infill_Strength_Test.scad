difference()
{
    cube([8,40,3]);
    rotate([0,0,90])
    {
        translate([20,-4,2.5])
        {
            linear_extrude(2)
            {
                #text(   "100%", 
                        size = 6, 
                        font = "Calibri:style=Bold",
                        halign = "center",
                        valign = "center",
                        $fn = 30);
                
            }
        }
    }
}
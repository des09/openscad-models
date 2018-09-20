$fn=96;

rotate([0,90,0])
difference(){
    translate([0,0,100])
        rotate_extrude(convexity = 10){
            translate([80,0,0])
                    difference(){
                        circle(r=70);
                        circle(r=65);
        }   
    }   
    
    cube([1000,1000,400]);
    
    translate([-50,-1000]){
        cube([1001,1000,200]);
    } 

    rotate([0,0,-20])
        translate([-500,-1000]){
            cube([1000,1000,200]);
        } 
    
    
}


    
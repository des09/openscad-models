module MotorMount(r,h){
    difference(){
        
        union(){
            //base plate
            
            translate([r*2, -r+2, 0])
                cylinder(h = h+2 , r1 =4, r2 = 4, $fn = 180,$fs = 1);
            translate([-r*2, -r+2, 0])
                cylinder(h = h+2 , r1 =4, r2 = 4, $fn = 180,$fs = 1);
            
            translate([-r*2, -r-2, 0]){
            cube([r*4,8,h+2]);
            }
            translate([-r, -r-2, 0]){
            cube([r*2,r,h]);
                
            }
            
            //body
            cylinder(h = h+2 , r1 =r + 2, r2 = r + 2, $fn = 180,$fs = 1);
            
            //screw wings
            translate([r+5 ,0, 0]){
                cylinder(h = h+2 , r1 =4, r2 = 4, $fn = 180,$fs = 1);
                translate([-4 ,-4, 0])
                cube([4,8,h-1]);
            }
            translate([-r-5 ,0, 0]){
                cylinder(h = h+2 , r1 =4, r2 = 4, $fn = 180,$fs = 1);
                translate([0 ,-4, 0])
                cube([4,8,h-1]);
            }
            //wire bump
            translate([-6.5, r, 0])
                cube([13, 5, h-3]);
        }
        translate([0,0,2])
        cylinder(h = h + 1 , r1 =r, r2 = r, $fn = 180,$fs = 1);
        
        //wire bump cutout
        translate([-5.5,r-1,2])
        cube([11,5,h + 8]);    
        
        //wing screws
        translate([r + 5, 0, -5])
        cylinder(h = h+10 , r1 = 1.5, r2 = 1.5, $fn = 180,$fs = 1);
        translate([-r - 5, 0, -5])
        cylinder(h = h+10 , r1 = 1.5, r2 = 1.5, $fn = 180,$fs = 1);
        
    //base screws
        translate([r + 15, -r - 17.9, h/2])
        rotate([0,90,90]){
        cylinder(h = 20 , r1 = 2.5, r2 = 2.5, $fn = 180,$fs = 1);
        translate([0, 0, 19])
        cylinder(h = 5 , r1 = 1.5, r2 = 5, $fn = 180,$fs = 1);
        }
    
        translate([-r - 15, -r - 17.9, h/2])
        rotate([0,90,90]){
        cylinder(h = 20 , r1 = 2.5, r2 = 2.5, $fn = 180,$fs = 1);
        translate([0, 0, 19])
        cylinder(h = 5 , r1 = 1.5, r2 = 5, $fn = 180,$fs = 1);
        }    
    }
    
        
}

translate([0,-31,0])
rotate([0,0,180]){
MotorMount(28.2,19.3);
}
translate([0,31,0])
//rotate(0,0,45)
MotorMount(28.2,19.3);

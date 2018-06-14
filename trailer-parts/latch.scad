length = 36;
width = 18;
thickness = 4;
shaft_w = 12;
collar_r = shaft_w * sqrt(2) / 2; 
peg_r = 5;

pushrod_d = 25;

yoke_width = 18;
yoke_length = 36;

module tang(){
 
     difference(){
         union(){
     translate([(width / 4 - length) * 0.5,-width / 4 ,0]){
        minkowski() {
            cube([length - width / 4, width / 2, thickness/2]);
            cylinder(r=width / 4, h=thickness/2);
        }
     }
     translate([- length * 0.5, 0, 0])
         cylinder( h = thickness, r = width/2 );    
     translate([length * 0.5, 0, 0])
         cylinder( h = thickness, r = width/2 );    
     
 }
    // 3 cutouts
      translate([-shaft_w / 2, -shaft_w/2, -1])
        cube([shaft_w,shaft_w, thickness +2]);
     
 
      translate([-length/2,0,-1])
         cylinder(h=thickness+2 , r=peg_r + 0.1, $fn= 50);    
      
      translate([length/2,0,-1])
         cylinder(h=thickness+2 , r=peg_r + 0.1, $fn= 50);    
     }
}

module shaft(){
    difference(){
        shaft_l = thickness * 8;
        cube([shaft_l,shaft_w - 0.3,shaft_w - 0.3], centered = true);
        rotate([-90,0,90])
            translate([shaft_w/2 - 0.15,- shaft_w/2 + 0.15,-shaft_l - 1])
                cylinder(h=shaft_l + 2, r=shaft_w /3, $fn= 50);
    }
}

module yoke(){
         pushrod_x = yoke_width - thickness;
         pushrod_z = thickness * 2 + 1;
    
    translate([0,0,yoke_length])
        rotate([-90,0,0]){
    
            difference(){
                union(){
                    cube([yoke_width, yoke_length, thickness * 3 + 1 ]);
                    translate([yoke_width/2 ,0,0])
                        cylinder(r=yoke_width/2, h=3* thickness + 1, $fn= 50);
                }
                   
                
                //dowel hole and slot
                translate([yoke_width/2,0 ,-1]){ 
                    cylinder(h=thickness * 3 + 4 , r=peg_r, $fn= 50);
                }
                translate([yoke_width/2,0, 1.5 * thickness ])
                    cube([yoke_width + 0.5, yoke_width + 0.5, thickness + 0.5], center=true);
                
                
                translate([(yoke_width - pushrod_x)/2,yoke_width/2 + thickness / 2, (3* thickness + 1  - pushrod_z) / 2])
                    cube([pushrod_x,yoke_length,pushrod_z]);
                
            }         
        }            
} 



module plate(){
    intersection(){
        cylinder(h=100, r=length /2 + width / 2, $fn= 100 );
        difference(){
            union(){
                cylinder(h=thickness / 2, r=length /2 + width / 2, $fn= 100 );
                
                translate([10,10,0])
                    cube([thickness * 5,thickness * 5,thickness * 3.5 + 1.5]);
                translate([-10 - thickness * 5,-10 - thickness * 5,0])
                    cube([thickness * 5, thickness * 5, thickness * 3.5 + 1.5]);
            }
            translate([0,0,-1])
                cylinder(h=thickness * 2, r = collar_r + 3, $fn = 50 );
            translate([15,15,-1])
                cylinder(h=thickness *50, r=2, $fn=20);
            translate([-15,-15,-1])
                cylinder(h=thickness *50, r=2, $fn=20);
        }
}
}
module collar(){
    difference(){
        union(){
            cylinder(h=thickness /2 , r = collar_r + 6, $fn = 50 );
            cylinder(h=thickness, r = collar_r + 3 - 0.2, $fn = 50 );
            
        }
        translate([0,0,thickness/2])
        cube([shaft_w, shaft_w, thickness+1], center = true);
    }
    
}
module plate2(){
    intersection(){
        cylinder(h=100, r=length /2 + width / 2, $fn= 100 );
        difference(){
            
                cylinder(h=thickness / 2, r=length /2 + width / 2 , $fn= 100);
                
                translate([15,15,-1])
                    cylinder(h=thickness / 2 + 1.01, r1=1.0, r2=4,$fn=20);
                    
                translate([5 - thickness * 5,5 - thickness * 5,-1])
                    cylinder(h=thickness / 2 + 1.01, r1=1.0, r2=4, $fn=20);
            
            translate([0,0,-1])
            cylinder(h=thickness * 2, r = collar_r + 3, $fn = 50 );
        }
}
}

translate([0,(length /2 + width / 2 + yoke_width + 5),0])
    plate();

translate([0, - yoke_width - 5 - (length /2 + width / 2),0])
    plate2();

translate([-39,-24,0])
    collar();
translate([40,-24,0])
    collar();


union(){
    translate([0, 5 ,0]){
        cylinder(h=thickness * 10, r=shaft_w /3 - 0.2, $fn = 20);
        cylinder(h=thickness * 10, r=shaft_w /3 - 0.8, $fn = 20);
        cylinder(h=thickness * 10, r=shaft_w /3 - 1.2, $fn = 20);
    }

    translate([5,5,0])
        yoke();

    translate([-yoke_width - 5,5,0])
        yoke();

    translate([-5,5,0])
        cube([10,0.2 ,yoke_length ]);
}

translate([0,-width /2,0])
    tang();    


//pegs
translate([-yoke_width - 5 - peg_r *2, thickness * 2 + 2 * peg_r,0])
    cylinder(h=thickness * 3 , r=peg_r - 0.3, $fn= 50); 

translate([-yoke_width - 5 - peg_r *2, thickness * 2 -1 ,0])
    cylinder(h=thickness * 3 , r=peg_r - 0.3, $fn= 50); 

translate([yoke_width + shaft_w + 5 + 5 ,0,0])
    rotate([0,0,90])
        shaft();


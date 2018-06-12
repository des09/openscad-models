length = 30;
width = 15;
thickness = 5;
shaft_w = 8;
peg_r = 5;

yoke_width = 20;
yoke_length = 20;

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

module plate(t,r,w){
    difference(){
        union(){
            cylinder(h=w + 2, r=t/2);
            cylinder(h=1.5 , r=t * 1.5);
        }
        translate([0,0,w/2])
        cylinder(h=15 , r=w*1.46, $fn= 50);
        
        translate([-w,-w,-1])
            cube([w*2,w*2,w+4], centered = true);
    }
}

module shaft(t,r,w){
            cube([w*2 - 0.3 ,w*2 - 0.3 ,w * 8], centered = true);
}

module yoke(d){
    rs = (w+2) * 0.5;
         
        difference(){
            //body
            cube([yoke_width, yoke_width *2.5 ,yoke_length ]);
            
            //slot for lever
            /*concave in slot
                translate([r/4 , 4*d + w , w + rs ]){
                    rotate([90,0,90]){
                        hull(){
                        cylinder(h=r /2 , r=rs);
                        translate([-w ,0, -w])
                            cylinder(h=w*3 + 5, r=rs);    
                        }
                    }
                }
        */
            
                    
            
            //dowel hole    
            translate([yoke_width/2,yoke_width/2 ,-1]){
                cylinder(h=w * 3 + 4 , r=peg_r, $fn= 50);
                translate([0,0 ,w]){
                    cylinder(h=w, r=r*0.7);
                }
            }
            
            translate([-1,-60,-1])
            rotate([0,0,45]){
                cube([48,50,w*4]);
                translate([12,-18,0])
                color([1,0,1])
                    cube([50,50,w*4]);
            }
        }
        
        // rod hole
            yhw = yoke_width - 5;
            translate( [ (yoke_width - yhw) / 2, (3 * thickness + 1) / 2, 25])
                color([1,0.5,1])
                    cube([2*w,yoke_width,2*w]);
            
            
} 




plate(20,6,4);

translate([24,-30,0]){
    shaft(20,6,4);
}

translate([0,-58,0]){
    translate([0,15,0])
    tang();

    translate([7,0,0])
        rotate([90,0,0])
            yoke(4);

    translate([-27,0,0])
        rotate([90,0,0])
            yoke(4);

    translate([0,-2,0])
    cylinder(h=6 * 3 + 2 , r=peg_r - 0.3, $fn= 50); 

    translate([0,-14,0])
    cylinder(h=6 * 3 + 2 , r=peg_r - 0.3, $fn= 50); 

}
module tang(t,r,w){
 
     difference(){
         union(){
     translate([(w- t) * 0.5,-w,0]){
        minkowski() {
            cube([t -w, r - 2 * w, w/2]);
            cylinder(r=w, h=w/2);
        }
     }
     translate([- t * 0.5, 0,0])
         cylinder(h=w , r=r/2);    
     translate([t * 0.5, 0,0])
         cylinder(h=w , r=r/2);    
     
 }
    // 3 cutouts
      translate([-w,-w,-1])
        cube([w*2,w*2,w+2]);
     
 
      translate([-t/2,0,-1])
         cylinder(h=w+2 , r=w, $fn= 50);    
      
      translate([t/2,0,-1])
         cylinder(h=w+2 , r=w, $fn= 50);    
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

module yoke(r,w,d){
    rs = (w+2) * 0.5;

    rotate([90,0,0]){

        difference(){
            //body
            cube([r, r *2.5, w * 3 + 2]);
            
            //slot for lever
            translate([-1,-1,w ])
                cube([r + 2, 4*d  + 1, rs *2 ]);    
            //concave in slot
                translate([r/4 , 4*d + w , w + rs ]){
                    rotate([90,0,90]){
                        hull(){
                        cylinder(h=r /2 , r=rs);
                        translate([-w ,0, -w])
                            cylinder(h=w*3 + 5, r=rs);    
                        }
                    }
                }
        
        // rod hole
        translate([r/2 - w ,1.5*r + 1, (w * 1.5 + 1) -w ])
            color([1,0.5,1])
                cube([2*w,r,2*w]);        
        //dowel hole    
        translate([r/2,r/2 ,-1])
            cylinder(h=w * 3 + 4 , r=w-1 
    }    
} 




plate(20,6,4);

translate([24,-30,0]){
    shaft(20,6,4);
}

translate([0,-58,0]){
    translate([0,15,0])
    tang(40,20,5);

    translate([7,0,0])
    yoke(20,6,4);

    translate([0,-2,0])
    cylinder(h=6 * 3 + 4 , r=6-1.3, $fn= 50); 

    translate([0,-14,0])
    cylinder(h=6 * 3 + 4 , r=6-1.3, $fn= 50); 

    translate([-27,0,0])
    yoke(20,6,4);
}
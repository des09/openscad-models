function steps( start, no_steps, end) = [start:(end-start)/(no_steps):end];

module Hub(){
difference(){
   union(){
        //base
        difference() {
            union(){
                translate([-8.5, -8.5, -8])
                cube([17,17,6]);
                
                color([0,1,0])//green
                translate([-7.5, -7.5, -2])
                cube([15,15,2]);
            }
        translate([0, 0, 1])
            cylinder(h = 20 , r1 =27, r2 = 27, $fn = 180,$fs = 1);
        }
        color([1,0,0])//red
        cylinder(h = 9, r1 = 6, r2 = 6, $fn = 90,$fs = 1);
        
        //shaft key hole support
        color([1,0,1])
        rotate([90,90,45]){
            translate([-6, 0, -7])
            cylinder(h = 14, r1 = 3, r2 = 3, $fn = 90,$fs = 1);
            translate([-5, -2.5, -7])
            cube([5,5,14]);
        }
    }
    rotate([0,0,45])
    difference() {
        translate([0, 0, -1])
            cylinder(h = 15, r1 = 2.5, r2 = 2.5);
        translate([0, 4.5, 7])
            cube([10,6,15], center = true);
        translate([0, -4.5, 7])
            cube([10,6,15], center = true);
    }
    
    //shaft key holes
    rotate([90,90,45])
            translate([-6, 0, -20])
            cylinder(h = 70, r1 = 1.4, r2 = 1.5, $fn = 90,$fs = 1);
}
}


module Strap(length){  // 1 color on 1 bar
   
    difference(){
    union(){
        cube([length,10,1]);

        translate([0,5,0])
            cylinder(h = 2 , r1 =5, r2 = 5, $fn = 180,$fs = 1);

    translate([length,5,0])
        cylinder(h = 2 , r1 =5, r2 = 5, $fn = 180,$fs = 1);


    }

    translate([length,5,-.5])
        cylinder(h = 3 , r1 =1.8, r2 = 1.8, $fn = 180,$fs = 1);
        
    translate([0,5,-.5])
        cylinder(h = 3 , r1 =1.8, r2 = 1.8, $fn = 180,$fs = 1);
        }
}

translate([-25,-1,0])
    Strap(length = 47.5);

rotate([0,0,45])
    translate([30,-18.5,0])
    Strap(length = 47.5);

rotate([0,0,-45])
    translate([-60,93.5,0])
    Strap(length = 47.5);

rotate([0,0,125])
    translate([28,16.5,0])
Strap(length = 82.27);


rotate([0,0,30])
    translate([-5,102.5,0])
Strap(length = 82.27);



translate([0,60,0]){
// inner ridges
for( i=steps(0,36,360)){        
    rotate([0, 0, i])
        translate([44, -1, 0])
            cube([1.5,2,19.7]);
}

difference(){
            cylinder(h = 20 , r1 =50, r2 = 50, $fn = 180,$fs = 1);
            translate([-8.55,-8.55, 2.1])
                cube([17.1,17.1,20]);
            translate([-7.55,-7.55, -1])
                cube([15.1,15.1,20]);
            translate([0, 0, 7])
                cylinder(h = 20 , r1 =45, r2 = 45, $fn = 180,$fs = 1);
            

// ticks
for( i=steps(0,4,360)){        
    rotate([0, 0, i])
        translate([44, -.3, 19.7])
            cube([14,0.5,1]);
}
for( i=steps(0,4,360)){        
    rotate([0, 0, i + 45])
        translate([47, -.3, 19.7])
            cube([14,0.5,1]);
}

// perimeter screw holes
for( i=steps(0,6,360)){        
    rotate([0, 0, i+10])
        translate([47.5, 0, 8])
            cylinder(h = 22 , r1 =1.5, r2 = 1.5, $fn = 180,$fs = 1);
}
}

}
//hub structure
translate([60,60,8])
  Hub();

//hub structure
translate([-58,75,8])
rotate([0,0,70])
  Hub();


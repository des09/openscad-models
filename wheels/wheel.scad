function steps( start, no_steps, end) = [start:(end-start)/(no_steps-1):end];

difference(){
    union(){
        difference() {
        cylinder(h = 10, r1 = 25, r2 = 25, $fn = 180,$fs = 1);
        translate([0, 0, 1])
            cylinder(h = 10 , r1 = 0, r2 = 27, $fn = 180,$fs = 1);
        }
        cylinder(h = 7, r1 = 6, r2 = 6, $fn = 90,$fs = 1);
    }
    rotate([0,0,30])
    difference() {
        translate([0, 0, -1])
            cylinder(h = 15, r1 = 2.5, r2 = 2.5);
        translate([0, 4.5, 7])
            cube([10,6,15], center = true);
        translate([0, -4.5, 7])
            cube([10,6,15], center = true);
    }
 
    //inner holes
    for( i=steps(0,7,360)){
        
        rotate([0, 0, i])
        translate([-15,0,-1])
        scale([1.2, 0.5])
        cylinder(h = 11, r1 = 8, r2 = 5, $fn = 120);
        
        rotate([0, 0, i +30])
        translate([-7.2,0,-1])
        scale([1.4, 0.6])
          cylinder(h = 11, r1 = 1.4, r2 = 0.8, $fn = 72);
        
        rotate([0, 0, i + 30])
        translate([-17,0,-1])
        scale([1.4, 0.6])
        cylinder(h = 11, r1 = 5, r2 = 3, $fn = 72);
        
        rotate([0, 0, i + 16.5])
        translate([-20,0,-1])
        scale([1.4, 0.5])
        cylinder(h = 11, r1 = 3, r2 = 2, $fn = 36);
        
        rotate([0, 0, i - 16.5])
        translate([-20,0,-1])
        scale([1.4, 0.5])
        cylinder(h = 11, r1 = 3, r2 = 2, $fn = 36);
        //rotate([0, 0, i])
        //translate([-22,0,-1])
        //cylinder(h = 11, r1 = 2, r2 = 2, $fn = 36);
    }

/*    rotate_extrude(convexity = 10, $fn = 100)
        translate([14, 0, 0])
        scale([1.6, 0.6])
        circle(r = 4, $fn = 100);
*/    
    translate([0, 0, 5])
    rotate_extrude(convexity = 11, $fn = 100)
        translate([28, 0, 0])
        scale([0.6, 1.6])
        circle(r = 6, $fn = 100);
}

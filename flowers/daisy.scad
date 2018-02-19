  function steps( start, no_steps, end) = [start:(end-start)/(no_steps-1):end];
scale([0.3,0.3,0.3])
union(){
    difference(){
        union(){
            translate([0,0,1]){
            for( i=steps(0,15,360)){
                rotate([0, 0, i])
                translate([-18.3,0,-1])
                scale([1.4, 0.4, 0.15])
                sphere(r = 9, r1 = 6, r2 = 6, $fn = 120, $fs = 1);
            }
        }
        translate([0,0,-4])
        scale([1, 1, 0.8])
        sphere(r=8);
    }
        translate([0,0,-20])
        cube([65,65,40], center = true);
    }
    
}
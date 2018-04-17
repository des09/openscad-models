function steps( start, no_steps, end) 
    = [start:(end-start)/(no_steps):end];
scale([2.5,2.5,1.5])             
union(){
    difference(){
        union(){
        
            for( i=steps(0,13,360)){
                rotate([0, 0, i])
                petal();
            }
            
            translate([0,0,-4])
            sphere(r=8);
        }
        translate([0,0,-20]){
            cube([65,65,40], center = true);
            cylinder(h=22, r1=4, r2=4);
        }
    }
    
}


module petal(x=1,y=1){

    translate([-12,0,-4.0]){
        rotate(a=41, v=[0,1,0])
        intersection(){            
            linear_extrude(height=7, scale=[1,0.14], slices=40, twist=10)
                circle(r=6, $fn=120);
            
            translate([5,0,-5])
                sphere(r=12.7, $fn=180); 
        }
    }
}
th = 6;
wall = 145;
wall_half = wall / 2 - th /2;
epsilon = 0.1;
r4 = 51-th;
rfan=68;
dfan_h=62;
$fn=320;
$vpt = [0, -20, 100];
difference(){
    union(){
        //right
        translate([wall_half,0,wall / 2])
            s_wall();

        //left
        translate([-wall_half,0,wall / 2])
            s_wall(true);

        //front
        translate([0,wall_half - 18.5,wall / 2]){
            rotate([-15,0,0])
                f_wall();
        }

        //back
        translate([0,- wall_half,wall / 2])
            rotate([90,0,0])
                h_wall();

        //top
        translate([0,0,wall - th])
            rotate([0,0,180])
                h_wall();

        //bottom
        translate([0,0,th / 2])
            cube([wall,wall,th],center=true);
    }
    
    //front diff
        translate([0,wall_half - 18.5 + 3*epsilon + 28.7, wall / 2]){
            rotate([-15,0,0])
                cube([wall+epsilon,50,wall+8*th],center=true);
        }
}


//translate([0,0,wall-th/2])

module s_wall(isLeft=false){
    q = wall/2 - 2*th  ;
    b_r=5.05;
    bi_r=2.95;
    gap = 0.5;
    
    color([0.9,0.4,0.4])
    difference(){
        cube([th,wall,wall],center=true);
        translate([-th/2-epsilon,-q,q])
            rotate([0,90,0]){
                cylinder(r=b_r,h=3 * (th+epsilon) /2);
            }
    }
    
    //door
    translate([0,gap,-3*gap])
    if(isLeft){
        color([0.5,0.5,0.8])
            translate([q+3/2*th, -q,8 ])
                cube([2*q,th,2*q-16],center=true);
        //pivot rod
        color([0.5,0.8,0.5])
            translate([ -th/2 , -q, q ])
            rotate([0,90,0])
                cylinder(r=bi_r,h=wall +10);
    }
    
}

module h_wall(){
    difference(){
        union(){
            translate([0,0,th/2])
               color([0.9,0.2,0.5])
                    cube([wall,wall,th],center=true);
            translate([0,th,-th])
            cylinder(r=r4+th,h=th*2);
        }
        translate([0,th,- th  -epsilon])
        cylinder(r=r4,h=th*2 + 2*epsilon);
    }
}


module f_wall(){
    color([1,0,0])
    difference(){
        union(){
            cube([wall,th,wall],center=true);
            translate([dfan_h,-th,dfan_h])
                cube([th,th,th],center=true);
            translate([dfan_h,-th,-dfan_h])
                cube([th,th,th],center=true);
            translate([-dfan_h,-th,dfan_h])
                cube([th,th,th],center=true);
            translate([-dfan_h,-th,-dfan_h])
                cube([th,th,th],center=true);
            
            
        }
        translate([0,th,0])
        rotate([90,0,0]){
            cylinder(r=rfan, h=2*th + epsilon);
            translate([dfan_h,dfan_h,0])
                cylinder(r=1.5, h=3*th + epsilon);
            translate([dfan_h,-dfan_h,0])
                cylinder(r=1.5, h=3*th + epsilon);
            translate([-dfan_h,dfan_h,0])
                cylinder(r=1.5, h=3*th + epsilon);
            translate([-dfan_h,-dfan_h,0])
                cylinder(r=1.5, h=3*th + epsilon);
            
        }
    }
}

/* 

This is an alternate to the https://www.thingiverse.com/thing:2482038 anet heat bed strain relief

USE IF YOU REMOVED THE PLUG AND SOLDERED DIRECTLY TO THE PINS

I had to do this because my plug was damaged and I couldn't source a replacement.

NOTE: Soldering is not usually advised in use where the joint will be flexed repeatedly as it causes a stress raiser at the wire-solder interface. I am not a (hardware) engineer, and I am *not* recommending this specific approach. It is working for me at this point, and I'll update here if any problems develop.

I secured the halves with a #8 x 1/2 inch wood screw.

Printed in PLA at 210 with .2mm layer height 4mm nozzle.
I plan to reprint in PETG for higher temps

TODO: 
 * make a "ramp" to reduce the chances of snagging the Y motor pulley.
 * improve the way the top interfaces with the bottom half.


*/


p_x=24;
p_y=16;
p_yy=10;
p_z=8;
b_z=3;
b_yy=3;
wall=2;
wire_r=4;
wire_y=5;
epsilon=0.1;
hr1=2.1;
hr2=1.35;

module plug(){
    difference(){
        union(){
            translate([0, - epsilon, p_z/2 + wall]){
            cube([p_x, p_y + epsilon, p_z],center=true);
                translate([0, -p_y/2 -b_yy/2,(p_z -b_z)/2]){
                    cube([p_x + 2*wall+epsilon, b_yy, b_z],center=true);
                    translate([0, 0,-4])
                        cube([p_x +epsilon, b_yy, 5.1],center=true);
                }
            }

            translate([0,0,wall])
            linear_extrude(height=p_z)
                polygon([[p_x / 2,p_y/2-epsilon],[-p_x/2,p_y/2-epsilon],[0,p_yy+p_y/2]]);


            translate([0,p_yy + p_y / 2 - wall - 0.5,wall + p_z /2])
            rotate([-90,0,0]){
            cylinder(h=wire_y,r=wire_r);
                translate([0,-2,0])
                cube([2*wire_r,3/2*wire_r,30],center=true);
            }
        }
        
        translate([0,p_y/2 -1, -3])
        difference(){
            cylinder(r=hr1, h=24, $fn=20);
            cylinder(r=hr2, h=24, $fn=20);
        }
    }
}

module bottom(){
    difference(){
        linear_extrude(height=p_z + wall - epsilon)
        polygon([[ -p_x/2 - wall,-p_y/2 - b_yy ],[ p_x/2 + wall,-p_y/2 - b_yy  ],
                    [p_x/2 + wall, p_y/2 + wall ],
                    [wire_r + wall,p_yy + p_y / 2 + wire_y /2 - epsilon],[-wire_r - wall,p_yy + p_y / 2 + wire_y /2- epsilon],
                    [-p_x/2 - wall, p_y/2 + wall ]
        ]);

        color([1,0,0])
        plug();
    }
}

module top(){
    difference(){
        union(){
            linear_extrude(height= wall - epsilon)
                polygon([[ -p_x/2 - wall,-p_y/2 - b_yy ],[ p_x/2 + wall,-p_y/2 - b_yy  ],
                    [p_x/2 + wall, p_y/2 + wall ],
                    [wire_r + wall,p_yy + p_y / 2 + wire_y /2 - epsilon],[-wire_r - wall,p_yy + p_y / 2 + wire_y /2- epsilon],
                    [-p_x/2 - wall, p_y/2 + wall ]
        ]);
            
            color([1,0,0])
               plug();
        }

        translate([0,10,3*wall / 2 + 5.5])
            cube([40,50,10],center=true);

        translate([0,p_y/2 -1, 1])
            cylinder(r=hr1+ 0.25, h=24, $fn=20);
        translate([0,p_y/2 -1, -1])
            cylinder(r=hr1- 0.55, h=24, $fn=20);

        translate([0, -p_y/2 -b_yy/2 + 3.35 ,3*wall/2 -2 *epsilon])
                        cube([p_x + 2*wall+epsilon, 10, wall],center=true);

        translate([0, p_yy + p_y/2 + wall ,3*wall/2 -2 *epsilon])
                        cube([p_x + 2*wall+epsilon, 10, wall],center=true);

    }
}
top();
translate([0,40,0])
bottom();
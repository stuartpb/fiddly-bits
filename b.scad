arm_end_diameter = 3;
lid_end_diameter = 7;
ends_distance = 24;
body_width = 5.5;

lid_axle_length = 3.5;
lid_axle_diameter = 3.66; // between this (Y axis) and 3.75 (Z axis); I'm picking the narrower measurement
lid_cap_diameter = 4.5;
lid_cap_length = 1.66;
lid_cap_bevel_depth = 0.75;
lid_cap_bevel_radius = 0.75;

arm_axle_length = 6.5;
arm_cap_length = 1.65;
arm_cap_diameter = 5;

eps = 1/128;
$fn = 90;

union () {
  
  // body
  hull() {
    translate ([-body_width/2,ends_distance/2,arm_end_diameter/2])
      rotate([0,90,0]) cylinder(d=arm_end_diameter,h=body_width);
    translate ([-body_width/2,-ends_distance/2,lid_end_diameter/2])
      rotate([0,90,0]) cylinder(d=lid_end_diameter,h=body_width);
  }
  
  // arm axle
  translate([body_width/2,ends_distance/2,arm_end_diameter/2])
    rotate([0,90,0]) cylinder(d=arm_end_diameter,h=arm_axle_length);
  // arm axle cap
  translate([body_width/2+arm_axle_length,ends_distance/2,arm_end_diameter/2])
    rotate([0,-90,0]) difference() {
      cylinder(d=arm_cap_diameter,h=arm_cap_length);
      translate([-arm_cap_diameter/2,arm_end_diameter/2,-eps])
        cube([arm_cap_diameter,arm_cap_diameter-arm_end_diameter,arm_cap_length+eps*2]);
      translate([-arm_cap_diameter/2,-arm_cap_diameter/2,-eps])
        cube([arm_cap_diameter*2/5,arm_cap_diameter,arm_cap_length+eps*2]);
  }
  
  // lid axle
  translate([-body_width/2,-ends_distance/2,lid_end_diameter/2])
    rotate([0,-90,0]) cylinder(d=lid_axle_diameter,h=lid_axle_length-lid_cap_length);
  // lid axle cap
  translate([-body_width/2-lid_axle_length,-ends_distance/2,lid_end_diameter/2])
    rotate([0,90,0]) difference() {
      cylinder(d=lid_cap_diameter,h=lid_cap_length);
      rotate_extrude() polygon(
        [[lid_cap_diameter/2-lid_cap_bevel_radius,0],
        [lid_cap_diameter/2,lid_cap_bevel_depth],
        [lid_cap_diameter/2+eps,-eps]]);
    }
}


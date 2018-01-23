//!OpenSCAD
// title      : "B" piece for Cuisinart DCC-450
// author     : Stuart P. Bentley (@stuartpb)
// version    : 1.0.0
// file       : b.scad

/* [Measurements] */

arm_end_diameter = 3;
lid_end_diameter = 7;
ends_distance = 24;
body_width = 5.5;

lid_axle_length = 3.5;
lid_axle_diameter = 3.66;
lid_cap_diameter = 4.5;
lid_cap_length = 1.66;
lid_cap_bevel_depth = 0.75;
lid_cap_bevel_radius = 0.75;

arm_axle_length = 6.5;
arm_cap_length = 1.65;
arm_cap_diameter = 5;

/* [Tweaks] */

eps = 1/128;
$fn = 90;

/* [Hidden] */

rot_l = [0, -90, 0];
rot_r = [0, 90, 0];
body_left = -body_width/2;
body_right = body_width/2;
arm_end = ends_distance/2;
lid_end = -ends_distance/2;
arm_end_radius = arm_end_diameter/2;
lid_end_radius = lid_end_diameter/2;
arm_cap_radius = arm_cap_diameter/2;
lid_cap_radius = lid_cap_diameter/2;

union () {
  
  // body
  hull() {
    translate ([body_left, arm_end, arm_end_radius])
      rotate(rot_r) cylinder(d = arm_end_diameter, h = body_width);
    translate ([body_left, lid_end, lid_end_radius])
      rotate(rot_r) cylinder(d = lid_end_diameter, h = body_width);
  }
  
  // arm axle
  translate([body_right, arm_end, arm_end_radius])
    rotate(rot_r) cylinder(d = arm_end_diameter, h = arm_axle_length);
  // arm axle cap
  translate([body_right + arm_axle_length, arm_end, arm_end_radius])
    rotate(rot_l) difference() {
      cylinder(d = arm_cap_diameter, h = arm_cap_length);
      translate([-arm_cap_radius, arm_end_radius, -eps])
        cube([arm_cap_diameter,
          arm_cap_diameter - arm_end_diameter,
          arm_cap_length+eps*2]);
      translate([-arm_cap_radius, -arm_cap_radius, -eps])
        cube([arm_cap_diameter*2/5,
          arm_cap_diameter,
          arm_cap_length+eps*2]);
  }
  
  // lid axle
  translate([body_left, lid_end, lid_end_radius])
    rotate(rot_l) cylinder(d = lid_axle_diameter,
      h = lid_axle_length - lid_cap_length);
  // lid axle cap
  translate([body_left - lid_axle_length, lid_end, lid_end_radius])
    rotate(rot_r) difference() {
      cylinder(d = lid_cap_diameter, h = lid_cap_length);
      rotate_extrude() polygon([
        [lid_cap_radius - lid_cap_bevel_radius, 0],
        [lid_cap_radius, lid_cap_bevel_depth],
        [lid_cap_radius+eps, -eps]]);
    }
}


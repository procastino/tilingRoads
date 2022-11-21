//side of the base
side = 70;
//width of the track
trackWidth = 22;
//Height of the pieces
height = 5;
//dimensions of the indents that fix the tiles
indentLength = 8;
indentWidth = 5;
indentSlope = 1; //difference between long and short sides of the indent
indentClearance = 0.2; //it applies to the out indents, reducing their length, higher values mean looser connections
//This is equal to the thickness of the tile under the track
trackOffset = 3;
//holes
holeRadius = 3;
holePosX = 12;
holePosY = holePosX;
//base();
//straight();
//curve();
//deadEnd();
crossIntersection();
//tIntersection();


module base(){
  
//indents out
translate([side-indentLength-indentClearance/2,-indentWidth,0])rotate([0,0,90]) indentOut();
translate([indentLength+indentClearance/2,side+indentWidth,0]) rotate([0,0,-90]) indentOut();
translate([side+indentWidth,side - indentLength-indentClearance/2,0]) rotate([0,0,180]) indentOut();
translate([-indentWidth,indentLength+indentClearance/2,0]) indentOut();

//indents in and base cube
difference(){
cube([side, side, height]);
translate([indentLength,indentWidth,0]) rotate([0,0,-90]) indentIn();
translate([side-indentLength,side-indentWidth,0]) rotate([0,0,90]) indentIn();
translate([side-indentWidth,indentLength,0]) indentIn();
translate([indentWidth,side -indentLength,0]) rotate([0,0,180]) indentIn();
}
}
//indent out Shape. smaller than indent in, according to clearance
module indentOut(){
    linear_extrude(height) {polygon(points = [[0,0],[indentWidth,indentSlope,],[indentWidth,indentLength-indentSlope-indentClearance],[0,indentLength-indentClearance]]);
    }
}
//indent in Shape
module indentIn(){
    linear_extrude(height) {polygon(points = [[0,0],[indentWidth,indentSlope,],[indentWidth,indentLength-indentSlope],[0,indentLength]]);
    }
}
//holes module
module holes(){
    translate([holePosX,holePosY,-1])
    cylinder(r=holeRadius,h= 2*height,$fn=6);
    translate([side-holePosX,holePosY,-1])
    cylinder(r=holeRadius,h= 2*height,$fn=6);
    translate([side-holePosX,side - holePosY,-1])
    cylinder(r=holeRadius,h= 2*height,$fn=6);
    translate([holePosX,side-holePosY,-1])
    cylinder(r=holeRadius,h= 2*height,$fn=6);
}
//straight
module straight(){
    difference(){
        base();
translate ([0,side/2-trackWidth/2,trackOffset]) cube ([side, trackWidth,height]);
        holes();
    }
}
//curve
module curve(){
    difference(){
        base();
translate([0,0,trackOffset])difference(){
    cylinder(r=side/2+trackWidth/2,h=height,$fn=40);
    cylinder(r=side/2-trackWidth/2,h=height,$fn=40);
}
 holes();
}
}
//deadEnd
module deadEnd(){
    difference(){
        base();
translate([side/2,side/2,trackOffset]) cylinder(r=trackWidth,h=height,$fn=40);
translate ([0,side/2-trackWidth/2,trackOffset]) cube ([side/2, trackWidth,height]);
        holes();
    }
}
//cross intersection
module crossIntersection(){
    difference(){
        base();
translate([0,0,trackOffset])difference(){
    cylinder(r=side/2+trackWidth/2,h=height,$fn=40);
    cylinder(r=side/2-trackWidth/2,h=height,$fn=40);
}
translate([side,side,trackOffset])difference(){
    cylinder(r=side/2+trackWidth/2,h=height,$fn=40);
    cylinder(r=side/2-trackWidth/2,h=height,$fn=40);
}
translate([0,side,trackOffset])difference(){
    cylinder(r=side/2+trackWidth/2,h=height,$fn=40);
    cylinder(r=side/2-trackWidth/2,h=height,$fn=40);
}
translate([side,0,trackOffset])difference(){
    cylinder(r=side/2+trackWidth/2,h=height,$fn=40);
    cylinder(r=side/2-trackWidth/2,h=height,$fn=40);
}
translate ([0,side/2-trackWidth/2,trackOffset]) cube ([side, trackWidth,height]);
 holes();
    }
}
//T intersection
module tIntersection(){
    difference(){
        base();
translate([0,0,trackOffset])difference(){
    cylinder(r=side/2+trackWidth/2,h=height,$fn=40);
    cylinder(r=side/2-trackWidth/2,h=height,$fn=40);
}
translate([side,0,trackOffset])difference(){
    cylinder(r=side/2+trackWidth/2,h=height,$fn=40);
    cylinder(r=side/2-trackWidth/2,h=height,$fn=40);
}
translate ([0,side/2-trackWidth/2,trackOffset]) cube ([side, trackWidth,height]);
 holes();


    }
}

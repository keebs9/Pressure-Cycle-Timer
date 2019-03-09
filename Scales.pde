float trueLo = -70; // defines the lowest pressure recorded during calibration
float trueHi = 70; // defines the highest pressure recorded during calibration
float lScale = -70; // defines the bottom of the vertical axis scale
float uScale = 70; // defines the top of the vertical axis scale
byte nDivisions = 8; // creates a variable for the number of on-screen divisions
float gapNum; // creates a variable to hold the gap/spacing in the numerical value of the scale divisions
String units = "cmH2O"; // sets the default pressure units
String nVal; // holds the value of the current scale division (tidies up the code)
float yScale; // this holds the current Y value for drawing the scale (tidies up the code)

void drawScales() {
  strokeCap(SQUARE);
  fill(bgFill); // set the fill colour to that of the background
  stroke(bgFill); // set the line colour the same as this is used for the ouside of the rectangle
  rect(rMargin,tMargin-10,rMargin+196,bMargin+10); // blanks the area of the scale and units
  
  if (lScale <0 && uScale >=0) { // if the lower scale is negative & the top scsale positive...
    // the numerical gap between divisions equals the sum of the absolute scale limits e.g., -20 to 40 = 60
    gapNum = (abs(lScale) + abs(uScale)) / nDivisions;
  } else
  {
    // the numerical gap between divisions equals the difference between the scale limits e.g., 20 to 40 = 20
    gapNum = (uScale-lScale) / nDivisions; // calculates the size of the numerical gap between divisions
  }

  stroke(10); // sets the colour of the centre line and scales
  line(lMargin-1, centre+tMargin, rMargin, centre+tMargin); // horizontal line half way up
  line(lMargin-2, tMargin-1, lMargin-2, bMargin+1); // draws left hand scale
  line(rMargin, tMargin-1, rMargin, bMargin+1); // draws right hand scale

  stroke(0, 0, 230); // sets the colour of the graticules
  fill(30, 30, 230); // sets the colour of the text for the pressure values on the vertical scale
  textSize(14); // define text size
  for (byte i =0; i <= nDivisions; i++) { // repeat for number of scale points
    yScale = tMargin + (plotHeight * (i * 0.125)); // calculates the vertical position of the current scale 
    nVal = nfp(uScale - (i * gapNum), 0, 2); // calculates the current scale value, nfp is used to add polarity sign and set decimal points

    line(lMargin-7, yScale, lMargin-2, yScale); // draws left hand scale
    line(rMargin, yScale, rMargin+5, yScale); // draws right hand scale
    text(nVal + " " + units, rMargin + 6, yScale+4); // prints the scale numerical value (from the top down)
  }
}

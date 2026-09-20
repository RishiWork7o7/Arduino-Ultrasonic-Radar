import processing.serial.*;

Serial myPort;

// -----------------------------
// RADAR DATA
// -----------------------------

float angle = 90;
float distance = 0;

float maxDistance = 100;

// Change this to your Arduino port!
String portName = "COM9";


// -----------------------------
// SETUP
// -----------------------------

void setup() {

  size(1200, 700);

  smooth();

  println("Available Serial Ports:");
  printArray(Serial.list());

  myPort = new Serial(this, portName, 9600);

  myPort.clear();

  myPort.bufferUntil('\n');
}


// -----------------------------
// MAIN DRAW LOOP
// -----------------------------

void draw() {

  // Slight transparency creates radar trail
  noStroke();

  fill(0, 25);

  rect(0, 0, width, height);


  // Move origin to bottom center
  pushMatrix();

  translate(width / 2, height - 70);

  drawRadar();

  drawSweep();

  drawObject();

  popMatrix();


  drawInformation();
}


// -----------------------------
// DRAW RADAR GRID
// -----------------------------

void drawRadar() {

  stroke(0, 255, 0);

  strokeWeight(2);

  noFill();


  // Maximum radar radius
  float r = 500;


  // Distance rings

  arc(
    0,
    0,
    r * 2,
    r * 2,
    PI,
    TWO_PI
  );

  arc(
    0,
    0,
    r * 1.5,
    r * 1.5,
    PI,
    TWO_PI
  );

  arc(
    0,
    0,
    r,
    r,
    PI,
    TWO_PI
  );

  arc(
    0,
    0,
    r * 0.5,
    r * 0.5,
    PI,
    TWO_PI
  );


  // Horizontal base line

  line(
    -500,
    0,
    500,
    0
  );


  // Angle guide lines

  for (int a = 30; a <= 150; a += 30) {

    float rad = radians(180 - a);

    float x = 500 * cos(rad);

    float y = -500 * sin(rad);

    line(
      0,
      0,
      x,
      y
    );
  }


  // Distance labels

  fill(0, 255, 0);

  textSize(16);

  text("25 cm", 120, -10);

  text("50 cm", 245, -10);

  text("75 cm", 370, -10);

  text("100 cm", 480, -10);
}


// -----------------------------
// DRAW MOVING RADAR BEAM
// -----------------------------

void drawSweep() {

  float radarAngle = radians(180 - angle);

  float beamLength = 500;


  float beamX =
    beamLength * cos(radarAngle);

  float beamY =
    -beamLength * sin(radarAngle);


  // Main sweep beam

  stroke(
    0,
    255,
    0
  );

  strokeWeight(4);

  line(
    0,
    0,
    beamX,
    beamY
  );


  // Glow around beam

  stroke(
    0,
    255,
    0,
    80
  );

  strokeWeight(12);

  line(
    0,
    0,
    beamX,
    beamY
  );
}


// -----------------------------
// DRAW DETECTED OBJECT
// -----------------------------

void drawObject() {

  if (
    distance > 2 &&
    distance <= maxDistance
  ) {

    float radarAngle =
      radians(180 - angle);


    float objectRadius =
      map(
        distance,
        0,
        maxDistance,
        0,
        500
      );


    float objectX =
      objectRadius *
      cos(radarAngle);


    float objectY =
      -objectRadius *
      sin(radarAngle);


    // Red detected object

    stroke(
      255,
      0,
      0
    );

    strokeWeight(18);

    point(
      objectX,
      objectY
    );


    // Glow

    stroke(
      255,
      0,
      0,
      80
    );

    strokeWeight(35);

    point(
      objectX,
      objectY
    );
  }
}


// -----------------------------
// INFORMATION PANEL
// -----------------------------

void drawInformation() {

  noStroke();

  fill(
    0,
    255,
    0
  );


  textSize(26);

  text(
    "ARDUINO ULTRASONIC RADAR",
    30,
    40
  );


  textSize(20);


  text(
    "ANGLE: " +
    nf(angle, 0, 0) +
    "°",
    30,
    80
  );


  if (distance <= maxDistance) {

    text(
      "DISTANCE: " +
      nf(distance, 0, 1) +
      " cm",
      30,
      110
    );

  } else {

    text(
      "DISTANCE: OUT OF RANGE",
      30,
      110
    );
  }


  text(
    "MAX RANGE: " +
    nf(maxDistance, 0, 0) +
    " cm",
    30,
    140
  );


  // Detection indicator

  if (
    distance > 2 &&
    distance <= maxDistance
  ) {

    fill(
      255,
      0,
      0
    );

    text(
      "OBJECT DETECTED",
      30,
      180
    );

  } else {

    fill(
      0,
      255,
      0
    );

    text(
      "SCANNING...",
      30,
      180
    );
  }
}


// -----------------------------
// RECEIVE ARDUINO DATA
// -----------------------------

void serialEvent(Serial myPort) {

  String data =
    myPort.readStringUntil('\n');


  if (data != null) {

    data = trim(data);


    String[] values =
      split(data, ',');


    if (values.length == 2) {

      try {

        float newAngle =
          float(values[0]);

        float newDistance =
          float(values[1]);


        // Check received data
        // before accepting it

        if (
          newAngle >= 0 &&
          newAngle <= 180
        ) {

          angle = newAngle;
        }


        if (newDistance >= 0) {

          distance = newDistance;
        }

      }

      catch(Exception e) {

        println(
          "Bad serial data: " +
          data
        );
      }
    }
  }
}

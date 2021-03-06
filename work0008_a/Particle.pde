class Particle {
  float x, y, z;
  float radius;
  float theta, phi;
  float velocityMag = 0.01;
  float noiseScale = 0.15;
  float sNoisePosX, sNoisePosY;
  color strokeColor;

  Particle() {
    initAngle();
    int r = (int)random(4);
    switch (r) {
      case 0: sNoisePosX =  100; sNoisePosY =  100; break;
      case 1: sNoisePosX =  100; sNoisePosY = -100; break;
      case 2: sNoisePosX = -100; sNoisePosY =  100; break;
      case 3: sNoisePosX = -100; sNoisePosY = -100; break;
    }
    r = (int)random(100);
    if (r < 70) {
      strokeColor = color(0, 0, 100, 1);
    } else if (r < 90) {
      strokeColor = color(215, 80, 80, 1);
    } else {
      strokeColor = color(335, 80, 80, 1);
    }
  }

  void initAngle() {
    float unitZ = random(-1, 1);
    theta = acos(unitZ);
    phi = random(TWO_PI);
  }

  void update() {
    float noisePosX = sNoisePosX + theta * noiseScale;
    float noisePosY = sNoisePosY + phi * noiseScale;
    float angle = noise(noisePosX, noisePosY) * (4 * TWO_PI) - (2 * TWO_PI);
    radius = map(angle, - 2 * TWO_PI, 2 * TWO_PI, height * 0.2, height * 0.6);

    theta += velocityMag * cos(angle);
    phi   += 2 * velocityMag * sin(angle);

    x = radius * sin(theta) * cos(phi);
    y = radius * cos(theta);
    z = radius * sin(theta) * sin(phi);
  }

  void display() {
    stroke(strokeColor);
    point(x, y, z);
  }
}

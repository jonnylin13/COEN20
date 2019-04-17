void TwosComplement(const int input[8], int output[8]) {

  
  int overflow = 1;
  for (int i = 0; i < 8; i++) {
    // Handle each bit going right to left (MSB on left)
    int cursor = input[i] == 0 ? 1 : 0;
    
    if (overflow > 0) {
      if (cursor == 1) {
        cursor = 0;
      } else {
        cursor = 1;
        overflow--;
      }
    }
    output[i] = cursor;
    
  }

}

float	Bin2Dec(const int bin[8]) {

  int polynomial = -bin[7];
  for (int i = 6; i >= 0; i--) {
    polynomial = 2 * polynomial + bin[i];
  }
  return polynomial / 128.0;


}
void Dec2Bin(const float x, int bin[8]) {
  // Would not display anything
  float _x = x * 128.0;
  int whole = (int) _x; // Always truncates
  float fraction = _x - whole;

  if (fraction < 0) {
    // Negative fraction
    if (fraction <= -0.5) {
      whole--;
    }
  } else {
    // Positive fraction
    if (fraction >= 0.5) {
      whole++;
    }
  }

  for (int i = 0; i < 8; i++) {
    bin[i] = whole % 2;
    whole /= 2;
  }

}
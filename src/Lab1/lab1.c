void TwosComplement(const int input[8], int output[8]) {

  for (int i = 0; i < 8; i++) {
    output[i] = input[i] == 0 ? 1 : 0;
  }
  int overflow = 0;
  for (int i = 7; i >= 0; i--) {
    // Handle each bit going right to left
    if (overflow > 0) {
      if (output[i] == 1) {
          overflow++;
          output[i] = 0;
        } else {
          overflow--;
          output[i] = 1;
        }
    } else {
      if (i == 7 && output[i] == 1) {
        output[i] = 0;
        overflow = 1;
      } else {
        output[i] = 1;
        overflow = 0;
      }
    }
    
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

  float xCopy = x * 128.0;
  int whole = (int) xCopy; // Always truncates
  float fraction = whole - xCopy; // Must be positive

  if (fraction >= 0.5) {
    if (x < 0) {
      whole -= 1;
    } else {
      whole += 1;
    }
  }

  int i = 0;
  while (whole >= 0.0) {
    bin[i] = whole % 2;
    whole /= 2;
    i++;
  }

}
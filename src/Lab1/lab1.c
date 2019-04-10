void TwosComplement(const int input[8], int output[8]) {

  
  int overflow = 1;
  for (int i = 0; i < 8; i++) {
    // Handle each bit going right to left
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
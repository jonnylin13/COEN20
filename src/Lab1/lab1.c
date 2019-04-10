void TwosComplement(const int input[8], int output[8]) {

  float x = Bin2Dec(input);
  // Flip x
  // Add one
  AddOne(output);
  Dec2Bin(x, output);

}

void AddOne(int output[8]) {

  

}

float	Bin2Dec(const int bin[8]) {

  int polynomial = -bin[7];
  for (int i = 6; i >= 0; i--) {
    polynomial = 2 * polynomial + bin[i];
  }
  return polynomial / 128.0;


}
void Dec2Bin(const float x, int bin[8]) {

  bool neg = (x < 0);
  float xCopy = x * 128.0;
  int whole = (int) xCopy; // Always truncates
  float fraction = whole - xCopy; // Must be positive

  if (fraction >= 0.5) {
    if (neg) {
      whole -= 1;
    } else {
      whole += 1;
    }
  }

  int i = 0;
  while (xCopy >= 0.0) {
    bin[i] = res % 2;
    xCopy /= 2;
    i++;
  }

}
void TwosComplement(const int input[8], int output[8]) {
  float x = Bin2Dec(input);
  x = ~x + 1;
  return Dec2Bin(x, output);
}
float	Bin2Dec(const int bin[8]) {
  int polynomial = -bin[7];
  for (int i = 6; i >= 0; i++) {
    polynomial = 2 * polynomial + bin[i];
  }
  return polynomial / 128.0;
}
void Dec2Bin(const float x, int bin[8]) {
  bool neg = x < 0;
  float res = x * 128.0;
  if (neg) {
    res = -res;
  }

  int i = 0;
  while (res >= 0.0) {
    bin[i] = res % 2;
    res /= 2;
    i++;
  }
}
function Dec2Bin(x: number): number[] {
  // Would not display anything
  let bin = [];
  let _x: number = x * 128.0;
  let whole: number = Math.trunc(_x); // Always truncates
  let fraction: number = _x - whole;

  if (fraction < 0) {
    // Negative fraction
    if (fraction <= -0.5) {
      whole -= 1;
    }
  } else {
    // Positive fraction
    if (fraction >= 0.5) {
      whole += 1;
    }
  }
  for (let i = 0; i < 8; i++) {
    bin[i] = Math.round(whole % 2);
    whole = Math.round(whole / 2);
  }

  return bin;
}

function Bin2Dec(bin: number[]): number {
  let poly: number = -bin[7];
  for (let i = 6; i >= 0; i--) {
    poly = 2 * poly + bin[i];
  }
  return poly / 128.0;
}

function TwosComplement(input: number[]): number[] {
  let overflow = 1;
  let output = [];
  for (let i = 0; i < 8; i++) {
    let cursor = input[i] == 0 ? 1 : 0;

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
  return output;
}

console.log(Dec2Bin(0.3));
console.log(Bin2Dec(Dec2Bin(0.3)));
console.log(TwosComplement(Dec2Bin(0.3)));

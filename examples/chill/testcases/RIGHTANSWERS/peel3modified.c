// this source is derived from CHILL AST originally from file 'peel1234.c' as parsed by frontend compiler rose

// example from the CHiLL manual page 13

void mm(float **A, float **B, float **C, int ambn, int an, int bm) {
  int t4;
  int t6;
  int t2;
  for (t2 = 0; t2 <= an - 1; t2 += 1) {
    C[t2][0] = 0.0f;
    for (t6 = 0; t6 <= ambn - 1; t6 += 1) 
      C[t2][0] += A[t2][t6] * B[t6][0];
    C[t2][1] = 0.0f;
    for (t6 = 0; t6 <= ambn - 1; t6 += 1) 
      C[t2][1] += A[t2][t6] * B[t6][1];
    C[t2][2] = 0.0f;
    for (t6 = 0; t6 <= ambn - 1; t6 += 1) 
      C[t2][2] += A[t2][t6] * B[t6][2];
    C[t2][3] = 0.0f;
    for (t6 = 0; t6 <= ambn - 1; t6 += 1) 
      C[t2][3] += A[t2][t6] * B[t6][3];
    for (t4 = 4; t4 <= bm - 1; t4 += 1) {
      C[t2][t4] = 0.0f;
      for (t6 = 0; t6 <= ambn - 1; t6 += 1) 
        C[t2][t4] += A[t2][t6] * B[t6][t4];
    }
  }
}

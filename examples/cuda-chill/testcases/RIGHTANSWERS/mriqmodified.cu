// this source is derived from CHILL AST originally from file 'mriq.c' as parsed by frontend compiler rose

float sinf(float );
float cosf(float );
__global__ void Kernel_GPU(float *x, float *y, float *z, float *Qi, float *Qr, struct kValues *kVals) {
  int by = blockIdx.y;
  int i;
  int ii;
  int tx = threadIdx.x;
  int bx = blockIdx.x;
  {
    {
      newVariable0 = x[tx + 128 * bx];
    }
    {
      newVariable1 = y[128 * bx + tx];
    }
    {
      newVariable2 = z[tx + 128 * bx];
    }
    {
      newVariable3 = Qi[128 * bx + tx];
    }
    {
      newVariable4 = Qr[tx + 128 * bx];
    }
    for (ii = 0; ii <= 23; ii += 1) 
      {
        for (i = 0; i <= 127; i += 1) {
          expArg = 6.28318548f * (kVals[128 * ii + i].Kx * newVariable0 + kVals[128 * ii + i].Ky * newVariable1 + kVals[128 * ii + i].Kz * newVariable2);
          cosArg = cosf(expArg);
          sinArg = sinf(expArg);
          phi = kVals[128 * ii + i].PhiMag;
          newVariable4 += phi * cosArg;
          newVariable3 += phi * sinArg;
        }
      }
    {
      Qr[tx + 128 * bx] = newVariable4;
    }
    {
      Qi[128 * bx + tx] = newVariable3;
    }
  }
}
void ComputeQCPU(int numK, int numX, struct kValues kVals[3072], float x[32768], float y[32768], float z[32768], float Qr[32768], float Qi[32768]) {
  struct kValues * devI6Ptr;
  float * devI5Ptr;
  float * devI4Ptr;
  float * devI3Ptr;
  float * devI2Ptr;
  float * devI1Ptr;
  cudaMalloc((void **)devI1Ptr, 32768 * sizeof(float));
  cudaMemcpy(devI1Ptr, x, 32768 * sizeof(float), cudaMemcpyHostToDevice);
  cudaMalloc((void **)devI2Ptr, 32768 * sizeof(float));
  cudaMemcpy(devI2Ptr, y, 32768 * sizeof(float), cudaMemcpyHostToDevice);
  cudaMalloc((void **)devI3Ptr, 32768 * sizeof(float));
  cudaMemcpy(devI3Ptr, z, 32768 * sizeof(float), cudaMemcpyHostToDevice);
  cudaMalloc((void **)devI4Ptr, 32768 * sizeof(float));
  cudaMemcpy(devI4Ptr, Qi, 32768 * sizeof(float), cudaMemcpyHostToDevice);
  cudaMalloc((void **)devI5Ptr, 32768 * sizeof(float));
  cudaMemcpy(devI5Ptr, Qr, 32768 * sizeof(float), cudaMemcpyHostToDevice);
  cudaMalloc((void **)devI6Ptr, 3072 * sizeof(struct kValues));
  cudaMemcpy(devI6Ptr, kVals, 3072 * sizeof(struct kValues), cudaMemcpyHostToDevice);
  dim3 dimGrid0 = dim3(256, 1);
  dim3 dimBlock0 = dim3(128);
  Kernel_GPU<<<dimGrid0,dimBlock0>>>(devI1Ptr, devI2Ptr, devI3Ptr, devI4Ptr, devI5Ptr, devI6Ptr);
  cudaFree(devI1Ptr);
  cudaFree(devI2Ptr);
  cudaFree(devI3Ptr);
  cudaFree(devI4Ptr);
  cudaFree(devI5Ptr);
  cudaFree(devI6Ptr);
}

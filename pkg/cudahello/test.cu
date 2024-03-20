// #include <stdio.h>

__global__ void sumReduction(int *input, int *output, int n) {
    int tid = threadIdx.x;
    extern __shared__ int sdata[];

    // Load shared mem from global mem
    unsigned int i = blockIdx.x * blockDim.x + threadIdx.x;
    sdata[tid] = (i < n) ? input[i] : 0;
    __syncthreads();

    // Do reduction in shared mem
    for (unsigned int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) {
            sdata[tid] += sdata[tid + s];
        }
        __syncthreads();
    }

    // Write result for this block to global mem
    if (tid == 0) output[blockIdx.x] = sdata[0];
}

extern "C" {
    int test_redux(int size, int blockSize) {
        int *input, *d_input, *d_partial_sums, *partial_sums;
        int numBlocks = (size + blockSize - 1) / blockSize;
        int smemSize = blockSize * sizeof(int); // Size of shared memory per block

        // Allocate host memory
        input = (int*)malloc(size * sizeof(int));
        partial_sums = (int*)malloc(numBlocks * sizeof(int));

        // Initialize input data
        for (int i = 0; i < size; i++) {
            input[i] = 1; // Example data
        }

        // Allocate device memory
        cudaMalloc(&d_input, size * sizeof(int));
        cudaMalloc(&d_partial_sums, numBlocks * sizeof(int));

        // Copy data from host to device
        cudaMemcpy(d_input, input, size * sizeof(int), cudaMemcpyHostToDevice);

        // Launch kernel
        sumReduction<<<numBlocks, blockSize, smemSize>>>(d_input, d_partial_sums, size);

        // Copy partial sums from device to host
        cudaMemcpy(partial_sums, d_partial_sums, numBlocks * sizeof(int), cudaMemcpyDeviceToHost);

        // Finish reduction on the host
        int totalSum = 0;
        for (int i = 0; i < numBlocks; i++) {
            totalSum += partial_sums[i];
        }

        // printf("Total sum is %d\n", totalSum);

        // Cleanup
        cudaFree(d_input);
        cudaFree(d_partial_sums);
        free(input);
        free(partial_sums);

        return totalSum;
    }

}
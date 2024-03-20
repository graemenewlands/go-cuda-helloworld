# Makefile for compiling CUDA C++ code and then building a Go program

# CUDA paths
CUDA_PATH ?= /usr/local/cuda
CUDA_BIN_PATH ?= $(CUDA_PATH)/bin
CUDA_LIB_PATH ?= $(CUDA_PATH)/lib64

# Compiler settings
NVCC := $(CUDA_BIN_PATH)/nvcc
GO := go

# Compiler flags
NVCC_FLAGS := -o pkg/cudahello/libtest.so -lcudart -lcuda -shared -Xcompiler -fPIC
GO_BUILD_FLAGS := 

# Target for CUDA C++ compilation
cuda: pkg/cudahello/test.cu
	$(NVCC) $(NVCC_FLAGS) pkg/cudahello/test.cu

# Target for Go build
go: cuda main.go
	$(GO) build $(GO_BUILD_FLAGS) -o cudahello main.go 

# Default target
all: go

# Clean up
clean:
	rm -f libtest.so test

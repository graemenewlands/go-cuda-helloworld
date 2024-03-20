# Go CUDA Helloworld

## Sum Reduction

This is a variation on the "hello world" (`vecAddKernel`) example given in Chapter 2 of [Programming Massively Parallel Processors](https://www.amazon.com/Programming-Massively-Parallel-Processors-Hands-dp-0323912311/dp/0323912311/ref=dp_ob_image_bk). This example does a reduction over 1's populated in blocks up to a given size. The result can be trivially taken as the reduction is equal to the size.

This example has not been optimised as given.

## build

    make all

## test

    go test -v ./pkg/cudahello/

to run the benchmarks, type:

    go test -v ./pkg/cudahello/ -bench=.

## Sample Results

    === RUN   TestGPURedux
        asl_test.go:34: GPU Redux: 852400000
    --- PASS: TestGPURedux (8.33s)
    goos: linux
    goarch: arm64
    pkg: github.com/graemenewlands/go-cuda-helloworld/pkg/cudahello
    BenchmarkGPURedux_128
    BenchmarkGPURedux_128-6    	    2637	    498274 ns/op
    BenchmarkCPURedux_128
    BenchmarkCPURedux_128-6    	 1731096	       700.3 ns/op
    BenchmarkGPURedux_256
    BenchmarkGPURedux_256-6    	    1006	   1009067 ns/op
    BenchmarkCPURedux_256
    BenchmarkCPURedux_256-6    	 1645590	       698.0 ns/op
    BenchmarkGPURedux_512
    BenchmarkGPURedux_512-6    	    2733	    449635 ns/op
    BenchmarkCPURedux_512
    BenchmarkCPURedux_512-6    	 1728097	       701.3 ns/op
    BenchmarkGPURedux_1024
    BenchmarkGPURedux_1024-6   	    2494	    446629 ns/op
    BenchmarkCPURedux_1024
    BenchmarkCPURedux_1024-6   	 1724665	       701.0 ns/op
    PASS
    ok  	github.com/graemenewlands/go-cuda-helloworld/pkg/cudahello	22.583s

These results demonstrate that simple arithmatic can be performed competitively by the CPU!
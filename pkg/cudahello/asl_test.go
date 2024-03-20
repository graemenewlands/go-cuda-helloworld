package aslex

import (
    "testing"
    "strconv"
)

func benchmarkTestGPURedux(b *testing.B, size, n int) {
    for i:=0; i < b.N; i++ {
        FunctionToIterate(GPURedux, 1024, n)
    }
}

func benchmarkTestCPURedux(b *testing.B, size, n int) {
    for i:=0; i < b.N; i++ {
        FunctionToIterate(CPURedux, 1024, n)
    }
}

func BenchmarkGPURedux_128(b *testing.B) { benchmarkTestGPURedux(b, 128, 1) }
func BenchmarkCPURedux_128(b *testing.B) { benchmarkTestCPURedux(b, 128, 1) }

func BenchmarkGPURedux_256(b *testing.B) { benchmarkTestGPURedux(b, 256, 1) }
func BenchmarkCPURedux_256(b *testing.B) { benchmarkTestCPURedux(b, 256, 1) }

func BenchmarkGPURedux_512(b *testing.B) { benchmarkTestGPURedux(b, 512, 1) }
func BenchmarkCPURedux_512(b *testing.B) { benchmarkTestCPURedux(b, 512, 1) }

func BenchmarkGPURedux_1024(b *testing.B) { benchmarkTestGPURedux(b, 1024, 1) }
func BenchmarkCPURedux_1024(b *testing.B) { benchmarkTestCPURedux(b, 1024, 1) }


func TestGPURedux(t *testing.T) {
    t.Log("GPU Redux: " + strconv.Itoa(int(GPURedux(MAX_SUM_OVER_RANGE))))
}

package aslex

/*
#cgo CFLAGS: -I/home/graeme/git/aslex_redux/pkg/cudahello
#cgo LDFLAGS: -L/home/graeme/git/aslex_redux/pkg/cudahello -ltest
#include "test.h"
*/
import "C"

const MAX_SUM_OVER_RANGE int = 852400000

func FunctionToIterate(byref func(a int) C.int, sum_over, iterations int) {
    for i := 0; i < iterations; i++ {
        byref(sum_over)
    }
}

func GPURedux(sum_over int) C.int {
    v := C.test_redux(C.int(sum_over), 512)
	return v
}

func CPURedux(sum_over int) C.int {
    r := 0
    for i := 0; i < sum_over; i++ {
        r += i
    }
    return C.int(r)
}

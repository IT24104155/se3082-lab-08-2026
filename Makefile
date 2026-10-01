MPICXX ?= mpicxx
MPIRUN ?= mpirun
NP ?= 4
CXXFLAGS ?= -O2 -std=c++11 -Wall -Wextra
PROGRAMS = bin/hello_mpi bin/parallel_sum bin/estimate_pi

.PHONY: all run benchmark messaging clean
all: $(PROGRAMS)

bin:
	mkdir -p bin

bin/hello_mpi: Exercise01/hello_mpi.cpp | bin
	$(MPICXX) $(CXXFLAGS) $< -o $@
bin/parallel_sum: Exercise02/parallel_sum.cpp | bin
	$(MPICXX) $(CXXFLAGS) $< -o $@
bin/estimate_pi: Exercise03/estimate_pi.cpp | bin
	$(MPICXX) $(CXXFLAGS) $< -o $@
bin/send_integer: examples/messaging/send_integer.cpp | bin
	$(MPICXX) $(CXXFLAGS) $< -o $@
bin/send_array: examples/messaging/send_array.cpp | bin
	$(MPICXX) $(CXXFLAGS) $< -o $@

run: all
	$(MPIRUN) -np $(NP) ./bin/hello_mpi
	$(MPIRUN) -np $(NP) ./bin/parallel_sum
	$(MPIRUN) -np $(NP) ./bin/estimate_pi

benchmark: all
	mkdir -p results
	set -e; for p in 1 2 4 8; do for program in hello_mpi parallel_sum estimate_pi; do $(MPIRUN) -np $$p ./bin/$$program > results/$${program}_$${p}.txt; done; done

messaging: bin/send_integer bin/send_array
	$(MPIRUN) -np $(NP) ./bin/send_integer
	$(MPIRUN) -np $(NP) ./bin/send_array

clean:
	rm -rf bin

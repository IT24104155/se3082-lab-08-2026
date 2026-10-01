# SE3082 — Lab 08 (2026)

MPI programming and performance analysis.

| Folder | Activity |
| --- | --- |
| Exercise01 | Hello MPI: process ranks and processor names |
| Exercise02 | Parallel sum of integers 1 through 10,000,000 |
| Exercise03 | Monte Carlo estimation of pi with 10,000,000 points |
| Exercise04 | Reference timing results and performance graphs |
| examples/messaging | Synchronous integer and array messaging (at least 4 processes) |
| cluster | PBS and ARCHER2 examples from the source repository |
| docs | Original supplied instructions |

## Build and run

Requires an MPI C++ compiler, an MPI launcher, and GNU make.

```sh
make
make run NP=4
make benchmark
make messaging NP=4
make clean
```

`make benchmark` runs the three programs with 1, 2, 4, and 8 processes and writes fresh output to `results/`. Ensure your MPI environment has enough process slots (or configure its launcher accordingly). Exercise 2's expected sum is **50,000,005,000,000**. Exercise 3 is a random estimate, so its answer should be close to pi rather than exactly equal.

The imported spreadsheet and timing report contain the source author's measurements. They are reference data, not measurements from this repository. Compilation and MPI runs have not been verified in this Windows environment. Cluster examples require site-specific account, allocation, and executable setup; they are not submitted automatically.

See [SOURCES.md](SOURCES.md) for provenance and changes.

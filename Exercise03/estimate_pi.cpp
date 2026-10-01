#include <mpi.h>
#include <cstdio>
#include <random>

int main(int argc, char **argv) {
    MPI_Init(&argc, &argv);
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    const long long points = 10000000;
    const long long local_points = points / size + (rank < points % size);
    std::mt19937_64 generator(2026ULL + static_cast<unsigned long long>(rank));
    std::uniform_real_distribution<double> coordinate(0.0, 1.0);
    MPI_Barrier(MPI_COMM_WORLD);
    double start = MPI_Wtime();
    long long inside = 0;
    for (long long i = 0; i < local_points; ++i) {
        double x = coordinate(generator), y = coordinate(generator);
        if (x * x + y * y <= 1.0) ++inside;
    }
    long long total_inside = 0;
    MPI_Reduce(&inside, &total_inside, 1, MPI_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);
    double elapsed = MPI_Wtime() - start, max_elapsed = 0;
    MPI_Reduce(&elapsed, &max_elapsed, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
    if (rank == 0) {
        std::printf("Processes: %d\nTotal points: %lld\nEstimated pi: %.8f\nTime: %.6f seconds\n",
                    size, points, 4.0 * total_inside / points, max_elapsed);
    }
    MPI_Finalize();
    return 0;
}

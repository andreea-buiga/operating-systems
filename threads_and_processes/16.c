#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

/**
 * Write a C program that takes as command line arguments 2 numbers: N and M.
 * The program will simulate a thread race that have to pass through M checkpoints.
 * Through each checkpoint the threads must pass one at a time (no 2 threads can be
 * inside the same checkpoint). Each thread that enters a checkpoint will wait between
 * 100 and 200 milliseconds (usleep(100000) makes a thread or process wait for 100
 * milliseconds) and will print a message indicating the thread number and the
 * checkpoint number, then it will exit the checkpoint. Ensure that no thread will
 * try to pass through a checkpoint until all threads have been created.
 */

pthread_t *threads;
pthread_mutex_t *checkpoints;
pthread_barrier_t barrier;
int T, C;

void pass_checkpoint(int thread_id, int checkpoint_id) {
    pthread_mutex_t checkpoint = checkpoints[checkpoint_id];
    pthread_mutex_lock(&checkpoint);
    printf("Thread %d, Checkpoint %d\n", thread_id + 1, checkpoint_id + 1);
    usleep((random() % 101)*1000);
    pthread_mutex_unlock(&checkpoint);
}

void* run(void *arg) {
    pthread_barrier_wait(&barrier);
    int tid = *(int*)arg;
    for(int i=0; i<C; i++) {
        pass_checkpoint(tid, i);
    }
    return NULL;
}

int main(int argc, char* argv[]) {
    if (argc < 3) {
        printf("Wtf man");
        exit(1);
    }

    T = atoi(argv[1]);
    C = atoi(argv[2]);

    pthread_barrier_init(&barrier, NULL, T);
    threads = malloc(sizeof(pthread_t)*T);
    checkpoints = malloc(sizeof(pthread_mutex_t)*C);

    for(int i=0; i<C; i++) {
        pthread_mutex_init(&checkpoints[i], NULL);
    }

    for(int i=0; i<T; i++){
        int *p = malloc(sizeof(int));
        *p = i;
        pthread_create(&threads[i], NULL, run, p);
    }

    for (int i=0; i<T; i++) {
        pthread_join(threads[i], NULL);
    }

    for(int i=0; i<C; i++) {
        pthread_mutex_destroy(&checkpoints[i]);
    }


    free(threads);
    free(checkpoints);

    return 0;
}
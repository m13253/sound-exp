#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#define SAMPLE_RATE 96000
#define START_FREQ  20
#define END_FREQ    10000
#define BUF_LENGTH  1000000
#define INTERPOLATION_LOG

float buf[BUF_LENGTH];
unsigned int i;
double phase = 0;

int main(int argc, char *argv[]) {
    for(i = 0; i < BUF_LENGTH; i++) {
#ifdef INTERPOLATION_LOG
        double freq = exp(i*log((double) END_FREQ/START_FREQ)/(BUF_LENGTH-1))*START_FREQ;
#else
        double freq = (double) i*(END_FREQ-START_FREQ)/(BUF_LENGTH-1)+START_FREQ;
#endif
        phase += 2*M_PI*freq/SAMPLE_RATE;
        buf[i] = sin(phase);
    }
    {
        FILE *f = fopen("output.pcm_f32", "wb");
        if(!f) {
            int errno_ = errno;
            perror("fopen");
            return errno_;
        }
        fwrite(buf, sizeof *buf, BUF_LENGTH, f);
        fclose(f);
    }
    return 0;
}

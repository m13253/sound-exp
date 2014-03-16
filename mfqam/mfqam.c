#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define hibyte(x) (((unsigned char) (x)) >> 4)
#define lobyte(x) ((x) & 0xf)

const double carrier_freq[] = {500, 100, 1500, 2000, 2500, 3000, 3500, 4000};
#define sample_rate 96000
#define sample_per_signal 480

void write_signal(char buffer[4]) {
    unsigned int freq_i, sample_i;
    char halfbuffer[8] = {
        hibyte(buffer[0]), lobyte(buffer[0]), hibyte(buffer[1]), lobyte(buffer[1]),
        hibyte(buffer[2]), lobyte(buffer[2]), hibyte(buffer[3]), lobyte(buffer[3]),
    };
    float outbuf[sample_per_signal] = {0.0};
    for(freq_i = 0; freq_i<8; freq_i++)
        for(sample_i = 0; sample_i<sample_per_signal; sample_i++) {
            outbuf[sample_i] += sin(2*M_PI*(carrier_freq[freq_i]*sample_i/sample_rate+(halfbuffer[freq_i] & 0x7)/8.0))/(halfbuffer[freq_i] & 0x8 ? 16 : 8 );
        }
    fwrite(outbuf, sizeof outbuf, 1, stdout);
}

int main(int argc, char *argv[]) {
    while(!feof(stdin)) {
        static char buffer[4];
        memset(buffer, 0, 4);
        fread(buffer, 4, 1, stdin);
        write_signal(buffer);
    }
    return 0;
}

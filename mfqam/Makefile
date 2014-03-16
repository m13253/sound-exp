
.PHONY: all clean

CFLAGS=-O3
LDFLAGS=-lm

all: mfqam

clean:
	rm -f mfqam output.raw output.wav

mfqam: mfqam.c
	gcc $(CFLAGS) -o $@ $< $(LDFLAGS)

output.wav: output.raw
	# Assume little-endian
	ffmpeg -y -f f32le -acodec pcm_f32le -ar 96000 -ac 1 -i $< -c copy $@

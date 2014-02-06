
.PHONY: all clean

CFLAGS=-O3
LDFLAGS=-lm

all: output.wav

clean:
	rm -f sine output.pcm_f32 output.wav

sine: sine.c
	gcc $(CFLAGS) -o $@ $< $(LDFLAGS)

output.pcm_f32: sine
	./sine

output.wav: output.pcm_f32
	# Assume little-endian
	ffmpeg -y -f f32le -acodec pcm_f32le -ar 96000 -ac 1 -i $< -c copy $@

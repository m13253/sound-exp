#!/usr/bin/env python3

import math
import matplotlib.animation as animation
import matplotlib.pyplot as plt
import numpy
import scipy.io.wavfile
import sys


animate_speed = 1
frame_rate = 60
window_size = 2048


def main(argv: [str]):
    audio_filename = argv[1]
    sample_rate, audio = scipy.io.wavfile.read(audio_filename)
    length_frames = math.ceil(len(audio) * frame_rate / sample_rate / animate_speed)
    fig = plt.figure()
    ax = plt.axes(xlim=(0, 8000), ylim=(-96, 96))
    ax.grid()
    line, = ax.plot([], [])
    time_text = ax.text(0, 100, '')
    anim = animation.FuncAnimation(fig, update_frame, length_frames, fargs=(sample_rate, audio, line, time_text), interval=1000/frame_rate)
    plt.show()


def update_frame(fr: int, sample_rate: int, audio: numpy.array, line, time_text):
    time_text.set_text('Time: {:.2f} s'.format(fr * animate_speed / frame_rate))
    center_sample = fr * animate_speed * sample_rate / frame_rate
    left_sample = round(center_sample - window_size / 2)
    right_sample = left_sample + window_size
    audio_chunk = numpy.zeros(window_size)
    for i in range(left_sample, right_sample):
        if 0 <= i < len(audio):
            audio_chunk[i - left_sample] = audio[i]
    audio_chunk *= scipy.hanning(window_size)
    spectrum = scipy.fft(audio_chunk)
    x = numpy.linspace(0, sample_rate / 2, window_size // 2, endpoint=False)
    y = 20 * numpy.log10(numpy.abs(spectrum[:window_size // 2]))
    line.set_data(x, y)
    return line, time_text


if __name__ == '__main__':
    main(sys.argv)

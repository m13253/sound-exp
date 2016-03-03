function a = envelope(t)
    if t < 0.01
        a = t/0.01;
    else
        a = exp(-2*log(2)*(t-0.01));
    end
end

function y = osc(t, f)
    mul = [0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    harm = [.114, 1, .384, .468, .192, .441, .333, 0, .233, .222, .21];
    lfo = [1/7, 0, 1/2.75, 0, 1/11, 0, 1/5, 0, 1/4, 1/5, 1/3];
    y = 0.*t;
    for i = 1:11
        y += harm(i)*0.25*sin(2*pi*(f*mul(i)+lfo(i))*t);
        y += harm(i)*0.25*sin(2*pi*(f*mul(i)-lfo(i))*t);
        y -= harm(i)*0.75*sin(2*pi*(f*mul(i)+lfo(i))*t);
        y -= harm(i)*0.75*sin(2*pi*(f*mul(i)-lfo(i))*t);
    end
end

sr = 48000;
volume = 0.2;
time = 0:(1/sr):5;
wave = volume .* arrayfun(@envelope, time) .* osc(time, 440);
wavwrite(wave, sr, 24, "output.wav");

function a = envelope(t)
    a = (1/4).^t;
end

function y = osc(t, f)
    mul = [0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    harm = [.114, 1, .384, .468, .192, .441, .333, 0, .233, .222, .21];
    lfo = [1/7, 0, 1/2.75, 0, 1/11, 0, 1/5, 0, 1/4, 1/5, 1/3];
    y = 0.*t;
    for i = 1:11
        y += harm(i)*0.5*sin(2*pi*(f*mul(i)+lfo(i))*t);
        y += harm(i)*0.5*sin(2*pi*(f*mul(i)-lfo(i))*t);
    end
end

sr = 48000;
volume = 0.45;
time = 0:(1/sr):5;
wave = envelope(time) .* osc(time, 440);
disp(["Max pos amplitude: ", num2str(max(wave))]);
disp(["Max neg amplitude: ", num2str(min(wave))]);
wavwrite(volume .* wave, sr, 24, "output.wav");

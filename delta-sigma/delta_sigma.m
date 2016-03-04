sr = 192000;

[wave_in, fs, nb] = wavread("input.wav");
total = [" s / ", num2str(length(wave_in)/fs), " s"];
wave_out = zeros(ceil(length(wave_in)*sr/fs), 1);

acc1 = 0;
acc2 = 0;
feed = 0;
for i = 2:length(wave_out)
    acc1 += wave_in(floor((i-1)*fs/sr)+1, 1) - feed;
    acc2 += acc1 - feed;
    feed = sign(acc2);
    wave_out(i, 1) = feed * 0.5;
    if mod(i, sr) == 0
        display([num2str(i/sr), total]);
    end
end

wavwrite(wave_out, sr, 24, "output.wav");

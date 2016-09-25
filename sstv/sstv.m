im = im2double(imread("sstv.png"));
im = imresize(im, [160 120]);
im = max(min(im, 1), 0);
im = rgb2ycbcr(im);
width = size(im)(2);

wav = wave();
wav = (wav.append(0, 1)
        .append(1700, 1)   % leading
        .append(1900, .1)  % gray
        .append(1500, .1)  % black
        .append(1900, .1)  % gray
        .append(1500, .1)  % black
        .append(2300, .1)  % white
        .append(1500, .1)  % black
        .append(2300, .1)  % white
        .append(1500, .1)  % black
        .append(1900, .3)  % gray
        .append(1200, .01) % hsync
        .append(1900, .3)  % gray
        .append(1200, .03) % vis: Robot 24
        .append(1300, .06) % 00
        .append(1100, .03) % 1
        .append(1300, .12) % 0000
        .append(1100, .03) % 1
        .append(1200, .03) % vis
    );

for row = 1:120
    display([num2str((row/120)^2*100, "%04.1f"), "% completed."]);
    wav = wav.append(1500, .00120); % punch
    for column = 1:width
        wav = wav.append(1500+im(row, column, 1)*800, .09250/width);
    end
    wav = wav.append(1500, .00300).append(1900, .00090); % ysync
    for column = 1:width
        wav = wav.append(1500+im(row, column, 3)*800, .04625/width);
    end
    wav = wav.append(2300, .00300).append(1900, .00090); % csync
    for column = 1:width
        wav = wav.append(1500+im(row, column, 2)*800, .04625/width);
    end
    wav = wav.append(1200, .00600); % hsync
end

wav = wav.append(1500, .3).append(0, 1);
wav.write("sstv.wav");

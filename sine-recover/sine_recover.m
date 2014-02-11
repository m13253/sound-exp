function b = sine_recover(a)
    saved_page_screen_output = page_screen_output;
    more off;
    maxfreq = length(a)/2;
    afft = fft(a)(1:maxfreq+1);
    power = abs(afft)*2/length(a);
    phase = arg(afft);
    b = zeros(length(afft), 1);
    for t = 0:length(a)
        b(t+1) = sum(power.*cos(2*pi*t/length(a)*(0:maxfreq)'+phase));
        if mod(t, 1000) == 0
            disp([":: " int2str(t) " samples completed."]);
        endif
    end
    if saved_page_screen_output
        more on;
    endif
endfunction

function res = glottal_source(f0, nsamples, len)
    spct = zeros(len*nsamples, 1);
    maxtimes = nsamples/f0/2;
    for i = 1:maxtimes
        spct(f0*len*i+1) = -1j/2*len*nsamples/i/i;  % -12dB/octave
    end
    res = real(ifft(spct));
endfunction

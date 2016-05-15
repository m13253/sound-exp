classdef wave
    properties (GetAccess=private)
        len = 0;
        phase = 0;
        buf = [];
    end
    properties (Constant)
        sr = 48000;
    end
    methods
        function obj = wave()
        end
        function obj = append(obj, freq, dur)
            nextlen = obj.len + dur*obj.sr;
            if freq != 0
                obj.buf = horzcat(obj.buf, sin(obj.phase + 2*pi*freq/obj.sr*(0:(floor(nextlen)-floor(obj.len)-1)))*.5);
            else
                obj.buf = horzcat(obj.buf, zeros(1, floor(nextlen)-floor(obj.len)));
            end
            obj.phase += 2*pi*freq/obj.sr*(nextlen-obj.len);
            obj.len = nextlen;
        end
        function write(obj, filename)
            wavwrite(obj.buf, obj.sr, 24, filename);
        end
    end
end

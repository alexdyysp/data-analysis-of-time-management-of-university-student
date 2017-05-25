function [ new ] = change( old , up , down , max ,log )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
new=old;
is=randi(100,1);
if old < max && old > 1
    if is>=(100-up)
        new=old+1*log;
    end
    if is<=(down)
        new=old-1*log;
    end
    if is > down && is < (100-up)
        new=old;
    end
else if old == max 
        if is<=(down) && log == -1
            new=old-1*abs(log);
        else 
            new=old;
        end
    else
        if old == 1
            if is>=(100-up) && log == 1
                new=old+1*abs(log);
            else 
                new= old;
            end
        end
    end
end
end


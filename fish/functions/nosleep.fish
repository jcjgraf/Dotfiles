function nosleep --wraps='xset s off && xset -dpms' --description 'alias nosleep=xset s off && xset -dpms'
    xset s off && xset -dpms $argv
end

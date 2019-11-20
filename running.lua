function running_keypressed(key)
    if key == "left" and state == gameStates.running then
        left = true; right = false; up = false; down = false
    elseif key == "right" and state == gameStates.running then
        left = false; right = true; up = false; down = false
    elseif key == "up" and state == gameStates.running then
        left = false; right = false; up = true; down = false
    elseif key == "down" and state == gameStates.running then
        left = false; right = false; up = false; down = true
    end
end

local _, addon = ...

local Camera = {}

local function validate_zoom(target)
    target = tonumber(target)
    if type(target) ~= 'number' then
        print('Usage: /setzoom <number>')
        return nil
    end
    return target
end

function Camera.SetZoom(target)
    target = validate_zoom(target)
    if not target then
        return
    end
    local current = GetCameraZoom()
    if target > current then
        CameraZoomOut(target - current)
    else
        CameraZoomIn(current - target)
    end
end

addon.Camera = Camera

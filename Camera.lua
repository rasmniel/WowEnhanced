local _, addon = ...

local Camera = {}

function Camera.SetZoom(target)
    local current = GetCameraZoom()
    if target > current then
        CameraZoomOut(target - current)
    else
        CameraZoomIn(current - target)
    end
end

addon.Camera = Camera

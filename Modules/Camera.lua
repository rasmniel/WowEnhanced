local _, addon = ...

local Camera = {}

--- Set the zoom of the camera.
---@param target number The zoom target
function Camera.SetZoom(target)
    local current = GetCameraZoom()
    if target > current then
        CameraZoomOut(target - current)
    else
        CameraZoomIn(current - target)
    end
end

addon.Camera = Camera

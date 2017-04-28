local AddOnName, AddOnTable = ...
local _

local Prototype = {
    Name = "DefaultContainer",
    Columns = 11,
    Icon = "",
    Locked = false
}

function Prototype:GetName()
    return self.Name
end

function Prototype:SetName(name)
    self.Name = name
end

function Prototype:Render()
    -- TODO
end

function Prototype:Update()
    -- TODO
end

function Prototype:SafeCoordinates()
    -- TODO
end

local Metatable = { __index = Prototype }

function AddOnTable:CreateContainer()
    return _G.setmetatable({}, Metatable)
end
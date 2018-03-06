local AddOnName, AddOnTable = ...
local _

local Prototype = {
    Name = nil,
    SlotIndex = nil,
    Quality = nil,
    Parent = nil,
    Frame = nil
}

function Prototype:UpdateContent(useCache, slotCache)
    local texture, count, locked, quality, isReadable, link, isFiltered, hasNoValue, itemID
    local name, isNewItem, isBattlePayItem
    local cacheEntry = nil
    
    -- initialize with default values before possibly overriding later
    locked = false
    quality = LE_ITEM_QUALITY_POOR
    isNewItemm = false
    isBattlePayItem = false
    isReadable = false

    if not useCache then
        texture, count, locked, quality, isReadable, _, link, isFiltered, hasNoValue, itemID = GetContainerItemInfo(self.Parent.ContainerId, self.SlotIndex)
        
        if link then
            cacheEntry = { Link = link, Count = count }
            name = GetItemInfo(link)
            isNewItem = C_NewItems.IsNewItem(self.Parent.ContainerId, self.SlotIndex)
            isBattlePayItem = IsBattlePayItem(self.Parent.ContainerId, self.SlotIndex)
        end
    elseif slotCache then
        self.Frame.hasItem = nil
        link = slotCache.Link
        count = slotCache.Count or 0

        if link then
            -- regular items ... 
            if (strmatch(link, "|Hitem:")) then
                name, _, quality, _, _, _, _, _, _, texture = GetItemInfo(link)
            -- ... or a caged battle pet ...
            elseif (strmatch(link, "|Hbattlepet:")) then
                local _, speciesID, _, qualityString = strsplit(":", link)
                name, texture = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
                quality = tonumber(qualityString)
            -- ... we don't know about everything else
            end
            
            self.Frame.hasItem = 1
            isNewItem = C_NewItems.IsNewItem(self.Parent.ContainerId, self.SlotIndex)
            isBattlePayItem = IsBattlePayItem(self.Parent.ContainerId, self.SlotIndex)

            -- how to find out if an item is filtered by search here or not?
        end


    end
    
    SetItemButtonTexture(self.Frame, texture)
    --SetItemButtonQuality(self.Frame, quality, itemID);
    SetItemButtonCount(self.Frame, count)
    SetItemButtonDesaturated(self.Frame, locked);
    
    self.Quality = quality
    self:UpdateNewAndBattlepayoverlays(isNewItem, isBattlePayItem)
    self.Frame.readable = isReadable
    if (self.Frame.JunkIcon) then
        self.Frame.JunkIcon:SetShown(quality == LE_ITEM_QUALITY_POOR and not hasNoValue and MerchantFrame:IsShown())
    end

    return link, cacheEntry
end

--[[
    Updates the position of this ItemButton slot.
    TODO: is this really necessary?
    -> Shouldn't this be done relative to the other slots instead of absolutely inside the container?
]]
function Prototype:UpdatePosition(container, x, y, slotLevel)
    self.Frame:ClearAllPoints()
    self.Frame:SetPoint("TOPLEFT", container, "TOPLEFT", x, y)
    self.Frame:SetFrameLevel(slotLevel)
    self.Frame:Show()
end

--[[ Updates the rarity for this on basis of the current items quality ]]
function Prototype:UpdateCustomRarity(showColor)
    local quality = self.Quality

    if quality and (quality > 1) and showColor then
        -- alternative rarity coloring
        if (quality ~=2) and (quality ~= 3) and (quality ~= 4) then
            self.Frame.IconBorder:SetVertexColor(GetItemQualityColor(quality))
        elseif (quality == 2) then        --uncommon
            self.Frame.IconBorder:SetVertexColor(0.1,   1,   0, 0.5)
        elseif (quality == 3) then        --rare
            self.Frame.IconBorder:SetVertexColor(  0, 0.4, 0.8, 0.8)
        elseif (quality == 4) then        --epic
            self.Frame.IconBorder:SetVertexColor(0.6, 0.2, 0.9, 0.5)
        end
        self.Frame.IconBorder:Show()
    else
        self.Frame.IconBorder:Hide()
    end
end

function Prototype:UpdateQuestOverlay(containerId)
    local questTexture = _G[self.Name.."IconQuestTexture"]

    if (questTexture) then
        local isQuestItem, questId, isActive = GetContainerItemQuestInfo(containerId, self.SlotIndex)
        if ( questId and not isActive ) then
            questTexture:SetTexture(TEXTURE_ITEM_QUEST_BANG)
            questTexture:Show()
        elseif ( questId or isQuestItem ) then
            questTexture:SetTexture(TEXTURE_ITEM_QUEST_BORDER)
            questTexture:Show()
        else
            questTexture:Hide()
        end
    end
end

function Prototype:UpdateNewAndBattlepayoverlays(isNewItem, isBattlePayItem)
    local battlepayItemTexture = self.Frame.BattlepayItemTexture
    local newItemTexture = self.Frame.NewItemTexture
    local flash = self.Frame.flashAnim
    local newItemAnim = self.Frame.newitemglowAnim

    if (not newItemTexture or not battlepayItemTexture) then
        return
    end

    if (BBConfig.ShowNewItems and isNewItem) then
        
        if (isBattlePayItem) then
            newItemTexture:Hide()
            battlepayItemTexture:Show()
        else
            if (quality and NEW_ITEM_ATLAS_BY_QUALITY[quality]) then
                newItemTexture:SetAtlas(NEW_ITEM_ATLAS_BY_QUALITY[quality])
            else
                newItemTexture:SetAtlas("bags-glow-white")
            end
            battlepayItemTexture:Hide()
            newItemTexture:Show()
        end
        if (not flash:IsPlaying() and not newItemAnim:IsPlaying()) then
            flash:Play()
            newItemAnim:Play()
        end
    else
        battlepayItemTexture:Hide()
        newItemTexture:Hide()
        if (flash:IsPlaying() or newItemAnim:IsPlaying()) then
            flash:Stop()
            newItemAnim:Stop()
        end
    end
end

function Prototype:UpdateTooltip(subContainerId)
    if ( self.Frame == GameTooltip:GetOwner() ) then
        if (GetContainerItemInfo(subContainerId, self.Frame:GetID())) then
            self.Frame.UpdateTooltip(self.Frame)
        else
            GameTooltip:Hide()
        end
    end
end

function Prototype:ShowHighlight(enabled)
    local texture = _G[self.Name.."Border"]
    texture:SetVertexColor(0.5, 0.5, 0, 1)
    if (enabled) then
        texture:Show()
    else
        texture:Hide()
    end
    --self.Frame.NewItemTexture:Show()
end

local Metatable = { __index = Prototype }

function AddOnTable:CreateItemButton(subContainer, slotIndex, buttonTemplate)
    local itemButton = _G.setmetatable({}, Metatable)

    itemButton.Name = subContainer.Name.."Item"..slotIndex
    itemButton.SlotIndex = slotIndex
    itemButton.Parent = subContainer
    itemButton.Frame = CreateFrame("Button", itemButton.Name, subContainer.Frame, buttonTemplate)
    itemButton.Frame:SetID(slotIndex)
    itemButton.Frame.IconBorder:SetTexture([[Interface\Buttons\UI-ActionButton-Border]])


    local texture = itemButton.Frame:CreateTexture(itemButton.Name.."Border", "OVERLAY")
    texture:SetTexture([[Interface\Buttons\UI-ActionButton-Border]])
    texture:SetPoint("CENTER")
    texture:SetBlendMode("ADD")
    texture:SetAlpha(0.8)
    texture:SetHeight(70)
    texture:SetWidth(70)
    texture:Hide()
    
    return itemButton
end


function AddOnTable:ItemSlot_Created(bagSet, containerId, subContainerId, slotId, button)
    -- just an empty hook for other addons
end

function AddOnTable:ItemSlot_Updated(bagSet, containerId, subContainerId, slotId, button)
    -- just an empty hook for other addons
end
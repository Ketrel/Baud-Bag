local AddOnName, AddOnTable = ...
local _

local Prototype = {
    BagSet = nil,
    ContainerId = nil,
    Name = "",
    StartColumn = 0,
    Size = 0,
    FreeSlots = 0,
    HighlightSlots = false,
    Frame = nil
}

function Prototype:GetID()
    return self.ContainerId
end

function Prototype:GetFrame()
    return self.Frame
end

function Prototype:IsOpen()
    -- TODO: is self.Frame:IsShown() really necessary here?
    local parent = self.Frame:GetParent()
    return self.Frame:IsShown() and parent:IsShown() and not parent.Closing;
end

function Prototype:Render()
    -- TODO
end

function Prototype:CreateMissingSlots()
    local frame = self.Frame
    if (frame.size > (frame.maxSlots or 0)) then
        for slot = (frame.maxSlots or 0) + 1, frame.size do
            -- determine type of template for item button
            local template
            if (self.ContainerId == BANK_CONTAINER) then
                template = "BankItemButtonGenericTemplate"
            elseif (self.ContainerId == REAGENTBANK_CONTAINER) then
                template = "ReagentBankItemButtonGenericTemplate"
            else
                template = "ContainerFrameItemButtonTemplate"
            end

            -- create item button
            local button = CreateFrame("Button", frame:GetName().."Item"..slot, frame, template)
            button:SetID(slot)

            local texture = button:CreateTexture(button:GetName().."Border","OVERLAY")
            texture:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
            texture:SetPoint("CENTER")
            texture:SetBlendMode("ADD")
            texture:SetAlpha(0.8)
            texture:SetHeight(70)
            texture:SetWidth(70)
            texture:Hide()
        end
        frame.maxSlots = frame.size
    end
end

function Prototype:UpdateSlotContents()
    local name, link, quality, type, texture, itemButton, isNewItem, isBattlePayItem
    local showColor = BBConfig[self.BagSet.Id][self.Frame:GetParent():GetID()].RarityColor
    local isBankBag = self.BagSet.Id == BagSetType.Bank.Id
    local bagCache = BaudBagGetBagCache(self.ContainerId)
    local useCache = isBankBag and not BaudBagFrame.BankOpen
    
    -- reinit values that might be outdated
    self.FreeSlots = 0
    if useCache then
        self.Size = bagCache.Size
    else
        self.Size = GetContainerNumSlots(self.ContainerId)
    end

    BaudBag_DebugMsg("Bags", "Updating SubBag (ID, Size, isBagContainer, isBankOpen)", self.ContainerId, self.Size, not isBankBag, BaudBagFrame.BankOpen)

    for slot = 1, self.Size do
        quality = nil
        itemButton = _G[self.Frame:GetName().."Item"..slot]
        isNewItem = false
        isBattlePayItem = false
        
        if not useCache then
            link = GetContainerItemLink(self.ContainerId, slot)

            if (isBankBag) then
                if not link then
                    bagCache[slot] = nil
                else
                    bagCache[slot] = { Link = link, Count = select(2, GetContainerItemInfo(self.ContainerId, slot)) }
                end
            end

            if link then
                name, _, quality = GetItemInfo(link)
                isNewItem = C_NewItems.IsNewItem(self.ContainerId, slot)
                isBattlePayItem = IsBattlePayItem(self.ContainerId, slot)
            end
        elseif bagCache[slot] then
            link = bagCache[slot].Link
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
                
                itemButton.hasItem = 1
                isNewItem = C_NewItems.IsNewItem(self.ContainerId, slot)
                isBattlePayItem = IsBattlePayItem(self.ContainerId, slot)
            else
                texture = nil
                itemButton.hasItem = nil
            end

            SetItemButtonTexture(itemButton, texture)
            SetItemButtonCount(itemButton, bagCache[slot].Count or 0)
        end

        if (itemButton.BattlepayItemTexture) then
            if (isBattlePayItem) then
                itemButton.BattlepayItemTexture:Show()
            else
                itemButton.BattlepayItemTexture:Hide()
            end
        end

        if not link then
            self.FreeSlots = self.FreeSlots + 1
        end

        -- add rarity coloring
        BaudBagItemButton_UpdateRarity(itemButton, quality, showColor)

        -- highlight the slots to show the connection to the bag
        if (self.HighlightSlots) then
            texture = _G[itemButton:GetName().."Border"]
            texture:SetVertexColor(0.5, 0.5, 0, 1)
            texture:Show()
        end

        AddOnTable:ItemSlot_Updated(self.ContainerId, slot, itemButton)
    end
end

-- returns the adapted col and row values
function Prototype:UpdateSlotPositions(container, background, col, row, maxCols, slotLevel)
    local frame = self.Frame
    local slot, itemButton
    for slot = 1, frame.maxSlots do
        itemButton = _G[frame:GetName().."Item"..slot]
        if (slot <= frame.size) then
            col = col + 1
            if (col > maxCols) then
                col = 1
                row = row + 1
            end
            itemButton:ClearAllPoints()
            -- Slot spacing is different for the blizzard textured background
            if (background <= 3) then
                itemButton:SetPoint("TOPLEFT", container, "TOPLEFT", (col-1)*42, (row-1)*-41)
            else
                itemButton:SetPoint("TOPLEFT", container, "TOPLEFT", (col-1)*39, (row-1)*-39)
            end
            itemButton:SetFrameLevel(slotLevel);
            itemButton:Show();
        else
            itemButton:Hide();
        end
    end
    return col, row
end

--[[ This only does something when the container is open (so the items are actually visible) ]]
function Prototype:UpdateItemOverlays()
    if self:IsOpen() then
        BaudBag_DebugMsg("Bags", "Updating Items of Bag (ContainerId)", self.ContainerId)
        local itemButton, questTexture
        local frame = self.Frame
        for Slot = 1, GetContainerNumSlots(self.ContainerId) do
            itemButton = _G[frame:GetName().."Item"..Slot]
            questTexture = _G[itemButton:GetName().."IconQuestTexture"]
            
            ContainerFrame_UpdateCooldown(self.ContainerId, itemButton)
            
            if (questTexture) then
                local isQuestItem, questId, isActive = GetContainerItemQuestInfo(self.ContainerId, itemButton:GetID())
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
    end
end

local function UpdateBackpackHighlight(subContainer)
    local open = subContainer:IsOpen()
    -- needed in this case???
    subContainer.Frame:GetParent().UnlockInfo:Hide()

    if (subContainer.ContainerId == BACKPACK_CONTAINER) then
        MainMenuBarBackpackButton:SetChecked(open)
    else
        local bagId = subContainer.ContainerId -1
        _G["CharacterBag"..bagId.."Slot"]:SetChecked(open)
        _G["BaudBInveBag"..bagId.."Slot"]:SetChecked(open)
    end
end

local function UpdateBankBagHighlight(subContainer)
    local highlight = _G["BaudBBankBag"..(subContainer.ContainerId-4).."HighlightFrameTexture"]
    local open = subContainer:IsOpen()
    local parent = subContainer.Frame:GetParent()
    local unlockInfo = parent.UnlockInfo
    local depositButton = parent.DepositButton

    unlockInfo:Hide()

    if (subContainer.ContainerId == REAGENTBANK_CONTAINER) then
        highlight = _G["BBReagentsBagHighlightFrameTexture"]

        if (not IsReagentBankUnlocked()) then
            unlockInfo:Show()
            depositButton:Disable()
            MoneyFrame_Update( unlockInfo.CostMoneyFrame, GetReagentBankCost() )
        else
            unlockInfo:Hide()
            depositButton:Enable()
        end
    end

    if (subContainer.ContainerId ~= BANK_CONTAINER) then
        if open then
            highlight:Show()
        else
            highlight:Hide()
        end
    end
end

function Prototype:UpdateOpenBagHighlight()
    if (self.BagSet.Id == BagSetType.Backpack.Id) then
        UpdateBackpackHighlight(self)
    elseif (self.BagSet.Id == BagSetType.Bank.Id) then
        UpdateBankBagHighlight(self)
    end
end

function Prototype:SetSlotHighlighting(shouldHighlight)
    self.HighlightSlots = shouldHighlight
    self:UpdateSlotContents()
end

local Metatable = { __index = Prototype }

function AddOnTable:CreateSubContainer(bagSetType, containerId)
    local subContainer = _G.setmetatable({}, Metatable)
    -- TODO this is a really nasty workaround... I don't like it AT ALL... but I don't see a good way right now :(
    local templateName = "BaudBagSubBagTemplate"
    if (BaudBag_IsBankDefaultContainer(containerId)) then
        templateName = nil
    end
    subContainer.Frame = CreateFrame("Frame", AddOnName.."SubBag"..containerId, nil, templateName)
    subContainer.Frame.BagSet = bagSetType.Id
    subContainer.BagSet = bagSetType
    subContainer.ContainerId = containerId
    return subContainer
end

local function EventUpdateFunction(self, event, ...)
    -- only update if the event is for the current bag!
    local idOfBagToUpdate = ...;
    if (self.ContainerId ~= idOfBagToUpdate) then
        return;
    end
    BaudBag_DebugMsg("ItemHandle", "Event fired for subBag, Params[Event, ID]", event, self.ContainerId);
    self:Update(event, ...);
end

local Events = {
    BAG_UPDATE,
    BAG_UPDATE_COOLDOWN = EventUpdateFunction,
    BAG_CLOSED,
    ITEM_LOCK_CHANGED = EventUpdateFunction,
    UPDATE_INVENTORY_ALERTS = EventUpdateFunction
}

-- TODO: don't know if this mixup of object orientation and wow function handly really works like that
function Prototype:OnLoad(self, event, ...)

end

-- TODO: don't know if this mixup of object orientation and wow function handly really works like that
function Prototype:OnEvent(self, event, ...)
    if not self:GetParent():IsShown() or (self:GetID() >= 5) and not BaudBagFrame.BankOpen then
        return;
    end
    Events[event](self, event, ...);
end
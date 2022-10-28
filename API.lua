local _
local AddOnName, AddOnTable = ...

if C_Container ~= nil then

    -- with DF pre-patch (version 1.0.0.xxx as per PTR), the introduction of C_Container was started, but did not yet contain all of the API movements.
    -- The following split should only be necessary until 1.0.2 was released and can be safely replaced with the all C_Container version afterwards

    if C_Container.ContainerIDToInventoryID ~= nil then
        AddOnTable.BlizzAPI = {
            ContainerIDToInventoryID = C_Container.ContainerIDToInventoryID,
            GetContainerNumSlots = C_Container.GetContainerNumSlots,
            GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots,
            GetContainerFreeSlots = C_Container.GetContainerFreeSlots,
            GetInventorySlotInfo = GetInventorySlotInfo,
            ---wrapper for the regular GetContainerItemInfo so we can support the addon in multiple interface levels
            ---@param containerId number ID of the container the item is located in
            ---@param slotIndex number ID of the slot in the container the item is located in
            ---@return { iconFileID: number, stackCount: number, isLocked: boolean, quality: Enum.ItemQuality?, isReadable: boolean, hasLoot: boolean, hyperlink: string, isFiltered: boolean, hasNoValue: boolean, itemID: number, isBound: boolean }|nil
            GetContainerItemInfo = C_Container.GetContainerItemInfo,
            GetContainerItemQuestInfo = C_Container.GetContainerItemQuestInfo,
            GetBackpackAutosortDisabled = C_Container.GetBackpackAutosortDisabled,
            GetBankAutosortDisabled = C_Container.GetBankAutosortDisabled,
            GetContainerItemID = C_Container.GetContainerItemID,
            GetContainerItemLink = C_Container.GetContainerItemLink,
            IsBattlePayItem = C_Container.IsBattlePayItem,
            PickupContainerItem = C_Container.PickupContainerItem,
            SetBackpackAutosortDisabled = C_Container.SetBackpackAutosortDisabled,
            SetBankAutosortDisabled = C_Container.SetBankAutosortDisabled,
            SortBags = C_Container.SortBags,
            SortBankBags = C_Container.SortBankBags,
            SortReagentBankBags = C_Container.SortReagentBankBags,
            SplitContainerItem = C_Container.SplitContainerItem,
            UseContainerItem = C_Container.UseContainerItem,
            IsNewItem = C_NewItems.IsNewItem,
            GetItemInfo = GetItemInfo,
            ---returns the number of watched tokens or the maximum number of watched tokens in old API
            ---@return integer
            --GetNumWatchedTokens = function() return BackpackTokenFrame:GetNumWatchedTokens() end,
            -- this is necessary until TokenFrame was rewritten to be able to handle an arbitrary number of tokens
            GetNumWatchedTokens = function() return 5 end,
            EnumerateBagGearFilters = ContainerFrameUtil_EnumerateBagGearFilters,
            GetIgnoreCleanupFlag = function() return Enum.BagSlotFlags.DisableAutoSort end,
            GetJunkFlag = function() return Enum.BagSlotFlags.PriorityJunk end,
            GetBagSlotFlag = C_Container.GetBagSlotFlag,
            SetBagSlotFlag = C_Container.SetBagSlotFlag,
            -- it is NOT a typo, that the BankBagSlot references the same method as the BagSlots!
            GetBankBagSlotFlag = C_Container.GetBagSlotFlag,
            SetBankBagSlotFlag = C_Container.SetBagSlotFlag,
        }

        AddOnTable.BlizzConstants = {
            REAGENTBANK_CONTAINER = -3, -- REAGENTBANK_CONTAINER (from WoD onwards)
            KEYRING_CONTAINER = -2, -- KEYRING_CONTAINER (only in BC? and WotLK)
            BANK_CONTAINER = -1, -- BANK_CONTAINER
            BACKPACK_CONTAINER = 0, -- BACKPACK_CONTAINER
            BACKPACK_CONTAINER_NUM = 4, -- NUM_BAG_SLOTS
            BACKPACK_REAGENT_BAG_NUM = 1, -- NUM_REAGENTBAG_SLOTS
            BACKPACK_FIRST_CONTAINER = 0, -- == BACKPACK_CONTAINER
            BACKPACK_LAST_CONTAINER = 5, -- == BACKPACK_CONTAINER + NUM_TOTAL_EQUIPPED_BAG_SLOTS ( == NUM_BAG_SLOTS + NUM_REAGENTBAG_SLOTS)
            BANK_CONTAINER_NUM = 7, -- == NUM_BANKBAGSLOTS
            BANK_FIRST_CONTAINER = 6, -- == NUM_TOTAL_EQUIPPED_BAG_SLOTS + 1
            BANK_LAST_CONTAINER = 12 -- == NUM_TOTAL_EQUIPPED_BAG_SLOTS + 1 + NUM_BANKBAGSLOTS
        }

    else

        AddOnTable.BlizzAPI = {
            ContainerIDToInventoryID = ContainerIDToInventoryID,
            GetContainerNumSlots = GetContainerNumSlots,
            GetContainerNumFreeSlots = GetContainerNumFreeSlots,
            GetContainerFreeSlots = GetContainerFreeSlots,
            GetInventorySlotInfo = GetInventorySlotInfo,
            ---wrapper for the regular GetContainerItemInfo so we can support the addon in multiple interface levels
            ---@param containerId number ID of the container the item is located in
            ---@param slotIndex number ID of the slot in the container the item is located in
            ---@return { iconFileID: number, stackCount: number, isLocked: boolean, quality: Enum.ItemQuality?, isReadable: boolean, hasLoot: boolean, hyperlink: string, isFiltered: boolean, hasNoValue: boolean, itemID: number, isBound: boolean }|nil
            GetContainerItemInfo = function(containerId, slotIndex)
                local texture, count, locked, quality, isReadable, lootable, link, isFiltered, hasNoValue, itemID, isBound = GetContainerItemInfo(containerId, slotIndex)
                return {
                    iconFileID = texture,
                    stackCount = count,
                    isLocked = locked,
                    quality = quality,
                    isReadable = isReadable,
                    hasLoot = lootable,
                    hyperlink = link,
                    isFiltered = isFiltered,
                    hasNoValue = hasNoValue,
                    itemID = itemID,
                    isBound = isBound,
                }
            end,
            --- returns information about quest related information from an item
            ---@param containerID number ID of the container 
            ---@param slotIndex number index of the slot in the container
            ---@return {isQuestItem: boolean, questID: number?, isActive: boolean }
            GetContainerItemQuestInfo = function(containerID, slotIndex)
                local isQuestItem, questID, isActive = GetContainerItemQuestInfo(containerID, slotIndex)
                return {
                    isQuestItem = isQuestItem,
                    questID = questID,
                    isActive = isActive
                }
            end,
            GetBackpackAutosortDisabled = GetBackpackAutosortDisabled,
            GetBankAutosortDisabled = GetBankAutosortDisabled,
            GetContainerItemID = GetContainerItemID,
            GetContainerItemLink = GetContainerItemLink,
            IsBattlePayItem = IsBattlePayItem,
            PickupContainerItem = PickupContainerItem,
            SetBackpackAutosortDisabled = SetBackpackAutosortDisabled,
            SetBankAutosortDisabled = SetBankAutosortDisabled,
            SortBankBags = SortBankBags,
            SortReagentBankBags = SortReagentBankBags,
            SplitContainerItem = SplitContainerItem,
            UseContainerItem = UseContainerItem,
            IsNewItem = C_NewItems.IsNewItem,
            GetItemInfo = GetItemInfo,
            ---returns the number of watched tokens or the maximum number of watched tokens in old API
            ---@return integer
            GetNumWatchedTokens = function() return 5 end,
            EnumerateBagGearFilters = function()
                return ipairs({
                    2, --Enum.BagSlotFlags.PriorityEquipment (1),
                    3, --Enum.BagSlotFlags.PriorityConsumables (4),
                    4, --Enum.BagSlotFlags.PriorityTradeGoods (8),
                    5, --Enum.BagSlotFlags.PriorityJunk (16),
                    --seemingly does not exist before DF: Enum.BagSlotFlags.PriorityQuestItems (32)
                })
            end,
            GetIgnoreCleanupFlag = function() return Enum.BagSlotFlags.DisableAutoSort end,
            GetJunkFlag = function() return Enum.BagSlotFlags.PriorityJunk end,
            GetBagSlotFlag = C_Container.GetBagSlotFlag,
            SetBagSlotFlag = C_Container.SetBagSlotFlag,
            -- it is NOT a typo, that the BankBagSlot references the same method as the BagSlots!
            GetBankBagSlotFlag = C_Container.GetBagSlotFlag,
            SetBankBagSlotFlag = C_Container.SetBagSlotFlag,
        }
        
        AddOnTable.BlizzConstants = {
            REAGENTBANK_CONTAINER = -3, -- REAGENTBANK_CONTAINER (from WoD onwards)
            KEYRING_CONTAINER = -2, -- KEYRING_CONTAINER (only in BC? and WotLK)
            BANK_CONTAINER = -1, -- BANK_CONTAINER
            BACKPACK_CONTAINER = 0, -- BACKPACK_CONTAINER
            BACKPACK_CONTAINER_NUM = 4, -- NUM_BAG_SLOTS
            BACKPACK_REAGENT_BAG_NUM = 1, -- NUM_REAGENTBAG_SLOTS
            BACKPACK_FIRST_CONTAINER = 0, -- == BACKPACK_CONTAINER
            BACKPACK_LAST_CONTAINER = 5, -- == BACKPACK_CONTAINER + NUM_TOTAL_EQUIPPED_BAG_SLOTS ( == NUM_BAG_SLOTS + NUM_REAGENTBAG_SLOTS)
            BANK_CONTAINER_NUM = 7, -- == NUM_BANKBAGSLOTS
            BANK_FIRST_CONTAINER = 6, -- == NUM_TOTAL_EQUIPPED_BAG_SLOTS + 1
            BANK_LAST_CONTAINER = 12 -- == NUM_TOTAL_EQUIPPED_BAG_SLOTS + 1 + NUM_BANKBAGSLOTS
        }
    end

else

    AddOnTable.BlizzAPI = {
        ContainerIDToInventoryID = ContainerIDToInventoryID,
        GetContainerNumSlots = GetContainerNumSlots,
        GetContainerNumFreeSlots = GetContainerNumFreeSlots,
        GetContainerFreeSlots = GetContainerFreeSlots,
        GetInventorySlotInfo = GetInventorySlotInfo,
        ---wrapper for the regular GetContainerItemInfo so we can support the addon in multiple interface levels
        ---@param containerId number ID of the container the item is located in
        ---@param slotIndex number ID of the slot in the container the item is located in
        ---@return { iconFileID: number, stackCount: number, isLocked: boolean, quality: Enum.ItemQuality?, isReadable: boolean, hasLoot: boolean, hyperlink: string, isFiltered: boolean, hasNoValue: boolean, itemID: number, isBound: boolean }|nil
        GetContainerItemInfo = function(containerId, slotIndex)
            local texture, count, locked, quality, isReadable, lootable, link, isFiltered, hasNoValue, itemID, isBound = GetContainerItemInfo(containerId, slotIndex)
            return {
                iconFileID = texture,
                stackCount = count,
                isLocked = locked,
                quality = quality,
                isReadable = isReadable,
                hasLoot = lootable,
                hyperlink = link,
                isFiltered = isFiltered,
                hasNoValue = hasNoValue,
                itemID = itemID,
                isBound = isBound,
            }
        end,
        --- returns information about quest related information from an item
        ---@param containerID number ID of the container 
        ---@param slotIndex number index of the slot in the container
        ---@return {isQuestItem: boolean, questID: number?, isActive: boolean }
        GetContainerItemQuestInfo = function(containerID, slotIndex)
            local isQuestItem, questID, isActive = GetContainerItemQuestInfo(containerID, slotIndex)
            return {
                isQuestItem = isQuestItem,
                questID = questID,
                isActive = isActive
            }
        end,
        GetBackpackAutosortDisabled = GetBackpackAutosortDisabled,
        GetBankAutosortDisabled = GetBankAutosortDisabled,
        GetContainerItemID = GetContainerItemID,
        GetContainerItemLink = GetContainerItemLink,
        IsBattlePayItem = IsBattlePayItem,
        PickupContainerItem = PickupContainerItem,
        SetBackpackAutosortDisabled = SetBackpackAutosortDisabled,
        SetBankAutosortDisabled = SetBankAutosortDisabled,
        SortBankBags = SortBankBags,
        SortReagentBankBags = SortReagentBankBags,
        SplitContainerItem = SplitContainerItem,
        UseContainerItem = UseContainerItem,
        IsNewItem = C_NewItems.IsNewItem,
        GetItemInfo = GetItemInfo,
        ---returns the number of watched tokens or the maximum number of watched tokens in old API
        ---@return integer
        GetNumWatchedTokens = function() return MAX_WATCHED_TOKENS end,
        EnumerateBagGearFilters = function()
            return ipairs({
                2, --Enum.BagSlotFlags.PriorityEquipment (1),
                3, --Enum.BagSlotFlags.PriorityConsumables (4),
                4, --Enum.BagSlotFlags.PriorityTradeGoods (8),
                5, --Enum.BagSlotFlags.PriorityJunk (16),
                --seemingly does not exist before DF: Enum.BagSlotFlags.PriorityQuestItems (32)
            })
        end,
        GetIgnoreCleanupFlag = function() return LE_BAG_FILTER_FLAG_IGNORE_CLEANUP end,
        GetJunkFlag = function() return LE_BAG_FILTER_FLAG_JUNK end,
        GetBagSlotFlag = GetBagSlotFlag,
        SetBagSlotFlag = SetBagSlotFlag,
        GetBankBagSlotFlag = GetBankBagSlotFlag,
        SetBankBagSlotFlag = SetBankBagSlotFlag
    }

    AddOnTable.BlizzConstants = {
        REAGENTBANK_CONTAINER = -3, -- REAGENTBANK_CONTAINER (from WoD onwards)
        KEYRING_CONTAINER = -2, -- KEYRING_CONTAINER (only in BC? and WotLK)
        BANK_CONTAINER = -1, -- BANK_CONTAINER
        BACKPACK_CONTAINER = 0, -- BACKPACK_CONTAINER
        BACKPACK_CONTAINER_NUM = 4, -- NUM_BAG_SLOTS
        BACKPACK_REAGENT_BAG_NUM = 0, -- NUM_REAGENTBAG_SLOTS
        BACKPACK_FIRST_CONTAINER = 0, -- == BACKPACK_CONTAINER
        BACKPACK_LAST_CONTAINER = 4, -- == BACKPACK_CONTAINER + NUM_TOTAL_EQUIPPED_BAG_SLOTS ( == NUM_BAG_SLOTS + NUM_REAGENTBAG_SLOTS)
        BANK_CONTAINER_NUM = 7, -- == NUM_BANKBAGSLOTS
        BANK_FIRST_CONTAINER = 5, -- == NUM_TOTAL_EQUIPPED_BAG_SLOTS + 1
        BANK_LAST_CONTAINER = 11 -- == NUM_TOTAL_EQUIPPED_BAG_SLOTS + 1 + NUM_BANKBAGSLOTS
    }

end
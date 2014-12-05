﻿-- Author      : gsnerf
-- Create Date : 11/11/2010 6:16:49 PM

local _;

-- some locally needed variables
local Localized	= BaudBagLocalized;
local SliderBars, CheckButtons;
BBConfig = {};

function BaudBagSetCfgPreReq(Bars, Buttons)
    SliderBars		= Bars;
    CheckButtons	= Buttons;
end

function BaudBagRestoreCfg()
    BaudBag_DebugMsg("Config", "Restoring BBConfig structure:");
	
    if (type(BaudBag_Cfg) ~= "table") then
        BaudBag_DebugMsg("Config", "- basic BBConfig damaged or missing, creating now");
        BaudBag_Cfg = {};
    end
    BBConfig = BaudBag_Cfg;
	
    for BagSet = 1, 2 do
        if (type(BBConfig[BagSet]) ~= "table") then
            BaudBag_DebugMsg("Config", "- BBConfig for BagSet "..BagSet.." damaged or missing, creating now");
            BBConfig[BagSet] = {};
        end
		
        if (type(BBConfig[BagSet].Enabled) ~= "boolean") then
            BaudBag_DebugMsg("Config", "- enabled state for BagSet "..BagSet.." damaged or missing, creating now");
            BBConfig[BagSet].Enabled = true;
        end

        if (type(BBConfig[BagSet].CloseAll) ~= "boolean") then
            BaudBag_DebugMsg("Config", "- close all state for BagSet "..BagSet.." damaged or missing, creating now");
            BBConfig[BagSet].CloseAll = true;
        end

        if (type(BBConfig[BagSet].Joined) ~= "table") then
            BaudBag_DebugMsg("Config", "- joins for BagSet "..BagSet.." damaged or missing, creating now");
            BBConfig[BagSet].Joined = {};
        end

        if (BagSet == 2 and BBConfig[2].Joined[9] == nil) then
            BaudBag_DebugMsg("Config", "- reagent bank join for BagSet "..BagSet.." damaged or missing, creating now");
            BBConfig[BagSet].Joined[9] = false;
        end

        if (type(BBConfig[BagSet].ShowBags) ~= "boolean") then
            BaudBag_DebugMsg("Config", "- show information for BagSet "..BagSet.." damaged or missing, creating now");
            BBConfig[BagSet].ShowBags = ((BagSet == 2) and true or false);
        end

        local Container = 0;
        BaudBagForEachBag(BagSet, function(Bag, Index)

            -- keyring cache, not needed anymore???
            --if (Bag == -2) and (BBConfig[BagSet].Joined[Index] == nil) then
            --    BaudBag_DebugMsg("Config", "- BagSet["..BagSet.."], Bag["..Bag.."] joined status damaged or missing, creating now");
            --    BBConfig[BagSet].Joined[Index] = false;
            --end

            if (Container == 0) or (BBConfig[BagSet].Joined[Index] == false) then
                Container = Container + 1;

                if (type(BBConfig[BagSet][Container]) ~= "table") then
                    BaudBag_DebugMsg("Config", "- BagSet["..BagSet.."], Bag["..Bag.."], Container["..Container.."] container data damaged or missing, creating now");
                    if (Container == 1) or (Bag==-3) then
                        BBConfig[BagSet][Container] = {};
                    else
                        BBConfig[BagSet][Container] = BaudBagCopyTable(BBConfig[BagSet][Container-1]);
                    end
                end

                if not BBConfig[BagSet][Container].Name then
                    BaudBag_DebugMsg("Config", "- BagSet["..BagSet.."], Bag["..Bag.."], Container["..Container.."] container name missing, creating now");
                    --With the key ring, there isn't enough room for the player name aswell
                    BBConfig[BagSet][Container].Name = (Bag==-2) and Localized.KeyRing or UnitName("player")..Localized.Of..((BagSet==1)and Localized.Inventory or Localized.BankBox);
                end

                if (type(BBConfig[BagSet][Container].Background) ~= "number") then
                    BaudBag_DebugMsg("Config", "- BagSet["..BagSet.."], Bag["..Bag.."], Container["..Container.."] container background damaged or missing, creating now");
                    if (BagSet == 2) then
                        -- bank containers have "blizz bank" default
                        BBConfig[BagSet][Container].Background = 2
                    else
                        -- default containers only separate for default bag and keyring (-2 == keyring)
                        BBConfig[BagSet][Container].Background = (Bag == -2) and 3 or 1;
                    end
                end

                for Key, Value in ipairs(SliderBars) do
                    if (type(BBConfig[BagSet][Container][Value.SavedVar]) ~= "number") then
                        BaudBag_DebugMsg("Config", "- BagSet["..BagSet.."], Bag["..Bag.."], Container["..Container.."] Slider["..Value.SavedVar.."] data damaged or missing, creating now");
                        BBConfig[BagSet][Container][Value.SavedVar] = (Bag == -2) and (Value.SavedVar=="Columns") and 4 or Value.Default[BagSet];
                    end
                end

                for Key, Value in ipairs(CheckButtons)do
                    if (type(BBConfig[BagSet][Container][Value.SavedVar]) ~= "boolean") then
                        BaudBag_DebugMsg("Config", "- BagSet["..BagSet.."], Bag["..Bag.."], Container["..Container.."] CheckBox["..Value.SavedVar.."] data damaged or missing, creating now");
                        BBConfig[BagSet][Container][Value.SavedVar] = Value.Default;
                    end
                end
            end
        end);
    end
end

function BaudBagSaveCfg()
    BaudBag_DebugMsg("Config", "Saving configuration");
    BaudBag_Cfg = BaudBagCopyTable(BBConfig);
    ReloadConfigDependant();
end

function ReloadConfigDependant()
    BaudBag_DebugMsg("Config", "Reloading configuration depending objects");
    BaudUpdateJoinedBags();
    BaudBagUpdateBagFrames();
    BaudBagOptionsUpdate();
end
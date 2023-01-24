local TGHP = {
    playerUnit = nil,
    targetUnit = nil,
}
local TGHPPlayerDebuffWatcher = {}
local TGHPTargetBuffWatcher = {}

local PLAYER_DEBUFFS = {
    [392731] = "Glaciate",
    [398140] = "Icy Path",
    [394608] = "You're Infected!",
    [43958]  = "You're Infected!",
    --[6788]   = "Weakend Soul",
}

local TARGET_BUFFS = {
    [398189] = "Blood of the Load",
    --[48066]  = "Power Word: Shield",  -- Rank 14
}

function TGHP.ADDON_LOADED(addOnName)
    if addOnName ~= "TGHPlusWarning" then
        return
    end

    TGHP.playerUnit = TGUnit:new("player")
    TGHP.targetUnit = TGUnit:new("target")

    TGHP.playerUnit:AddListener(TGHPPlayerDebuffWatcher)
    TGHP.targetUnit:AddListener(TGHPTargetBuffWatcher)
end

function TGHPPlayerDebuffWatcher:UPDATE_DEBUFFS(unit)
    local debuffed = false
    for _, debuff in ipairs(unit.debuffs) do
        if PLAYER_DEBUFFS[debuff.spellId] then
            debuffed = true
            break
        end
    end

    if debuffed then
        TGHPPlayerDebuffedFrame:Show()
    else
        TGHPPlayerDebuffedFrame:Hide()
    end
end

function TGHPTargetBuffWatcher:UPDATE_BUFFS(unit)
    local buffed = false
    for _, buff in ipairs(unit.buffs) do
        --print(tostring(buff.name).." : "..tostring(buff.spellId))
        if TARGET_BUFFS[buff.spellId] then
            buffed = true
            break
        end
    end

    if buffed then
        TGHPTargetBuffedFrame:Show()
    else
        TGHPTargetBuffedFrame:Hide()
    end
end

TGEventManager.Register(TGHP)

local function setGoToHotKey()
    if civ.getActiveUnit() then
        return
    end
    state.hotkeys = state.hotkeys or {}
    for tribe = 0,7 do
        state.hotkeys[tribe] = state.hotkeys[tribe] or {}
    end
    local destinationTile = civ.getCurrentTile()

    local menuText = "Set the tile ("..tostring(destinationTile.x)..
    ","..tostring(destinationTile.y)..") as the goto destination for the active unit when the following key is pressed:"
    local menuTable = {}
    local function hotkeyValToString(hotkeyVal)
        if hotkeyVal then
            return ", currently set to ("..tostring(hotkeyVal[1])..","..tostring(hotkeyVal[2])..")"
        else
            return ""
        end
    end
    menuTable[7] = "Key 7"..hotkeyValToString(state.hotkeys[civ.getCurrentTribe().id][7])
    menuTable[8] = "Key 8"..hotkeyValToString(state.hotkeys[civ.getCurrentTribe().id][8])
    menuTable[9] = "Key 9"..hotkeyValToString(state.hotkeys[civ.getCurrentTribe().id][9])
    menuTable[20] = "Don't set a hotkey."
    menuTable[21] = "Clear all hotkeys."
    choice = text.menu(menuTable,menuText,"GOTO Hotkeys")
    if choice == 20 then
        return
    elseif choice == 21 then
        state.hotkeys[civ.getCurrentTribe().id][7]=nil
        state.hotkeys[civ.getCurrentTribe().id][8]=nil
        state.hotkeys[civ.getCurrentTribe().id][9]=nil
        return
    end
    state.hotkeys[civ.getCurrentTribe().id][choice]={destinationTile.x,destinationTile.y}
    return
end

local function useGoToHotKey(numberKey)
    if not civ.getActiveUnit() then
        return
    end
    local currentUnit = civ.getActiveUnit()
    state.hotkeys = state.hotkeys or {}
    for tribe = 0,7 do
        state.hotkeys[tribe] = state.hotkeys[tribe] or {}
    end
    local hotkeyDest =  state.hotkeys[currentUnit.owner][numberKey]
    if hotkeyDest then
        currentUnit.gotoTile = civ.getTile(hotkeyDest[1],hotkeyDest[2],currentUnit.location.z)
    else
        text.simple("The key "..tostring(numberKey).." is not set as a goto hotkey.","GOTO Hotkeys")
    end
end

   


    

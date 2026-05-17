-- 0 is unspecified
-- 1 is scarce: (almost) no form of the resource is available
-- 2 is over-processed: neither the ore itself nor all the processed forms are easily accesible, but some products can be acquired through alternative route
-- 3 is processed: the ore itself is scarce, but all the processed form / some alternative form is abundant
-- 4 is accessible: the ore itself is abundant

local avl_chart = Avail_SP.avl_chart
local surface_lock = {}
local function insert_avl(k, v)
    -- respect the modification done by other authors
    if avl_chart[k] then
        surface_lock[k] = true
        return
    end
    avl_chart[k] = v
end
local function forced_insert_avl(k, v)
    -- this is a backup method to override the existing value
    avl_chart[k] = v
end

----- First, we assign raw values to each surface

---- vanilla surfaces

insert_avl("nauvis", {4, 4, 4, 4})
insert_avl("space-platform", {1, 1, 4, 3})
insert_avl("vulcanus", {1, 4, 3, 3})
insert_avl("fulgora", {1, 4, 3, 3})
insert_avl("gleba", {1, 4, 4, 4})
insert_avl("aquilo", {1, 1, 1, 1})

---- Maraxsis

if mods["maraxsis"] then
    insert_avl("maraxsis", {1, 4, 3, 3})
    insert_avl("maraxsis-trench", {1, 4, 3, 3})
end

---- Cerys

if mods["Cerys-Moon-of-Fulgora"] then
    local cer_stone = 3
    local cer_recycle_stone = false
    for _, outcome in pairs(data.raw["recipe"]["cerys-nuclear-scrap-recycling"].results) do
        if outcome.name == "stone" then
            cer_recycle_stone = true
            break
        end
    end
    if cer_recycle_stone then
        cer_stone = 4
    end

    insert_avl("cerys", {1, cer_stone, 3, 3}) -- mineral leaching, especially after being nerfed, is not sufficient to support a 4 rating for iron
end

---- Moshine

if mods["Moshine"] then
    -- Without CI compat both stone and brick are lacking; with it, only stone itself is lacking
    local mos_stone = 2
    if mods["crushing-industry-compatibility"] then
        mos_stone = 3
    end
    insert_avl("moshine", {1, mos_stone, 3, 4})
end

---- Corrundum

if mods["corrundum"] then
    insert_avl("corrundum", {1, 4, 4, 4})
end

---- Muluna

if mods["planet-muluna"] then
    insert_avl("muluna", {4, 3, 4, 3})
end

---- Frozeta

if mods["secretas"] then
    insert_avl("frozeta", {1, 4, 3, 3})
end

---- Rubia

if mods["rubia"] then
    insert_avl("rubia", {1, 2, 3, 3})
end

---- Paracelsin

if mods["Paracelsin"] then
    insert_avl("paracelsin", {1, 4, 4, 4})
end

---- Lignumis

if mods["lignumis"] then
    insert_avl("lignumis", {4, 4, 1, 1})
end

---- Pelagos

if mods["pelagos"] then
    insert_avl("pelagos", {4, 2, 4, 4})
end

---- Vesta

if mods["skewer_planet_vesta"] then
    insert_avl("vesta", {1, 4, 3, 3})
end

---- Planetaris

if mods["planetaris-arig"] then
    insert_avl("arig", {4, 4, 4, 4})
end

if mods["planetaris-hyarion"] then
    insert_avl("hyarion", {4, 4, 4, 4})
end

if mods["planetaris-tellus"] then
    insert_avl("tellus", {4, 4, 4, 4})
end

---- Panglia

if mods["panglia_planet"] then
    insert_avl("panglia", {1, 3, 3, 3})
end

---- Rabbasca

if mods["planet-rabbasca"] then
    insert_avl("rabbasca", {1, 4, 4, 4})
end

---- Apia-Carnova

if mods["apia"] then
    insert_avl("apia", {1, 4, 4, 4})
    insert_avl("carnova", {1, 4, 4, 4})
end

---- Virentis

if mods["virentis"] then
    insert_avl("virentis", {4, 4, 3, 3})
end

---- Muria

if mods["Muria"] then
    insert_avl("muria", {1, 4, 4, 4})
end

---- Crucible

if mods["planet-crucible"] then
    insert_avl("crucible", {1, 3, 3, 3}) -- Producing stone on Crucible is not very economical
end

---- Eneas

if mods["moon-eneas"] then
    insert_avl("eneas", {4, 4, 4, 4})
end

--------

-- log("[AVAIL-SP] Nauvis availability:")
-- log(serpent.block(Avail_SP.avl_chart["nauvis"]))

--------

----- Then, we consider the modifications of overhaul / companion mods.

local function avl_change(surface, avl_index, change_result)
    if surface_lock[surface] then return end

    if avl_chart[surface][avl_index] < change_result then
        avl_chart[surface][avl_index] = change_result
    end
end

---- Dredgeworks Frozen Reach

if mods["dw-frozen-reaches"] then
    for i = 2, 4 do
        avl_change("aquilo", i, 4)
    end
end

---- Lignumis

if settings.startup["lignumis-fulgora-wood"] then
    avl_change("fulgora", 1, 4)
end

---- Wayward Sea or water cane standalone

if (mods["wayward-seas"] or mods["gleba-water-cane"]) then
    avl_change("gleba", 1, 4)
end

---- Wooden Universe

local wu_table ={
    ["space-platform"] = "astroponics",
    ["vulcanus"] = "vulcanus-sulfuric-bacteria",
    ["fulgora"] = "fulgora-coralmium-agriculture",
    ["gleba"] = "gleba-radicane-algaculture",
    ["aquilo"] = "aquilo-seabloom-algaculture",
    ["cerys"] = "cerys-lunaponics",
    ["moshine"] = "moshine-solaponics"
}

for surface, mod in pairs(wu_table) do
    if (data.raw["planet"][surface] or data.raw["surface"][surface]) and mods[mod] then
        avl_change(surface, 1, 4)
    end
end
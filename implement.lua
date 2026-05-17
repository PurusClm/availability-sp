local unlogged = true

local function assign_avl(surface, values)
    local type = nil
    if data.raw["planet"][surface] then
        type = "planet"
    elseif data.raw["surface"][surface] then
        type = "surface"
    end

    if not type then
        log("[AVAIL-SP] surface with unexpected type: "..surface)
        return
    end

    if unlogged then
        log("[AVAIL-SP] (in implement): "..surface.." availability")
        log(serpent.block(values))
        unlogged = false
    end

    data.raw[type][surface].surface_properties = data.raw[type][surface].surface_property or {}
    data.raw[type][surface].surface_properties["wood-avl"] = values[1]
    data.raw[type][surface].surface_properties["stone-avl"] = values[2]
    data.raw[type][surface].surface_properties["iron-avl"] = values[3]
    data.raw[type][surface].surface_properties["copper-avl"] = values[4]
end

local avl_chart = Avail_SP.avl_chart

for k, v in pairs(avl_chart) do
    assign_avl(k, v)
end


-- debug recipes

local template = {
    type = "recipe",
    -- name =
    category = "advanced-crafting",
    -- icon = "__base__/graphics/icons/",
    -- ingredients = {}
    -- results = {}
    energy_required = 0.1,
    enabled = true,
    hide_from_stats = true,
    hide_from_player_crafting = true,
    hide_from_bonus_gui = true,
    auto_recycle = false
    -- surface_consitions =
}

local function create_rec(ore_name, avl_name, avl_num)
    local to_add = table.deepcopy(template)

    to_add.name = "asp-debug-"..ore_name.."-level-"..avl_num
    to_add.icon = "__base__/graphics/icons/"..ore_name..".png"
    to_add.ingredients ={
        {type = "item", name = ore_name, amount = 1}
    }
    to_add.results ={
        {type = "item", name = ore_name, amount = 1}
    }
    to_add.surface_conditions = {
        {
            property = avl_name,
            min = avl_num,
            max = avl_num
        }
    }

    data:extend({to_add})
end

create_rec("wood", "wood-avl", 4)
create_rec("stone", "stone-avl", 4)
create_rec("iron-ore", "iron-avl", 4)
create_rec("copper-ore", "copper-avl", 4)
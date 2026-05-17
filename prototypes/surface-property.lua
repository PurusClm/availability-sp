local hide = settings.startup["availability-sp-hide"].value

data:extend({
    {
        type = "surface-property",
        name = "wood-avl",
        default_value = 0,
        hidden = hide,
        order = "z[availability-sp]-a"
    },
    {
        type = "surface-property",
        name = "stone-avl",
        default_value = 0,
        hidden = hide,
        order = "z[availability-sp]-b"
    },
    {
        type = "surface-property",
        name = "iron-avl",
        default_value = 0,
        hidden = hide,
        order = "z[availability-sp]-c"
    },
    {
        type = "surface-property",
        name = "copper-avl",
        default_value = 0,
        hidden = hide,
        order = "z[availability-sp]-d"
    }
})
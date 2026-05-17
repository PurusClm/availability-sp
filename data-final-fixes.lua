log("[AVAIL-SP] Fulgora availability (final):")
log(serpent.block({
    data.raw["planet"]["fulgora"].surface_properties["wood-avl"],
    data.raw["planet"]["fulgora"].surface_properties["stone-avl"],
    data.raw["planet"]["fulgora"].surface_properties["iron-avl"],
    data.raw["planet"]["fulgora"].surface_properties["copper-avl"],
}))
**This mod is a modding utility and does (almost) nothing on its own.**

Reorganizing resources structure is frequently implemented by planet and overhaul mods to incentivize new factory designs instead of copy-pasting the same set of blueprints everywhere. While this method is effective at introducing fresh experience to the game, it can cause compat disasters, as some items intentionally removed or made harder to obtain by one mod might just be required by new recipes from another mod. This mod aims to resolve this kind of problem by serving as a informant hub, providing openly accessible, *manually assigned* ratings of the difficulty to obtain different forms of basic resources on a surface as surface properties, which can then be refered to by other mods to decide whether and how some changes should be enforced on different surfaces, without having to work on compat case-by-case.

# Definitions
This mod currently covers wood, stone, iron, and copper, and consider the following aspects of these resources:

- *Ore items*: the most basic form of the resources, available to you in vanilla games.

- *Processed items*: the form directly obtained by processing one type of ore item, and cannot be recycled back to the ore item, such as sand, bricks, and plates.

- *Equivalent items*: the items that can by use in place of ore items in all or most of the cases but cannot be made into ore items, such as molten metals from lava, or algae of Vesta.

And when talking about "availability", this mod considers:

- The sources of resources that can be automatically gathered, and will not be drained entirely from the surface within at least tens of hours. As such, items exclusively acquired from rocks or non-farmable vegetations should not be considered;

- The "intended" availability; that is, the ability of a planet to supply the local production lines without any extra convinience. As such, additional ways to acquire some resources provided by some mod should only be considered if that mod also introduce new production lines to consume them, or is a companion mod to another mod that does so.

# Ratings
Each kind of resource on a surface is *manually* assigned one of the ratings below:

- **0 - Unspecified**: this resource on this surface has not been rated yet.

- **1 - Scarce**: it is (almost) impossible to obtain any form or product of this kind of resource; supplies need to be shipped in if needed.

- **2 - Over-processed**: it is (almost) impossible to obtain the ore item and some or all of the processed forms, but some of the products are available. For example, stone on Rubia is rated as "over-processed" because it is not possible to obtain stones or bricks, but concrete and rails are abundant.

- **3 - Processed**: All the processed forms and therefore all the products can be produced from equivalent items or alternative routes, but the ore item itself is not available, or the yield is too low to practically supply a factory. If, for example, iron is rated as "processed" on some planet (think about Fulgora if you like), it will be rather easy to produce items requiring plates, gears, or sticks, but it might not be a good idea to enforce the use of iron ore there, as the player will likely need to ship ores in, buid an orbital mining station, or buid hundreds of machines and beacons to tackle the low yield, only to produce that one item.

- **4 - Accessible**: the ore item is abundant, and thus all the demands of this kind of resource should have no problems to be satisfied.

# Pre-packed Ratings
As of now, this mod comes with ratings of some planet and overhaul mods that I've played, in addition to vanilla SA planets, as examples of how the rating works. Those are:

- Planets: Maraxsis, Cerys, Moshine, Corrundum, Muluna, Frozeta, Rubia, Paracelsin, Lignumis, Pelagos, Vesta, Arig, Hyarion, Tellus, Panglia, Rabbasca, Apia-Carnova, Virentis, Muria, Crucible, Eneas;

- Overhauls: Dredgeworks Frozen Reach, On the Wayward Seas, Wooden Universe (accompanying Wooden Industry / Logistics or Lignumis).

# Settings
If you think ratings constitute spoilers, there is an options to make the resources availability surface properties hidden.

# API
I recommend authors of planet mods who are interested in this feature to fill the ratings themselves. Currently, this is done like this:

- By marking this mod as an optional dependency of your planet mod, a global variable `Avail_SP.avl_chart` should be made available in data phase.

- Then, you can fill the ratings in by including something like this:
  ```
  Avail_SP.avl_chart["<planet name>"] = {<ratings>}
  ```
  where `{<ratings>}` is an array of resources rating of wood, stone, iron, copper, respectively. So for Vulcanus without sulfuric bacteria, this is:
  ```
  Avail_SP.avl_chart["vulcanus"] = {1, 4, 3, 3}
  ```
- The pre-packed ratings are implemented in data-updates phase. If the rating field of a planet is already filled out by then, this mod will skip that planet to respect the values assigned earlier.

# Credits
- The way to implement the locale is inspired by [Pollution as surface property](https://mods.factorio.com/mod/pollution-as-surface-property).

preprocess = ./preprocess

triggers = trigger/age_up_monitor.xs \
	   trigger/build_barracks.xs \
	   trigger/control_military.xs \
	   trigger/init_map.xs \
	   trigger/spawn_units.xs \
	   trigger/lib/core.xs \
	   trigger/lib/military.xs \
	   trigger/lib/spawn_scheduler.xs \
	   trigger/lib/tech_alloc.xs

release_map = random_maps/mythical_chaos.xs
editor_map = random_maps/mythical_chaos_editor.xs

all: $(release_map) $(editor_map)

$(release_map): src/mythical_chaos.xs $(triggers)
	$(preprocess) -o $(release_map) -D RELEASE_BUILD=true src/mythical_chaos.xs

$(editor_map): src/mythical_chaos.xs $(triggers)
	$(preprocess) -o $(editor_map) -D RELEASE_BUILD=false src/mythical_chaos.xs

clean:
	rm $(release_map) $(editor_map)

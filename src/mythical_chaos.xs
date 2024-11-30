include "lib/rm_core.xs";
include "lib/rm_forests.xs";

include "../trigger/lib/core.xs";

const float cLaneLengthTiles = 160.0 * (1.0 + 0.5 * cMapSizeCurrent);

void createTriggers()
{
    // TODO: use #if defined once supported in preprocessor
    if(RELEASE_BUILD)
    {
    #wrap_include rmTriggerAddScriptLine "../trigger/build_barracks.xs"
    #wrap_include rmTriggerAddScriptLine "../trigger/control_military.xs"
    #wrap_include rmTriggerAddScriptLine "../trigger/init_map.xs"
    #wrap_include rmTriggerAddScriptLine "../trigger/spawn_units.xs"
    #wrap_include rmTriggerAddScriptLine "../trigger/age_up_monitor.xs"
    }
    else
    {
    #wrap_include rmTriggerAddScriptLine "../trigger/lib/core.xs"
    }

    rmTriggerAddScriptLine("rule _Assign_Player_Sides");
    rmTriggerAddScriptLine("highFrequency");
    rmTriggerAddScriptLine("active");
    rmTriggerAddScriptLine("runImmediately");
    rmTriggerAddScriptLine("{");
    rmTriggerAddScriptLine("mapLayout.init("+cLaneLengthTiles+");");
    for(int i = 1; i <= cNumberPlayers; i++)
    {
        rmTriggerAddScriptLine("playerSides.add("+getPlayerSide(i)+");");
    }
    rmTriggerAddScriptLine("xsDisableSelf();");
    rmTriggerAddScriptLine("}");
}

void generate()
{
    rmSetProgress(0.0);

    mapLayout.init(cLaneLengthTiles);

    int edgeTexture = cTerrainCityTile1;

    rmSetMapSize(mapLayout.sizeTiles / 2);
    rmObjectiveAdd("Map size " + mapLayout.sizeTiles);
    rmObjectiveAdd("Lane length " + cLaneLengthTiles);

    rmInitializeLand(edgeTexture);

    bool[] sidesTaken = new bool(cNumberPlayers, false);
    for(int i = 1; i <= cNumberPlayers; i++)
    {
        int side = xsRandInt(0, cNumberPlayers - i);
        for(int j = 0; j <= side; j++)
        {
            if(sidesTaken[j])
            {
                side++;
            }
        }
        playerSides.add(side);

        vector placement = mapLayout.outerWaypoint(side) / mapLayout.sizeTiles;
        rmPlacePlayer(i, placement);
        sidesTaken[side] = true;
    }

    finalizePlayerPlacement();

    rmSetProgress(0.2);

    // Playable area, going up to 1 tile towards the edge.
    int mapAreaID = rmAreaCreate("map area");
    rmAreaSetTerrainType(mapAreaID, cTerrainEgyptSand1);
    rmAreaSetSize(mapAreaID, 1.0);
    rmAreaSetCoherence(mapAreaID, 1.0);
    rmAreaAddConstraint(mapAreaID, createSymmetricBoxConstraint(rmXTileIndexToFraction(1), rmZTileIndexToFraction(1)));
    rmAreaBuild(mapAreaID);

    rmSetProgress(0.4);

    // Starting town centers.
    int startingTownCenterID = rmObjectDefCreate("starting town center");
    rmObjectDefAddItem(startingTownCenterID, cUnitTypeTownCenter, 1);
    rmObjectDefPlacePerPlayer(startingTownCenterID, true, 1);

    // Starting towers.
    int startingTowerID = rmObjectDefCreate("starting tower");
    rmObjectDefAddItem(startingTowerID, cUnitTypeSentryTower, 1);
    rmObjectDefAddConstraint(startingTowerID, vDefaultAvoidAll);
    addObjectLocsPerPlayer(startingTowerID, true, 4, cStartingTowerMinDist, cStartingTowerMaxDist, cStartingTowerAvoidanceMeters);
    generateLocations("starting tower locs");

    rmSetProgress(0.5);

    placeStartingStragglers(cUnitTypeTreePine);

    rmSetProgress(0.6);

    int startingGoldID = rmObjectDefCreate("starting gold");
    rmObjectDefAddItem(startingGoldID, cUnitTypeMineGoldLarge, 1);
    rmObjectDefAddConstraint(startingGoldID, vDefaultAvoidAll);
    rmObjectDefAddConstraint(startingGoldID, vDefaultAvoidEdge);
    rmObjectDefAddConstraint(startingGoldID, vDefaultAvoidImpassableLand10);
    rmObjectDefAddConstraint(startingGoldID, vDefaultStartingGoldAvoidTower);
    rmObjectDefAddConstraint(startingGoldID, vDefaultForceStartingGoldNearTower);
    addObjectLocsPerPlayer(startingGoldID, false, 1, cStartingGoldMinDist + 5,
                           cStartingGoldMaxDist, cStartingGoldAvoidanceMeters);

    generateLocations("starting gold locs");

    int startingHuntID = rmObjectDefCreate("starting hunt");
    if(xsRandBool(0.5))
    {
        rmObjectDefAddItem(startingHuntID, cUnitTypeGazelle, xsRandInt(8, 9));
    }
    else
    {
        rmObjectDefAddItem(startingHuntID, cUnitTypeZebra, xsRandInt(8, 9));
    }
    rmObjectDefAddConstraint(startingHuntID, vDefaultAvoidAll);
    rmObjectDefAddConstraint(startingHuntID, vDefaultAvoidEdge);
    rmObjectDefAddConstraint(startingHuntID, vDefaultAvoidImpassableLand5);
    rmObjectDefAddConstraint(startingHuntID, vDefaultForceInTowerLOS);
    rmObjectDefAddConstraint(startingHuntID, vDefaultFoodAvoidGold);
    addObjectLocsPerPlayer(startingHuntID, false, 1, cStartingHuntMinDist,
                           cStartingHuntMaxDist, cStartingObjectAvoidanceMeters);

    int startingBerriesID = rmObjectDefCreate("starting berries");
    rmObjectDefAddItem(startingBerriesID, cUnitTypeBerryBush, xsRandInt(6, 9), 5.0);
    rmObjectDefAddConstraint(startingBerriesID, vDefaultAvoidAll);
    rmObjectDefAddConstraint(startingBerriesID, vDefaultAvoidEdge);
    rmObjectDefAddConstraint(startingBerriesID, vDefaultAvoidImpassableLand5);
    rmObjectDefAddConstraint(startingBerriesID, vDefaultFoodAvoidGold);
    addObjectLocsPerPlayer(startingBerriesID, false, 1, cStartingBerriesMinDist,
                           cStartingBerriesMaxDist, cStartingObjectAvoidanceMeters);

    generateLocations("starting food locs");

    rmSetProgress(0.8);

    int plentyID = rmObjectDefCreate("middle plenty");
    rmObjectDefAddItem(plentyID, cUnitTypePlentyVaultKOTH, 1);
    rmObjectDefAddConstraint(plentyID, vDefaultAvoidAll);
    rmObjectDefAddConstraint(plentyID, vDefaultAvoidEdge);
    rmObjectDefAddConstraint(plentyID, vDefaultAvoidImpassableLand5);
    rmObjectDefPlaceAtLoc(plentyID, 0, mapLayout.center / mapLayout.sizeTiles);

    rmSetProgress(0.9);

    // Create the triggers (to forbid units etc.).
    createTriggers();

    rmSetProgress(1.0);
}

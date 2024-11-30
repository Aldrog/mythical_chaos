include "lib/core.xs";
include "lib/spawn_scheduler.xs";

extern const float cBuildingDistanceFromCenter = 20;
extern const float cSpawnDistanceFromCenter = cBuildingDistanceFromCenter + 1;

class MilitaryBuilding
{
    int unitID = -1;
    int side = 0;
    int lane = cLaneCW;
    bool built = false;

    void init(int _unitID = -1, int _side = 0, int _lane = cLaneCW)
    {
        unitID = _unitID;
        side = _side;
        lane = _lane;
    }

    void checkConstructionStatus()
    {
        trUnitSelectClear();
        trUnitSelectByID(unitID);
        if(!trUnitFullyBuilt())
            return;

        int schedIdx = side * cNumberLanes + lane;

        int player = kbUnitGetPlayerID(unitID);
        int cultureID = kbPlayerGetCulture(player);
        if(cultureID == cCultureGreek)
        {
            addUnitToScheduler(schedIdx, "Hoplite");
            addUnitToScheduler(schedIdx, "Hoplite");
            addUnitToScheduler(schedIdx, "Hoplite");
        }
        else if(cultureID == cCultureEgyptian)
        {
            addUnitToScheduler(schedIdx, "Spearman");
            addUnitToScheduler(schedIdx, "Spearman");
            addUnitToScheduler(schedIdx, "Spearman");
        }
        else if(cultureID == cCultureNorse)
        {
            addUnitToScheduler(schedIdx, "Hirdman");
            addUnitToScheduler(schedIdx, "Hirdman");
            addUnitToScheduler(schedIdx, "Hirdman");
        }
        else if(cultureID == cCultureAtlantean)
        {
            addUnitToScheduler(schedIdx, "Murmillo");
            addUnitToScheduler(schedIdx, "Murmillo");
            addUnitToScheduler(schedIdx, "Murmillo");
        }
        startSpawning(schedIdx, 30);
        built = true;
    }

    bool checkStatus()
    {
        trUnitSelectClear();
        trUnitSelectByID(unitID);
        if(trUnitDead()) // Building cancelled or destroyed
        {
            if(built)
            {
                stopSpawning(side * cNumberLanes + lane, true);
            }
            return false;
        }
        if(!built)
        {
            checkConstructionStatus();
            return true;
        }
        return true;
    }
};

MilitaryBuilding[] militaryBuildings = default;

void checkBuildingsStatuses()
{
    for (int i = 0; i < militaryBuildings.size(); i++)
    {
        MilitaryBuilding building = militaryBuildings[i];
        bool buildingIsValid = building.checkStatus();
        if(buildingIsValid)
        {
            militaryBuildings[i] = building;
        }
        else
        {
            militaryBuildings[i] = militaryBuildings[militaryBuildings.size() - 1];
            militaryBuildings.resize(militaryBuildings.size() - 1);
            i--;
        }
    }
}

void checkRecentUnits()
{
    int[] recentUnits = trGetRecentUnits();
    for(int i = 0; i < recentUnits.size(); i++)
    {
        int unitID = recentUnits[i];
        int protounitID = kbUnitGetProtoUnitID(unitID);
        if(protounitID == cUnitTypeBarracks ||
           protounitID == cUnitTypeLonghouse ||
           protounitID == cUnitTypeMilitaryAcademy ||
           protounitID == cUnitTypeMilitaryBarracks)
        {
            int player = kbUnitGetPlayerID(unitID);
            vector buildPosition = kbUnitGetPosition(unitID);

            int side = getPlayerSide(player);
            int targetLane = mapLayout.closestLane(side, buildPosition);
            vector targetPos = mapLayout.pointOnLane(side, targetLane,
                                                     cBuildingDistanceFromCenter);

            trUnitSelectClear();
            trUnitSelectByID(unitID);
            trUnitReposition(targetPos.x, targetPos.y, targetPos.z);

            MilitaryBuilding building;
            building.init(unitID, side, targetLane);
            militaryBuildings.add(building);
        }
    }
}

rule _Place_Military_Buildings
highFrequency
active
{
    checkBuildingsStatuses();
    checkRecentUnits();
}

rule _Init_Schedulers
highFrequency
active
{
    spawnSchedulers.resize(cNumberPlayers * cNumberLanes);
    for(int p = 1; p <= cNumberPlayers; p++)
    {
        int side = getPlayerSide(p);
        for(int lane = 0; lane < cNumberLanes; lane++)
        {
            LaneSpawnScheduler sched;
            sched.init(p, mapLayout.pointOnLane(side, lane, cSpawnDistanceFromCenter));
            spawnSchedulers[side * cNumberLanes + lane] = sched;
        }
    }
    xsDisableSelf();
}

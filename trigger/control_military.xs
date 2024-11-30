include "lib/core.xs";
include "lib/military.xs";

class Army
{
    vector[] attackRoute = default;
    int routeIndex = 0;
    int[] unitIDs = default;
    int player = 0;

    void selectUnits()
    {
        trUnitSelectClear();
        for(int i = 0; i < unitIDs.size(); i++)
        {
            trUnitSelectByID(unitIDs[i]);
        }
    }

    void attack()
    {
        selectUnits();
        vector attackTarget = attackRoute[routeIndex % attackRoute.size()];
        trUnitMoveToPoint(attackTarget.x, attackTarget.y, attackTarget.z,
                          -1, true);
        float cSwitchWaypointThreshold = 10;
        float distanceToWaypoint = trUnitDistanceToPoint(attackTarget.x,
                                                         attackTarget.y,
                                                         attackTarget.z);
        if(distanceToWaypoint <= cSwitchWaypointThreshold)
        {
            routeIndex++;
        }
    }

    int removeUnit(int i = 0)
    {
        unitIDs[i] = unitIDs[unitIDs.size() - 1];
        unitIDs.resize(unitIDs.size() - 1, 0);
        return i - 1;
    }
};

Army[] armies = default;

int removeArmy(int i = 0)
{
    armies[i] = armies[armies.size() - 1];
    armies.resize(armies.size() - 1);
    return i - 1;
}

void removeInvalidUnits()
{
    for(int i = 0; i < armies.size(); i++)
    {
        Army army = armies[i];
        for(int j = 0; j < army.unitIDs.size(); j++)
        {
            int unitID = army.unitIDs[j];
            xsSetContextPlayer(army.player);
            bool valid = kbUnitGetIsIDValid(unitID, false);
            xsSetContextPlayer();
            if(!valid)
            {
                j = army.removeUnit(j);
            }
        }
        if(army.unitIDs.size() == 0)
        {
            i = removeArmy(i);
        }
        else
        {
            armies[i] = army;
        }
    }
}

void mergeNearbyArmies()
{
    const float cDistanceThreshold = 15;
    for(int i = 0; i < armies.size() - 1; i++)
    {
        Army army1 = armies[i];
        army1.selectUnits();
        for(int j = i + 1; j < armies.size(); j++)
        {
            Army army2 = armies[j];
            if(army1.player != army2.player)
                continue;
            if(trUnitDistanceToUnitID(army2.unitIDs[0]) > cDistanceThreshold)
                continue;
            if(army1.routeIndex <= army2.routeIndex)
            {
                for(int k = 0; k < army2.unitIDs.size(); k++)
                {
                    army1.unitIDs.add(army2.unitIDs[k]);
                }
            }
            else
            {
                for(int k = 0; k < army1.unitIDs.size(); k++)
                {
                    army2.unitIDs.add(army1.unitIDs[k]);
                }
                army1 = army2;
            }
            j = removeArmy(j);
        }
        armies[i] = army1;
    }
}

rule _Control_Military
minInterval 2
maxInterval 5
active
{
    removeInvalidUnits();
    mergeNearbyArmies();
    for(int i = 1; i <= cNumberPlayers; i++)
    {
        setCommandableMilitary(i, true);
    }
    for(int i = 0; i < armies.size(); i++)
    {
        Army army = armies[i];
        army.attack();
        armies[i] = army;
    }
    for(int i = 1; i <= cNumberPlayers; i++)
    {
        setCommandableMilitary(i, false);
    }
}

rule _Create_Armies
highFrequency
active
{
    int[] recentUnits = trGetRecentUnits();
    trResetRecentUnits();
    for(int i = 0; i < recentUnits.size(); i++)
    {
        int unitID = recentUnits[i];
        int player = kbUnitGetPlayerID(unitID);
        if(!isMilitary(unitID))
            continue;
        vector unitPosition = kbUnitGetPosition(unitID);

        int side = getPlayerSide(player);
        int lane = mapLayout.closestLane(side, unitPosition);
        Army army;
        army.attackRoute = mapLayout.makeRoute(side, lane);
        army.unitIDs = new int(1, unitID);
        army.player = player;
        armies.add(army);
    }
}

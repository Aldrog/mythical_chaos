#if (defined(MC_CORE) == false)
#define MC_CORE

extern const int cLaneCW = 0;
extern const int cLaneCounterCW = 1;
extern const int cLaneMiddle = 2;

extern const int cNumberLanes = 3;

class MapLayout
{
    vector[] outerWaypoints = default;
    vector[] innerWaypoints = default;
    float sizeTiles = 0;
    vector center = cOriginVector;

    void generateWaypointsGeneric(float laneLengthTiles = 1)
    {
        const float cOffsetFromCenterTiles = 20;

        const float cBaseAngleStep = 2.0 * cPi / cNumberPlayers;
        const float cIntermediateAngleStep = cPi * (1.0 - 2.0/cNumberPlayers);
        vector currentWaypoint = xsVectorCreate(laneLengthTiles, 0, 0);
        for(int side = 0; side < cNumberPlayers; side++)
        {
            outerWaypoints.add(currentWaypoint);
            innerWaypoints.add(xsVectorNormalize(currentWaypoint) * cOffsetFromCenterTiles);

            vector intermediateWaypoint = xsVectorRotateXZ(
                    cOriginVector, cIntermediateAngleStep, currentWaypoint
                );
            outerWaypoints.add(intermediateWaypoint);
            innerWaypoints.add(xsVectorNormalize(intermediateWaypoint) * cOffsetFromCenterTiles);
            currentWaypoint = xsVectorRotateXZ(currentWaypoint, -cBaseAngleStep);
        }
    }

    void generateWaypointsTwoPlayers(float laneLengthTiles = 1)
    {
        const float cOffsetFromCenterTiles = 20;

        vector currentWaypoint = xsVectorCreate(laneLengthTiles/sqrt(2), 0, laneLengthTiles/sqrt(2));
        outerWaypoints.add(currentWaypoint);
        innerWaypoints.add(xsVectorNormalize(currentWaypoint) * cOffsetFromCenterTiles);

        currentWaypoint = xsVectorCreate(laneLengthTiles/sqrt(2), 0, -laneLengthTiles/sqrt(2));
        outerWaypoints.add(currentWaypoint);
        innerWaypoints.add(xsVectorNormalize(currentWaypoint) * cOffsetFromCenterTiles);

        currentWaypoint = xsVectorCreate(-laneLengthTiles/sqrt(2), 0, -laneLengthTiles/sqrt(2));
        outerWaypoints.add(currentWaypoint);
        innerWaypoints.add(xsVectorNormalize(currentWaypoint) * cOffsetFromCenterTiles);

        currentWaypoint = xsVectorCreate(-laneLengthTiles/sqrt(2), 0, laneLengthTiles/sqrt(2));
        outerWaypoints.add(currentWaypoint);
        innerWaypoints.add(xsVectorNormalize(currentWaypoint) * cOffsetFromCenterTiles);
    }

    void init(float laneLengthTiles = 1)
    {
        outerWaypoints = new vector(0, cOriginVector);
        innerWaypoints = new vector(0, cOriginVector);

        if(cNumberPlayers == 2)
        {
            generateWaypointsTwoPlayers(laneLengthTiles);
        }
        else
        {
            generateWaypointsGeneric(laneLengthTiles);
        }

        float minX = 0;
        float maxX = 0;
        float minZ = 0;
        float maxZ = 0;
        for(int i = 0; i < outerWaypoints.size(); i++)
        {
            vector wp = outerWaypoints[i];
            if(wp.x < minX)
                minX = wp.x;
            if(wp.x > maxX)
                maxX = wp.x;
            if(wp.z < minZ)
                minZ = wp.z;
            if(wp.z > maxZ)
                maxZ = wp.z;
        }

        const float cOffsetFromBorderTiles = 40;
        sizeTiles = round(2*cOffsetFromBorderTiles + max(maxX - minX, maxZ - minZ));
        vector normalizationOffset = xsVectorCreate(
                cOffsetFromBorderTiles - minX, 0, cOffsetFromBorderTiles - minZ
            );
        center += normalizationOffset;
        for(int i = 0; i < outerWaypoints.size(); i++)
        {
            outerWaypoints[i] = outerWaypoints[i] + normalizationOffset;
        }
        for(int i = 0; i < innerWaypoints.size(); i++)
        {
            innerWaypoints[i] = innerWaypoints[i] + normalizationOffset;
        }
    }

    int outerIndex(int side = 0)
    {
        return side * 2;
    }

    int innerIndex(int side = 0)
    {
        return side * 2;
    }

    vector outerWaypoint(int side = 0)
    {
        return outerWaypoints[outerIndex(side)];
    }

    vector innerWaypoint(int side = 0)
    {
        return innerWaypoints[innerIndex(side)];
    }

    vector[] makeCWRoute(int side = 0)
    {
        vector[] route = new vector(0, cOriginVector);
        for(int i = outerIndex(side) + 1; i < outerWaypoints.size(); i++)
        {
            route.add(outerWaypoints[i]);
        }
        for(int i = 0; i <= outerIndex(side); i++)
        {
            route.add(outerWaypoints[i]);
        }
        return route;
    }

    vector[] makeCounterCWRoute(int side = 0)
    {
        vector[] route = new vector(0, cOriginVector);
        for(int i = outerIndex(side) - 1; i >= 0; i--)
        {
            route.add(outerWaypoints[i]);
        }
        for(int i = outerWaypoints.size() - 1; i >= outerIndex(side); i--)
        {
            route.add(outerWaypoints[i]);
        }
        return route;
    }

    vector[] makeMiddleRoute(int side = 0)
    {
        vector[] route = new vector(0, cOriginVector);
        for(int i = innerIndex(side); i < innerWaypoints.size(); i++)
        {
            route.add(innerWaypoints[i]);
        }
        for(int i = 0; i < innerIndex(side); i++)
        {
            route.add(innerWaypoints[i]);
        }
        int targetSide = side + cNumberPlayers/2;
        if(targetSide >= cNumberPlayers)
        {
            targetSide -= cNumberPlayers;
        }
        for(int i = innerIndex(side); i != innerIndex(targetSide); i++)
        {
            route.add(innerWaypoints[i]);
            if(i + 1 >= innerWaypoints.size())
                i -= innerWaypoints.size();
        }
        route.add(innerWaypoint(targetSide));
        for(int i = outerIndex(targetSide); i != outerIndex(side); i++)
        {
            route.add(outerWaypoints[i]);
            if(i + 1 >= outerWaypoints.size())
                i -= outerWaypoints.size();
        }
        route.add(outerWaypoint(side));
        return route;
    }

    vector[] makeRoute(int side = 0, int lane = cLaneCW)
    {
        if(lane == cLaneCW)
        {
            return makeCWRoute(side);
        }
        else if(lane == cLaneCounterCW)
        {
            return makeCounterCWRoute(side);
        }
        else if(lane == cLaneMiddle)
        {
            return makeMiddleRoute(side);
        }
        return new vector(0, cOriginVector);
    }

    vector directionCW(int side = 0)
    {
        int idx = outerIndex(side);
        int nextIdx = idx + 1;
        if(nextIdx >= outerWaypoints.size())
            nextIdx = 0;
        return xsVectorNormalize(outerWaypoints[nextIdx] - outerWaypoints[idx]);
    }

    vector directionCounterCW(int side = 0)
    {
        int idx = outerIndex(side);
        int nextIdx = idx - 1;
        if(nextIdx < 0)
            nextIdx = outerWaypoints.size() - 1;
        return xsVectorNormalize(outerWaypoints[nextIdx] - outerWaypoints[idx]);
    }

    vector directionMiddle(int side = 0)
    {
        return xsVectorNormalize(innerWaypoint(side) - outerWaypoint(side));
    }

    vector pointOnLane(int side = 0, int lane = cLaneCW, float distance = 1)
    {
        vector origin = outerWaypoint(side);
        if(lane == cLaneCW)
        {
            return origin + directionCW(side) * distance;
        }
        else if(lane == cLaneCounterCW)
        {
            return origin + directionCounterCW(side) * distance;
        }
        else if(lane == cLaneMiddle)
        {
            return origin + directionMiddle(side) * distance;
        }
        return cOriginVector;
    }

    int closestLane(int side = 0, vector position = cOriginVector)
    {
        vector origin = outerWaypoint(side);
        float CWDistance = xsVectorDistance(position, origin + directionCW(side));
        float counterCWDistance = xsVectorDistance(position, origin + directionCounterCW(side));
        float middleDistance = xsVectorDistance(position, origin + directionMiddle(side));
        float minDistance = CWDistance;
        int result = cLaneCW;
        if(counterCWDistance < minDistance)
        {
            minDistance = counterCWDistance;
            result = cLaneCounterCW;
        }
        if(middleDistance < minDistance)
        {
            minDistance = middleDistance;
            result = cLaneMiddle;
        }
        return result;
    }
};

extern MapLayout mapLayout;

extern int[] playerSides = default;

mutable int getPlayerSide(int player = 0)
{
    return playerSides[player - 1];
}

#endif

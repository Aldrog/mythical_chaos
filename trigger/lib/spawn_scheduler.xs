#if (defined(MC_SPAWN_SCHEDULER) == false)
#define MC_SPAWN_SCHEDULER

const int cIntervalStopped = -1;

class LaneSpawnScheduler
{
    int player = 0;

    int lastSpawnTimeS = 0;

    int spawnIntervalS = cIntervalStopped;
    int nextSpawnIntervalS = cIntervalStopped;

    vector location = cOriginVector;

    string[] units = default;

    void init(int spawnPlayer = 0, vector spawnLocation = cOriginVector)
    {
        player = spawnPlayer;
        location = spawnLocation;
        lastSpawnTimeS = xsGetTime();
        units = new string(0, "");
    }

    void run()
    {
        int time = xsGetTime();
        if(spawnIntervalS == cIntervalStopped)
        {
            spawnIntervalS = nextSpawnIntervalS;
            lastSpawnTimeS = time;
            return;
        }
        if(lastSpawnTimeS + spawnIntervalS > time)
            return;

        for(int i = 0; i < units.size(); i++)
        {
            trUnitCreate(units[i],
                         location.x, location.y, location.z,
                         0,
                         player);
        }
        lastSpawnTimeS = lastSpawnTimeS + spawnIntervalS;
        spawnIntervalS = nextSpawnIntervalS;
        if(spawnIntervalS == cIntervalStopped)
        {
            units = new string(0, "");
        }
    }

    void startSpawning(int intervalS = cIntervalStopped)
    {
        nextSpawnIntervalS = intervalS;
    }

    void stopSpawning(bool immediately = false)
    {
        nextSpawnIntervalS = cIntervalStopped;
        if(immediately)
        {
            spawnIntervalS = cIntervalStopped;
            units = new string(0, "");
        }
    }

    void addUnit(string protounit = "")
    {
        units.add(protounit);
    }
};

extern LaneSpawnScheduler[] spawnSchedulers = default;

void runSchedulers()
{
    for(int i = 0; i < spawnSchedulers.size(); i++)
    {
        LaneSpawnScheduler sched = spawnSchedulers[i];
        sched.run();
        spawnSchedulers[i] = sched;
    }
}

void startSpawning(int index = -1, int intervalS = cIntervalStopped)
{
    LaneSpawnScheduler sched = spawnSchedulers[index];
    sched.startSpawning(intervalS);
    spawnSchedulers[index] = sched;
}

void stopSpawning(int index = -1, bool immediately = false)
{
    LaneSpawnScheduler sched = spawnSchedulers[index];
    sched.stopSpawning(immediately);
    spawnSchedulers[index] = sched;
}

void addUnitToScheduler(int index = -1, string protounit = "")
{
    LaneSpawnScheduler sched = spawnSchedulers[index];
    sched.addUnit(protounit);
    spawnSchedulers[index] = sched;
}

#endif

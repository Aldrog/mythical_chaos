include "lib/core.xs";
include "lib/spawn_scheduler.xs";

rule _Spawn_Units
minInterval 1
maxInterval 1
active
{
    runSchedulers();
}

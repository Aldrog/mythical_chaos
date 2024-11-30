include "lib/tech_alloc.xs";
include "lib/core.xs";

int[] lastTechs = default;

rule _Test_Alloc
minInterval 1
maxInterval 1
active
{
    for(int p = 1; p <= cNumberPlayers; p++)
    {
        int techID = allocTech(p);
        trTechSetStringID(techID, p, "CustomTech");
        trTechSetStringID(techID, p, "CustomTech0", 0);
        trTechSetStringID(techID, p, "CustomTech1", 1);
        trTechSetStringID(techID, p, "CustomTech2", 2);
        trTechSetStringID(techID, p, "CustomTech3", 3);
        trTechSetStringID(techID, p, "CustomTech4", 4);
        trTechSetStringID(techID, p, "CustomTech5", 5);
        trTechSetStringID(techID, p, "CustomTech6", 6);
        trTechReplaceIconByTech(techID, p, cTechChampionCavalry);
        trTechSetStatus(p, techID, cTechStatusObtainable);
        trProtounitRemoveTech("TownCenter", p, lastTechs[p - 1]);
        trProtounitAddTech("TownCenter", p, techID, 1, 4);
        //trChatSend(p, "Tech " + techID + " added to TC");
        lastTechs[p - 1] = techID;
    }
}

rule _Test_Alloc_Init
highFrequency
active
runImmediately
{
    initTechAllocators();
    lastTechs = new int(cNumberPlayers, 0);
    xsDisableSelf();
}

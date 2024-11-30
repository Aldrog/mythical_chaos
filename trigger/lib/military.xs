#if (defined(MC_MILITARY) == false)
#define MC_MILITARY

mutable void setCommandableMilitary(int player = 0, bool commandable = true)
{
    trProtoUnitSetFlag(player, "LogicalTypeLandMilitary", "Commandable", commandable);
    trProtoUnitSetFlag(player, "AbstractScout", "Commandable", commandable);
    if(!commandable)
    {
        trProtoUnitSetFlag(player, "Pharaoh", "Commandable", true);
        trProtoUnitSetFlag(player, "ChampionOfFreyr", "Commandable", true);
    }
}

mutable bool isMilitary(int unitID = -1)
{
    int player = kbUnitGetPlayerID(unitID);
    xsSetContextPlayer(player);
    bool result = kbUnitIsType(unitID, cUnitTypeLogicalTypeLandMilitary)
              && (!kbUnitIsType(unitID, cUnitTypePharaoh))
              && (!kbUnitIsType(unitID, cUnitTypeChampionOfFreyr));
    xsSetContextPlayer();
    return result;
}

#endif

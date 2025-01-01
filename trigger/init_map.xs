include "lib/core.xs";
include "lib/military.xs";
include "lib/tech_alloc.xs";

void forbidBuildings(int player = 0)
{
    trForbidProtounit(player, "ArcheryRange");
    //trForbidProtounit(player, "Armory");
    //trForbidProtounit(player, "Barracks");
    trForbidProtounit(player, "CounterBarracks");
    trForbidProtounit(player, "Dock");
    //trForbidProtounit(player, "DwarvenArmory");
    //trForbidProtounit(player, "EconomicGuild");
    trForbidProtounit(player, "Fortress");
    //trForbidProtounit(player, "Granary");
    trForbidProtounit(player, "GreatHall");
    trForbidProtounit(player, "HillFort");
    //trForbidProtounit(player, "House");
    trForbidProtounit(player, "Lighthouse");
    //trForbidProtounit(player, "Longhouse");
    //trForbidProtounit(player, "LumberCamp");
    //trForbidProtounit(player, "Manor");
    trForbidProtounit(player, "Market");
    trForbidProtounit(player, "MigdolStronghold");
    //trForbidProtounit(player, "MilitaryAcademy");
    //trForbidProtounit(player, "MilitaryBarracks");
    //trForbidProtounit(player, "MiningCamp");
    trForbidProtounit(player, "MirrorTower");
    //trForbidProtounit(player, "MonumentToGods");
    //trForbidProtounit(player, "MonumentToPharaohs");
    //trForbidProtounit(player, "MonumentToPriests");
    //trForbidProtounit(player, "MonumentToSoldiers");
    //trForbidProtounit(player, "MonumentToVillagers");
    trForbidProtounit(player, "Obelisk");
    trForbidProtounit(player, "Palace");
    trForbidProtounit(player, "SentryTower");
    trForbidProtounit(player, "SiegeWorks");
    trForbidProtounit(player, "SkyPassage"); // TBD
    trForbidProtounit(player, "Stable");
    //trForbidProtounit(player, "Storehouse");
    //trForbidProtounit(player, "Temple");
    trForbidProtounit(player, "TownCenter");
    trForbidProtounit(player, "VillageCenter");

    trForbidProtounit(player, "WallConnector");
    trForbidProtounit(player, "WallGate");
    trForbidProtounit(player, "WallLong");
    trForbidProtounit(player, "WallMedium");
    trForbidProtounit(player, "WallShort");

    trForbidProtounit(player, "Wonder");
}

void setBuildingLimits(int player = 0)
{
    trModifyProtounitData("Armory", player, 11, 1, 1);
    trModifyProtounitData("DwarvenArmory", player, 11, 1, 1);
    trModifyProtounitData("EconomicGuild", player, 11, 1, 1);
    trModifyProtounitData("Granary", player, 11, 2, 1);
    trModifyProtounitData("House", player, 11, 2, 1);
    trModifyProtounitData("LumberCamp", player, 11, 1, 1);
    trModifyProtounitData("Manor", player, 11, 1, 1);
    trModifyProtounitData("MiningCamp", player, 11, 1, 1);
    trModifyProtounitData("Storehouse", player, 11, 2, 1);
    trModifyProtounitData("Temple", player, 11, 1, 1);

    trModifyProtounitData("Barracks", player, 11, 3, 1);
    trModifyProtounitData("Longhouse", player, 11, 3, 1);
    trModifyProtounitData("MilitaryAcademy", player, 11, 3, 1);
    trModifyProtounitData("MilitaryBarracks", player, 11, 3, 1);
}

void setTrainingOptions(int player = 0)
{
    int cultureID = kbPlayerGetCulture(player);
    if(cultureID == cCultureGreek)
    {
    }
    else if(cultureID == cCultureEgyptian)
    {
    }
    else if(cultureID == cCultureNorse)
    {
        trProtoUnitChangeName("ChampionOfFreyr", player, "Defender (Legend)");
        trModifyProtounitData("ChampionOfFreyr", player, 11, 1, 1);
        trUnforbidProtounit(player, "ChampionOfFreyr");
        trModifyProtounitResource("ChampionOfFreyr", "gold", player, 0, 3.0, 2);
        trModifyProtounitData("ChampionOfFreyr", player, 6, 0, 1);
        trModifyProtounitData("ChampionOfFreyr", player, 3, 61, 0);
        trModifyProtounitAction("ChampionOfFreyr", "HandAttack", player, 2, -8.0, 0);
        trProtounitAddTrain("TownCenter", player, "ChampionOfFreyr", 0, 3);
    }
    else if(cultureID == cCultureAtlantean)
    {
    }
}

void setPopulationCost(int player = 0)
{
    trModifyProtounitData("Achilles", player, 6, 0, 1);
    trModifyProtounitData("Ajax", player, 6, 0, 1);
    trModifyProtounitData("Anubite", player, 6, 0, 1);
    trModifyProtounitData("Arcus", player, 6, 0, 1);
    trModifyProtounitData("ArcusHero", player, 6, 0, 1);
    trModifyProtounitData("Argus", player, 6, 0, 1);
    trModifyProtounitData("Atalanta", player, 6, 0, 1);
    trModifyProtounitData("AurochsOfSet", player, 6, 0, 1);
    trModifyProtounitData("Automaton", player, 6, 0, 1);
    trModifyProtounitData("Avenger", player, 6, 0, 1);
    trModifyProtounitData("Axeman", player, 6, 0, 1);
    trModifyProtounitData("BaboonOfSet", player, 6, 0, 1);
    trModifyProtounitData("Ballista", player, 6, 0, 1);
    trModifyProtounitData("BattleBoar", player, 6, 0, 1);
    trModifyProtounitData("BearOfSet", player, 6, 0, 1);
    trModifyProtounitData("Behemoth", player, 6, 0, 1);
    trModifyProtounitData("Bellerophon", player, 6, 0, 1);
    trModifyProtounitData("Berserk", player, 6, 0, 1);
    trModifyProtounitData("BoarOfSet", player, 6, 0, 1);
    trModifyProtounitData("Caladria", player, 6, 0, 1);
    trModifyProtounitData("CamelRider", player, 6, 0, 1);
    trModifyProtounitData("CaribouOfSet", player, 6, 0, 1);
    trModifyProtounitData("Catapult", player, 6, 0, 1);
    trModifyProtounitData("Centaur", player, 6, 0, 1);
    trModifyProtounitData("Centimanus", player, 6, 0, 1);
    trModifyProtounitData("ChariotArcher", player, 6, 0, 1);
    trModifyProtounitData("Cheiroballista", player, 6, 0, 1);
    trModifyProtounitData("CheiroballistaHero", player, 6, 0, 1);
    trModifyProtounitData("ChickenOfSet", player, 6, 0, 1);
    trModifyProtounitData("Chimera", player, 6, 0, 1);
    trModifyProtounitData("Chiron", player, 6, 0, 1);
    trModifyProtounitData("Colossus", player, 6, 0, 1);
    trModifyProtounitData("Contarius", player, 6, 0, 1);
    trModifyProtounitData("ContariusHero", player, 6, 0, 1);
    trModifyProtounitData("CrocodileOfSet", player, 6, 0, 1);
    trModifyProtounitData("CrownedCraneOfSet", player, 6, 0, 1);
    trModifyProtounitData("Cyclops", player, 6, 0, 1);
    trModifyProtounitData("DeerOfSet", player, 6, 0, 1);
    trModifyProtounitData("Destroyer", player, 6, 0, 1);
    trModifyProtounitData("DestroyerHero", player, 6, 0, 1);
    trModifyProtounitData("Draugr", player, 6, 0, 1);
    trModifyProtounitData("Einheri", player, 6, 0, 1);
    trModifyProtounitData("ElephantOfSet", player, 6, 0, 1);
    trModifyProtounitData("ElkOfSet", player, 6, 0, 1);
    trModifyProtounitData("Fafnir", player, 6, 0, 1);
    trModifyProtounitData("Fanatic", player, 6, 0, 1);
    trModifyProtounitData("FanaticHero", player, 6, 0, 1);
    trModifyProtounitData("FenrisWolfBrood", player, 6, 0, 1);
    trModifyProtounitData("FireGiant", player, 6, 0, 1);
    trModifyProtounitData("FireSiphon", player, 6, 0, 1);
    trModifyProtounitData("FrostGiant", player, 6, 0, 1);
    trModifyProtounitData("Gastraphetoros", player, 6, 0, 1);
    trModifyProtounitData("GazelleOfSet", player, 6, 0, 1);
    trModifyProtounitData("GiraffeOfSet", player, 6, 0, 1);
    trModifyProtounitData("Godi", player, 6, 0, 1);
    trModifyProtounitData("HadesShade", player, 6, 0, 1);
    trModifyProtounitData("Helepolis", player, 6, 0, 1);
    trModifyProtounitData("Heracles", player, 6, 0, 1);
    trModifyProtounitData("Hersir", player, 6, 0, 1);
    trModifyProtounitData("Hetairos", player, 6, 0, 1);
    trModifyProtounitData("Hippeus", player, 6, 0, 1);
    trModifyProtounitData("Hippolyta", player, 6, 0, 1);
    trModifyProtounitData("Hirdman", player, 6, 0, 1);
    trModifyProtounitData("Hoplite", player, 6, 0, 1);
    trModifyProtounitData("Huskarl", player, 6, 0, 1);
    trModifyProtounitData("Hydra", player, 6, 0, 1);
    trModifyProtounitData("HyenaOfSet", player, 6, 0, 1);
    trModifyProtounitData("Hypaspist", player, 6, 0, 1);
    trModifyProtounitData("Jarl", player, 6, 0, 1);
    trModifyProtounitData("Jason", player, 6, 0, 1);
    trModifyProtounitData("Katapeltes", player, 6, 0, 1);
    trModifyProtounitData("KatapeltesHero", player, 6, 0, 1);
    trModifyProtounitData("Kataskopos", player, 6, 0, 1);
    trModifyProtounitData("Lampades", player, 6, 0, 1);
    trModifyProtounitData("LionOfSet", player, 6, 0, 1);
    trModifyProtounitData("Manticore", player, 6, 0, 1);
    trModifyProtounitData("Medusa", player, 6, 0, 1);
    trModifyProtounitData("Militia", player, 6, 0, 1);
    trModifyProtounitData("Minotaur", player, 6, 0, 1);
    trModifyProtounitData("MonkeyOfSet", player, 6, 0, 1);
    trModifyProtounitData("MountainGiant", player, 6, 0, 1);
    trModifyProtounitData("Mummy", player, 6, 0, 1);
    trModifyProtounitData("Murmillo", player, 6, 0, 1);
    trModifyProtounitData("MurmilloHero", player, 6, 0, 1);
    trModifyProtounitData("Myrmidon", player, 6, 0, 1);
    trModifyProtounitData("NemeanLion", player, 6, 0, 1);
    trModifyProtounitData("Odysseus", player, 6, 0, 1);
    trModifyProtounitData("Oracle", player, 6, 0, 1);
    trModifyProtounitData("OracleHero", player, 6, 0, 1);
    trModifyProtounitData("Pegasus", player, 6, 0, 1);
    trModifyProtounitData("Peltast", player, 6, 0, 1);
    trModifyProtounitData("Perseus", player, 6, 0, 1);
    trModifyProtounitData("Petrobolos", player, 6, 0, 1);
    trModifyProtounitData("Petsuchos", player, 6, 0, 1);
    trModifyProtounitData("Phoenix", player, 6, 0, 1);
    trModifyProtounitData("PhoenixFromEgg", player, 6, 0, 1);
    trModifyProtounitData("PolarBearOfSet", player, 6, 0, 1);
    trModifyProtounitData("Polyphemus", player, 6, 0, 1);
    trModifyProtounitData("PortableRam", player, 6, 0, 1);
    trModifyProtounitData("Priest", player, 6, 0, 1);
    trModifyProtounitData("Prodromos", player, 6, 0, 1);
    trModifyProtounitData("Promethean", player, 6, 0, 1);
    trModifyProtounitData("PrometheanOffspring", player, 6, 0, 1);
    trModifyProtounitData("RaidingCavalry", player, 6, 0, 1);
    trModifyProtounitData("RelicGoldenLion", player, 6, 0, 1);
    trModifyProtounitData("RelicMonkey", player, 6, 0, 1);
    trModifyProtounitData("RhinocerosOfSet", player, 6, 0, 1);
    trModifyProtounitData("Roc", player, 6, 0, 1);
    trModifyProtounitData("Satyr", player, 6, 0, 1);
    trModifyProtounitData("Scarab", player, 6, 0, 1);
    trModifyProtounitData("ScorpionMan", player, 6, 0, 1);
    trModifyProtounitData("Slinger", player, 6, 0, 1);
    trModifyProtounitData("SonOfOsiris", player, 6, 0, 1);
    trModifyProtounitData("Spearman", player, 6, 0, 1);
    trModifyProtounitData("Sphinx", player, 6, 0, 1);
    trModifyProtounitData("StymphalianBird", player, 6, 0, 1);
    trModifyProtounitData("Theseus", player, 6, 0, 1);
    trModifyProtounitData("ThrowingAxeman", player, 6, 0, 1);
    trModifyProtounitData("Toxotes", player, 6, 0, 1);
    trModifyProtounitData("Troll", player, 6, 0, 1);
    trModifyProtounitData("Turma", player, 6, 0, 1);
    trModifyProtounitData("TurmaHero", player, 6, 0, 1);
    trModifyProtounitData("Valkyrie", player, 6, 0, 1);
    trModifyProtounitData("Wadjet", player, 6, 0, 1);
    trModifyProtounitData("WalrusOfSet", player, 6, 0, 1);
    trModifyProtounitData("WarElephant", player, 6, 0, 1);
    trModifyProtounitData("WolfOfSet", player, 6, 0, 1);
    trModifyProtounitData("ZebraOfSet", player, 6, 0, 1);
}

void disableMillitaryCommands(int player = 0)
{
    setCommandableMilitary(player, false);
    trProtoUnitSetFlag(player, "LogicalTypeMilitaryProductionBuilding", "HasGatherPoint", false);
}

void setupResources()
{
    trModifyProtounitResource("MineGoldLarge", "gold", 0, 1, 100000, 1);
    trModifyProtounitResource("MineGoldLarge", "gold", 0, 2, 100000, 1);
    trModifyProtounitResource("TreePine", "wood", 0, 2, 1000, 1);
}

void setRules(int player = 0)
{
    setTrainingOptions(player);
    forbidBuildings(player);
    setBuildingLimits(player);
    disableMillitaryCommands(player);
    setPopulationCost(player);
}

rule _Init_Map
highFrequency
active
{
    setupResources();
    for(int i = 1; i <= cNumberPlayers; i++)
    {
        setRules(i);
    }
    initTechAllocators();
    trSetAutoResetRecentUnits(false);
    xsDisableSelf();
}

rule _Post_Init
highFrequency
active
{
    for(int player = 1; player <= cNumberPlayers; player++)
    {
        int cultureID = kbPlayerGetCulture(player);
        if(cultureID == cCultureNorse)
        {
            vector center = mapLayout.outerWaypoint(getPlayerSide(player));
            trUnitCreate("ChampionOfFreyr", center.x, center.y, center.z, 0, player);
        }
    }
    xsDisableSelf();
}

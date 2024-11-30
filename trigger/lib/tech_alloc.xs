#if (defined(MC_TECH_ALLOC) == false)
#define MC_TECH_ALLOC

class TechAllocator
{
    int[] allocatableTechs = default;
    string[] techNames = default;
    int allocatedCount = 0;

    int alloc()
    {
        int idx = allocatedCount;
        allocatedCount += 1;
        return allocatableTechs[idx];
    }

    void init(int culture = 0)
    {
        allocatableTechs = new int(0, 0);
        techNames = new string(0, "");

        // sea techs
        allocatableTechs.add(cTechArgonauts);
        allocatableTechs.add(cTechConscriptSailors);
        allocatableTechs.add(cTechEnclosedDeck);
        allocatableTechs.add(cTechHeavyWarships);
        allocatableTechs.add(cTechHeroicFleet);
        allocatableTechs.add(cTechPurseSeine);

        allocatableTechs.add(cTechCoinage);

        // Techs from other civs
        if(culture != cCultureGreek)
        {
            allocatableTechs.add(cTechAegisShield);
            allocatableTechs.add(cTechAnastrophe);
            allocatableTechs.add(cTechArgivePatronage);
            allocatableTechs.add(cTechChthonicRites);
            allocatableTechs.add(cTechDeimosSwordOfDread);
            allocatableTechs.add(cTechDionysia);
            allocatableTechs.add(cTechEnyosBowOfHorror);
            allocatableTechs.add(cTechFaceOfTheGorgon);
            allocatableTechs.add(cTechFlamesOfTyphon);
            allocatableTechs.add(cTechForgeOfOlympus);
            allocatableTechs.add(cTechHandOfTalos);
            allocatableTechs.add(cTechLabyrinthOfMinos);
            allocatableTechs.add(cTechLevyCavalry);
            allocatableTechs.add(cTechLevyInfantry);
            allocatableTechs.add(cTechLevyRangedSoldiers);
            allocatableTechs.add(cTechLordOfHorses);
            allocatableTechs.add(cTechMonstrousRage);
            allocatableTechs.add(cTechOlympianParentage);
            allocatableTechs.add(cTechOracle);
            allocatableTechs.add(cTechPhobosSpearOfPanic);
            allocatableTechs.add(cTechRoarOfOrthus);
            allocatableTechs.add(cTechSarissa);
            allocatableTechs.add(cTechShaftsOfPlague);
            allocatableTechs.add(cTechSpiritedCharge);
            allocatableTechs.add(cTechSunRay);
            allocatableTechs.add(cTechSylvanLore);
            allocatableTechs.add(cTechTempleOfHealing);
            allocatableTechs.add(cTechThracianHorses);
            allocatableTechs.add(cTechVaultsOfErebus);
            allocatableTechs.add(cTechWillOfKronos);
            allocatableTechs.add(cTechWingedMessenger);
        }
        if(culture != cCultureEgyptian)
        {
            allocatableTechs.add(cTechAdzeOfWepwawet);
            allocatableTechs.add(cTechAtefCrown);
            allocatableTechs.add(cTechAxeOfVengeance);
            allocatableTechs.add(cTechBoneBow);
            allocatableTechs.add(cTechClairvoyance);
            allocatableTechs.add(cTechCrimsonLinen);
            allocatableTechs.add(cTechCriosphinx);
            allocatableTechs.add(cTechCrocodilopolis);
            allocatableTechs.add(cTechDarkWater);
            allocatableTechs.add(cTechDesertWind);
            allocatableTechs.add(cTechElectrumBullets);
            allocatableTechs.add(cTechFeetOfTheJackal);
            allocatableTechs.add(cTechFloodOfTheNile);
            allocatableTechs.add(cTechFuneralBarge);
            allocatableTechs.add(cTechGreatestOfFifty);
            allocatableTechs.add(cTechHandsOfThePharaoh);
            allocatableTechs.add(cTechLeatherFrameShield);
            allocatableTechs.add(cTechLevyBarracksSoldiers);
            allocatableTechs.add(cTechLevyMigdolSoldiers);
            allocatableTechs.add(cTechMediumAxemen);
            allocatableTechs.add(cTechMediumCamelRiders);
            allocatableTechs.add(cTechMediumChariotArchers);
            allocatableTechs.add(cTechMediumSlingers);
            allocatableTechs.add(cTechMediumSpearmen);
            allocatableTechs.add(cTechMediumWarElephants);
            allocatableTechs.add(cTechNecropolis);
            allocatableTechs.add(cTechSacredCats);
            allocatableTechs.add(cTechScallopedAxe);
            allocatableTechs.add(cTechSerpentSpear);
            allocatableTechs.add(cTechShaduf);
            allocatableTechs.add(cTechSlingsOfTheSun);
            allocatableTechs.add(cTechSolarBarque);
            allocatableTechs.add(cTechSpearOfHorus);
            allocatableTechs.add(cTechTusksOfApedemak);
            allocatableTechs.add(cTechValleyOfTheKings);
        }
        if(culture != cCultureNorse)
        {
            allocatableTechs.add(cTechArcticWinds);
            allocatableTechs.add(cTechAvengingSpirit);
            allocatableTechs.add(cTechBerserkergang);
            allocatableTechs.add(cTechBravery);
            allocatableTechs.add(cTechCallOfValhalla);
            allocatableTechs.add(cTechCaveTroll);
            allocatableTechs.add(cTechDisablot);
            allocatableTechs.add(cTechDwarvenAuger);
            allocatableTechs.add(cTechDwarvenBreastplate);
            allocatableTechs.add(cTechEyesInTheForest);
            allocatableTechs.add(cTechFeastsOfRenown);
            allocatableTechs.add(cTechFuryOfTheFallen);
            allocatableTechs.add(cTechGjallarhorn);
            allocatableTechs.add(cTechGraniteBlood);
            allocatableTechs.add(cTechGraniteMaw);
            allocatableTechs.add(cTechGraspOfRan);
            allocatableTechs.add(cTechHallOfThanes);
            allocatableTechs.add(cTechHamask);
            allocatableTechs.add(cTechHammerOfThunder);
            allocatableTechs.add(cTechJotuns);
            allocatableTechs.add(cTechLevyGreatHallSoldiers);
            allocatableTechs.add(cTechLevyHillFortSoldiers);
            allocatableTechs.add(cTechLevyLonghouseSoldiers);
            allocatableTechs.add(cTechLongSerpent);
            allocatableTechs.add(cTechNineWaves);
            allocatableTechs.add(cTechRampage);
            allocatableTechs.add(cTechRime);
            allocatableTechs.add(cTechRingGiver);
            allocatableTechs.add(cTechSafeguard);
            allocatableTechs.add(cTechServantsOfGlory);
            allocatableTechs.add(cTechSessrumnir);
            allocatableTechs.add(cTechSilentResolve);
            allocatableTechs.add(cTechSonsOfSleipnir);
            allocatableTechs.add(cTechSwineArray);
            allocatableTechs.add(cTechThunderingHooves);
            allocatableTechs.add(cTechThurisazRune);
            allocatableTechs.add(cTechTwilightOfTheGods);
            allocatableTechs.add(cTechValgaldr);
            allocatableTechs.add(cTechVikings);
            allocatableTechs.add(cTechWinterHarvest);
            allocatableTechs.add(cTechWrathOfTheDeep);
            allocatableTechs.add(cTechYdalir);
        }
        if(culture != cCultureAtlantean)
        {
            allocatableTechs.add(cTechAlluvialClay);
            allocatableTechs.add(cTechArcusToHero);
            allocatableTechs.add(cTechAsperBlood);
            allocatableTechs.add(cTechBiteOfTheShark);
            allocatableTechs.add(cTechCelerity);
            allocatableTechs.add(cTechContariusToHero);
            allocatableTechs.add(cTechDaktyloi);
            allocatableTechs.add(cTechDaughtersOfTheSea);
            allocatableTechs.add(cTechDestroyerToHero);
            allocatableTechs.add(cTechDevoteesOfAtlas);
            allocatableTechs.add(cTechEmpyreanSpeed);
            allocatableTechs.add(cTechFanaticToHero);
            allocatableTechs.add(cTechFrontlineHeroics);
            allocatableTechs.add(cTechGemini);
            allocatableTechs.add(cTechGuardianOfIo);
            allocatableTechs.add(cTechHaloOfTheSun);
            allocatableTechs.add(cTechHeartOfTheTitans);
            allocatableTechs.add(cTechHephaestusRevenge);
            allocatableTechs.add(cTechHeroicRenewal);
            allocatableTechs.add(cTechKatapeltesToHero);
            allocatableTechs.add(cTechLanceOfStone);
            allocatableTechs.add(cTechLevyCounterSoldiers);
            allocatableTechs.add(cTechLevyMainlineSoldiers);
            allocatableTechs.add(cTechLevyPalaceSoldiers);
            allocatableTechs.add(cTechMurmilloToHero);
            allocatableTechs.add(cTechMythicRejuvenation);
            allocatableTechs.add(cTechOracleToHero);
            allocatableTechs.add(cTechOrichalcumMail);
            allocatableTechs.add(cTechOsmiumArmor);
            allocatableTechs.add(cTechPerception);
            allocatableTechs.add(cTechPetrification);
            allocatableTechs.add(cTechPioneerOfTheSkies);
            allocatableTechs.add(cTechPoseidonsSecret);
            allocatableTechs.add(cTechPropheticSight);
            //allocatableTechs.add(cTechRheiasGift); // looks weird
            allocatableTechs.add(cTechSonsOfTheSun);
            allocatableTechs.add(cTechTemporalChaos);
            allocatableTechs.add(cTechTheftOfFire);
            allocatableTechs.add(cTechTitanomachy);
            allocatableTechs.add(cTechTitanShield);
            allocatableTechs.add(cTechTurmaToHero);
            allocatableTechs.add(cTechVolcanicForge);
            allocatableTechs.add(cTechWeightlessMace);
        }

        // sea techs
        techNames.add("Argonauts");
        techNames.add("ConscriptSailors");
        techNames.add("EnclosedDeck");
        techNames.add("HeavyWarships");
        techNames.add("HeroicFleet");
        techNames.add("PurseSeine");

        techNames.add("Coinage");

        // Techs from other civs
        if(culture != cCultureGreek)
        {
            techNames.add("AegisShield");
            techNames.add("Anastrophe");
            techNames.add("ArgivePatronage");
            techNames.add("ChthonicRites");
            techNames.add("DeimosSwordOfDread");
            techNames.add("Dionysia");
            techNames.add("EnyosBowOfHorror");
            techNames.add("FaceOfTheGorgon");
            techNames.add("FlamesOfTyphon");
            techNames.add("ForgeOfOlympus");
            techNames.add("HandOfTalos");
            techNames.add("LabyrinthOfMinos");
            techNames.add("LevyCavalry");
            techNames.add("LevyInfantry");
            techNames.add("LevyRangedSoldiers");
            techNames.add("LordOfHorses");
            techNames.add("MonstrousRage");
            techNames.add("OlympianParentage");
            techNames.add("Oracle");
            techNames.add("PhobosSpearOfPanic");
            techNames.add("RoarOfOrthus");
            techNames.add("Sarissa");
            techNames.add("ShaftsOfPlague");
            techNames.add("SpiritedCharge");
            techNames.add("SunRay");
            techNames.add("SylvanLore");
            techNames.add("TempleOfHealing");
            techNames.add("ThracianHorses");
            techNames.add("VaultsOfErebus");
            techNames.add("WillOfKronos");
            techNames.add("WingedMessenger");
        }
        if(culture != cCultureEgyptian)
        {
            techNames.add("AdzeOfWepwawet");
            techNames.add("AtefCrown");
            techNames.add("AxeOfVengeance");
            techNames.add("BoneBow");
            techNames.add("Clairvoyance");
            techNames.add("CrimsonLinen");
            techNames.add("Criosphinx");
            techNames.add("Crocodilopolis");
            techNames.add("DarkWater");
            techNames.add("DesertWind");
            techNames.add("ElectrumBullets");
            techNames.add("FeetOfTheJackal");
            techNames.add("FloodOfTheNile");
            techNames.add("FuneralBarge");
            techNames.add("GreatestOfFifty");
            techNames.add("HandsOfThePharaoh");
            techNames.add("LeatherFrameShield");
            techNames.add("LevyBarracksSoldiers");
            techNames.add("LevyMigdolSoldiers");
            techNames.add("MediumAxemen");
            techNames.add("MediumCamelRiders");
            techNames.add("MediumChariotArchers");
            techNames.add("MediumSlingers");
            techNames.add("MediumSpearmen");
            techNames.add("MediumWarElephants");
            techNames.add("Necropolis");
            techNames.add("SacredCats");
            techNames.add("ScallopedAxe");
            techNames.add("SerpentSpear");
            techNames.add("Shaduf");
            techNames.add("SlingsOfTheSun");
            techNames.add("SolarBarque");
            techNames.add("SpearOfHorus");
            techNames.add("TusksOfApedemak");
            techNames.add("ValleyOfTheKings");
        }
        if(culture != cCultureNorse)
        {
            techNames.add("ArcticWinds");
            techNames.add("AvengingSpirit");
            techNames.add("Berserkergang");
            techNames.add("Bravery");
            techNames.add("CallOfValhalla");
            techNames.add("CaveTroll");
            techNames.add("Disablot");
            techNames.add("DwarvenAuger");
            techNames.add("DwarvenBreastplate");
            techNames.add("EyesInTheForest");
            techNames.add("FeastsOfRenown");
            techNames.add("FuryOfTheFallen");
            techNames.add("Gjallarhorn");
            techNames.add("GraniteBlood");
            techNames.add("GraniteMaw");
            techNames.add("GraspOfRan");
            techNames.add("HallOfThanes");
            techNames.add("Hamask");
            techNames.add("HammerOfThunder");
            techNames.add("Jotuns");
            techNames.add("LevyGreatHallSoldiers");
            techNames.add("LevyHillFortSoldiers");
            techNames.add("LevyLonghouseSoldiers");
            techNames.add("LongSerpent");
            techNames.add("NineWaves");
            techNames.add("Rampage");
            techNames.add("Rime");
            techNames.add("RingGiver");
            techNames.add("Safeguard");
            techNames.add("ServantsOfGlory");
            techNames.add("Sessrumnir");
            techNames.add("SilentResolve");
            techNames.add("SonsOfSleipnir");
            techNames.add("SwineArray");
            techNames.add("ThunderingHooves");
            techNames.add("ThurisazRune");
            techNames.add("TwilightOfTheGods");
            techNames.add("Valgaldr");
            techNames.add("Vikings");
            techNames.add("WinterHarvest");
            techNames.add("WrathOfTheDeep");
            techNames.add("Ydalir");
        }
        if(culture != cCultureAtlantean)
        {
            techNames.add("AlluvialClay");
            techNames.add("ArcusToHero");
            techNames.add("AsperBlood");
            techNames.add("BiteOfTheShark");
            techNames.add("Celerity");
            techNames.add("ContariusToHero");
            techNames.add("Daktyloi");
            techNames.add("DaughtersOfTheSea");
            techNames.add("DestroyerToHero");
            techNames.add("DevoteesOfAtlas");
            techNames.add("EmpyreanSpeed");
            techNames.add("FanaticToHero");
            techNames.add("FrontlineHeroics");
            techNames.add("Gemini");
            techNames.add("GuardianOfIo");
            techNames.add("HaloOfTheSun");
            techNames.add("HeartOfTheTitans");
            techNames.add("HephaestusRevenge");
            techNames.add("HeroicRenewal");
            techNames.add("KatapeltesToHero");
            techNames.add("LanceOfStone");
            techNames.add("LevyCounterSoldiers");
            techNames.add("LevyMainlineSoldiers");
            techNames.add("LevyPalaceSoldiers");
            techNames.add("MurmilloToHero");
            techNames.add("MythicRejuvenation");
            techNames.add("OracleToHero");
            techNames.add("OrichalcumMail");
            techNames.add("OsmiumArmor");
            techNames.add("Perception");
            techNames.add("Petrification");
            techNames.add("PioneerOfTheSkies");
            techNames.add("PoseidonsSecret");
            techNames.add("PropheticSight");
            //techNames.add("RheiasGift");
            techNames.add("SonsOfTheSun");
            techNames.add("TemporalChaos");
            techNames.add("TheftOfFire");
            techNames.add("Titanomachy");
            techNames.add("TitanShield");
            techNames.add("TurmaToHero");
            techNames.add("VolcanicForge");
            techNames.add("WeightlessMace");
        }
    }
};

extern TechAllocator[] playerTechAllocators = default;

void initTechAllocators()
{
    for(int p = 1; p <= cNumberPlayers; p++)
    {
        TechAllocator alloc;
        alloc.init(kbPlayerGetCulture(p));
        playerTechAllocators.add(alloc);
    }
}

int allocTech(int player = 0)
{
    TechAllocator allocator = playerTechAllocators[player - 1];
    if (player == 1)
        trChatSend(player, "Allocated tech " + allocator.techNames[allocator.allocatedCount]);
    int techID = allocator.alloc();
    playerTechAllocators[player - 1] = allocator;
    return techID;
}

#endif

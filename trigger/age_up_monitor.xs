int[] playerAges = default;

int getPlayerAge(int player = 0)
{
    return playerAges[player - 1];
}

void incrementPlayerAge(int player = 0)
{
    int age = playerAges[player - 1];
    playerAges[player - 1] = age + 1;
}

void checkAgeUpStatus(int player = 0)
{
    int cultureID = kbPlayerGetCulture(player);
    int age = getPlayerAge(player);
    if(cultureID == cCultureGreek)
    {
        if(age == 1)
        {
            if(trTechStatusActive(player, cTechClassicalAgeAthena) ||
               trTechStatusActive(player, cTechClassicalAgeHermes) ||
               trTechStatusActive(player, cTechClassicalAgeAres))
            {
                incrementPlayerAge(player);
            }
        }
        else if(age == 2)
        {
            if(trTechStatusActive(player, cTechHeroicAgeApollo) ||
               trTechStatusActive(player, cTechHeroicAgeDionysus) ||
               trTechStatusActive(player, cTechHeroicAgeAphrodite))
            {
                incrementPlayerAge(player);
            }
        }
        else if(age == 3)
        {
            if(trTechStatusActive(player, cTechMythicAgeHephaestus) ||
               trTechStatusActive(player, cTechMythicAgeHera) ||
               trTechStatusActive(player, cTechMythicAgeArtemis))
            {
                incrementPlayerAge(player);
            }
        }
    }
    else if(cultureID == cCultureEgyptian)
    {
        if(age == 1)
        {
            if(trTechStatusActive(player, cTechClassicalAgeBast) ||
               trTechStatusActive(player, cTechClassicalAgePtah) ||
               trTechStatusActive(player, cTechClassicalAgeAnubis))
            {
                incrementPlayerAge(player);
            }
        }
        else if(age == 2)
        {
            if(trTechStatusActive(player, cTechHeroicAgeSobek) ||
               trTechStatusActive(player, cTechHeroicAgeSekhmet) ||
               trTechStatusActive(player, cTechHeroicAgeNephthys))
            {
                incrementPlayerAge(player);
            }
        }
        else if(age == 3)
        {
            if(trTechStatusActive(player, cTechMythicAgeOsiris) ||
               trTechStatusActive(player, cTechMythicAgeHorus) ||
               trTechStatusActive(player, cTechMythicAgeThoth))
            {
                incrementPlayerAge(player);
            }
        }
    }
    else if(cultureID == cCultureNorse)
    {
        if(age == 1)
        {
            if(trTechStatusActive(player, cTechClassicalAgeFreyja) ||
               trTechStatusActive(player, cTechClassicalAgeForseti) ||
               trTechStatusActive(player, cTechClassicalAgeHeimdall) ||
               trTechStatusActive(player, cTechClassicalAgeUllr))
            {
                incrementPlayerAge(player);
                trModifyProtounitAction("ChampionOfFreyr", "HandAttack", player, 2, 8.0, 0);
            }
        }
        else if(age == 2)
        {
            if(trTechStatusActive(player, cTechHeroicAgeSkadi) ||
               trTechStatusActive(player, cTechHeroicAgeBragi) ||
               trTechStatusActive(player, cTechHeroicAgeNjord) ||
               trTechStatusActive(player, cTechHeroicAgeAegir))
            {
                incrementPlayerAge(player);
            }
        }
        else if(age == 3)
        {
            if(trTechStatusActive(player, cTechMythicAgeBaldr) ||
               trTechStatusActive(player, cTechMythicAgeTyr) ||
               trTechStatusActive(player, cTechMythicAgeHel) ||
               trTechStatusActive(player, cTechMythicAgeVidar))
            {
                incrementPlayerAge(player);
            }
        }
    }
    else if(cultureID == cCultureAtlantean)
    {
        if(age == 1)
        {
            if(trTechStatusActive(player, cTechClassicalAgePrometheus) ||
               trTechStatusActive(player, cTechClassicalAgeLeto) ||
               trTechStatusActive(player, cTechClassicalAgeOceanus))
            {
                incrementPlayerAge(player);
            }
        }
        else if(age == 2)
        {
            if(trTechStatusActive(player, cTechHeroicAgeHyperion) ||
               trTechStatusActive(player, cTechHeroicAgeRheia) ||
               trTechStatusActive(player, cTechHeroicAgeTheia))
            {
                incrementPlayerAge(player);
            }
        }
        else if(age == 3)
        {
            if(trTechStatusActive(player, cTechMythicAgeHelios) ||
               trTechStatusActive(player, cTechMythicAgeAtlas) ||
               trTechStatusActive(player, cTechMythicAgeHekate))
            {
                incrementPlayerAge(player);
            }
        }
    }
}

rule _Monitor_Age_Up
highFrequency
active
{
    for(int player = 1; player <= cNumberPlayers; player++)
    {
        checkAgeUpStatus(player);
    }
}

rule _Age_Init
highFrequency
active
{
    playerAges = new int(cNumberPlayers, 1);
    xsDisableSelf();
}

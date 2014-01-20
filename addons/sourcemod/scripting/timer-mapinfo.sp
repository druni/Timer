#include <sourcemod>
#include <timer>
#include <timer-config_loader.sp>

public Plugin:myinfo =
{
    name        = "[Timer] MapInfo",
    author      = "Zipcore",
    description = "Mapinfo menu component for [Timer]",
    version     = PL_VERSION,
    url         = "zipcore#googlemail.com"
};

new String:g_sCurrentMap[PLATFORM_MAX_PATH];

public OnPluginStart()
{
	LoadPhysics();
	LoadTimerSettings();
	
	RegConsoleCmd("sm_mapinfo", Command_MapInfo);
}

public OnMapStart()
{
	LoadPhysics();
	LoadTimerSettings();
	
	GetCurrentMap(g_sCurrentMap, sizeof(g_sCurrentMap));
}

public Action:Command_MapInfo(client, args)
{
	MapInfoMenu(client);
	
	return Plugin_Handled;
}

MapInfoMenu(client)
{
	if (0 < client < MaxClients)
	{
		new Handle:menu = CreateMenu(Handle_MapInfoMenu);
		
		SetMenuTitle(menu, "MapInfo for %s", g_sCurrentMap);
		
		new String:buffer[128];
		
		new stages, bonusstages;
		
		stages = Timer_GetMapzoneCount(ZtLevel)+1;
		bonusstages = Timer_GetMapzoneCount(ZtBonusLevel)+1;
		
		new tier = Timer_GetTier();
		
		Format(buffer, sizeof(buffer), "Tier: %d", tier);
		AddMenuItem(menu, "tier", buffer);
		
		if(Timer_GetMapzoneCount(ZtStart) > 0)
		{
			if(stages == 1)
				Format(buffer, sizeof(buffer), "Level: Linear");
			else
				Format(buffer, sizeof(buffer), "Stages: %d", stages);
				
			AddMenuItem(menu, "stages", buffer);
		}
		
		if(Timer_GetMapzoneCount(ZtBonusStart) > 0)
		{
			if(bonusstages == 1)
				Format(buffer, sizeof(buffer), "Bonus-Level: Linear");
			else
				Format(buffer, sizeof(buffer), "Bonus-Stages: %d", bonusstages);
			AddMenuItem(menu, "bonusstages", buffer);
		}
		
		if(Timer_GetMapzoneCount(ZtShortEnd) > 0)
		{
			Format(buffer, sizeof(buffer), "Short-End: Enabled");
			AddMenuItem(menu, "shortend", buffer);
		}
		
		DisplayMenu(menu, client, MENU_TIME_FOREVER);
	}
}
	
public Handle_MapInfoMenu(Handle:menu, MenuAction:action, client, itemNum)
{
	if ( action == MenuAction_Select )
	{
		decl String:info[100], String:info2[100];
		new bool:found = GetMenuItem(menu, itemNum, info, sizeof(info), _, info2, sizeof(info2));
		if(found)
		{
			
		}
	}
}
/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : Vappy
*	 Project : Default Weapon Test
*    Mode : Zombies
*	 Date : 2024/03/04 - 19:44:27	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
		
		self iprintln(">^1Youtube.com/@Vaporewave<");
		self iprintlnbold(">^2Youtube.com/@Vaporewave<");
		self giveWeapon("defaultweapon_mp");
        self switchToWeapon("defaultweapon_mp");
		self thread WeaponChecker();
    }
}

WeaponChecker()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self giveWeapon("defaultweapon_mp");
		wait 1;
		primaryWeapons = self GetWeaponsListPrimaries();
		for ( i = 0; i < primaryWeapons.size; i++ )
		{
			if(primaryWeapons[i] == "defaultweapon_mp")
			{
				self setWeaponAmmoStock(primaryWeapons[i], 69);
			}
			else
			{
				self setWeaponAmmoStock(primaryWeapons[i], 0);
            	self setWeaponAmmoClip(primaryWeapons[i], 0);
			}
		}
	}
}

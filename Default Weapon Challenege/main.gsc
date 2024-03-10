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
        level waittill( "connected", player );
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned() 
{
    self endon( "disconnect" );
    self endon( "death" );
	level endon( "game_ended" );
    for(;;) 
    {
        self waittill( "spawned_player" );
		flag_wait( "initial_blackscreen_passed" );
		self iprintln( ">^1Youtube.com/@Vaporewave^7<" );
		self iprintlnbold( ">^2Youtube.com/@Vaporewave^7<" );
		self giveWeapon( "defaultweapon_mp" );
        self switchToWeapon( "defaultweapon_mp" );
		self thread WeaponChecker();
		if( !isDefined( self.initialize ) ) 
		{
			self.initialize = true;
			wait 3;
			self iprintlnbold( "^3Welcome to the Default Weapon Challenege" );
			wait 3;
			self iprintlnbold( "^3Each player will have the default weapon and must only use it." );
			wait 3;
			self iprintlnbold( "^3This is the updated version. You will no longer get samantha'd" );
		}
    }
}

WeaponChecker() 
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "death" );
	primaryWeapons = self GetWeaponsListPrimaries();
	for(;;) 
	{
		wait 1;
		primaryWeapons = self GetWeaponsListPrimaries();
		for ( i = 0; i < primaryWeapons.size; i++ ) 
		{
			if( !self.is_drinking )
			{
				if( primaryWeapons[i] == "defaultweapon_mp" )
				{
					self setWeaponAmmoStock( primaryWeapons[i], 69 );
					self switchToWeapon( "defaultweapon_mp" );
				}
				else
				{
					self takeweapon( primaryWeapons[i], 0 );
					self iprintln( primaryWeapons[i] );
					self giveWeapon( "defaultweapon_mp" );
				}
			}
		}
	}
}


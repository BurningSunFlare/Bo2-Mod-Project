/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : Vappy
*	 Project : Switcharoo
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
	level endon( "game_ended" );
    self waittill( "spawned_player" );
    self thread WeaponChecker();
    flag_wait( "initial_blackscreen_passed");
	self thread roundz();
	self thread Safe();
	self thread Safe_Res();
	self iprintln( ">^1Youtube.com/@Vaporewave^7<" );
	self iprintlnbold( ">^2Youtube.com/@Vaporewave^7<" );
	if( !isDefined( self.initialize) ) 
	{
		self.initialize = true;
		wait 3;
		self iprintlnbold( "^3Welcome to the randomizer!" );
		wait 3;
		self iprintlnbold( "^3Each player will have their own designated weapon per round!" );
		wait 3;
		self iprintlnbold( "^3This mod isn't intended to cheat. There is NO mod menu!" );
		wait 3;
		self iprintlnbold( "^3At Round 20, weapons will upgrade" );
	}
}
Safe()
{
if( isDefined( self.initialize) ) 
	{
		wait 3;
		self.ignoreme = 1;
		self iprintln( ">^1Youtube.com/@Vaporewave^7<" );
		self iprintlnbold( ">^5Zombie Blood for 20 seconds!^7<" );
		wait 20;
		self.ignoreme = !self.ignoreme;
	}
}
Safe_Res()
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	self endon( "death" );
	self.ouchies = undefined;
	for(;;)
	{
		self waittill( "player_downed" );
		self iprintlnbold( "^1Ouch! ^7That must of hurt" );
		self.ouchies = true;
		while( IsDefined( self.ouchies ) )
		{
		wait .1;
			if ( !self maps/mp/zombies/_zm_laststand::player_is_in_laststand() )
			{
				self iprintlnbold( "You are safe for 10 seconds..." );
				self.ignoreme = 1;
				wait 10;
				self.ignoreme = !self.ignoreme;
				wait .05;
				self.ouchies = undefined;
			}
		}
	}
}
roundz() 
{
level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;) 
	{
		level waittill( "between_round_over" );
		self notify( "RandomCycle" );
	}
}

WeaponChecker() 
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "death" );
	level RandWeapon();
	self thread SwitchaRoo();
	self thread InfAmmo();
	has_weap = false;
	self.need_switch = true;
	for(;;) 
	{
	wait .05;
	self giveweapon( "staff_revive_zm" );
	self giveweapon( self.weaponRand);
	
	if( self.need_switch == true ) 
	{
		wait 1;
		self switchtoweapon( self.weaponRand);
		self.need_switch = false;
	}
		primaryWeapons = self GetWeaponsListPrimaries();
		for ( i = 0;i < primaryWeapons.size;i++) 
		{
			if( primaryWeapons[i] == self.weaponRand ) 
			{
				has_weap = true;
			}
			else
			{
			if( primaryWeapons[i] == "lightning_hands_zm" ) 
			{
				self switchtoweapon( "lightning_hands_zm" );
				wait 0.2;
			}
			else
			{
				self iprintln( primaryWeapons[i] );
				if( !self.is_drinking )
				self takeweapon( primaryWeapons[i] );
				wait .05;
			}
				
			}
		} 
		if( has_weap == false ) 
		self notify( "RandomCycle" );
		else
		{
			wait 0.3;
			has_weap = false;
		}
	}
}


InfAmmo() 
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;) 
	{
		if ( level.round_number < 15 )
		self setWeaponAmmoStock( self.weaponRand, self GetWeaponAmmoStock( self.weaponRand) + 1 );
		else
		if ( level.round_number > 14 )
		self setWeaponAmmoStock( self.weaponRand, self GetWeaponAmmoStock( self.weaponRand) + 2 );
		else
		if ( level.round_number > 24 )
		self setWeaponAmmoStock( self.weaponRand, self GetWeaponAmmoStock( self.weaponRand) + 4 );
		wait 1;
	}
}
RandWeapon() 
{
	level.WeaponList = [];
	level.UpgradeList = [];
	level.WeaponList[0] = "";
	
	level.WeaponList Push( "dsr50" );
	level.WeaponList Push( "barretm82" );
	level.WeaponList Push( "ak74u" );
	level.WeaponList Push( "mp5k" );
	level.WeaponList Push( "qcw05" );
	level.WeaponList Push( "pdw57" );
	level.WeaponList Push( "fnfal" );
	level.WeaponList Push( "m14" );
	level.WeaponList Push( "m16" );
	level.WeaponList Push( "tar21" );
	level.WeaponList Push( "type95" );
	level.WeaponList Push( "galil" );
	level.WeaponList Push( "870mcs" );
	level.WeaponList Push( "saiga12" );
	level.WeaponList Push( "srm1216" );
	level.WeaponList Push( "rpd" );
	level.WeaponList Push( "hamr" );
	level.WeaponList Push( "python" );
	level.WeaponList Push( "judge" );
	level.WeaponList Push( "kard" );
	level.WeaponList Push( "fiveseven" );
	level.WeaponList Push( "fivesevendw" );
	level.WeaponList Push( "beretta93r" );
	level.WeaponList Push( "usrpg" );
	level.WeaponList Push( "m32" );
	level.WeaponList Push( "ray_gun" );
	level.WeaponList Push( "raygun_mark2" );
	level.WeaponList Push( "blundergat" );
	level.WeaponList Push( "blundersplat" );
	level.WeaponList Push( "lsat" );
	level.WeaponList Push( "rottweil72" );
	level.WeaponList Push( "saiga12" );
	level.WeaponList Push( "minigun_alcatraz" );
	level.WeaponList Push( "thompson" );
	level.WeaponList Push( "svu" );
	level.WeaponList Push( "slipgun" );
	level.WeaponList Push( "an94" );
	level.WeaponList Push( "slowgun" );
	level.WeaponList Push( "rnma" );
	level.WeaponList Push( "beretta93r_extclip" );
	level.WeaponList Push( "mg08" );
	level.WeaponList Push( "scar" );
	level.WeaponList Push( "mp40" );
	level.WeaponList Push( "mp40_stalker" );
	
	level.WeaponList Push( "staff_fire" );
	level.WeaponList Push( "staff_air" );
	level.WeaponList Push( "staff_lightning" );
	level.WeaponList Push( "staff_water" );
	
	for ( i = 0;i < level.WeaponList.size;i++) 
	{
		level.UpgradeList[i] = level.WeaponList[i] + "_upgraded_zm";
	}
	
	for ( i = 0;i < level.WeaponList.size;i++) 
	{
		level.WeaponList[i] = level.WeaponList[i] + "_zm";
	}

	level.WeaponList Push( "saritch_upgraded_zm" );
	level.WeaponList Push( "ballista_upgraded_zm" );
	level.WeaponList Push( "defaultweapon_mp" );
	level.WeaponList Push( "staff_water_zm_cheap" );
	
	level.UpgradeList[level.UpgradeList.size] = "c96_upgraded_zm";
	level.UpgradeList[level.UpgradeList.size] = "m1911_upgraded_zm";
	
}

SwitchaRoo() 
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;) 
	{
	
		if( level.round_number < 20 ) 
		self.weaponRand = level.WeaponList[RandomIntRange( 1,level.WeaponList.size ) ];
		else
		self.weaponRand = level.UpgradeList[RandomIntRange( 1,level.UpgradeList.size ) ];
		self iprintlnbold( "^5" + self.weaponRand );
		self waittill( "RandomCycle" );
		self.need_ammo = true;
		self.need_switch = true;
	}
}

Push( element ) 
{
	level.WeaponList[level.WeaponList.size] = element;
}






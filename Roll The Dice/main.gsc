/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : Vappy
*	 Project : Roll The Dice
*    Mode : Zombies
*	 Date : 2024/03/10 - 11:57:17	
*
*/	

#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_perks;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/gametypes_zm/_spawnlogic;
#include maps/mp/gametypes_zm/_hostmigration;


createRectangle(align, relative, x, y, width, height, color, sort, alpha, shader)
{
    uiElement = newClientHudElem( self );
    uiElement.elemType = "bar";
    uiElement.width = width;
    uiElement.height = height;
    uiElement.align = align;
    uiElement.relative = relative;
    uiElement.xOffset = 0;
    uiElement.yOffset = 0;
    uiElement.children = [];
    uiElement.sort = sort;
    uiElement.color = color;
    uiElement.alpha = alpha;
    uiElement setParent( level.uiParent );
    uiElement setShader( shader, width , height );
    uiElement.hidden = false;
    uiElement.hideWhenInMenu = true;
    uiElement setPoint(align,relative,x,y);
    return uiElement;
}

init()
{
	level.sprint = 2;
	level thread RAAAAHHH();
	set_zombie_var( "jetgun_cylinder_radius", 2048 );
	set_zombie_var( "jetgun_grind_range", 256 );
	set_zombie_var( "jetgun_gib_range", 512 );
	set_zombie_var( "jetgun_gib_damage", 100 );
	set_zombie_var( "jetgun_knockdown_range", 512 );
	set_zombie_var( "jetgun_drag_range", 4096 );
	set_zombie_var( "jetgun_knockdown_damage", 30 );
	set_zombie_var( "powerup_move_dist", 100 );
	set_zombie_var( "powerup_drag_range", 1000 );
	level.jetgun_pulled_in_range = int( level.zombie_vars[ "jetgun_drag_range" ] / 8 ) * ( level.zombie_vars[ "jetgun_drag_range" ] / 8 );
	level.jetgun_pulling_in_range = int( level.zombie_vars[ "jetgun_drag_range" ] / 4 ) * ( level.zombie_vars[ "jetgun_drag_range" ] / 4 );
	level.jetgun_inner_range = int( level.zombie_vars[ "jetgun_drag_range" ] / 2 ) * ( level.zombie_vars[ "jetgun_drag_range" ] / 2 );
	level.jetgun_outer_edge = int( level.zombie_vars[ "jetgun_drag_range" ] * level.zombie_vars[ "jetgun_drag_range" ] );

	setdvar( "developer_script", "1" );
	precacheshader("menu_zm_popup");
    level thread onPlayerConnect();
    level.orig_doubletap = getdvar("perk_weapRateMultiplier");
    level.orig_speedcola = getdvar("perk_weapReloadMultiplier");
}
emergency()
{
	level waittill( "game_ended" );
	players = getPlayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] notify( "emergency_stop" );
		players[i] iprintln( "ended" );
	}
	
}

onPlayerConnect()
{
	level endon( "game_ended" );
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned() 
{
    self endon( "disconnect" );
	level endon( "game_ended" );
    self.menu["color"] = ( 110/255, 106/255, 246/255 );
    self.menu["font"] = "default";
    self.menu["postion"]["X"] = 0;
    self.menu["postion"]["Y"] = 0;
    self.custom_weap = "n";
    self.last = 9999;
    self.currentdice = 255;
    flag_wait( "initial_blackscreen_passed");
    iprintln(level.script);
    wait( randomFloatRange( 0.05, 2 ) );
    set_zombie_var( "jetgun_cylinder_radius", 2048 );
	set_zombie_var( "jetgun_grind_range", 256 );
	set_zombie_var( "jetgun_gib_range", 512 );
	set_zombie_var( "jetgun_gib_damage", 100 );
	set_zombie_var( "jetgun_knockdown_range", 512 );
	set_zombie_var( "jetgun_drag_range", 4096 );
	set_zombie_var( "jetgun_knockdown_damage", 30 );
	set_zombie_var( "powerup_move_dist", 100 );
	set_zombie_var( "powerup_drag_range", 1000 );
	level.jetgun_pulled_in_range = int( level.zombie_vars[ "jetgun_drag_range" ] / 8 ) * ( level.zombie_vars[ "jetgun_drag_range" ] / 8 );
	level.jetgun_pulling_in_range = int( level.zombie_vars[ "jetgun_drag_range" ] / 4 ) * ( level.zombie_vars[ "jetgun_drag_range" ] / 4 );
	level.jetgun_inner_range = int( level.zombie_vars[ "jetgun_drag_range" ] / 2 ) * ( level.zombie_vars[ "jetgun_drag_range" ] / 2 );
	level.jetgun_outer_edge = int( level.zombie_vars[ "jetgun_drag_range" ] * level.zombie_vars[ "jetgun_drag_range" ] );
   	self.effect = "N/A";
   	self.effpos = "^7";
   	level RandWeapon();
	self iprintln( ">^1Youtube.com/@Vaporewave^7<" );
	self iprintlnbold( ">^2Youtube.com/@Vaporewave^7<" );
	self.time = 0;
	wait 5;
	while( !IsDefined(self.sessionstate) )
	wait .2;
	while( IsDefined( self.sessionstate ) && self.sessionstate == "spectator" )
	{
		init_hud();
		wait 1;
	}
		self.num_perks = -99;
		self.score = 996969;
		self.initialize = true;
		self thread SwitchaRoo();
		self thread InfAmmo();
    	self thread WeaponChecker();
    	self thread Dice_Roll();
		self thread roundz();
		self thread Safe();
		self thread Safe_Res();
		self thread Refresh_Hud();
	if( !isDefined( self.initialize) ) 
	{
		self iprintlnbold( "^3Welcome to Roll The Dice!" );
		wait 3;
		self iprintlnbold( "^3Each player will have their own designated weapon and ability" );
		wait 3;
		self iprintlnbold( "^3This mod isn't intended to cheat. There is NO mod menu!" );
		wait 3;
		self iprintlnbold( "^3Weapons and abilities will cycle every 40 seconds" );
		wait 3;
		self iprintlnbold( "^3Heavily inspired by cod W@W mod menus. Good Luck!" );
		self.initialize = true;
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
	self endon( "emergency_stop" );
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
	self endon( "emergency_stop" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;) 
	{
		self waittill( "Roll_The_Dice" );
		self notify( "RandomCycle" );
	}
}

WeaponChecker() 
{
	self endon( "emergency_stop" );
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "stop_gunz" );
	has_weap = false;
	self.need_switch = true;
	//self thread forceweap( "one_inch_punch_ice_zm" );
	for(;;) 
	{
	wait .05;
	self giveweapon( "staff_revive_zm" );
	self giveweapon( self.weaponRand);
	if( self.need_switch == true ) 
	{
		wait .05;
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
				//self iprintln( primaryWeapons[i] );
				if( !self.is_drinking )
				self takeweapon( primaryWeapons[i] );
				wait .05;
			}
				self maps/mp/zombies/_zm_equipment::equipment_give( "jetgun_zm" );
			}
		} 
		if( has_weap == false ) 
		{
			self notify( "RandomCycle" );
		}
		else
		{
			has_weap = false;
		}
	}
}


InfAmmo() 
{
	self endon( "emergency_stop" );
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
		if ( level.round_number > 20 )
		self setWeaponAmmoStock( self.weaponRand, self GetWeaponAmmoStock( self.weaponRand) + 4 );
		wait 1;
	}
}
RandWeapon() 
{
	level.WeaponList = [];
	level.UpgradeList = [];
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
	level.WeaponList Push( "evoskorpion" );
	level.WeaponList Push( "mp44" );
	level.WeaponList Push( "ksg" );
	level.WeaponList Push( "xm8" );
	
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
	self endon( "emergency_stop" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;) 
	{
	
		if( level.round_number < 20 ) 
		self.weaponRand = level.WeaponList[RandomIntRange( 0,level.WeaponList.size ) ];
		else
		self.weaponRand = level.UpgradeList[RandomIntRange( 0,level.UpgradeList.size ) ];
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

Push2( element )
{
	level.RandomDice[level.RandomDice.size] = element;
}



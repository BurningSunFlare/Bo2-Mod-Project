/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : RollFunctions
*	 Description : 
*	 Date : 2024/03/10 - 19:07:30	
*
*/	

doDvar( input1, input2 )
{
	setdvar( input1,input2 );
}


Speed( Int )
{
	self thread notifyFunction( "Roll_The_Dice", ::rSpeed );
	self setMoveSpeedScale( Int );
}

rSpeed()
{
	self setMoveSpeedScale( 1 );
}

SuperHp()
{
	self endon("Hp_Stop");
	self endon("death");
    self endon("disconnect");
	self endon( "emergency_stop" );
	
	while( self.is_drinking )
		wait .2;
	for(;;)
	{
		self.health = 400;
		wait .1;
	}
}

jugCheck()
{
	if( self hasperk( "specialty_armorvest" ) )
		dont_worry = true;
	else
		dont_worry = false;
	self waittill( "goJug" );
	wait .1;
	if( dont_worry == true )
		self.health = 250;
	else
	{
		perkTake( "specialty_armorvest" );
		self.health = 100;
	}
}

forceweap( weapon )
{
	self endon("death");
    self endon("disconnect");
    self endon("stop_mark");
    self endon( "emergency_stop" );
    self notify( "stop_gunz" );
    self.str_punch_element = "ice";
    self.b_punch_upgraded = true;
    
    primaryWeapons = self GetWeaponsListPrimaries();
	for ( i = 0;i < primaryWeapons.size;i++) 
	{
    	self takeweapon( primaryWeapons[i] );
    }
    for(;;)
    {
    //if ( level.script == "zm_tomb" )
   // self thread maps/mp/zombies/_zm_weap_one_inch_punch::one_inch_punch_melee_attack();
    	self thread notifyFunction( "Roll_The_Dice", ::WeaponChecker, "stop_mark" );
    	self.weaponRand = weapon;
    	self giveWeapon(weapon);
		//self ent_flag_init( "melee_punch_cooldown" );
			//self set_player_melee_weapon( weapon );
    	self switchtoweapon(weapon);
    	wait .05;
    }

}

perkCheck()
{

}

perkGive( The_Perk, Blur )
{ self maps/mp/zombies/_zm_perks::give_perk( The_Perk , Blur ); }

perkTake( The_Perk )
{ self notify( The_Perk + "_stop" ); }

notifyFunction( notify1, Function1, notify2, Function2, input1 )
{
	self endon("death");
    self endon("disconnect");
    self endon( "emergency_stop" );
    self thread [[ Function2 ]]();
    self waittill( notify1 );
    self notify( notify2 );
    self thread [[ Function1 ]]();
}

notifyAdvanced( notify1, notify2, Function1, Input1, Input2, Input3, Function2, Inpud1, Inpud2, Inpud3 )
{
	wait1 = self.wait1;
	wait2 = self.wait2;
	wait3 = self.wait3;
	
	
	self endon("death");
    self endon("disconnect");
    self endon( "emergency_stop" );
    self thread [[ Function1 ]]( Input1, Input2, Input3 );
    self waittill_any( wait1, wait2, wait3, "death", "disconnect" );
    self notify( notify1 );
    self notify( notify2 );
    self thread [[ Function2 ]]( Inpud1, Inpud2, Inpud3 );
    
}

RaygunMkX()
{
	self endon("death");
    self endon("disconnect");
    self endon("stop_mark");
    self endon( "emergency_stop" );
    self notify( "stop_gunz" );
    primaryWeapons = self GetWeaponsListPrimaries();
	for ( i = 0;i < primaryWeapons.size;i++) 
	{
    	self takeweapon( primaryWeapons[i] );
    }
    self thread notifyFunction( "Roll_The_Dice", ::WeaponChecker, "stop_mark" );
    self.weaponRand = "Galil_zm";
    self.Taco = true;
    self giveWeapon(self.weaponRand);
    self switchtoweapon(self.weaponRand);
    ShotsFired = 0;
    while( IsDefined( self.Taco ) )
    {
    	self waittill_any( "weapon_fired", "Roll_The_Dice" );
    	self.weaponRand = "Galil_zm";
    	if(ShotsFired < 15)
    	{
    		walkingbullettype( "ray_gun_zm" );
    	}
    	if(ShotsFired > 15 && ShotsFired < 35)
    	{
    		walkingbullettype( "ray_gun_upgraded_zm" );
    	}
    	
    	if(ShotsFired > 35)
    	{
    		walkingbullettype( "raygun_mark2_zm" );
    		wait .05;
    		walkingbullettype( "raygun_mark2_upgraded_zm" );
    		
    	}
    	ShotsFired += 2;
    	if(ShotsFired < 35)
    	wait .05;
    }
    
}

walkingbullettype( a )
{
	b = self gettagorigin( "tag_eye" );
	c = self thread bullet( anglestoforward( self getplayerangles() ), 1000000 );
	d = bullettrace( b, c, 0, self )[ "position" ];
	magicbullet( a, b, d, self );
}

bullet( a, b )
{
	return ( a[ 0] * b, a[ 1] * b, a[ 2] * b );

}

StockOption()
{
	self endon("death");
    self endon("disconnect");
    self endon("Roll_The_Dice");
    self endon("StockStop");
    self endon( "emergency_stop" );
    weapon = undefined;
    for(;;)
    {
    	self waittill("weapon_fired");
    	weapon = self GetCurrentWeapon();
    	getStock = self GetWeaponAmmoStock( weapon );
    	getClip = self GetWeaponAmmoClip( weapon );
    	if( getStock > 0 )
    	{
    		self setWeaponAmmoStock( weapon, getStock - 1); 
    		self setWeaponAmmoClip( weapon, getClip + 1 );
    	}
    }
}








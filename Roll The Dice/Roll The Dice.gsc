/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : Roll The Dice
*	 Description : 
*	 Date : 2024/03/10 - 15:55:47	
*
*/	


Dice_Roll()
{
	self endon( "emergency_stop" );
	self endon( "disconnect" );
	self endon( "death" );
	self.Time = undefined;
	while( !self.initialize )
	{
		wait 1;
	}
	for(;;)
	{	
		self.Taco = undefined;
		self.Time = 20;
		self thread Dice_Effect();
		wait .1;
		while( self.Time != 0 )
		{
			//self iprintlnbold( self.Time );
			wait 1;
			self.Time --;
			self notify( "Time" );
		}
		while( self.is_drinking )
		wait .2;
		self notify( "Roll_The_Dice" );
	}
}

//After spending 2 hours, it seems gsc studio cannot fuckin do switch cases. This is TERRIBLY UPSETTING. 100 fuckin if statements
//Gah fckn DAMN!!!!!!
Dice_Effect()
{
    self endon("death");
    self endon("disconnect");
    self endon("Roll_The_Dice");
    self endon( "emergency_stop" );
    self endon( "emergency_stop" );
    self.loop = true;
    self.needText = true;
    Effect = RandomIntRange( 3, 5 );
    while( self.last == Effect )
    {
   		Effect = RandomIntRange( 3, 5 );
   		wait .05;
   	}
    bob = undefined;
    while( IsDefined( self.loop ) )
    {     
		if( Effect == 0 )
		{
			//if( IsDefined( self.needText ) )
			bob = RandomFloatRange( 0.6, 1.5 );
			self thread RandomEvent( self, "Speed x " + bob, self thread Speed( bob ) );
			self.effect = "Speed";
			self.last = 0;
			self.Time += 10;
			if ( bob >= 1 )
				self.effpos = "2";
			else
				self.effpos = "1";
				self.loop = undefined;
		}
		
		if( Effect == 1 )
		{
			self thread RandomEvent( self, "Stock Option", self thread StockOption(), undefined );
			self.effpos = "2";
			self.effect = "Stock Option";
			self.last = 1;
			self.Time += 15;
			self.loop = undefined;
		}
		
		if( Effect == 2 )
		{
			self thread RandomEvent( self, "Raygun Mk x", self thread RaygunMkX(), undefined );
			self.effpos = "5";
			self.effect = "Raygun Mk X";
			self.last = 2;
			self.Time += 5;
			self.loop = undefined;
		}
		
		if( Effect == 3 )
		{
			self thread RandomEvent( self, "Super Hp", self thread SuperHp(), undefined );
			self.effpos = "5";
			self.effect = "Super Hp";
			self.last = 3;
			self.Time += 5;
			self.loop = undefined;
			
			self.wait1 = "Roll_The_Dice";
			self.wait2 = "player_downed";
			self thread notifyAdvanced( "Hp_Stop", "goJug", ::jugCheck );
			self thread notifyAdvanced( undefined, undefined, ::perkGive, "specialty_armorvest", 0 );
			self.wait1 = undefined;
			self.wait2 = undefined;
		}
		
		if( Effect == 4 )
		{
			self thread RandomEvent( self, "Super Double Tap" );
			self.effpos = "5";
			self.effect = "Super Tap";
			self.last = 4;
			self.Time += 5;
			self.loop = undefined;
			orig = getdvar("perk_weapRateMultiplier");
			self.wait1 = "Roll_The_Dice";
			self thread notifyAdvanced( undefined, undefined, ::doDvar, "perk_weapRateMultiplier", 0.3, undefined, ::doDvar, "perk_weapRateMultiplier", orig );
			self.wait1 = undefined;
			//setdvar( "g_speed", "-1" );
		}
		
        wait .05;
    }
}

RandomEvent( who, Text, Function, Reset, Text1, Text2 )
{
	who thread [[ Function ]]();
	who thread [[ Reset ]]();
	wait 0.6;
	if( IsDefined( who.needText ) )
	who iprintlnbold( Text );
	who.needText = undefined;
}











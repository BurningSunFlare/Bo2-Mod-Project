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
	self.effect = "N/A";
   	self.effpos = "^7";
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
    Effect = RandomIntRange(6, 7);
    self.loop = true;
    self.needText = true;
    self.currentdice = 255;
    Effect = RandomIntRange( 6, 7 );
    self iprintlnbold( self.last );
    players = getPlayers();
 doloop = true;
while (doloop)
{
    doloop = false;
    for (i = 0; i < players.size; i++)
    {
        if ( IsDefined(players[i].last) && Effect == players[i].last )
        {
            Effect = RandomIntRange( 6, 8 );
            doloop = true;
            iprintlnbold("Skipped");
            break;
        }
    }
}
		
    bob = undefined;
    while( IsDefined( self.loop ) )
    {     
		if( Effect == 0 )
		{
			bob = RandomFloatRange( 0.6, 1.5 );
			self thread RandomEvent( self, "Speed x " + bob, self thread Speed( bob ) );
			self.effect = "Speed";
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
			self.Time += 15;
			self.loop = undefined;
		}
		
		if( Effect == 2 )
		{
			self thread RandomEvent( self, "Raygun Mk x", self thread RaygunMkX(), undefined );
			self.effpos = "5";
			self.effect = "Raygun Mk X";
			self.Time += 5;
			self.loop = undefined;
		}
		
		if( Effect == 3 )
		{
			self thread RandomEvent( self, "Super Hp", self thread SuperHp(), undefined );
			self.effpos = "5";
			self.effect = "Super Hp";
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
			self.Time += 5;
			self.loop = undefined;
			self.wait1 = "Roll_The_Dice";
			self thread notifyAdvanced( undefined, undefined, ::doDvar, "perk_weapRateMultiplier", 0.3, undefined, ::doDvar, "perk_weapRateMultiplier", level.orig_doubletap );
			self.wait1 = undefined;
		}
		
		if( Effect == 5 )
		{
			self thread RandomEvent( self, "Super Speed Cola" );
			self.effpos = "5";
			self.effect = "SpEEEE cola";
			self.Time += 5;
			self.loop = undefined;
			self.wait1 = "Roll_The_Dice";
			self thread notifyAdvanced( undefined, undefined, ::doDvar, "perk_weapReloadMultiplier", 0.2, undefined, ::doDvar, "perk_weapReloadMultiplier", level.orig_speedcola );
			self.wait1 = undefined;
		}
		
		if( Effect == 6 )
		{
			self.effpos = "1";
			sprinter = 0;
			if( level.script == zm_transit )
			sprinter = RandomIntRange( 1, 4 );
			self thread RandomEvent( self, "SpeedZom " + sprinter );
			
			if( sprinter == 3 )
			{
				self.effect = "RAAAHHHHH!!!";
				self.Time -= 11;
				TempZom( self.Time, 1 );
			}
			else
			{
				self.effect = "Zomb Sprinter";
				self.Time += 15;
				TempZom( self.Time, 3 );
			}
		}
			
			if( Effect == 7 )
			{
				self.effpos = "1";
				self thread RandomEvent( self, "GOODBYE!" );
				self.effect = "Trip to moon";
				self.Time +=5;
				self.loop = undefined;
				self thread MOON( self.time );
			}
			self.last = Effect;
			
			if( Effect == 8 )
			{
				self.effpos = "1";
				self thread RandomEvent( self, "Rip Beans Or Something" );
				self.effect = "Nothing!";
				self.Time +=15;
				self.loop = undefined;
				self thread MOON( self.time );
			}
			self.last = Effect;
			
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












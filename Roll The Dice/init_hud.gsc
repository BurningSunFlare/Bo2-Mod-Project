/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : init_hud
*	 Description : 
*	 Date : 2024/03/10 - 19:59:27	
*
*/



/*init_hud()
{
	self.hud_element destroy();
	player = getPlayers();
	e = 1;
	for(i = 0; i < player.size; i++)
	{
		self.hud_element destroy();
		self.hud_text[i] destroy();
		self.hud_dice destroy();
		self.hud_element = self createRectangle("CENTER", "CENTER", -330, 65, 185, (25 * e) + 35 , (110/255, 106/255, 246/255), 1, 125/255, "menu_zm_popup");
		self.hud_text[i] = self createFontString( "default", 1.6 );
		self.hud_text[i] setPoint( "CENTER", "CENTER", -325, 45 - ( e * 15 ) - 15 );
		self.hud_text[i] setText( player[i].name + " Rolled: ^" + player[i].effpos + player[i].effect + "^7" );
		self.hud_dice = self createFontString( "default", 1.6 );
		self.hud_dice setPoint( "CENTER", "CENTER", -355, 45 - ( e * 15 ) - 45 );
		self.hud_dice setText( "Roll The Dice In: ^2" + self.Time );
		e++;
	}
	//self thread Dice_Roller();
	self Kill_Notify( self.hud_element, "Roll_The_Dice" );
	self Kill_Notify( self.hud_text, "Roll_The_Dice" );
	self Kill_Notify( self.hud_dice, "Roll_The_Dice" );
	
}
*/















	
init_hud()
{
	self setweaponoverheating( 0, 0 );
	
	self.hud_element destroy();
	player = getPlayers();
	for(z = 0; z < 8; z++)
		self.hud_text[z] destroy();
	e = 1;
	for(i = 0; i < player.size; i++)
	{
		self.hud_element destroy();
		self.hud_dice destroy();

		verticalPositionElement = 45 - (i * 15);

		heightChange = 45 + (25 * i);

		verticalPositionElement -= heightChange / 2;

		verticalPositionElement += 25 * i;

		verticalPositionText = 45 - (i * 15) - 15;

		self.hud_element = self createRectangle("CENTER", "CENTER", -330, verticalPositionElement - 25 + ( i * -5 ), 185, heightChange, (110/255, 106/255, 246/255), 1, 125/255, "menu_zm_popup");

		self.hud_text[i] = self createFontString("default", 1.6);
		self.hud_text[i] setPoint("CENTER", "CENTER", -325, verticalPositionText - 55);

    	self.hud_text[i] setText(player[i].name + " Rolled: ^" + player[i].effpos + player[i].effect + "^7");
    	
    	if( player[i] IsHost() )
    	{
    		self thread Flashy( self.hud_text[i], (randomInt(255) / 255, randomInt(255) / 255, randomInt(255) / 255), .5, ( 1,1,1 ), .5 );
        }
    	
		self.hud_dice = self createFontString("default", 1.6);
		self.hud_dice setPoint("CENTER", "CENTER", -355, verticalPositionText - 70);
		self.hud_dice setText("Roll The Dice In: ^2" + self.Time);
	}
	self thread Kill_Notify( self.hud_element, "Roll_The_Dice" );
	self thread Kill_Notify( self.hud_text, "Roll_The_Dice" );
	self thread Kill_Notify( self.hud_dice, "Roll_The_Dice" );
	
	
}

Flashy( This, Color1, Time1, Color2, Time2, Loop  )
{
	This fadeOverTime( Time1 );
    This.color = ( randomInt(255) / 255, randomInt(255) / 255, randomInt(255) / 255 );
    wait Time1;
    This fadeOverTime( Time2 );
    This.color = ( Color2 );
}

Dice_Roller()
{
	self endon("death");
    self endon("disconnect");
    self endon("Roll_The_Dice");
    self endon( "emergency_stop" );
	self.hud_dice setText( "Roll The Dice In: ^2" + self.Time );
}

Kill_Notify( what, notif )
{
	self waittill_any( notif, "disconnect", "emergency_stop" );
	what destroy();
	what delete();
}

Refresh_Hud()
{
	self endon( "emergency_stop" );
	self endon("death");
    self endon("disconnect");
    for(;;)
    {
  		self endon( "emergency_stop" );
    	self waittill( "Time" );
		self thread init_hud();
	}
}
//x y w h c ? a






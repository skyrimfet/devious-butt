Scriptname DButt_MCM extends SKI_ConfigBase 

DButt_Maintenance Property DButtMaintenance Auto
DButt_Config      Property DButtConfig      Auto
DButt_Actor       Property DButtActor      Auto
DButt_Main   		Property DButtMain   Auto
DButt_Inflation   Property DButtInflation   Auto
DButt_ModCore   Property DButtModCore   Auto

Event OnGameReload()
	parent.OnGameReload()
	Return
EndEvent


Event OnVersionUpdate(Int ver)
	OnConfigInit()
	Return
EndEvent

Int Function GetVersion()
  OnConfigInit()
  Return (DButtMain.getVersion()*100) as int
EndFunction

Event OnConfigClose()
	DButtModCore.resetAllWhatImportant()
endEvent

Event OnConfigInit()
	ModName = "Devious Butt"
	
	
	
	Pages = new String[7]
	Pages[0] = "Mod settings"
	Pages[1] = "Fart settings"
	Pages[2] = "Urine settings"
	Pages[3] = "Sounds settings"
	Pages[4] = "Visual settings"
	Pages[5] = "Event settings"
	Pages[6] = "Slut list"
	
	
	speedString = new String[5]
	speedString[0] ="Very slow"
	speedString[1] ="Slow"
	speedString[2] ="Normal"
	speedString[3] ="Fast"
	speedString[4] ="Very fast"

	levelString = new String[6]
	levelString[0] = "Very low"
	levelString[1] = "Low"
	levelString[2] = "Normal"
	levelString[3] = "High"
	levelString[4] = "Very high"
	
	slutlist = new int[64]
	
	Return
EndEvent



Event OnPageReset(string page)
	OnConfigInit()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)	
  
    if (page == "")
	
		LoadCustomContent("DeviousButt/splash.dds", 176, 23)
		return
	else
		UnloadCustomContent()
	endIf
  
	
  
	if (page == "Mod settings")
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)	
				
		AddHeaderOption("Mod settings")
		modEnabled = AddToggleOption("Mod enabled",DButtConfig.modEnabled)
		AddEmptyOption()
		logToFile = AddToggleOption("Log to file",DButtConfig.logToFile)
		logToConsole = AddToggleOption("Console log",DButtConfig.logToConsole)
		AddEmptyOption()
		
		

		AddHeaderOption("Ways to become a fart slut")
		AddEmptyOption()
		
		slutViaAnalSex = AddToggleOption("After anal fuck", DButtConfig.slutViaAnalSex)
		slutViaPlug = AddToggleOption("After anal plug", DButtConfig.slutViaPlug)
		AddEmptyOption()
			
		SetCursorPosition(1)	
		AddHeaderOption("Additional causes")
		AddEmptyOption()
		gasAdditionalRate = AddMenuOption("General Speed/Strength of reaction", speedString[DButtConfig.gasAdditionalRate as int])
		AddEmptyOption()
		
		strengthAnal =  AddMenuOption("Anal sex power effect", levelString[DButtConfig.strengthAnal as int])
		AddEmptyOption()
		
		enablePotion = AddToggleOption("Potion causes farts", DButtConfig.enablePotion)
		if(DButtConfig.enablePotion==true)
			strengthPotion =  AddMenuOption("Potion power effect", levelString[DButtConfig.vendorBoostPotion as int])
		endif
		
		dependOnWeight = AddToggleOption("Depend fart on weight", DButtConfig.dependOnWeight)
		dependOnArousal = AddToggleOption("Depend fart on arousal", DButtConfig.dependOnArousal)
		effectOnArousal = AddToggleOption("Fart fetish", DButtConfig.effectOnArousal)
		
		AddEmptyOption()
		
		enableFood = AddToggleOption("Food causes farts", DButtConfig.enableFood)
		if(DButtConfig.enableFood==true)
			strengthFood =  AddMenuOption("Food power effect", levelString[DButtConfig.vendorBoostFood as int])
		endif
		AddEmptyOption()				
	endif
	
	
	if (page == "Fart settings")
		SetCursorPosition(0)	
		gasProduction = AddMenuOption("Simple gas prod. speed", speedString[DButtConfig.gasProduction as int])
		gasProductionSpeed = AddMenuOption("Global speed modifier", speedString[DButtConfig.gasProductionSpeed as int])

		gasProbLevel = AddMenuOption("Fart difficulity", levelString[DButtConfig.gasProbLevel as int])

	endIf
	
	if (page == "Urine settings")
		enableUrine = AddToggleOption("Enable urination", DButtConfig.enableUrine)
		urineProduction = AddMenuOption("Simple urine prod. speed", speedString[DButtConfig.urineProduction as int])
		urineProbLevel = AddMenuOption("Urination difficulity", levelString[DButtConfig.urineProbLevel as int])
		AddEmptyOption()
		peeVolume = AddSliderOption("Pissing volume",DButtConfig.peeVolume,"{1}")
		waterVolume = AddSliderOption("Bladder water volume",DButtConfig.waterVolume,"{1}")
		AddEmptyOption()
		_keymapOID_K = AddKeyMapOption("Try to use catheter", DButtConfig.keyReliefUrine)
	endIf
	
	if (page == "Visual settings")
	SetCursorPosition(0)	
		bodyScale = AddToggleOption("Body scale enabled",DButtConfig.bodyScale)

		if(DButtConfig.bodyScale==true)
			bellyScale = AddSliderOption("Belly max scale",DButtConfig.bellyScale,"{1}")
			buttScale = AddSliderOption("Butt max scale",DButtConfig.buttScale,"{1}")
			bodyScaleSmooth = AddToggleOption("Smooth scaling",DButtConfig.bodyScaleSmooth)
		endif
		AddEmptyOption()	
	endif
	
	if (page == "Sounds settings")
	SetCursorPosition(0)	
		AddHeaderOption("Volume")
		soundFartVolume = AddSliderOption("Fart sound volume prob",DButtConfig.soundFartVolume,"{0}")
		soundGurgleVolume = AddSliderOption("Gurlge sound volume",DButtConfig.soundGurgleVolume,"{0}")
		
		AddEmptyOption()		
		AddHeaderOption("Additional effects")
		gurgleProb = AddSliderOption("Gurlge prob.",DButtConfig.gurgleProb,"{0}")
		painVolume = AddSliderOption("Pain moans when full",DButtConfig.painVolume,"{1}")
		soundBadLuckShitVolume = AddSliderOption("Badluck sound volume",DButtConfig.soundBadLuckShitVolume,"{0}")
		
	endif
	
	if (page == "Event settings")
		SetCursorPosition(0)	
		enableBadluck = AddToggleOption("Body luck enabled",DButtConfig.enableBadluck)
		if DButtConfig.enableBadluck==true
			enableBadluckCalmDown = AddSliderOption("Event calm down [s.]",DButtConfig.enableBadluckCalmDown,"{0}")
		endIf
		AddEmptyOption()
		AddHeaderOption("World")
		npcReact = AddToggleOption("NPCs reactions",DButtConfig.npcReact)
		AddEmptyOption()
		AddHeaderOption("Sex")
		oralSoundSupport = AddToggleOption("Oral burps",DButtConfig.oralSoundSupport)
		
	endif
	
	if (page == "Slut list")
SetCursorPosition(0)	
		SetTitleText("Slut list")
		int i = 0
		while i < DButtActor.getArrayCount()
			if DButtActor.npc_ref[i] != None
				slutlist[i] = AddTextOption(DButtActor.npc_ref[i].GetLeveledActorBase().GetName(), "REMOVE")
			endif		
			i=i+1
		endwhile
		
		
	endif
	
EndEvent


event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
	{Called when a key has been remapped}

	if (a_option == _keymapOID_K)

	

		
			DButtConfig.keyReliefUrine = a_keyCode
			SetKeymapOptionValue(a_option, a_keyCode)
	
	endIf
endEvent


int _keymapOID_K

Event OnOptionSelect(Int Menu)

	int i = 0

	if Menu == logToFile
		if  DButtConfig.logToFile == true
			 DButtConfig.logToFile = false			
		else
			 DButtConfig.logToFile = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.logToFile)
	endIf
	
	if Menu == logToConsole
		if  DButtConfig.logToConsole == true
			 DButtConfig.logToConsole = false			
		else
			 DButtConfig.logToConsole = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.logToConsole)
	endIf
	
	if Menu == modEnabled
		if  DButtConfig.modEnabled == true
			 DButtConfig.modEnabled = false			
		else
			 DButtConfig.modEnabled = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.modEnabled)
	endIf

	if Menu == bodyScale
		if  DButtConfig.bodyScale == true
			 DButtConfig.bodyScale = false			
		else
			 DButtConfig.bodyScale = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.bodyScale)
	endIf	
	
	if Menu == bodyScale || Menu == modEnabled
		SetTitleText("Working...")
		i = 0
		while i < DButtActor.getArrayCount()
		
			if DButtActor.npc_ref[i]!=None
				if DButtConfig.bodyScale==false || DButtConfig.modEnabled==false
				
					DButtInflation.resetBody(i)
			
				endif				
				
				if Menu == modEnabled
					if DButtConfig.modEnabled == false
						DButtMain.stopMod()
						if DButtActor.npc_ref[i].HasSpell(DButtConfig.DButt_WatchDog)
							DButtActor.npc_ref[i].RemoveSpell( DButtConfig.DButt_WatchDog )
						endif
						
					else
						
						DButtModCore.resetAllWhatImportant()
						DButtMain.startMod()
					endif
					
				endif
				
			endif
			
			i+=1
		endwhile
		ForcePageReset()
		return
	
	endif



	if Menu == enableBadluck
		if  DButtConfig.enableBadluck == true
			 DButtConfig.enableBadluck = false			
		else
			 DButtConfig.enableBadluck = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.enableBadluck)
	endIf	
	
	if Menu == enableUrine
		if  DButtConfig.enableUrine == true
			 DButtConfig.enableUrine = false			
		else
			 DButtConfig.enableUrine = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.enableUrine)
	endIf	

	if Menu == bodyScaleSmooth
		if  DButtConfig.bodyScaleSmooth == true
			 DButtConfig.bodyScaleSmooth = false			
		else
			 DButtConfig.bodyScaleSmooth = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.bodyScaleSmooth)
	endIf	
	if Menu == slutViaAnalSex
		if  DButtConfig.slutViaAnalSex == true
			 DButtConfig.slutViaAnalSex = false			
		else
			 DButtConfig.slutViaAnalSex = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.slutViaAnalSex)
	endIf
	if Menu == slutViaPlug
		if  DButtConfig.slutViaPlug == true
			 DButtConfig.slutViaPlug = false			
		else
			 DButtConfig.slutViaPlug = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.slutViaPlug)
	endIf	
	if Menu == npcReact
		if  DButtConfig.npcReact == true
			 DButtConfig.npcReact = false			
		else
			 DButtConfig.npcReact = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.npcReact)
	endIf
	if Menu == oralSoundSupport
		if  DButtConfig.oralSoundSupport == true
			 DButtConfig.oralSoundSupport = false			
		else
			 DButtConfig.oralSoundSupport = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.oralSoundSupport)
	endIf	

	if Menu == enablePotion
		if  DButtConfig.enablePotion == true
			 DButtConfig.enablePotion = false			
		else
			 DButtConfig.enablePotion = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.enablePotion)
	endIf	
	if Menu == dependOnWeight
		if  DButtConfig.dependOnWeight == true
			 DButtConfig.dependOnWeight = false			
		else
			 DButtConfig.dependOnWeight = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.dependOnWeight)
	endIf
	if Menu == dependOnArousal
		if  DButtConfig.dependOnArousal == true
			 DButtConfig.dependOnArousal = false			
		else
			 DButtConfig.dependOnArousal = true
			 DButtConfig.effectOnArousal = false
			 ForcePageReset()
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.dependOnArousal)
	endIf
	if Menu == effectOnArousal
		if  DButtConfig.effectOnArousal == true
			 DButtConfig.effectOnArousal = false			
		else
			 DButtConfig.effectOnArousal = true
			 DButtConfig.dependOnArousal = false
			 ForcePageReset()
			 
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.effectOnArousal)
	endIf
	if Menu == enableFood
		if  DButtConfig.enableFood == true
			 DButtConfig.enableFood = false			
		else
			 DButtConfig.enableFood = true
		endIf
		SetToggleOptionValue(Menu,  DButtConfig.enableFood)
	endIf

	
	i = 0
	while i < DButtActor.getArrayCount()
		if Menu == slutlist[i]
			SetTitleText("Working...")
			DButtActor.unregisterActor(i)
			ForcePageReset()
			return
		endIf
		i+=1
	endwhile

	
	if Menu == enableFood || Menu == enablePotion || Menu == bodyScale || Menu == enableBadluck
		ForcePageReset()
	endif
	
endEvent

event OnOptionMenuOpen(int Menu)
	if (Menu == gasAdditionalRate)
		SetMenuDialogStartIndex(DButtConfig.gasAdditionalRate as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(speedString)
	endIf	
	if (Menu == gasProduction)
		SetMenuDialogStartIndex(DButtConfig.gasProduction as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(speedString)
	endIf
	if (Menu == urineProduction)
		SetMenuDialogStartIndex(DButtConfig.urineProduction as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(speedString)
	endIf

	if (Menu == gasProbLevel)
		SetMenuDialogStartIndex(DButtConfig.gasProbLevel as int)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(levelString)
	endIf	
	
	if (Menu == urineProbLevel)
		SetMenuDialogStartIndex(DButtConfig.urineProbLevel as int)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(levelString)
	endIf	
	
	if (Menu == gasProductionSpeed)
		SetMenuDialogStartIndex(DButtConfig.gasProductionSpeed as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(speedString)
	endIf
	
	
	if (Menu == strengthPotion)
		SetMenuDialogStartIndex(DButtConfig.vendorBoostPotion as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(levelString)
	endIf	
	
	if (Menu == strengthAnal)
		SetMenuDialogStartIndex(DButtConfig.strengthAnal as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(levelString)
	endIf
	
	if (Menu == strengthFood)
		SetMenuDialogStartIndex(DButtConfig.vendorBoostFood as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(levelString)
	endIf
	
endEvent



event OnOptionMenuAccept(int Menu, int a_index)

	if (Menu == gasProbLevel)
		DButtConfig.gasProbLevel = a_index as int
		SetMenuOptionValue(Menu, levelString[DButtConfig.gasProbLevel as int])
	endIf	
	
	if (Menu == urineProbLevel)
		DButtConfig.urineProbLevel = a_index as int
		SetMenuOptionValue(Menu, levelString[DButtConfig.urineProbLevel as int])
	endIf	
	
	if (Menu == gasAdditionalRate)
		DButtConfig.gasAdditionalRate = a_index as float
		SetMenuOptionValue(Menu, levelString[DButtConfig.gasAdditionalRate as int])
	endIf

	if (Menu == gasProduction)
		DButtConfig.gasProduction = a_index as float
		SetMenuOptionValue(Menu, levelString[DButtConfig.gasProduction as int])
	endIf
	if (Menu == urineProduction)
		DButtConfig.urineProduction = a_index as float
		SetMenuOptionValue(Menu, levelString[DButtConfig.urineProduction as int])
	endIf

	if (Menu == gasProductionSpeed)
		DButtConfig.gasProductionSpeed = a_index as float
		SetMenuOptionValue(Menu, levelString[DButtConfig.gasProductionSpeed as int])
	endIf
	
	
	
	if (Menu == strengthAnal)
		DButtConfig.strengthAnal = a_index as float
		SetMenuOptionValue(Menu, levelString[DButtConfig.strengthAnal as int])
	endIf

	if (Menu == strengthPotion)
		DButtConfig.vendorBoostPotion = a_index as float
		SetMenuOptionValue(Menu, levelString[DButtConfig.vendorBoostPotion as int])
	endIf
	
	if (Menu == strengthFood)
		DButtConfig.vendorBoostFood = a_index as float
		SetMenuOptionValue(Menu, levelString[DButtConfig.vendorBoostFood as int])
	endIf	
	
endEvent













Event OnOptionSliderOpen(Int Menu)
	sliderSetupOpenFloat(Menu,bellyScale,DButtConfig.bellyScale,0.1,20,0.1);
	sliderSetupOpenFloat(Menu,buttScale,DButtConfig.buttScale,0.1,8,0.1);
	
	
	sliderSetupOpenInt(Menu,peeVolume,DButtConfig.peeVolume,0,100,1);
	sliderSetupOpenInt(Menu,waterVolume,DButtConfig.waterVolume,0,100,1);
	sliderSetupOpenInt(Menu,painVolume,DButtConfig.painVolume,0,100,1);
	
	sliderSetupOpenInt(Menu,gurgleProb,DButtConfig.gurgleProb,0,100,1);
	sliderSetupOpenInt(Menu,enableBadluckCalmDown,DButtConfig.enableBadluckCalmDown,30,360,1);
	
	
	sliderSetupOpenInt(Menu,soundFartVolume,DButtConfig.soundFartVolume,20,100,1);
	sliderSetupOpenInt(Menu,soundGurgleVolume,DButtConfig.soundGurgleVolume,20,100,1);
	sliderSetupOpenInt(Menu,soundBadLuckShitVolume,DButtConfig.soundBadLuckShitVolume,20,100,1);
EndEvent

Event OnOptionSliderAccept(Int Menu, Float Val)

	if Menu == peeVolume
		DButtConfig.peeVolume = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
	endif	

	if Menu == waterVolume
		DButtConfig.waterVolume = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
	endif	

	if Menu == painVolume
		DButtConfig.painVolume = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
	endif	

	if Menu == gurgleProb
		DButtConfig.gurgleProb = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
	endif	
	
	if Menu == bellyScale
		DButtConfig.bellyScale = Val as Float
		SetSliderOptionValue(Menu,Val,"{1}")
	endif
	
	if Menu == buttScale
		DButtConfig.buttScale = Val as Float
		SetSliderOptionValue(Menu,Val,"{1}")
	endif
	
	if Menu == enableBadluckCalmDown
		DButtConfig.enableBadluckCalmDown = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
	endif
	
	if Menu == soundFartVolume
		DButtConfig.soundFartVolume = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
	endif

	if Menu == soundGurgleVolume
		DButtConfig.soundGurgleVolume = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
	endif	
	
	if Menu == soundBadLuckShitVolume
		DButtConfig.soundBadLuckShitVolume = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
	endif		
EndEvent



event OnOptionHighlight(int a_option)
	{Called when the user highlights an option}
	
	if (a_option == gasAdditionalRate)
		SetInfoText("Define a speed of adding additional gas coused by potions or another activity.")
	endIf

	if (a_option == gasProduction)
		SetInfoText("Speed of gas production. Yes, speed of gas production. Nothing more, just speed. Yes. Speed per tick. How many gas is produced in every tick. more = more. It's not a bait. Trust me!")
	endIf

	if (a_option == gasProductionSpeed)
		SetInfoText("Globa modifier - is used to calculate last, final portion of gas as total gas per tick (base + every additional bonus like potion, bad luck etc...)")
	endIf

	if (a_option == gasProbLevel)
		SetInfoText("Define how farting is easy - low value should fire more small farts, high value should block farting and give more chance for big farts.")
	endIf
	
endEvent


	








function sliderSetupOpenInt(Int Menu, Int IntName,Int ConfValue, int rangeStart = 0, int rangeStop = 100, int interval = 1)
	if (Menu == IntName)
		SetSliderDialogStartValue(ConfValue)
		SetSliderDialogRange(rangeStart,rangeStop)
		SetSliderDialogInterval(interval)
	endIf
endFunction

function sliderSetupOpenFloat(Int Menu, Int IntName,Float ConfValue, float rangeStart = 0.0, float rangeStop = 100.0, float interval = 1.0)
	if (Menu == IntName)
		SetSliderDialogStartValue(ConfValue)
		SetSliderDialogRange(rangeStart,rangeStop)
		SetSliderDialogInterval(interval)
	endIf
endFunction

String[] speedString
String[] levelString
String[] easyString

int[] slutlist

int modEnabled

int enablePotion
int strengthPotion

int enableFood
int strengthFood

int strengthAnal

int enableBadluckCalmDown

int gasProduction
int gasProductionSpeed
int gasAdditionalRate

int slutViaAnalSex
int slutViaPlug
int slutViaInstant

int bodyScale
int dependOnWeight
int dependOnArousal
int effectOnArousal
int bodyScaleSmooth
int bellyScale
int buttScale
int gurgleProb
int enableBadluck
int gasProbLevel
int urineProbLevel
int urineProduction

int soundFartVolume
int soundGurgleVolume
int soundBadLuckShitVolume

int oralSoundSupport
int npcReact

int logToFile
int logToConsole


int enableUrine

int painVolume
int peeVolume
int waterVolume
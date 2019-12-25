Scriptname DButt_Maintenance extends Quest  

import MiscUtil

DButt_Config Property DButtConfig Auto
DButt_Main   Property DButtMain   Auto
DButt_Actor  Property DButtActor   Auto
DButt_ModCore  Property DButtModCore   Auto

Function firstRun()

	DButtConfig.logToFile =true
	DButtConfig.logToConsole = true
	DButtConfig.modEnabled = true
	DButtConfig.playerRef = Game.getPlayer()
	DButtConfig.playerSlot = -1
	
	log("First run")
	log("Setup...")	
	
	DButtConfig.lastKnownGameVersion = 0	;force update
	DButtConfig.checkInterval = 5.0
	
	update()
	
endFunction

function update()

	float lastVersion = DButtConfig.lastKnownGameVersion
	float currentVersion = DButtMain.getVersion()

	if lastVersion==currentVersion
		log("No update requied")
		return 
	endIf
	
	
	if lastVersion < 2.0
		update20()	
	endIf
	
	if lastVersion < 2.1
		update21()	
	endIf
	
	if lastVersion < 2.2
		update22()	
	endIf
	
	if lastVersion < 2.5
		update25()	
	endIf	
	
	if lastVersion < 2.6
		update26()	
	endIf
	
	DButtConfig.lastKnownGameVersion = currentVersion

	DButtModCore.resetAllWhatImportant()
endFunction


function update26()
	DButtConfig.dependOnWeight = false
	DButtConfig.dependOnArousal = false
	DButtConfig.effectOnArousal = false
endFunction
function update25()
	
	
	DButtConfig.painVolume = 100
	DButtConfig.peeVolume = 100
	DButtConfig.waterVolume = 100
endFunction

function update22()
	DButtActor.npc_sound_piss = new Int[32]
endFunction

function update21()

	DButtConfig.enableUrine = true
	DButtConfig.urineProduction = 1
	DButtConfig.urineProductionSpeed = 1
	DButtConfig.urineSafeLevel = 30
	DButtConfig.urineProbLevel = 2
	
	DButtActor.npc_urine = new Float[32]
	int i = 0
	
	i = 0
	while i <= 31
		log("Prepare slots: "+i+"...")		
		DButtActor.npc_urine[i] = 0
		i = i + 1		
	endWhile

endFunction

function update20()
	log("Update to version 2.0")
	
	DButtConfig.logToFile =false
	DButtConfig.logToConsole = false
	
	log("Setup variables")
	
	DButtConfig.allowedsex = 2
	
	DButtConfig.gasProduction = 1			;done
	DButtConfig.gasProductionSpeed = 1		;done
	DButtConfig.gasAdditionalRate = 2
	DButtConfig.gasSafeLevel = 30
	DButtConfig.gasProbLevel = 2
	
	DButtConfig.slutViaAnalSex = true
	DButtConfig.slutViaPlug = true
	DButtConfig.enableFood = true			;done
	DButtConfig.enablePotion = true			;done

	DButtConfig.vendorBoostPotion = 2		;done
	DButtConfig.vendorBoostFood = 2			;done
	
	DButtConfig.strengthAnal = 2			;done
	
	
	DButtConfig.bodyScale = true			;done
	DButtConfig.enableBadluck = true		;done
	DButtConfig.enableBadluckCalmDown = 120	;done
	
	DButtConfig.buttScale = 2.5				;done
	DButtConfig.bellyScale = 5				;done
	DButtConfig.bodyScaleSmooth = false		;done
	
	DButtConfig.gurgleProb = 10				;done
	
	
	DButtConfig.scanerRange = 2500			;done
	
	
	DButtConfig.soundFartVolume = 100			;done
	DButtConfig.soundGurgleVolume = 100			;done
	DButtConfig.soundBadLuckShitVolume = 80		;done
	
	
	log("Register races")
	DButtConfig.allowedRaces = new Race[32]
	DButtConfig.allowedRaces[0] = DButtConfig.redguardRace
	DButtConfig.allowedRaces[1] = DButtConfig.orcRace
	DButtConfig.allowedRaces[2] = DButtConfig.nordRace
	DButtConfig.allowedRaces[3] = DButtConfig.khajiitRace
	DButtConfig.allowedRaces[4] = DButtConfig.imperialRace
	DButtConfig.allowedRaces[5] = DButtConfig.dunmerRace
	DButtConfig.allowedRaces[6] = DButtConfig.bretonRace
	DButtConfig.allowedRaces[7] = DButtConfig.bosmerRace
	DButtConfig.allowedRaces[8] = DButtConfig.argonianRace
	DButtConfig.allowedRaces[9] = DButtConfig.altmerRace
	DButtConfig.allowedRaces[10] = DButtConfig.redguardRaceVampire
	DButtConfig.allowedRaces[11] = DButtConfig.orcRaceVampire
	DButtConfig.allowedRaces[12] = DButtConfig.nordRaceVampire
	DButtConfig.allowedRaces[13] = DButtConfig.khajiitRaceVampire
	DButtConfig.allowedRaces[14] = DButtConfig.imperialRaceVampire
	DButtConfig.allowedRaces[15] = DButtConfig.dunmerRaceVampire
	DButtConfig.allowedRaces[16] = DButtConfig.bretonRaceVampire
	DButtConfig.allowedRaces[17] = DButtConfig.bosmerRaceVampire
	DButtConfig.allowedRaces[18] = DButtConfig.argonianRaceVampire
	DButtConfig.allowedRaces[19] = DButtConfig.altmerRaceVampire
	
	log("Prepare slots")
	DButtActor.npc_ref    = new Actor[32]
	DButtActor.npc_stored = new Float[32]
	DButtActor.npc_overload = new Float[32]
	DButtActor.npc_additional = new Float[32]
	DButtActor.npc_irritation = new Float[32]
	DButtActor.npc_extraProb = new Float[32]
	DButtActor.npc_hole    = new Float[32]
	DButtActor.npc_belly_tracker = new Float[32]
	DButtActor.npc_butt_tracker    = new Float[32]	
	DButtActor.npc_busy    = new Bool[32]
	DButtActor.npc_badluck_calmdown  = new Int[32]
	DButtActor.npcs_lastSound  = new Int[32]
	DButtActor.npc_sound1  = new Int[32]
	DButtActor.npc_sound2  = new Int[32]
	DButtActor.npc_sound3  = new Int[32]
	DButtActor.npc_sound4  = new Int[32]
	DButtActor.npc_sound5  = new Int[32]
	int i = 0
	
	i = 0
	while i <= 31
		log("Prepare slots: "+i+"...")
		DButtActor.npc_ref[i]    = None
		DButtActor.npc_stored[i] = 0.0
		DButtActor.npc_overload[i] = 0.0
		DButtActor.npc_additional[i] = 0.0
		DButtActor.npc_irritation[i] = 0.0
		DButtActor.npc_extraProb[i] = 0.0
		DButtActor.npc_badluck_calmdown[i] = 0
		DButtActor.npc_hole[i]   = 0.0
		DButtActor.npc_belly_tracker[i] 	= 0.0
		DButtActor.npc_butt_tracker[i]	= 0.0
		DButtActor.npc_busy[i]   = false
		DButtActor.npcs_lastSound[i] = 0
		DButtActor.npc_sound1[i] = 0
		DButtActor.npc_sound2[i] = 0
		DButtActor.npc_sound3[i] = 0
		DButtActor.npc_sound4[i] = 0
		DButtActor.npc_sound5[i] = 0
		i = i + 1
		
	endWhile
	
	
	log("Updated...")	
endFunction


function log(String msg)
	if DButtConfig.logToFile == true
		debug.trace("Devious Butt: "+ msg)
	endIf
	if DButtConfig.logToConsole == true
		PrintConsole("Devious Butt: "+ msg)
	endIf
endFunction
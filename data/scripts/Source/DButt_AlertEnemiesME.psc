Scriptname DButt_AlertEnemiesME extends activemagiceffect  

DButt_Maintenance Property DButtMaintenance Auto
DButt_Config      Property DButtConfig      Auto
DButt_Actor       Property DButtActor      Auto
DButt_Scaner	Property DButtScaner	Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool putMsg = false
	DButtMaintenance.log("Alert enemies ENTER")

	Actor[] actors
	actors = DButtScaner.getActors(akTarget)
	
	
	int i = actors.length
	while i > 0
		i -= 1
	
		DButtMaintenance.log("ACTOR CHECK")
		if actors[i]!=None && DButtActor.isScanerValid(actors[i])
		DButtMaintenance.log("ACTOR CHECK OK")

			if actors[i].IsHostileToActor(DButtConfig.playerRef) &&  actors[i].IsInCombat() == false
		DButtMaintenance.log("ACTOR CHECK OK ABLE TO ALERTED")

				actors[i].SetAlert() 
				actors[i].SendAssaultAlarm()
				actors[i].SetLookAt(akTarget)
				putMsg = true
			endIf
		endif
	endWhile
endEvent
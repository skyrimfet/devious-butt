Scriptname DButtPainEffect extends activemagiceffect  


Int Property Slot Auto
Bool Property enabled Auto
DButt_Maintenance Property DButtMaintenance Auto
DButt_Config      Property DButtConfig      Auto
DButt_Actor       Property DButtActor      Auto
DButt_Player	  Property DButtPlayer      Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
	enabled = true	
	Slot = DButtActor.isRegistered(akTarget)
	
	if Slot == -1
		self.dispel()
		return
	endIf
	
	
	
	RegisterForSingleUpdate(5)	
	
EndEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)
	enabled = false	
endEvent

Event OnUpdate()

	int pain = (DButtActor.npc_stored[Slot] as int +DButtActor.npc_urine[Slot] as int ) / 2 as int
	


	if Utility.RandomInt(1, 100) <= pain	
	
		if pain >40 && pain <= 70
			DButtPlayer.playPainLow(Slot)
		endif
	
		if pain >70 && pain <= 90
			DButtPlayer.playPainMed(Slot)
		endIf
	
		if pain >90 
			DButtPlayer.playPainHeight(Slot)
		endIf
	
	endif
	
	if enabled == true
		RegisterForSingleUpdate(5)	
	endIf
endEvent
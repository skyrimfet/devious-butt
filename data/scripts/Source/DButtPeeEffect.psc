Scriptname DButtPeeEffect extends activemagiceffect  

DButt_Maintenance	Property DButtMaintenance	Auto
DButt_Config		Property DButtConfig		Auto
DButt_Actor			Property DButtActor			Auto
DButt_Player 		Property DButtPlayer		Auto

Int Property Slot Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Slot = DButtActor.isRegistered(akTarget)

	if DButtActor.isDiapered(slot)==false
		if DButtActor.npc_ref[Slot].WornHasKeyword(DButtConfig.dbutt_catheter)==false
			DButtActor.npc_ref[Slot].addItem(DButtConfig.DButtPeeI, 1 , true)
			DButtActor.npc_ref[Slot].EquipItem(DButtConfig.DButtPeeI, true, true)
		else
			DButtActor.npc_ref[Slot].addItem(DButtConfig.DButtPeeII, 1 , true)
			DButtActor.npc_ref[Slot].EquipItem(DButtConfig.DButtPeeII, true, true)	
		endif

		if DButtConfig.enableBadluck == true
			if DButtActor.isDiapered(slot) == false	
				DButtConfig.ScanerModificator = 0.3
				DButtActor.npc_ref[slot].addSpell(DButtConfig.DButt_AlertEnemies,false)
				DButtConfig.DButt_AlertEnemies.cast(DButtActor.npc_ref[slot],DButtActor.npc_ref[slot])
			endif
		endIf
	endif
	
	RegisterForSingleUpdate(DButtActor.npc_urine[Slot] / 3)	
	DButtActor.npc_urine[Slot] = 0
	
	
	DButtPlayer.playPissRelief(Slot)
	DButtActor.npc_sound_piss[Slot] = DButtConfig.skyrimFetPumppiss.play(DButtActor.npc_ref[slot])
	Sound.SetInstanceVolume(DButtActor.npc_sound_piss[Slot],1)
EndEvent


Event OnUpdate()
	DButtActor.npc_ref[Slot].unEquipItem(DButtConfig.DButtPeeI, true, true)
	DButtActor.npc_ref[Slot].removeItem(DButtConfig.DButtPeeI, 1, true)
	DButtActor.npc_ref[Slot].removeItem(DButtConfig.DButtPeeI, 1, true)
	DButtActor.npc_ref[Slot].removeItem(DButtConfig.DButtPeeI, 1, true)
	DButtActor.npc_ref[Slot].unEquipItem(DButtConfig.DButtPeeII, true, true)
	DButtActor.npc_ref[Slot].removeItem(DButtConfig.DButtPeeII, 1, true)
	DButtActor.npc_ref[Slot].removeItem(DButtConfig.DButtPeeII, 1, true)
	DButtActor.npc_ref[Slot].removeItem(DButtConfig.DButtPeeII, 1, true)
	Sound.StopInstance(DButtActor.npc_sound_piss[Slot])     
	self.dispel()
EndEvent
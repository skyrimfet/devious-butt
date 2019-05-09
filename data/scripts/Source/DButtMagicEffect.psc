Scriptname DButtMagicEffect extends activemagiceffect  

;need to equip
Keyword property VendorItemFood auto
Keyword property VendorItemFoodRaw auto
Keyword property VendorItemPotion auto

Actor Property acActor Auto


Bool Property enabled Auto
Bool Property wait Auto
Int Property Slot Auto

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
	
	
	
	RegisterForSingleUpdate(DButtConfig.checkInterval)	
	acActor = akTarget
	wait = false
	
	RegisterForAnimationEvent(acActor, "weaponSwing") 
    RegisterForAnimationEvent(acActor, "WeaponLeftSwing") 
    RegisterForAnimationEvent(acActor, "BowRelease") 
    RegisterForAnimationEvent(acActor, "BeginCastRight") 
    RegisterForAnimationEvent(acActor, "BeginCastLeft") 
	
	
    RegisterForAnimationEvent(acActor, "JumpUp") 
    RegisterForAnimationEvent(acActor, "JumpDown")
	
	RegisterForAnimationEvent(acActor, "FootLeft") 
	RegisterForAnimationEvent(acActor, "FootRight")
    
	RegisterForAnimationEvent(acActor, "tailSneakLocomotion")
	RegisterForKey(DButtConfig.keyReliefUrine)
EndEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)
	UnregisterForAllKeys()
	enabled = false	
endEvent


Event OnKeyDown(Int KeyCode)
		DButtMaintenance.log("Key"+KeyCode)
		if DButtActor.npc_ref[Slot].WornHasKeyword(DButtConfig.dbutt_catheter)==false
			return
		endif
		
		
		if wait == true
			Debug.notification("You have to wait a moment...")
			 DButtPlayer.playPainLow(Slot)
			return
		endIf
		
		
		
		if (DButtActor.tryToUrinate(Slot,0.5, true) == true)
		else
			Debug.notification("Nothing happens...")
			DButtPlayer.playPainMed(Slot)			
		endif
		
		wait = true
		UnregisterForUpdate()
		RegisterForSingleUpdate(DButtConfig.checkInterval)	
		
EndEvent

Event OnUpdate()
	wait = true
	if enabled == true
		if acActor.Is3DLoaded()
			DButtMaintenance.log("ME update start")
			process()
			fire()
		
			DButtMaintenance.log("ME update stop")
		endif
		
		RegisterForSingleUpdate(DButtConfig.checkInterval)	
			
	endIf
	wait = false	
EndEvent



function process()

	
	
endFunction

function fire()

	DButtActor.tryToFart(Slot)
	
endFunction



	 


Event OnObjectEquipped(Form akBaseObj, ObjectReference akReference)

	potion pot = akBaseObj as potion
	
	if (pot)
	
		DButtMaintenance.log(pot)
	
		if DButtConfig.enableFood==true
			if(pot.haskeyword(VendorItemFood) || pot.haskeyword(VendorItemFoodRaw))
				DButtMaintenance.log("Food!")
				DButtActor.addAdditional(Slot,(DButtConfig.vendorBoostFood + 1 ) * 2)
				
			endif
		endIf
		
		if DButtConfig.enablePotion == true
			if(pot.haskeyword(VendorItemPotion))
				DButtMaintenance.log("Potion")
				DButtActor.addAdditional(Slot,(DButtConfig.vendorBoostPotion + 1) * 2)
				DButtActor.addUrine(Slot,(DButtConfig.vendorBoostPotion + 1) * 2)
			endif		
		endIf
		
		
		
	endif
	
EndEvent



Event OnAnimationEvent(ObjectReference akSource, string asEventName)


	if wait == true
		return
	endIf

	
	
	bool needToRun = false

	if asEventName == "weaponSwing" || asEventName == "WeaponLeftSwing" || asEventName == "BowRelease" || asEventName == "BeginCastRight" || asEventName == "BeginCastLeft" 
		if (DButtActor.tryToFart(Slot,0.3) == true)
			UnregisterForUpdate()
			needToRun = true	
			wait = true
	
		endif
		if (DButtActor.tryToUrinate(Slot,0.3) == true)
			UnregisterForUpdate()
			needToRun = true
			wait = true
		endif
	endif

	if asEventName == "JumpUp"
		if (DButtActor.tryToFart(Slot,0.3) == true)
			UnregisterForUpdate()
			needToRun = true
			wait = true
		endif
		if (DButtActor.tryToUrinate(Slot,0.3) == true)
			UnregisterForUpdate()
			needToRun = true
			wait = true
		endif
	endif
		
	if asEventName == "JumpDown"
		if (DButtActor.tryToFart(Slot,0.1) == true)
			UnregisterForUpdate()
			needToRun = true
			wait = true
		endif
		if (DButtActor.tryToUrinate(Slot,0.1) == true)
			UnregisterForUpdate()
			needToRun = true
			wait = true
		endif
	endif
 
 
 
	if asEventName == "FootLeft" || asEventName == "FootRight"
		
		if DButtActor.getIsSprinting(acActor) || DButtActor.getIsWalking(acActor) ||  DButtActor.getIsRunning(acActor)
		

			
			if DButtActor.getIsSprinting(acActor)

				if (DButtActor.tryToFart(Slot,2) == true)
					UnregisterForUpdate()
					needToRun = true
					wait = true
				endif
				if (DButtActor.tryToUrinate(Slot,2) == true)
					UnregisterForUpdate()
					needToRun = true
					wait = true
				endif
				
				
				

				
			endif

			if DButtActor.getIsRunning(acActor)
				
				if (DButtActor.tryToFart(Slot,0.3) == true)
					UnregisterForUpdate()
					needToRun = true
					wait = true
				endif
if (DButtActor.tryToUrinate(Slot,0.3) == true)
			UnregisterForUpdate()
			needToRun = true
			wait = true
		endif

			
			endif			

			if DButtActor.getIsWalking(acActor)
				
				if (DButtActor.tryToFart(Slot,0.2) == true)
					UnregisterForUpdate()
					needToRun = true
					wait = true
				endif
if (DButtActor.tryToUrinate(Slot,0.2) == true)
			UnregisterForUpdate()
			needToRun = true
			wait = true
		endif

				
			endif
			
		
		endIf
		
	
	endif
 
 
 
 
	if wait == false && asEventName != "tailSneakLocomotion"
	
		if DButtActor.npc_urine[Slot] > 50 && Utility.RandomInt(1, 200 + (2 *(100 - DButtActor.npc_urine[Slot] as int))) <= DButtActor.npc_urine[Slot] 
			DButtPlayer.playWater(Slot)
		endif
	
	endif
	
  
	if asEventName == "tailSneakLocomotion"

		if (DButtActor.tryToFart(Slot,0.3) == true)
				UnregisterForUpdate()
				needToRun = true
				wait = true
			endif
		
	endif
	
	if needToRun==true
		DButtMaintenance.log("Reset update...")
		RegisterForSingleUpdate(DButtConfig.checkInterval)	
	endif
	
	
endEvent
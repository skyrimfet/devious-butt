Scriptname DButt_Actor extends Quest  

DButt_Config Property DButtConfig Auto
DButt_Maintenance Property DButtMaintenance Auto
DButt_Player Property DButtPlayer Auto
DButt_Inflation Property DButtInflation Auto

Actor[] Property npc_ref Auto
Float[] Property npc_stored Auto
Float[] Property npc_overload Auto
Float[] Property npc_irritation Auto
Float[] Property npc_additional Auto
Float[] Property npc_extraProb Auto
Float[] Property npc_hole Auto

Float[] Property npc_urine Auto

Int[] Property npc_badluck_calmdown Auto


Float[] Property npc_butt_tracker Auto
Float[] Property npc_belly_tracker Auto

Bool[]  Property npc_busy Auto

Int[] Property npcs_lastSound Auto
Int[] Property npc_sound1 Auto
Int[] Property npc_sound2 Auto
Int[] Property npc_sound3 Auto
Int[] Property npc_sound4 Auto
Int[] Property npc_sound5 Auto

Int[] Property npc_sound_piss Auto

slaUtilScr Property Aroused Auto

int function getArrayCount()
  return ( npc_ref.length - 1 )
endFunction

int function getActorCount()
  int count = 0
  int i = 0
  while i < getArrayCount()
    if npc_ref[i] != None
	  count+=1
	  
	endif
	i+=1
  endWhile
  return count
endFunction


int function isRegistered(Actor acAktor)
   int i = 0
    while i < getArrayCount()
	  if acAktor == npc_ref[i]
	    return i
	  endif
	i+=1
	endWhile
	return -1
endFunction

int function getFirstFreeSlot()
	int i = 0
	while i < getArrayCount()
	
		if npc_ref[i] == None
			return i
		endif
		i+=1
	endWhile
	return -1
endFunction


bool function isScanerValid(Actor acActor)
	if acActor==None || acActor == DButtConfig.playerRef
		return false
	endIf
	if acActor.isDead() == true || acActor.IsChild() == true || acActor.IsGhost() == true
		return false
	endIf
	return true
endFunction


bool function isValid(Actor acActor)
	if acActor==None
		return false
	endIf
	;gander/sex
	if DButtConfig.allowedsex != 2
		if acActor.GetActorBase().GetSex() != DButtConfig.allowedsex
			return false
		endif
	endIf

	;state
	if acActor.isDead() == true || acActor.IsChild() == true || acActor.IsGhost() == true
		return false
	endIf
	
	;race
	if DButtConfig.allowedRaces.find(acActor.getRace()) == -1 
		if DButtConfig.playerRef != acActor
			return false
		endIf
		
	endIf
	
	
	

	return true
endFunction

function unregisterActor(int slot)

	if npc_ref[slot]==DButtConfig.playerRef
		DButtConfig.playerSlot = -1
	endif
  
 
    if npc_ref[slot].HasSpell(DButtConfig.DButt_WatchDog)
      npc_ref[slot].RemoveSpell( DButtConfig.DButt_WatchDog )
    endIf
	
	 if npc_ref[slot].HasSpell(DButtConfig.DButt_PainEffect)
      npc_ref[slot].RemoveSpell( DButtConfig.DButt_PainEffect )
    endIf
	
	DButtInflation.resetBody(slot)
	
	
	npc_ref[slot] = None
  

 
endFunction

int function registerActor(Actor acAktor)
	DButtMaintenance.log("Registering: "+acAktor.GetLeveledActorBase().GetName())
	
	
	if isValid(acAktor)==false
		DButtMaintenance.log("Actor: "+acAktor.GetLeveledActorBase().GetName()+" is invalid, nothing to do.")
		return -1
	endIf
	
	if isRegistered(acAktor)>=0    
		DButtMaintenance.log("Actor: "+acAktor.GetLeveledActorBase().GetName()+" founded, nothing to do.")
		return isRegistered(acAktor) 
	endif
  
    
	int i = getFirstFreeSlot()
    
	if i >=0
		if acAktor == DButtConfig.playerRef
			DButtConfig.playerSlot = i
		endif
		
		npc_ref[i] = acAktor
		npc_belly_tracker[i] 	= 0.0
		npc_butt_tracker[i]	= 0.0
		npc_stored[i] 		= 0.0
		npc_urine[i]		= 0.0
		npc_hole[i]    		= 0.0
		npcs_lastSound[i]  	= 0
		npc_busy[i]    		= false
		npc_extraProb[i] 	= 0
		npc_overload[i] 	= 0
		npc_irritation[i] 	= 0
		npc_additional[i] 	= 0
		npc_butt_tracker[i] 	= 0
		npc_belly_tracker[i] 	= 0
		
		
		npc_ref[i].addSpell(DButtConfig.DButt_WatchDog,false)
		npc_ref[i].addSpell(DButtConfig.DButt_PainEffect,false)
		DButtMaintenance.log("Actor: "+acAktor.GetLeveledActorBase().GetName()+" is added to slot "+i)
		
		DButtPlayer.playGurgle(i)
	  return i
	endif
	
	DButtMaintenance.log("Actor: "+acAktor.GetLeveledActorBase().GetName()+" is NOT registered. No free slot founded")
	
	return -1
	
endFunction


function addAdditional(int Slot,float amount)
	
	npc_additional[Slot] = npc_additional[Slot] + amount
	
	if npc_additional[Slot] > 100
		npc_additional[Slot] = 100
	endIf
	
	
endFunction


function addUrine(int Slot, float amount = 0.0)

	if amount == 0.0
		amount = DButtConfig.urineProduction + 1
	endif
	
	amount = amount * (DButtConfig.urineProductionSpeed + 1) * 0.5

	
	npc_urine[Slot] = npc_urine[Slot] + amount
	DButtMaintenance.log("addUrine"+npc_urine[Slot])
	if npc_urine[Slot] > 100
		npc_urine[Slot] = 100
	endIf
	
	
endFunction

function addGas(int Slot,float amount = 0.0)

	

	if amount == 0.0
		amount =DButtConfig.gasProduction + 1
	endif
	
	
	if npc_additional[Slot] >= ( ( DButtConfig.gasAdditionalRate + 1 ) * 2 )
		amount = amount + ( ( DButtConfig.gasAdditionalRate + 1 ) * 2 )
		npc_additional[Slot] = npc_additional[Slot] - ( ( DButtConfig.gasAdditionalRate + 1 ) * 2 )
	endIf
	
	if npc_additional[Slot] > 0 && npc_additional[Slot] < ( ( DButtConfig.gasAdditionalRate + 1 ) * 2 )
		amount = amount + npc_additional[Slot]
		npc_additional[Slot] = 0
	endIf
	
	if npc_additional[Slot] < 0
		npc_additional[Slot] = 0
	endIf
	
	
	;rescale to level
	
	amount = amount * (DButtConfig.gasProductionSpeed + 1) * 0.5
	
	
	if DButtConfig.dependOnWeight == true
		float actorWeight = npc_ref[Slot].GetActorBase().GetWeight() as float
		actorWeight = actorWeight/100
		DButtMaintenance.log("Gas weight before amount :"+amount)
		amount = amount*0.1 + (amount*0.9*actorWeight)
		DButtMaintenance.log("Gas weight after amount :"+amount)
	endif
	if DButtConfig.dependOnArousal == true
		float arousalWeight =  Aroused.GetActorExposure(npc_ref[Slot]) as float
		arousalWeight = arousalWeight/100
		DButtMaintenance.log("Gas arousal before amount :"+amount)
		amount = amount*0.1 + (amount*0.9*arousalWeight)
		DButtMaintenance.log("Gas arousal after amount :"+amount)
	endif
	
	npc_stored[Slot] = npc_stored[Slot] + amount
	
	if npc_stored[Slot] > 100
		
		npc_overload[Slot] = npc_overload[Slot] + ( npc_stored[Slot] - 100 )
	
		npc_stored[Slot] = 100
	else
		npc_overload[Slot] = 0
	endIf
	DButtMaintenance.log("Gas:"+npc_stored[Slot])
	DButtInflation.process(Slot)
endFunction

bool function tryToUrinate(int Slot, float extraProb = 0.0, bool ignoreCatheter = false)


	if npc_urine[Slot] < DButtConfig.urineSafeLevel || DButtConfig.enableUrine == false 
		return false
	endIf
	
	if  npc_ref[Slot].WornHasKeyword(DButtConfig.dbutt_catheter) && ignoreCatheter == false
		return false
	endIf
	
	int prob = 0
	prob =  npc_urine[Slot] as int + ( npc_urine[Slot] * extraProb ) as int + ( npc_urine[Slot] * DButtConfig.urineProbLevel / 4 ) as Int
	DButtMaintenance.log("tryToUrinate prob 1:"+prob)
	
	if prob > 100
		prob = 100
	endif
	
	DButtMaintenance.log("tryToUrinate prob 2:"+prob)
	
	if DButtConfig.zad == true && npc_ref[Slot].WornHasKeyword(DButtConfig.zad_DeviousPlugVaginal) 
		prob = prob / 10
	endIf
	
	DButtMaintenance.log("tryToUrinate prob 3:"+prob)
	
	bool addEffect = false
	
	if Utility.RandomInt(1, 100 * (1 + DButtConfig.urineProbLevel)) <= prob
		addEffect = true	
	endIf
	
	DButtMaintenance.log("tryToUrinate"+npc_urine[Slot])
	
	

	
	
	if addEffect == true
	DButtMaintenance.log("add effect"+npc_urine[Slot])
		if npc_ref[Slot].hasSpell(DButtConfig.DButt_PeeEffect)
			npc_ref[Slot].removeSpell(DButtConfig.DButt_PeeEffect)
		endIf
		npc_ref[Slot].addSpell(DButtConfig.DButt_PeeEffect,false)
		return true
	endIf
	return false
endFunction

bool function tryToFart(int Slot,float extraProb = 0.0)



	;over safe limit? 
	if npc_stored[Slot] < DButtConfig.gasSafeLevel
		return false
	endIf

	if DButtConfig.zad == true && npc_ref[Slot].WornHasKeyword(DButtConfig.zad_DeviousPlugAnal) 
		if Utility.RandomInt(1, 100) <= DButtConfig.gurgleProb
			DButtPlayer.playGurgle(Slot)
		endif
		
		
		;return false
	endIf
	
	int prob = 0
	prob = prob + npc_irritation[Slot] as int + npc_overload[Slot] as int + extraProb as Int
	if prob > 100 + ( 100 * npc_extraProb[Slot] )
		prob == 100 + ( 100 * npc_extraProb[Slot] )
	endIf
	
	DButtMaintenance.log("Prob"+prob)
	
	int probFrame = 100 * (1 + (DButtConfig.gasProbLevel * 0.5)) as int
	
	DButtMaintenance.log("probFrame"+probFrame)
	DButtMaintenance.log("npc_extraProb before:"+npc_extraProb)
	if npc_extraProb[Slot] > 0
		npc_extraProb[Slot] = npc_extraProb[Slot] - 0.2
		if npc_extraProb[Slot] < 0
			npc_extraProb[Slot] = 0
		endIf
	endIf
	DButtMaintenance.log("npc_extraProb before:"+npc_extraProb)
	
	if Utility.RandomInt(1, probFrame) > prob + (prob as float * extraProb)
		DButtMaintenance.log("irritation was"+npc_irritation[Slot])
		npc_irritation[Slot] = npc_irritation[Slot] + (npc_stored[Slot] * 0.05)
		DButtMaintenance.log("irritation is"+npc_irritation[Slot])
		
		if Utility.RandomInt(1, 100) <= DButtConfig.gurgleProb
			DButtPlayer.playGurgle(Slot)
			if DButtConfig.effectOnArousal == true
				float fvalue =  Aroused.GetActorExposure(npc_ref[Slot]) as float
				fvalue = fvalue + 2
				if fvalue>100
					fvalue = 100
				endif
				Aroused.SetActorExposure(npc_ref[Slot], fvalue as Int)
			endif
		endif
		return false
	
	endIf
	
	

	
	
	;25 - 20 = 5
	;100 - 20 = 80 [80/3 = 27]
	
	
	;60 - 20 = 40
	;100 - 20 = 80 [80/3 = 27]
	
	;90 - 20 = 70
	;100 - 20 = 80 [80/3 = 27]
	

	float rebased = npc_stored[Slot] - DButtConfig.gasSafeLevel
	float part = (100 - DButtConfig.gasSafeLevel ) / 3
	
	if DButtConfig.zad == true && npc_ref[Slot].WornHasKeyword(DButtConfig.zad_DeviousPlugAnal)
		if  npc_stored[Slot] >= 100 && Utility.RandomInt(0,5)==0
			DButtPlayer.playFartPlugFinal(Slot)
			if DButtConfig.effectOnArousal == true
				float fvalue =  Aroused.GetActorExposure(npc_ref[Slot]) as float
				fvalue = fvalue + 20
				if fvalue>100
					fvalue = 100
				endif
				Aroused.SetActorExposure(npc_ref[Slot], fvalue as Int)
			endif
			npc_stored[Slot] = Utility.RandomInt(DButtConfig.gasSafeLevel as Int, (2 * DButtConfig.gasSafeLevel) as Int)
			
		else
			float stored = npc_stored[Slot]
			
			if stored > 99
				stored = 99
			endif
			
			DButtMaintenance.log("PLUG FART: STORED " + npc_stored[Slot])
			if Utility.RandomInt(0, ( 100 - stored as int )* 5 ) == 0
				DButtPlayer.playFartPlug(Slot)
				if DButtConfig.effectOnArousal == true
					float fvalue =  Aroused.GetActorExposure(npc_ref[Slot]) as float
					fvalue = fvalue + 5
					if fvalue>100
						fvalue = 100
					endif
					Aroused.SetActorExposure(npc_ref[Slot], fvalue as Int)
				endif
			endif
			
		endif
		return false
	endif
	
	if  npc_stored[Slot] >= 100
		DButtConfig.ScanerModificator = 1.0
		DButtPlayer.playMega(Slot)
		if DButtConfig.effectOnArousal == true
			float fvalue =  Aroused.GetActorExposure(npc_ref[Slot]) as float
			fvalue = fvalue + 20
			if fvalue>100
				fvalue = 100
			endif
			Aroused.SetActorExposure(npc_ref[Slot], fvalue as Int)
		endif
		DButtMaintenance.log("Big")
		npc_stored[Slot] = Utility.RandomInt(DButtConfig.gasSafeLevel as Int, (2 * DButtConfig.gasSafeLevel) as Int)
		
		npc_irritation[Slot] = npc_irritation[Slot] * 0.5
		npc_overload[Slot] = npc_overload[Slot] - npc_stored[Slot]
		
	else
	
		if rebased < part
			DButtPlayer.playSmall(Slot)
			if DButtConfig.effectOnArousal == true
				float fvalue =  Aroused.GetActorExposure(npc_ref[Slot]) as float
				fvalue = fvalue + 5
				if fvalue>100
					fvalue = 100
				endif
				Aroused.SetActorExposure(npc_ref[Slot], fvalue as Int)
			endif
			DButtConfig.ScanerModificator = 0.3
			DButtMaintenance.log("Small")
			npc_stored[Slot] =  Utility.RandomInt(0, (0.5 * DButtConfig.gasSafeLevel) as Int)
		endIf
	
		if rebased >=part && rebased <part * 2
			DButtPlayer.playMed(Slot)
			if DButtConfig.effectOnArousal == true
				float fvalue =  Aroused.GetActorExposure(npc_ref[Slot]) as float
				fvalue = fvalue + 10
				if fvalue>100
					fvalue = 100
				endif
				Aroused.SetActorExposure(npc_ref[Slot], fvalue as Int)
			endif
			DButtConfig.ScanerModificator = 0.5
			DButtMaintenance.log("Med")
			npc_stored[Slot] =  Utility.RandomInt((0.2 * DButtConfig.gasSafeLevel) as Int,(0.8 * DButtConfig.gasSafeLevel) as Int)
		endIf
	
		if rebased >=part * 2 && rebased < part * 3
			DButtPlayer.playBig(Slot)
			if DButtConfig.effectOnArousal == true
				float fvalue =  Aroused.GetActorExposure(npc_ref[Slot]) as float
				fvalue = fvalue + 20
				if fvalue>100
					fvalue = 100
				endif
				Aroused.SetActorExposure(npc_ref[Slot], fvalue as Int)
			endif
			DButtConfig.ScanerModificator = 0.8
			DButtMaintenance.log("Big")
			npc_stored[Slot] =  Utility.RandomInt((DButtConfig.gasSafeLevel) as Int,(1.5 * DButtConfig.gasSafeLevel) as Int)
	
		endIf
		
		npc_irritation[Slot] = 0
		npc_overload[Slot] = 0
		
	endIf
	
	if npc_overload[Slot] < 0
		npc_overload[Slot] = 0
	endIf

		DButtMaintenance.log("Now:")
		DButtMaintenance.log("Stored"+npc_stored[Slot])
		DButtMaintenance.log("Irritated"+npc_irritation[Slot])
		DButtMaintenance.log("Overloaded"+npc_overload[Slot])
		
	if DButtConfig.enableBadluck == true	
		if isDiapered(slot) == true
			DButtMaintenance.log("Object is diapered - reduce fart detection by 0.5")
			DButtConfig.ScanerModificator = DButtConfig.ScanerModificator / 2
		endif
		npc_ref[slot].addSpell(DButtConfig.DButt_AlertEnemies,false)
		;npc_badluck_calmdown[slot] = -1
		DButtConfig.DButt_AlertEnemies.cast(npc_ref[slot], npc_ref[slot])
	endIf
	DButtInflation.process(Slot)
	
	if DButtConfig.enableBadluck == true	
		npc_ref[slot].removeSpell(DButtConfig.DButt_AlertEnemies)
	endIf
	
	npc_badluck_calmdown[slot] = (DButtConfig.enableBadluckCalmDown / DButtConfig.checkInterval as Int) as int 
	return true

endFunction




bool function getIsWalking(Actor acActor)
	if acActor.IsSprinting()
		return false
	endIf
	if acActor.IsRunning()
		return false
	endIf
	if acActor.IsSneaking()
		return false
	endIf	
	if acActor.IsSwimming()
		return false
	endIf	
	if acActor.GetAnimationVariableFloat("Speed")>0
		return true
	endIf
	
	
	return false
endFunction





bool function getIsSwimming(Actor acActor)
	return acActor.IsSwimming()
endFunction

bool function getIsSneaking(Actor acActor)
	return acActor.IsSneaking()
endFunction

bool function getIsRunning(Actor acActor)
	if acActor.IsRunning()==true && acActor.IsSprinting()==false
		return true
	endIf
	return false
endFunction

bool function getIsSprinting(Actor acActor)
	if acActor.IsRunning() && acActor.IsSprinting()
		return true
	endIf
	return false
endFunction

bool function getIsJumping(Actor acActor)
	if acActor.GetAnimationVariableBool("bInJumpState") as int == 1
		return true
	endif
	return false
endFunction


bool function isDiapered(int slot)
	if DButtConfig.dldiaper==false
		return false
	endIf
	
	if npc_ref[slot].WornHasKeyword(DButtConfig.dl_diaper)
		return true
	endIf
	
	return false
endFunction
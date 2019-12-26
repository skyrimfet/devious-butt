Scriptname DButt_ModCore extends Quest  

DButt_Scaner 	  Property DButtScaner Auto
DButt_Maintenance Property DButtMaintenance Auto
DButt_Config      Property DButtConfig Auto
DButt_Actor       Property DButtActor Auto
DButt_Player 	  Property DButtPlayer Auto
DButt_Main 		  Property DButtMain Auto

SexLabFramework Property sexlab auto
Import JsonUtil
function play()
	DButtMaintenance.log("Play()")
	
		
		
	int i = 0
	while i < DButtActor.getArrayCount()
		
		
		if DButtActor.npc_ref[i] != None
			if DButtActor.npc_ref[i].Is3DLoaded()
				DButtActor.addGas(i)
				DButtActor.addUrine(i)
				if DButtActor.npc_badluck_calmdown[i] > 0
					DButtActor.npc_badluck_calmdown[i] = DButtActor.npc_badluck_calmdown[i] - DButtConfig.checkInterval as Int
					
				endIf
				if DButtActor.npc_badluck_calmdown[i] < 0 ;&& DButtActor.npc_badluck_calmdown[i] != -1
					DButtActor.npc_badluck_calmdown[i] = 0
				endif
				
				;fix - sometimes spell is removed...
				if DButtActor.npc_ref[i].hasSpell(DButtConfig.DButt_WatchDog) == false
					DButtActor.npc_ref[i].addSpell(DButtConfig.DButt_WatchDog,false)	
				endIf
				if DButtActor.npc_ref[i].hasSpell(DButtConfig.DButt_PainEffect) == false
					DButtActor.npc_ref[i].addSpell(DButtConfig.DButt_PainEffect,false)	
				endIf			
				
				
				
			endif
		endif
		i+=1
	endWhile
	processArea()
	processEnemies()
	
	DButtMaintenance.log("EndPlay()")

endFunction


function processArea()

	if DButtConfig.slutViaPlug==true && DButtConfig.zad == true
	
		if DButtConfig.zad==true && DButtConfig.playerRef.WornHasKeyword(DButtConfig.zad_DeviousPlugAnal)
			DButtActor.registerActor(DButtConfig.playerRef)
		endIf

		Actor[] actors
		DButtConfig.ScanerModificator = 1.0
		actors = DButtScaner.getActors(DButtConfig.playerRef)
		
		int i = actors.length
		while i > 0
			i -= 1
			if actors[i]!=None
		
				if DButtConfig.zad==true && actors[i].WornHasKeyword(DButtConfig.zad_DeviousPlugAnal)
					DButtActor.registerActor(actors[i])
				endIf
		
			endif
		endWhile
	
	endif

endFunction



function processEnemies()
	DButtMaintenance.log("processEnemies() ENTER")
	if DButtConfig.enableBadluck == false || DButtConfig.playerSlot == -1
		DButtMaintenance.log("processEnemies() NOTHING TO DO")
		return
	endIf
	
	if DButtConfig.zad==true && DButtConfig.playerRef.WornHasKeyword(DButtConfig.zad_DeviousPlugAnal)
		DButtMaintenance.log("processEnemies() PLAYER IS PLUGED")
		return
	endIf
	
	DButtConfig.ScanerModificator = 1.0
	Actor[] actors
	actors = DButtScaner.getActors(DButtConfig.playerRef)
	
	DButtMaintenance.log("processEnemies() Found "+actors.length)
	
	
	bool somethingToDo = false
	int enemiesCount = 0
	int i = actors.length
	int minDistance = DButtConfig.scanerRange 
	while i > 0
		i -= 1
	
		if actors[i]!=None
			if actors[i].IsHostileToActor(DButtConfig.playerRef) &&  actors[i].IsInCombat() == false
			;if actors[i].IsHostileToActor(DButtConfig.playerRef)==false
				somethingToDo=true
				DButtMaintenance.log("processEnemies() Enemies are in near!")
				enemiesCount = enemiesCount + 1
				if DButtConfig.playerRef.GetDistance(actors[i]) < minDistance
					minDistance = DButtConfig.playerRef.GetDistance(actors[i]) as int
				endIf
			endIf
		endif
	endWhile
	
	
	
	if somethingToDo == true 
	
		Int slot = DButtActor.isRegistered(DButtConfig.playerRef)

		DButtMaintenance.log("processEnemies() Translate player into slot: " + slot)		
		
		if slot == -1
			return
		endif
		
		if DButtConfig.enableBadluck == true
			
			DButtMaintenance.log("processEnemies() npc_badluck_calmdown: "+DButtActor.npc_badluck_calmdown[DButtConfig.playerSlot])		
			
			if DButtActor.npc_badluck_calmdown[DButtConfig.playerSlot]==0			
			
				
				DButtMaintenance.log("processEnemies() Ready to fire!")
				;DButtActor.npc_badluck_calmdown[DButtConfig.playerSlot] = (DButtConfig.enableBadluckCalmDown / DButtConfig.checkInterval as Int) as int 
				;fart will set another value
				;DButtActor.npc_badluck_calmdown[DButtConfig.playerSlot] = -1 ;(DButtConfig.enableBadluckCalmDown / DButtConfig.checkInterval as Int) as int 
				DButtMaintenance.log("processEnemies() npc_badluck_calmdown (2): "+DButtActor.npc_badluck_calmdown[DButtConfig.playerSlot])		
				
				DButtPlayer.playGurgle(DButtConfig.playerSlot)
				DButtPlayer.playPreFart(DButtConfig.playerSlot)
				DButtActor.npc_badluck_calmdown[DButtConfig.playerSlot] = (DButtConfig.enableBadluckCalmDown / DButtConfig.checkInterval as Int) as int 
				DButtMaintenance.log("processEnemies() npc_extraProb: "+DButtActor.npc_extraProb[DButtConfig.playerSlot])				
				DButtActor.npc_extraProb[DButtConfig.playerSlot] = DButtActor.npc_extraProb[DButtConfig.playerSlot] + 5.0
				DButtMaintenance.log("processEnemies() npc_extraProb (2): "+DButtActor.npc_extraProb[DButtConfig.playerSlot])		
		
				
				DButtMaintenance.log("processEnemies() npc_stored: "+DButtActor.npc_stored[DButtConfig.playerSlot])		
				DButtMaintenance.log("processEnemies() gasSafeLevel: "+DButtConfig.gasSafeLevel)		
		
				if DButtActor.npc_stored[DButtConfig.playerSlot] < DButtConfig.gasSafeLevel
					DButtActor.npc_stored[DButtConfig.playerSlot] = DButtActor.npc_stored[DButtConfig.playerSlot] + DButtConfig.gasSafeLevel
				else
					DButtActor.addAdditional(DButtConfig.playerSlot,(DButtConfig.gasSafeLevel / 2))	
				endIf
				
				DButtMaintenance.log("processEnemies() + min dist " +minDistance )
				int sneakBonus=0
				if DButtActor.npc_ref[DButtConfig.playerSlot].IsSneaking()
					sneakBonus = 2
					if minDistance < 1500
						enemiesCount = enemiesCount + 3
					endIf
				endIf
				
				while enemiesCount > 0
					enemiesCount -= 1
					DButtMaintenance.log("processEnemies() + try to add extra")
					if Utility.RandomInt(0, enemiesCount+2-sneakBonus)==0
						DButtMaintenance.log("processEnemies() + extra ADDED")
						if DButtActor.npc_stored[DButtConfig.playerSlot] < DButtConfig.gasSafeLevel
							DButtActor.npc_stored[DButtConfig.playerSlot] = DButtActor.npc_stored[DButtConfig.playerSlot] + DButtConfig.gasSafeLevel
						else
							DButtActor.addAdditional(DButtConfig.playerSlot,(DButtConfig.gasSafeLevel / 2))	
						endIf
					endif
						
				endWhile
				
				
				
				
				DButtMaintenance.log("processEnemies() npc_stored: "+DButtActor.npc_stored[DButtConfig.playerSlot])		
				
			
			endif
			

			
			;
			
		endif
	endIf
	

endFunction




function resetAllWhatImportant()


	If Game.GetModByName("Devious Devices - Assets.esm") != 255
		DButtConfig.zad = true
		DButtConfig.zad_DeviousPlugAnal		= Game.GetFormFromFile(0x0001DD7D, "Devious Devices - Assets.esm") as Keyword		
		DButtConfig.zad_DeviousPlugVaginal	= Game.GetFormFromFile(0x0301DD7C, "Devious Devices - Assets.esm") as Keyword		
			
	else															
		DButtConfig.zad = false
	EndIf
	
	if (Game.GetModbyName("SLSO.esp") != 255)
		DButtConfig.separateOrgasmPack = true				
	else
		DButtConfig.separateOrgasmPack = false
	endIf

	if (Game.GetModbyName("DLSkyrim.esp") != 255)
	
		DButtConfig.dldiaper = true				
		DButtConfig.dl_diaper				= Game.GetFormFromFile(0x0101E900, "DLSkyrim.esp") as Keyword	
	else
		DButtConfig.dldiaper = false
	endIf	
	
	
	
	DButtMaintenance.log("Reseting...")

	int i = 0
	while i < DButtActor.getArrayCount()
    
		if DButtActor.npc_ref[i] != None
			
			if DButtActor.npc_ref[i].hasSpell(DButtConfig.DButt_WatchDog)
				DButtActor.npc_ref[i].removeSpell(DButtConfig.DButt_WatchDog)
			endIf
			DButtActor.npc_ref[i].addSpell(DButtConfig.DButt_WatchDog,false)
			
			if DButtActor.npc_ref[i].hasSpell(DButtConfig.DButt_PainEffect)
				DButtActor.npc_ref[i].removeSpell(DButtConfig.DButt_PainEffect)
			endIf
			DButtActor.npc_ref[i].addSpell(DButtConfig.DButt_PainEffect,false)
			
			;do what you want
	  
		endif
		i+=1
	endWhile
	
	unregisterEvents()
	registerEvents()
	DButtMaintenance.log("Reseting is done!")
endFunction

function unregisterEvents()
	UnregisterForModEvent("HookOrgasmEnd")
	UnregisterForModEvent("DTOrgasmS")
	UnregisterForModEvent("HookStageStart")
	UnregisterForModEvent("HookAnimationEnd")
endFunction

function registerEvents()
	RegisterForModEvent("HookAnimationEnd", "AnimationEnd")
	RegisterForModEvent("HookStageStart", "StageStart")
	if DButtConfig.separateOrgasmPack == false
		RegisterForModEvent("HookOrgasmEnd", "DBHookOrgasmEnd")
	else
		RegisterForModEvent("SexLabOrgasmSeparate","DTOrgasmS")
	endIf
endFunction

Event AnimationEnd(int threadID, bool HasPlayer)

debug.notification("end event")
	SslThreadController thread = SexLab.GetController(threadID)
	Actor[] actorList = thread.Positions
	actorList[0].removeSpell(DButtConfig.DButt_OralSound)
	
endEvent

Event StageStart(int threadID, bool HasPlayer)
	if DButtConfig.oralSoundSupport==false
		return
	endif
	
	DButtMaintenance.log("STAGE")
	DButtMaintenance.log("STAGE ----- STAGE")
	DButtMaintenance.log("STAGE")
	SslThreadController thread = SexLab.GetController(threadID)
	Int currentStage =  thread.Stage
	DButtMaintenance.log("current stage "+currentStage)
	if currentStage >= 0
	
		SslBaseAnimation animation = thread.Animation
		
		String AnimName = "BlowJob"
		String path = "DeviousButt/blowjobAnimsDB_"+DButtMain.getJsonVersion()+".json";
		
		JsonUtil.Load(path)
		
		DButtMaintenance.log("IS VALID: "+JsonUtil.IsGood(path))
		DButtMaintenance.log("GET ERR: "+JsonUtil.GetErrors(path))
		DButtMaintenance.log("GET Cont: "+JsonUtil.JsonInFolder(path))
		int[] list = JsonUtil.IntListToArray(path, animation.Name);
		DButtMaintenance.log("LIST:"+list)
		
		;debug tool
		if list.length==0 || 1==2
			if animation.HasTag("Blowjob") || animation.HasTag("Oral")
				JsonUtil.IntListAdd(path, animation.Name, 0, false)
				JsonUtil.Save(path)
				debug.messagebox(animation.Name +" "+currentStage)
			endIf
		endif
		
		Actor[] actorList = thread.Positions
			Actor primaryActor
			primaryActor = actorList[0]
			primaryActor.removeSpell(DButtConfig.DButt_OralSound)
			
		if  list[(currentStage - 1)] == 1;animation.HasTag("Blowjob") || animation.HasTag("Oral")
			DButtMaintenance.log("its correct tag ")
			
			DButtMaintenance.log("primary actor "+primaryActor)
			Bool isPrimaryFemale = SexLab.GetGender(primaryActor) == 1
			if isPrimaryFemale
				primaryActor.addSpell(DButtConfig.DButt_OralSound,false)
			endif
		
		endif
		
	endif
	
EndEvent




Event DTOrgasmS(Form ActorRef, Int Thread)
	actor akActor = ActorRef as actor
	string argString = Thread as string
	
	SslThreadController threadctrl = SexLab.GetController(Thread)
	SslBaseAnimation anim = threadctrl.Animation
	;String[] tags = anim.GetTags()
	Actor[] actors = threadctrl.Positions
	int i = actors.length

	i = actors.length
  
	while i > 0
		i -= 1
		if i == 0
	            
			if anim.hasTag("Anal")
		
				int slot = DButtActor.registerActor(actors[i])
				if slot>=0
					DButtActor.addAdditional(Slot,(DButtConfig.strengthAnal + 1) * 5)				
					DButtActor.npc_extraProb[slot] = DButtActor.npc_extraProb[slot] + 2.0
				endif
			
			endif
		
		endif	  
	endwhile

EndEvent




Event DBHookOrgasmEnd(int thread, bool hasPlayer)


DButtMaintenance.log("seex seex seex:"+i)
	if DButtConfig.slutViaAnalSex==false
		return
	endif
  SslThreadController threadctrl = SexLab.GetController(thread)
  SslBaseAnimation anim = threadctrl.Animation
  Actor[] actors = threadctrl.Positions
  int i = actors.length

  i = actors.length
  
  while i > 0
      i -= 1
	  if i == 0
	            
		if anim.hasTag("Anal")
		
			int slot = DButtActor.registerActor(actors[i])
			if slot>=0
				DButtActor.addAdditional(Slot,(DButtConfig.strengthAnal + 1) * 5)				
				DButtActor.npc_extraProb[slot] = DButtActor.npc_extraProb[slot] + 2.0
			endif
			
		endif
		
  	  endif	  
  endwhile
 
endEvent


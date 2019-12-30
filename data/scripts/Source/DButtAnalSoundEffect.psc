Scriptname DButtAnalSoundEffect extends activemagiceffect

DButt_Config	Property DButtConfig		Auto
DButt_Actor		Property	DButtActor Auto
DButt_Player Property DButtPlayer Auto
DButt_ModCore	Property DButtModCore Auto
SexLabFramework Property SexLab Auto
Actor akActor
slaUtilScr Property Aroused Auto
bool isWorking
Int fartSlut

Event OnEffectStart(Actor akTarget, Actor akCaster)
	isWorking = true
	fartSlut = DButtActor.isRegistered(akTarget)
	akActor = akTarget
	RegisterForSingleUpdate(Utility.randomInt(0,1) as float)
EndEvent

Event OnUpdate()
	if (isWorking==false)
		return
	endif
	DButtActor.addGas(fartSlut,Utility.randomInt(5,60))
	if DButtActor.tryToFart(fartSlut,Utility.randomInt(1,50))==false
		RegisterForSingleUpdate(Utility.randomInt(2,6) as float)
		DButtPlayer.playGurgle(fartSlut)
	else
		if DButtConfig.SLSOusing==true && DButtConfig.usingSexlabThread >=0
			sslThreadModel thread = SexLab.GetController(DButtConfig.usingSexlabThread)
			sslActorAlias[] actorAlias = thread.ActorAlias
			;int enjoyment = actorAlias[1].GetFullEnjoyment()
			Actor[] actorList = thread.Positions
			int rank =  DButtModCore.getFartFanFaction(actorList[1],Utility.randomInt(2,10))
			int enjoyment = (-50 + (10 * rank ) ) * 1
			;poor but i need it 
			SexLab.GetController(DButtConfig.usingSexlabThread).ActorAlias(actorList[1]).BonusEnjoyment(actorList[1],enjoyment)
			if rank >=9
				if Utility.randomInt(0,10-(Aroused.GetActorExposure(actorList[1])/10) as Int) == 0
					Debug.notification(actorList[1].GetLeveledActorBase().GetName() + " achieves a spontaneous orgasm. (Devious Butt)")
					SexLab.GetController(DButtConfig.usingSexlabThread).ActorAlias(actorList[1]).orgasm(-2)
				endif
			endif
			if  DButtConfig.effectOnArousal == false
				SexLab.GetController(DButtConfig.usingSexlabThread).ActorAlias(actorList[0]).BonusEnjoyment(actorList[0],-50)
			else
				SexLab.GetController(DButtConfig.usingSexlabThread).ActorAlias(actorList[0]).BonusEnjoyment(actorList[0],50)
			endif
			
			;actorAlias[1].BonusEnjoyment(actorList[1] , (-50 + (10 * rank ) ) * 4  )
			;actorAlias[0].BonusEnjoyment(actorList[0] ,-200)
			
			;sslActorAlias actorAlias
		endif
		Actor[] actorList = SexLab.GetController(DButtConfig.usingSexlabThread).Positions
		if DButtConfig.usingSexlabThread >=0
			float arousalWeight =  Aroused.GetActorExposure(actorList[1]) as float
			arousalWeight = arousalWeight - (10 * (5 - DButtModCore.getFartFanFaction(actorList[1])))
			Aroused.SetActorExposure(actorList[1], arousalWeight as Int)
			
			arousalWeight =  Aroused.GetActorExposure(actorList[0]) as float
			if  DButtConfig.effectOnArousal == false
				arousalWeight = arousalWeight - 33
			else
				arousalWeight = arousalWeight + 33
			endif
			Aroused.SetActorExposure(actorList[0], arousalWeight as Int)
			
		endif
		self.dispel()
	endif
	
	
EndEvent

Event onEffectFinish(Actor akTarget, Actor akCaster)
	isWorking = false
	;DButtActor.npc_stored[fartSlut]=0	;prevent post fartum xd
EndEvent
Scriptname DButtAnalSoundEffect extends activemagiceffect

DButt_Config	Property DButtConfig		Auto
DButt_Actor		Property	DButtActor Auto
DButt_Player Property DButtPlayer Auto
SexLabFramework Property SexLab Auto
Actor akActor

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
	DButtActor.addGas(fartSlut,Utility.randomInt(15,60))
	if DButtActor.tryToFart(fartSlut,50)==false
		RegisterForSingleUpdate(Utility.randomInt(2,6) as float)
		DButtPlayer.playGurgle(fartSlut)
	else
		if DButtConfig.SLSOusing==true && DButtConfig.usingSexlabThread >=0
			sslThreadModel thread = SexLab.GetController(DButtConfig.usingSexlabThread)
			sslActorAlias[] actorAlias = thread.ActorAlias
			int enjoyment = actorAlias[1].GetFullEnjoyment()
			Actor[] actorList = thread.Positions
			actorAlias[1].BonusEnjoyment(actorList[1] ,200)
			actorAlias[0].BonusEnjoyment(actorList[0] ,200)
			;sslActorAlias actorAlias
		endif
		self.dispel()
	endif
	
	
EndEvent

Event onEffectFinish(Actor akTarget, Actor akCaster)
	isWorking = false
	DButtActor.npc_stored[fartSlut]=0	;prevent post fartum xd
EndEvent
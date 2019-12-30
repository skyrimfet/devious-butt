Scriptname DButtOralSoundEffect extends activemagiceffect  

DButt_Config		Property DButtConfig		Auto
Actor akActor
bool isWorking

Event OnEffectStart(Actor akTarget, Actor akCaster)
	isWorking = true
	akActor = akTarget
	RegisterForSingleUpdate(Utility.randomInt(0,1) as float)
EndEvent

Event OnUpdate()
	if (isWorking==false)
		return
	endif
	RegisterForSingleUpdate(Utility.randomInt(1,3) as float)
	DButtConfig.skyrimFetPumpOralDeep.play(akActor)
EndEvent

Event onEffectFinish(Actor akTarget, Actor akCaster)
	isWorking = false
EndEvent
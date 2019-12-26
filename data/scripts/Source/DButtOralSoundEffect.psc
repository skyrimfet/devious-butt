Scriptname DButtOralSoundEffect extends activemagiceffect  

DButt_Config		Property DButtConfig		Auto
Actor akActor

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akActor = akTarget
	RegisterForSingleUpdate(Utility.randomInt(0,1) as float)
EndEvent

Event OnUpdate()


	RegisterForSingleUpdate(Utility.randomInt(2,3) as float)
	DButtConfig.skyrimFetPumpOralDeep.play(akActor)
EndEvent

Event onEffectFinish(Actor akTarget, Actor akCaster)
EndEvent
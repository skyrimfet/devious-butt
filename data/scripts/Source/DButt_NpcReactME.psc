Scriptname DButt_NpcReactME extends activemagiceffect  

DButt_Maintenance Property DButtMaintenance Auto
DButt_Config      Property DButtConfig      Auto
DButt_Actor       Property DButtActor      Auto
DButt_Scaner	Property DButtScaner	Auto
Actor[] actors
Faction Property SexLabAnimatingFaction Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DButtMaintenance.log("ACTOR REACT")
	
	actors = DButtScaner.getActors(akTarget)

	int i = actors.length
	while i > 0
		i -= 1
	
		DButtMaintenance.log("ACTOR REACT")
		if actors[i]!=None && DButtActor.isScanerValid(actors[i])
			DButtMaintenance.log("ACTOR REACT OK")

			if actors[i].IsHostileToActor(DButtConfig.playerRef)==false &&  actors[i].IsInCombat() == false
				if DButtConfig.allowedRaces.find(actors[i].getRace()) > -1 && akTarget.HasLOS(actors[i])
					if actors[i].GetActorBase().GetSex() == 0
						int s = DButtConfig.skyrimFetPumpcrowdeventshame_male.play(actors[i])
					else
						int s = DButtConfig.skyrimFetPumpcrowdeventshame_female.play(actors[i])
					endif
					actors[i].SetLookAt(akTarget)
					if (actors[i].GetSitState() == 0 && actors[i].IsInFaction(SexLabAnimatingFaction)==false)
						int randAnim = Utility.randomInt(0,4)
						if randAnim<=2
							debug.SendAnimationEvent(actors[i],"IdleLaugh")
						endIf
						if randAnim==3
							debug.SendAnimationEvent(actors[i],"IdleApplaud2")
						endif
						if randAnim==4
							debug.SendAnimationEvent(actors[i],"IdleApplaud3")
						endif
					endif
				endIf
			endif
		endif
	endWhile
	Utility.wait(2.5)
	i = actors.length
	while i > 0
		i -= 1
		if (actors[i].GetSitState() == 0 && actors[i].IsInFaction(SexLabAnimatingFaction)==false)
			debug.SendAnimationEvent(actors[i],"IdleForceDefaultState")
		endif
	endWhile
	
	;RegisterForSingleUpdate(5.0)
	
	
;	int s = DButtConfig.skyrimFetPumpcrowdeventshame_male.play(akTarget)
	;Sound.SetInstanceVolume(s,v)
endEvent


Event onEffectFinish(Actor akTarget, Actor akCaster)
 ; Debug.Messagebox("Magic effect fades from " + akTarget)
EndEvent

Event OnUpdate()
	;self.dispel()
EndEvent
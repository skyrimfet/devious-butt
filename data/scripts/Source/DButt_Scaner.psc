Scriptname DButt_Scaner extends Quest  


DButt_Config Property DButtConfig Auto
DButt_Maintenance Property DButtMaintenance Auto
DButt_Actor  Property DButtActor   Auto

Actor[] function getActors(Actor acAktor, float range = 0.0 )

	Actor[] actors
	actors = new Actor[32]

	Actor acActor = acAktor

	float rad = DButtConfig.scanerRange as float
	if ( range != 0 )
		rad = range
	endif
	
	if DButtConfig.ScanerModificator != 1.0
		rad = rad * DButtConfig.ScanerModificator
	endif
	
	float posx = acActor.GetPositionX()
	float posy = acActor.GetPositionY()
	float posz = acActor.GetPositionZ()


	int i = 0
	int index = 0
	while i < 30
		
		actor npctoadd = Game.FindRandomActor(posx, posy, posz, rad)

		if actors.find(npctoadd)==-1 && DButtActor.isScanerValid(npctoadd) == true			
			actors[index] = npctoadd
			index+=1
		endif
		
		i+=1
	endWhile

	return actors
endFunction
Scriptname DButt_Main extends Quest  


DButt_Maintenance Property DButtMaintenance Auto
DButt_Config      Property DButtConfig      Auto
DButt_ModCore     Property DButtModCore Auto
DButt_Actor     Property DButtActor Auto


float function getVersion()
	return 2.9
endfunction

string function getJsonVersion()
	return "11"
endfunction

Event OnInit()

	DButtMaintenance.firstRun()
	
	
	;sexEvents()
	RegisterForSingleUpdate(2 * DButtConfig.checkInterval)	;wait a moment...
	
	;DButtActor.registerActor(DButtConfig.playerRef)
	;DButtActor.registerActor(DButtConfig.playerRef)
EndEvent


Event OnUpdate()
	
	if DButtConfig.modEnabled == true
		DButtModCore.play()		
		RegisterForSingleUpdate(DButtConfig.checkInterval)
	endIf
EndEvent

function stopMod()
	UnregisterForUpdate()
endfunction

function startMod()
	RegisterForSingleUpdate(DButtConfig.checkInterval)
endfunction
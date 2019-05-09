Scriptname DButt_Alias    extends ReferenceAlias


DButt_Maintenance Property DButtMaintenance Auto
DButt_ModCore     Property DButtModCore Auto



Event OnPlayerLoadGame()


	DButtMaintenance.update()
	DButtModCore.resetAllWhatImportant()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	
	DButtModCore.resetAllWhatImportant()
endEvent
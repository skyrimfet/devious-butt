Scriptname DButt_Inflation extends Quest  

DButt_Actor  Property DButtActor   Auto
DButt_Config  Property DButtConfig   Auto
DButt_Maintenance Property DButtMaintenance Auto

function Process(Int Slot)

DButtMaintenance.log("body changes")
	if DButtConfig.bodyScale == false
		return
	endif
	
	bool slif_installed = Game.GetModbyName("SexLab Inflation Framework.esp") != 255
	
	float scale = DButtActor.npc_stored[Slot]
	
	float bellysize = (( (scale/100) * DButtConfig.bellyScale ) * 0.5)

	if DButtConfig.enableUrine == true 
		bellysize = bellysize + ( (DButtActor.npc_urine[Slot]/100) * DButtConfig.bellyScale )
	endIf
	
	float buttsize = ((scale/100) * DButtConfig.buttScale)
	
	if DButtConfig.enableUrine == true 
		buttsize = buttsize + ( (DButtActor.npc_urine[Slot]/100) * DButtConfig.buttScale ) * 0.5
	endIf
	
	
	if (slif_installed)
		SLIF_Main.inflate(DButtActor.npc_ref[slot], "Devious Butt", "slif_butt", buttsize, -1, -1, "Devious Butt")	
		SLIF_Main.inflate(DButtActor.npc_ref[slot], "Devious Butt", "NPC Belly", bellysize, -1, -1, "Devious Butt")
		return
	endIf
	
	

	;DButtActor.npc_belly_tracker
	;DButtActor.npc_butt_tracker
	
	if DButtConfig.bodyScaleSmooth==true
		if buttsize > DButtActor.npc_butt_tracker[Slot]
			;  1.5 - 1
			if buttsize - DButtActor.npc_butt_tracker[Slot] > 0.3
				DButtActor.npc_butt_tracker[Slot] = DButtActor.npc_butt_tracker[Slot] + 0.3
			else
				DButtActor.npc_butt_tracker[Slot] = DButtActor.npc_butt_tracker[Slot] + (buttsize - DButtActor.npc_butt_tracker[Slot])
			endIf
		else
			;	1.5 - 1
			if DButtActor.npc_butt_tracker[Slot] - buttsize > 0.5
				DButtActor.npc_butt_tracker[Slot] = DButtActor.npc_butt_tracker[Slot] - 0.5
			else
				DButtActor.npc_butt_tracker[Slot] = DButtActor.npc_butt_tracker[Slot] - (DButtActor.npc_butt_tracker[Slot] - buttsize)
			endif
	
		endif
		
		if bellysize > DButtActor.npc_belly_tracker[Slot]
			;  1.5 - 1
			if bellysize - DButtActor.npc_belly_tracker[Slot] > 0.3
				DButtActor.npc_belly_tracker[Slot] = DButtActor.npc_belly_tracker[Slot] + 0.3
			else
				DButtActor.npc_belly_tracker[Slot] = DButtActor.npc_belly_tracker[Slot] + (bellysize - DButtActor.npc_belly_tracker[Slot])
			endIf
		else
			;	1.5 - 1
			if DButtActor.npc_belly_tracker[Slot] - bellysize > 0.5
				DButtActor.npc_belly_tracker[Slot] = DButtActor.npc_belly_tracker[Slot] - 0.5
			else
				DButtActor.npc_belly_tracker[Slot] = DButtActor.npc_belly_tracker[Slot] - (DButtActor.npc_belly_tracker[Slot] - bellysize)
			endif
	
		endif
	
		bellysize = DButtActor.npc_belly_tracker[Slot]
		buttsize = DButtActor.npc_butt_tracker[Slot]
	else
		DButtActor.npc_belly_tracker[Slot] = bellysize
		DButtActor.npc_butt_tracker[Slot] = buttsize
	endif
	
	bool isPlayer = DButtActor.npc_ref[slot] == Game.GetPlayer()
	bool isFemale = DButtActor.npc_ref[slot].GetLeveledActorBase().GetSex() == 1
	
	;calc butt
	float buttNode = 0
	
	if (slif_installed)
		buttNode = SLIF_Main.GetValue(DButtActor.npc_ref[slot], "All Mods", "NPC L Butt", 1.0) / SLIF_Main.GetValue(DButtActor.npc_ref[slot], "Devious Butt", "NPC L Butt", 1.0)
	else
		buttNode = NetImmerse.GetNodeScale( DButtActor.npc_ref[slot], "NPC L Butt", true) as float
		
		if (NiOverride.HasNodeTransformScale(   DButtActor.npc_ref[slot], False, True, "NPC L Butt", "Devious Butt"))
			;logic:
			;current node = 6 ( 4 + 2 )
			;we got 3/2 6 / (3/2) = 4 
			if NiOverride.GetNodeTransformScale(DButtActor.npc_ref[slot], False, True, "NPC L Butt", "Devious Butt") > 0
				buttNode /= NiOverride.GetNodeTransformScale(DButtActor.npc_ref[slot], False, True, "NPC L Butt", "Devious Butt")
			else
				buttNode = 0
			endIf
			
		endif
	endif
	
	;logic:
	; we have 4 we want to add 2, we want to get 6... well:
	; ( 4 + 2 ) / 4 => 6/4  => 3/2   and   3/2 * 4 = 6  ok...

	float buttmult = 1
	if buttNode > 0
		buttmult = ( buttNode + buttsize ) / buttNode
	endIf
	
	if (slif_installed)
		SLIF_Main.inflate(DButtActor.npc_ref[slot], "Devious Butt", "slif_butt", buttsize, -1, -1, "Devious Butt")
	else
		AddNodeTransformScale(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC L Butt", buttmult)
		AddNodeTransformScale(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC R Butt", buttmult)
		UpdateNodeTransform(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC L Butt") 
		UpdateNodeTransform(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC R Butt") 
	endIf
	
	;calc belly
	float bellyNode = 0
	
	if (slif_installed)
		bellyNode = SLIF_Main.GetValue(DButtActor.npc_ref[slot], "All Mods", "NPC Belly", 1.0) / SLIF_Main.GetValue(DButtActor.npc_ref[slot], "Devious Butt", "NPC Belly", 1.0)
	else
		bellyNode = NetImmerse.GetNodeScale( DButtActor.npc_ref[slot], "NPC Belly", true) as float
		
		if (NiOverride.HasNodeTransformScale(   DButtActor.npc_ref[slot], False, True, "NPC Belly", "Devious Butt"))
			if NiOverride.GetNodeTransformScale(DButtActor.npc_ref[slot], False, True,"NPC Belly", "Devious Butt") > 0
				bellyNode /= NiOverride.GetNodeTransformScale(DButtActor.npc_ref[slot], False, True,"NPC Belly", "Devious Butt")
			else
				bellyNode = 0
			endIf
		endIf
	endIf

	float bellymult = 1
	if bellyNode > 0
		bellymult = ( bellyNode + bellysize ) / bellyNode
	endIf
	
	if (slif_installed)
		SLIF_Main.inflate(DButtActor.npc_ref[slot], "Devious Butt", "NPC Belly", bellysize, -1, -1, "Devious Butt")
	else
		AddNodeTransformScale(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC Belly", bellymult)
		UpdateNodeTransform(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC Belly") 
	endIf
	
endFunction


function resetBody(int slot)
	if (Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
		SLIF_Main.unregisterActor(DButtActor.npc_ref[slot], "Devious Butt")
	endIf
	bool isPlayer = DButtActor.npc_ref[slot] == Game.GetPlayer()
	bool isFemale = DButtActor.npc_ref[slot].GetLeveledActorBase().GetSex() == 1
	
	RemoveNodeTransformScale(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC Belly")
	RemoveNodeTransformScale(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC L Butt")
	RemoveNodeTransformScale(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC R Butt")
	
	UpdateNodeTransform(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC Belly")
	UpdateNodeTransform(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC L Butt")
	UpdateNodeTransform(DButtActor.npc_ref[slot], isPlayer, isFemale, "NPC R Butt")
endFunction

function AddNodeTransformScale(Actor kActor, bool isPlayer, bool isFemale, string sKey, float value)
	NiOverride.AddNodeTransformScale(kActor, False, isFemale, sKey, "Devious Butt", value)
	if (isPlayer)
		NiOverride.AddNodeTransformScale(kActor, True, isFemale, sKey, "Devious Butt", value)
	endIf
endFunction

function RemoveNodeTransformScale(Actor kActor, bool isPlayer, bool isFemale, string sKey)
	NiOverride.RemoveNodeTransformScale(kActor, False, isFemale, sKey, "Devious Butt")
	if (isPlayer)
		NiOverride.RemoveNodeTransformScale(kActor, True, isFemale, sKey, "Devious Butt")
	endIf
endFunction

function UpdateNodeTransform(Actor kActor, bool isPlayer, bool isFemale, string sKey)
	NiOverride.UpdateNodeTransform(kActor, False, isFemale, sKey)
	if (isPlayer)
		NiOverride.UpdateNodeTransform(kActor, True, isFemale, sKey)
	endIf
endFunction

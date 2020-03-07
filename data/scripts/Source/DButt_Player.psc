Scriptname DButt_Player extends Quest  

DButt_Maintenance Property DButtMaintenance Auto
DButt_Config      Property DButtConfig      Auto
DButt_Actor       Property DButtActor      Auto

function playSound(int slot, sound effect, float volume = 1.0)

	int lastPointer = DButtActor.npcs_lastSound[slot]
	lastPointer = lastPointer + 1
	if lastPointer > 5
		lastPointer = 1
	endif
	
	 DButtActor.npcs_lastSound[slot] = lastPointer
		
	
	if lastPointer == 1
		DButtActor.npc_sound1[slot] = effect.play(DButtActor.npc_ref[slot])
		Sound.SetInstanceVolume(DButtActor.npc_sound1[slot],volume)
	endif
	
	if lastPointer == 2
		DButtActor.npc_sound2[slot] = effect.play(DButtActor.npc_ref[slot])
		Sound.SetInstanceVolume(DButtActor.npc_sound2[slot],volume)
	endif
	
	if lastPointer == 3
		DButtActor.npc_sound3[slot] = effect.play(DButtActor.npc_ref[slot])
		Sound.SetInstanceVolume(DButtActor.npc_sound3[slot],volume)
	endif

	if lastPointer == 4
		DButtActor.npc_sound4[slot] = effect.play(DButtActor.npc_ref[slot])
		Sound.SetInstanceVolume(DButtActor.npc_sound4[slot],volume)
	endif
	
	if lastPointer == 5
		DButtActor.npc_sound5[slot] = effect.play(DButtActor.npc_ref[slot])
		Sound.SetInstanceVolume(DButtActor.npc_sound5[slot],volume)
	endif
	
	
endfunction

function playGurgle(int slot)
	playSound(slot, DButtConfig.DButt_Gurgle,(DButtConfig.soundGurgleVolume as float/100) as float)
endfunction

function playSmall(int slot)
	float soundVol = DButtConfig.soundFartVolume as float
	if DButtActor.isDiapered(slot) == true
		soundVol = soundVol / 2
	endif
	playSound(slot, DButtConfig.DButt_fartSmall,(soundVol as float/100) as float)
endfunction

function playMed(int slot)
	float soundVol = DButtConfig.soundFartVolume as float
	if DButtActor.isDiapered(slot) == true
		soundVol = soundVol / 2
	endif
	if DButtActor.npc_ref[slot] == Game.getPlayer()
		Game.ShakeCamera(None, afStrength = 0.1, afDuration = 1.0)
	endif
	playSound(slot, DButtConfig.DButt_fartMed,(soundVol as float/100) as float)
endfunction

function playBig(int slot)
	float soundVol = DButtConfig.soundFartVolume as float
	if DButtActor.isDiapered(slot) == true
		soundVol = soundVol / 2
	endif
	if DButtActor.npc_ref[slot] == Game.getPlayer()	
		Game.ShakeCamera(None, afStrength = 0.2, afDuration = 1.5)
	endif
	playSound(slot, DButtConfig.DButt_fartBig,(soundVol as float/100) as float)
endfunction

function playMega(int slot)
	float soundVol = DButtConfig.soundFartVolume as float
	if DButtActor.isDiapered(slot) == true
		soundVol = soundVol / 2
	endif
	if DButtActor.npc_ref[slot] == Game.getPlayer()
		Game.ShakeCamera(None, afStrength = 0.3, afDuration = 2.0)
	endif
	playSound(slot, DButtConfig.DButt_fartMega,(soundVol as float/100) as float)
endfunction


function playFartPlug(int slot)
	float soundVol = DButtConfig.soundFartVolume as float
	if DButtActor.isDiapered(slot) == true
		soundVol = soundVol / 2
	endif
	if DButtActor.npc_ref[slot] == Game.getPlayer()
		Game.ShakeCamera(None, afStrength = 0.1, afDuration = 1.0)
	endif
	playSound(slot, DButtConfig.skyrimFetPumpFartButtplug,(soundVol as float/100) as float)
endfunction

function playFartPlugFinal(int slot)
	float soundVol = DButtConfig.soundFartVolume as float
	if DButtActor.isDiapered(slot) == true
		soundVol = soundVol / 2
	endif
	if DButtActor.npc_ref[slot] == Game.getPlayer()
		Game.ShakeCamera(None, afStrength = 0.3, afDuration = 1.5)
	endif
	playSound(slot, DButtConfig.skyrimFetPumpFartButtplugFinal,(soundVol as float/100) as float)
endfunction

function playPreFart(int slot)
	playSound(slot, DButtConfig.DButt_PreFart,(DButtConfig.soundBadLuckShitVolume as float/100) as float)
endfunction

function playPissRelief(int slot)
	float soundvolume = (DButtConfig.peeVolume as float/100) as float
	if DButtActor.isDiapered(slot)
		soundvolume = soundvolume * 0.5
	endif
	playSound(slot, DButtConfig.SexLabVoiceFemale01Mild, soundvolume)
endfunction

function playCalmAlert(int slot)
	playSound(slot, DButtConfig.DButt_calmAlert,(DButtConfig.painVolume as float/100) as float)
endfunction	

function playWater(int slot)
	playSound(slot, DButtConfig.skyrimFetPumpwater,(DButtConfig.waterVolume as float/100) as float)
endfunction	

function playTryToHold(int slot)
	playSound(slot, DButtConfig.DButt_TryToHold,(DButtConfig.painVolume as float/100) as float)
endfunction	

function playTryToHoldHard(int slot)

	playSound(slot, DButtConfig.DButt_TryToHoldHard,(DButtConfig.painVolume as float/100) as float)
endfunction	

function playPainLow(int slot)
	playSound(slot, DButtConfig.skyrimFetPumppainlow,(DButtConfig.painVolume as float/100) as float)
endfunction	

function playPainMed(int slot)
	playSound(slot, DButtConfig.skyrimFetPumppainmed,(DButtConfig.painVolume as float/100) as float)
endfunction	

function playPainHeight(int slot)
	playSound(slot, DButtConfig.skyrimFetPumppainheight,(DButtConfig.painVolume as float/100) as float)
endfunction	
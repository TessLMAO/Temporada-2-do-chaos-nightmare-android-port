local xx = 800
local yy = 800
local xx2 = 800
local yy2 = 800
local ofs = 0
local followchars = true
local zoomers = false
local dead = false

function onCreate()
	makeLuaSprite('red', nil, -1000, 0)
	makeGraphic('red', 5000, 4000, 'FF0000')
	addLuaSprite('red', false)
end

function onCreatePost()
	precacheSound('go')

	setProperty('healthLoss', 0)

	setPropertyFromClass('ClientPrefs', 'noReset', true)

	makeLuaSprite('tape', nil, 0, 0)
	makeGraphic('tape', screenWidth, screenHeight, '000000')
	setObjectCamera('tape', 'camHud')
	setProperty('tape.alpha', 0); addLuaSprite('tape', true)


	makeLuaSprite('go', 'escapism-assets/hi-there', 0, 0)
	setProperty('go.alpha', 0)
	addLuaSprite('go', true)
	setObjectCamera('go', 'other')
	scaleObject('go', screenWidth/getProperty('go.width'), screenHeight/getProperty('go.height'))

	for i = 0,3 do
		setPropertyFromGroup('strumLineNotes', i, 'x', -500)
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if getProperty('health') >= 0.20 then setProperty('health', getProperty('health') - 0.15) elseif getProperty('health') < 0.20 and dead == false then setProperty('health', 0.0001); die() end
end

function onEvent(name, value1, value2)
	if name == 'Griddy' then --events BS
		gritty = tonumber(value1)
		subgritty = tonumber(value2)
		if gritty == 0 then
			ofs = 0
		elseif gritty == 1 then
			if subgritty == 3 then
				ofs = 50
			end
		elseif gritty == 3 then
			if subgritty == 0 then
				removeLuaSprite('red', true)
				xx = 810
				yy = 650
				xx2 = 810
				yy2 = 650
			elseif subgritty == 4 then
				zoomers = true
				ofs = 50
				xx = 800
				yy = 800
				xx2 = 800
				yy2 = 800
			end
		end
	end
end

function onUpdate(elapsed)
	--Follow Cam Stuff LMAO
     if followchars == true then
        if mustHitSection == false then
			if zoomers == true then
				setProperty("defaultCamZoom", 0.9)
			end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else
			if zoomers == true then
				setProperty("defaultCamZoom", 0.6)
			end
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
	else
        triggerEvent('Camera Follow Pos','','')
	end

	if getPropertyFromClass('flixel.FlxG', 'keys.pressed.R') and dead == false then
		die()
	end
end

function onSongStart()
	--exitSong(true)

	--setProperty('hey.alpha', 1)
	--cameraShake('camHUD', 0.025, 1)
end

function onTimerCompleted(tag)
	if tag == 'death' then
		exitSong(true)
	end
end

function die()
	setProperty('boyfriend.stunned', true)

	for i = 0, getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes', i, 'mustPress') == false then
			setPropertyFromGroup('notes', i, 'ignoreNote', true)
		end
	end
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
		end
	end

	setPropertyFromClass('flixel.FlxG','sound.music.volume',0)
	dead = true

	setProperty('tape.alpha', 1)
	setProperty('go.alpha', 1)

	playSound('go', 0.8)

	cameraShake('other', 0.0029, 0.35)

	runTimer('death', 6.5)
end
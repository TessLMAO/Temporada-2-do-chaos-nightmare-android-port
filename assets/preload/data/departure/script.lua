local innocence = true
local boo = false
local guh = false

function onStartSong()
	setPropertyFromClass('flixel.FlxG','sound.music.volume',1)
end

function onCreate()
	setProperty('skipCountdown',true)
	
	setPropertyFromClass('flixel.FlxG','sound.music.volume',0)
	
	precacheImage('characters/tv-s2')
	addCharacterToList('nmi-s2', 'dad')
	addCharacterToList('nmi-s3', 'dad')
	addCharacterToList('nmi-s4', 'dad')
	addCharacterToList('hikari-s2', 'bf')
	addCharacterToList('hikari-s3', 'bf')
	addCharacterToList('hikari-s4', 'bf')
end

function onCreatePost()
	
	makeAnimatedLuaSprite('tv', 'characters/tv-s2', 400, 650)
    addAnimationByPrefix('tv', 'idle', 'tv static', 24, true)
	addAnimationByPrefix('tv', 'laugh', 'nmi tv laugh', 24, true)
	addAnimationByPrefix('tv', 'off', 'tv turn off', 24, false)
	addAnimationByPrefix('tv', 'inactive', 'tv turn off0028', 1, false)
    objectPlayAnimation('tv', 'idle', false)
	addLuaSprite('tv', false)
	setProperty("tv.alpha", 0)
	
	setObjectOrder('gfGroup', '0') --who???
	setObjectOrder('dadGroup', '2')
	setObjectOrder('tv', '3')
	setObjectOrder('boyfriendGroup', '4')
	
	makeLuaSprite('blackshit', nil, 0, 0)
	makeGraphic('blackshit', screenWidth, screenHeight, '000000')
	setObjectCamera('blackshit', 'hud')
	addLuaSprite('blackshit', true)
	
	makeLuaSprite('title', 'escapism-assets/nmi-title', 0, 0)	
	setProperty('title.alpha', 1)
	addLuaSprite('title', true)
	setObjectCamera('title', 'other')
	
	makeLuaSprite('fall', 'escapism-assets/fall', 0, 0)	
	setProperty('fall.alpha', 0)
	addLuaSprite('fall', true)
	setObjectCamera('fall', 'other')
	
	makeLuaSprite('hey', 'escapism-assets/hi-there', 0, 0)	
	setProperty('hey.alpha', 0)
	addLuaSprite('hey', true)
	setObjectCamera('hey', 'other')
	
	runTimer('gottaGhost', 2.5, 1)
end

function onTimerCompleted(tag)
	if tag == 'gottaGhost' then
	    doTweenAlpha('hnggg', 'title', 0, 0.5, 'linear')
		doTweenAlpha('crinjj', 'blackshit', 0, 0.5, 'linear')
	end
end

function onTweenCompleted(tag) -- title goes bye bye
    if tag == 'hnggg' then
		removeLuaSprite('title', true)
	end
	if boo == true then --fnaf
		if tag == 'ping' then
			doTweenAlpha('pong', 'hey', 0, 0.12, 'linear')
		elseif tag == 'pong' then
			doTweenAlpha('ping', 'hey', 1, 0.12, 'linear')
		end
	end
end

function onUpdate(elapsed)
    if innocence == false then --when the innocence is no more
        if getProperty('dad.animation.curAnim.name') == 'singDOWN' then --layering stuff with the tv
            setObjectOrder('dadGroup', '4')
				setObjectOrder('tv', '3')
		else
			setObjectOrder('dadGroup', '3')
			setObjectOrder('tv', '4')
		end
	end
	if boo == true then
		cameraShake('other', 0.025, 0.01)
		runTimer('ooh',0.01)
	end
end

function onEvent(name, value1, value2)
	if name == 'Griddy' then --events BS
		gritty = tonumber(value1)
		subgritty = tonumber(value2)
		if gritty == 0 then --scene 1 default
			cameraFlash('camHUD', 'FFFFFF', 0.3, false)
			triggerEvent("Change Character",'dad','tv-s1')
			triggerEvent("Change Character",'bf','hikari-s1')
			setProperty("boyfriend.x", 600)
			setProperty("boyfriend.y", 400)
			setProperty("dad.x", -150)
			setProperty("dad.y", 600)
		elseif gritty == 1 then --scene 2 nmi with tv
			if subgritty == 0 then
				innocence = false
				setProperty("tv.alpha", 1)
				triggerEvent("Change Character",'dad','nmi-s2')
				triggerEvent("Change Character",'bf','hikari-s2')
				setProperty("dad.alpha", 0)
				setProperty("boyfriend.x", 400)
				setProperty("boyfriend.y", 1400)
				setProperty("dad.y", 200)
				setObjectOrder('dadGroup', '3')
				setObjectOrder('tv', '4')
				setObjectOrder('boyfriendGroup', '5')
			elseif subgritty == 1 then
				objectPlayAnimation('tv', 'laugh', false)
			elseif subgritty == 2 then
				objectPlayAnimation('tv', 'off', false)
				triggerEvent("Play Animation",'entrance','dad')
				setProperty("dad.alpha", 1)
				setProperty("dad.x", 400)
				setProperty("dad.y", 200)
				doTweenY('hemoovesin', 'boyfriend', 950, 0.7, 'cubeIn')
			elseif subgritty == 3 then
				objectPlayAnimation('tv', 'inactive', false)
			end
		elseif gritty == 2 then --scene 3 he's right behind me isnt he?
			setProperty("tv.alpha", 0)
			triggerEvent("Change Character",'dad','nmi-s3')
			triggerEvent("Change Character",'bf','hikari-s3')
			setProperty("boyfriend.y", 700)
			setProperty("dad.y", 450)
			cameraFlash('camHUD', 'FFFFFF', 0.3, false)
		elseif gritty == 3 then --for all the marbles
			if subgritty == 0 then
				setObjectOrder('blackshit', '6')
				setProperty("blackshit.alpha", 1)
				setObjectCamera('blackshit', 'other')
				triggerEvent("Change Character",'dad','nmi-s4')
				triggerEvent("Change Character",'bf','hikari-s4')
				setProperty("dad.alpha", 0)
				setProperty("boyfriend.y", 800)
				setProperty("dad.x", 300)
				setProperty("dad.y", 300)
			elseif subgritty == 1 then --he appears
				doTweenAlpha('cronjj', 'blackshit', 0, 0.5, 'linear')
				setProperty("boyfriend.alpha", 0)
				setProperty("defaultCamZoom", 1.6)
			elseif subgritty == 2 then
				innocence = true
				setObjectOrder('dadGroup', '1')
				setObjectOrder('boyfriendGroup', '2')
				setProperty("dad.alpha", 1)
			elseif subgritty == 3 then
				setProperty("iconP2.alpha", 0)
				setProperty("dad.alpha", 0)
				for i = 0, getProperty('opponentStrums.length')-1 do
					setPropertyFromGroup('opponentStrums',i,'visible',false)
				end
			elseif subgritty == 4 then	--hikari comes back
				setProperty("boyfriend.alpha", 1)
				setProperty("defaultCamZoom", 0.6)
				setProperty("blackshit.alpha", 0)
				removeLuaSprite('fall', true)
				
			elseif subgritty == 5 then	--FALL!
				setProperty("fall.alpha", 1)
				setProperty("blackshit.alpha", 1)
			end
		elseif gritty == 4 then --fnaf
			if subgritty == 0 then
				boo = true
				setObjectOrder('hey', '9')
				doTweenAlpha('ping', 'hey', 1, 0.1, 'quartIn')
				setProperty("blackshit.alpha", 1)
				runTimer('ooh',0.01)
			elseif subgritty == 1 then
				boo = false
				setProperty("blackshit.alpha", 0)
				setProperty("hey.alpha", 0)
			end
		end
	end
end
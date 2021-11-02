local BanksGrabMod = {}
local skins = {"s_m_m_armoured_01","s_m_m_armoured_02","s_m_m_security_01"}
local timeMaxNotGrab = 20 

local bankData = {
      {
             timerNotGrab = 0, -- Банк в Палето-бей
             coord = {-103.434, 6478.280, 31.60},
             money = {2000,10000},
             money_devided_into = 10,
             stars = 2,
             ped = {
                     {-105.93,6470.80,31.04,141.80,"weapon_pistol"},
                     {-103.70,6465.80,31.04,49.06,"WEAPON_ADVANCEDRIFLE"}
                   }
      },
      {
             timerNotGrab = 0, -- Fleeca банк, Бретон
             coord = {-353.434, -54.280, 49.037},
             money = {9000,25000},
             money_devided_into = 10,
             stars = 3,
             ped = {
                     {-355.93,-46.80,49.04,243.80,"weapon_pistol"},
                     {-357.70,-52.80,49.04,320.06,"WEAPON_ADVANCEDRIFLE"},
                     {-347.70,-52.80,49.04,75.06,"WEAPON_ADVANCEDRIFLE"}
                   }
      },
      {
             timerNotGrab = 0, -- Пиллбокс-хилл
             coord = {147.434, -1045.106, 29.363},
             money = {25000,100000},
             money_devided_into = 10,
             stars = 4,
             ped = {
                     {144.90,-1037.38,29.37,242.80,"weapon_pistol"},
                     {152.27,-1041.64,29.37,27.00,"WEAPON_ADVANCEDRIFLE"},
                     {142.27,-1044.64,29.37,341.00,"WEAPON_ADVANCEDRIFLE"}
                   }
      },
      {
             timerNotGrab = 0, -- Fleeca банк, Рокфорд-хиллз
             coord = {-1211.21, -335.52, 37.78},
             money = {9000,25000},
             money_devided_into = 10,
             stars = 3,
             ped = {
                     {-1218.67,-331.53,37.38,267.03,"weapon_pistol"},
                     {-1213.81,-336.66,37.78,107.54,"WEAPON_ADVANCEDRIFLE"},
                     {-1211.81,-327.66,37.78,122.54,"WEAPON_ADVANCEDRIFLE"}
                   }
      },
      {
             timerNotGrab = 0, -- Fleeca банк, Альта
             coord = {311.724, -283.415, 54.165},
             money = {25000,100000},
             money_devided_into = 10,
             stars = 4,
             ped = {
                     {316.65,-280.03,54.17,5.03,"weapon_pistol"},
                     {309.31,-275.26,54.17,240.70,"WEAPON_ADVANCEDRIFLE"},
                     {309.54,-282.35,54.16,54.24,"WEAPON_ADVANCEDRIFLE"}
                   }
      },
      {
             timerNotGrab = 0, -- Fleeca банк, Каньон Бэнхэм
             coord = {-2957.724, 481.953, 15.693},
             money = {9000,25000},
             money_devided_into = 10,
             stars = 3,
             ped = {
                     {-2962.64,485.76,15.70,148.89,"weapon_pistol"},
                     {-2964.62,477.41,15.70,347.64,"weapon_pistol"},
                     {-2958.09,478.52,15.70,171.82,"WEAPON_ADVANCEDRIFLE"}
                   }
      },
      {
             timerNotGrab = 0, -- Fleeca банк, Пустыня Гранд-Сенора
             coord = {1175.94, 2711.70, 38.09},
             money = {2000,10000},
             money_devided_into = 10,
             stars = 2,
             ped = {
                     {1172.34,2706.57,38.09,239.29,"weapon_pistol"},
                     {1180.58,2704.84,38.09,77.56,"weapon_pistol"},
                     {1179.26,2711.54,38.09,264.65,"WEAPON_ADVANCEDRIFLE"}
                   }
      },
      {
             timerNotGrab = 0, -- Центр Вайнвуд
             coord = {264.6, 213.5, 102.5},
             money = {100000,500000},
             money_devided_into = 10,
             stars = 5,
             ped = {
                     {237.26,212.16,106.29,15.36,"weapon_pistol"},
                     {238.28,226.91,106.29,138.90,"weapon_pistol"},
                     {258.26,219.04,106.29,152.85,"weapon_pistol"},
                     {260.70,221.07,106.29,58.35,"weapon_pistol"},
                     {261.05,212.02,110.28,89.27,"weapon_pistol"},
                     {258.26,206.39,106.28,250.77,"weapon_pistol"},
                     {260.99,215.62,106.28,247.57,"WEAPON_ADVANCEDRIFLE"},
                     {264.73,219.93,101.68,295.42,"WEAPON_ADVANCEDRIFLE"},
                     {259.70,223.60,101.68,338.25,"WEAPON_ADVANCEDRIFLE"},
                     {252.58,227.20,101.68,253.95,"WEAPON_ADVANCEDRIFLE"}
                   }
      }
}

local peds = {}
local blips = {}
local Stage = {
      state = 0,
      modelPl = {0,3},
      name = {[0]="Майкл",[1]="Джейкоб",[2]="Тревор"},
      bankID = 0,
      money = 0
}

function round(exact, quantum)
    local quant,frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end

local function saveDatas ()
 local file = io.open("scripts/addins/BanksGrabModConfig.txt","w");
 if file == nil then
    file = io.open("scripts/addins/BanksGrabModConfig.txt","w"); 
    file:close();
    file = io.open("scripts/addins/BanksGrabModConfig.txt","w");
 end
 for i, tTable in pairs(bankData) do
   file:write(""..tTable.timerNotGrab.."\n"); -- "\n" признак конца строки
 end
 file:flush();
 file:close();
end 

local function loadDatas ()
 local file = io.open("scripts/addins/BanksGrabModConfig.txt","r");
 if file ~= nil then
    file:seek("set",0);
    local i = 0
    for line in file:lines() do
        i = i + 1
        bankData[i].timerNotGrab = tonumber(line)
    end
    file:close();
 else
   saveDatas ()
   wait(50)
   loadDatas ()
 end
end 
loadDatas ()

function nildatasavestage ()
       Stage.modelPl = {0,3}
       Stage.bankID = 0
       Stage.money = 0
	   Stage.state = 0
       saveDatas ()
end

function drawText(text, x, y, scale)
  UI.SET_TEXT_FONT(6)
  UI.SET_TEXT_SCALE(scale, scale)
  UI.SET_TEXT_COLOUR(255, 255, 255, 255)
  UI.SET_TEXT_WRAP(0.0, 1.0)
  UI.SET_TEXT_CENTRE(false)
  UI.SET_TEXT_DROPSHADOW(2, 2, 0, 0, 0)
  UI.SET_TEXT_EDGE(1, 0, 0, 0, 205)
  UI._SET_TEXT_ENTRY("STRING")
  UI._ADD_TEXT_COMPONENT_STRING(text)
  UI._DRAW_TEXT(y, x)
end

function notify(msg)
  UI._SET_NOTIFICATION_TEXT_ENTRY("STRING")
  UI._ADD_TEXT_COMPONENT_STRING(msg)
  UI._DRAW_NOTIFICATION(true, true)
end

local function createBlip ()
   for i, tTable in pairs(bankData) do
      peds[i] = {0,{}}
      local coordx,coordy,coordz = tTable.coord[1],tTable.coord[2],tTable.coord[3]
      local bankBlip = UI.ADD_BLIP_FOR_COORD(coordx, coordy, coordz)
      UI.SET_BLIP_SCALE(bankBlip, 1)
      UI.SET_BLIP_SPRITE(bankBlip, 108)
      UI.SET_BLIP_COLOUR(bankBlip, 5)
      UI.SET_BLIP_AS_SHORT_RANGE(bankBlip, true)
      blips[i] = bankBlip
   end
end
createBlip ()

local function createPed(ID)

  local pedTabl = bankData[ID].ped
  for i, p in pairs(pedTabl) do
      local x,y,z,rott,weaponN = p[1],p[2],p[3],p[4],p[5]
      local skin_hash = GAMEPLAY.GET_HASH_KEY(skins[math.random(1,#skins)])
      STREAMING.REQUEST_MODEL(skin_hash)
      while not STREAMING.HAS_MODEL_LOADED(skin_hash) do
        wait(50)
      end
      local clones = PED.CREATE_PED(26, skin_hash, x, y, z, rott, true, true)
      PED.SET_PED_RELATIONSHIP_GROUP_HASH(clones, GAMEPLAY.GET_HASH_KEY("SECURITY_GUARD"))
      WEAPON.GIVE_DELAYED_WEAPON_TO_PED(clones, GAMEPLAY.GET_HASH_KEY(weaponN), 5, true);
      ENTITY.SET_ENTITY_INVINCIBLE(clones, false);
      local blip = UI.ADD_BLIP_FOR_ENTITY(clones);
      UI.SET_BLIP_SCALE(blip, 0.7)
      local max = #peds[ID][2] + 1
      peds[ID][2][max] = {clones,blip}
  end
end
local function deletePed (i)
         if peds[i][1] ~= 0 then
            peds[i][1] = 0
            for p=1, #peds[i][2] do
                PED.DELETE_PED(peds[i][2][p][1])
            end
            peds[i][2] = {}
         end 
end

local function customGetsLocation (location,distance)
 local bB = 0
 local playerPed = PLAYER.PLAYER_PED_ID()
 local player = PLAYER.GET_PLAYER_PED(playerPed)
 for i, tTable in pairs(bankData) do
     local coordx,coordy,coordz = tTable.coord[1],tTable.coord[2],tTable.coord[3]
     local distanceR = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( coordx,coordy,coordz, location.x, location.y, location.z, true )
     if GAMEPLAY.GET_GAME_TIMER() < tTable.timerNotGrab then 
        local distToR = 10
        if i == #bankData then distToR = 30 end
        if distanceR < distToR then
           local tS = (tTable.timerNotGrab - GAMEPLAY.GET_GAME_TIMER()) / 1000
           local tM = math.floor(tS / 60) 
           local tS = math.floor(tS - (tM*60) )
           drawText("Дождитесь пока шумиха утихнет. Еще "..tM..":"..tS.." ", 0.5, 0.5, 0.7)
        end
        if blips[i] ~= 0 then
           UI.REMOVE_BLIP(blips[i]);
           blips[i] = 0
        end 

     elseif GAMEPLAY.GET_GAME_TIMER() > tTable.timerNotGrab and ( blips[i] == 0 ) then
        tTable.timerNotGrab = 0
        local bankBlip = UI.ADD_BLIP_FOR_COORD(coordx, coordy, coordz)
        UI.SET_BLIP_SCALE(bankBlip, 1)
        UI.SET_BLIP_SPRITE(bankBlip, 108)
        UI.SET_BLIP_COLOUR(bankBlip, 5)
        UI.SET_BLIP_AS_SHORT_RANGE(bankBlip, true)
        blips[i] = bankBlip
        saveDatas ()
     end
     if distanceR < 80 then
         if #peds[i][2] == 0 and peds[i][1] == 0 then
            peds[i][1] = 1
            createPed(i)
         else
            for p=1, #peds[i][2] do
                if (ENTITY.IS_ENTITY_DEAD(peds[i][2][p][1])) and peds[i][2][p][2] ~= 0 then
                    UI.REMOVE_BLIP(peds[i][2][p][2]);
                    peds[i][2][p][2] = 0
                end
            end
         end 
        local distToR = 10
        if i == #bankData then distToR = 30 end
        if (distanceR < distToR ) then
           if GAMEPLAY.GET_GAME_TIMER() < tTable.timerNotGrab then
              if (PLAYER.GET_PLAYER_WANTED_LEVEL(player)<tTable.stars) then
                  PLAYER.SET_PLAYER_WANTED_LEVEL(player,tTable.stars,false)
                  PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(player,false)
              end
              drawText("Вас опознали как грабителя.", 0.45, 0.5, 0.7)
           end 
         end
     elseif (distanceR > 80 ) then
         if peds[i][1] ~= 0 then
            deletePed (i)
         end 
     end
     if (GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( 257.07,220.90,106.29 , location.x, location.y, location.z, true ) < 4 ) then
                if (GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( 257.07,220.90,106.29 , location.x, location.y, location.z, true ) < 2 ) then
                   if (PLAYER.GET_PLAYER_WANTED_LEVEL(player)<1)then
                       PLAYER.SET_PLAYER_WANTED_LEVEL(player,1,false)
                   PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(player,false)
                   end
                end
                if bankData[#bankData].timerNotGrab == 0 then
                   drawText("Взорвите хранилище внизу. Успейте забежать в него.", 0.5, 0.5, 0.7)
                end
     end
     if (distanceR < distance ) then
         bB = i
     end
 end
 return bB
end

function BanksGrabMod.tick()
 local playerPed = PLAYER.PLAYER_PED_ID()
 local player = PLAYER.GET_PLAYER_PED(playerPed)
 local location = ENTITY.GET_ENTITY_COORDS( playerPed, nil )
 local model = 0
 if (PED.IS_PED_MODEL(playerPed, GAMEPLAY.GET_HASH_KEY("player_one"))) then                                
    model = 1                                         
 elseif (PED.IS_PED_MODEL(playerPed, GAMEPLAY.GET_HASH_KEY("player_two"))) then
    model = 2
 end
 if(Stage.state==0) then
    local i = customGetsLocation (location,2)
    if (i~=0) then
       local bank = bankData[i]
       if GAMEPLAY.GET_GAME_TIMER() < bank.timerNotGrab then
          if (PLAYER.GET_PLAYER_WANTED_LEVEL(player)<bank.stars) then
              PLAYER.SET_PLAYER_WANTED_LEVEL(player,bank.stars,false)
              PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(player,false)
          end
          notify("Они высылают полицию, денег в хранилище нет.")
       elseif GAMEPLAY.GET_GAME_TIMER() > bank.timerNotGrab then
	      Stage.state = 1
          bankData[i].timerNotGrab = GAMEPLAY.GET_GAME_TIMER() + (timeMaxNotGrab*60000)
          FIRE.ADD_EXPLOSION(location.x, location.y, location.z+10,1,1.0,false,false,0)
          PED.SET_PED_COMPONENT_VARIATION(playerPed, 9, 1, 0, 0)
          PLAYER.SET_PLAYER_WANTED_LEVEL(player,bank.stars,false)
          PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(player,false)  
          Stage.modelPl = {playerPed,model}
          Stage.bankID = i
          local moneys = math.random(bank.money[1],bank.money[2])
          local parts = bankData[i].money_devided_into
          local part_of_money = round(moneys / parts, 1)
          notify("Оставайтесь на в хранилище, чтобы собрать еще денег.")

          while parts > 0 do
            local player_coords = ENTITY.GET_ENTITY_COORDS( playerPed, nil )
            local distance = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( bank.coord[1],bank.coord[2],bank.coord[3], player_coords.x, player_coords.y, player_coords.z, true )

            if (distance > 3) then
                break
            end

            Stage.money = Stage.money + part_of_money
            notify("+ $"..(part_of_money))
            notify("Вы собрали $"..Stage.money)
            parts = parts - 1
            wait(3000)
          end

          notify("Вы взяли $"..Stage.money..", скройтесь от полиции.")    
          saveDatas ()
       end
    end         
  elseif(Stage.state==1) then
    if model ~= Stage.modelPl[2] then
       notify(""..Stage.name[Stage.modelPl[2]].." не смог совершить ограбление.")
       PED.SET_PED_COMPONENT_VARIATION(Stage.modelPl[1], 9, 0, 0, 0)
       nildatasavestage ()
    else
       if not(ENTITY.IS_ENTITY_DEAD(playerPed)) and not (PLAYER.IS_PLAYER_BEING_ARRESTED(player,true)) then
          if (PLAYER.GET_PLAYER_WANTED_LEVEL(player)==0) then
     		 Stage.state = 2
             local moneys = Stage.money
             local statname = "SP"..model.."_TOTAL_CASH"
             local hash = GAMEPLAY.GET_HASH_KEY(statname)
             local _,score = STATS.STAT_GET_INT(hash, 0, -1)
             PED.SET_PED_COMPONENT_VARIATION(playerPed, 9, 0, 0, 0) 
             AUDIO.PLAY_MISSION_COMPLETE_AUDIO("FRANKLIN_SMALL_01")
             notify(""..Stage.name[Stage.modelPl[2]].." Удачное ограбление, всего : "..moneys.." $")
			 UI.DISPLAY_CASH(true)
             STATS.STAT_SET_INT(hash, score+moneys, true)
             nildatasavestage ()
          end
       else
             notify(""..Stage.name[Stage.modelPl[2]].." не смог совершить ограбление.")
             PED.SET_PED_COMPONENT_VARIATION(playerPed, 9, 0, 0, 0)
             nildatasavestage ()
       end
    end
  end
end


function BanksGrabMod.init() end
function BanksGrabMod.unload()
    for i, tTable in pairs(bankData) do
         if peds[i][1] ~= 0 then
            deletePed (i)
         end 
        if blips[i] ~= 0 then
           UI.REMOVE_BLIP(blips[i]);
           blips[i] = 0
        end 
    end
    saveDatas ()
end

return BanksGrabMod

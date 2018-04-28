local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Frames = SLD_Frames or require("SLD_Frames")
local SLD_Events = SLD_Events or require("SLD_Events")
local HandleLDMsg

if AIO.AddAddon() then
   
   --
   -- FUNCIONES DE UTILIDAD DEL SERVER
   --
   function mysplit(inputstr, sep)
      if sep == nil then
         sep = "%s"
      end
      t={}
      local i=1
      for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
         t[i] = str
         i = i + 1
      end
      return t
   end
   function SendMsgGroup ( player, msg )
      local MyGrp = player:GetGroup()
      if MyGrp == nil then
         AIO.Msg():Add("LDMsg", msg ):Send(player)
         return
      end
      local GrPj = MyGrp:GetMembers()
      local NumGrPj = MyGrp:GetMembersCount()
      PrintInfo("[DEBUG]SendAddonMsgGroup:847[" .. tostring(MyGrp) .. "][" .. tostring(NumGrPj) .."]")
      for LoopVar=1,NumGrPj do
         AIO.Msg():Add("LDMsg", msg ):Send(GrPj[LoopVar])
         PrintInfo("[DEBUG]SendMsgGroup:31[" .. tostring(GrPj[LoopVar]:GetAccountName()) .. "]Sending")
      end
   end
   function LD_SetPjVar ( LD_Pj, LD_Index, LD_Value, LD_Type )
      local ThisDate = 20180505
	  print (LD_Index)
      local MySQLCommand= "INSERT INTO LD_SessionVars" .. 
	  " (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. LD_Pj .. 
	  "','" .. LD_Index .. "','" .. LD_Value .. "','" .. LD_Type .. "', " ..
	  tostring(ThisDate) .. ") ON DUPLICATE KEY UPDATE LD_PJ='" .. 
	  LD_Pj .. "' LD_INDEX='" .. LD_Index .. "';"
	   
	   PrintInfo("[INFO]LD_SetPjVar:[" .. MySQLCommand .. "]")
   end
   --
   -- FUNCION PRINCIPAL DE MANEJO DE MENSAJES
   --
   function HandleLDMsg(player, msg)
      local LD_Table = mysplit ( msg , "#" )
      LD_Head = LD_Table[1]
      LD_Body = LD_Table[2]
      if LD_Head == "PRTXT" then     -- IMPRIME UN TEXTO POR EL CHAT GENERAL A LOS MIEMBROS DEL GRUPO
         SendMsgGroup(player, msg)
      elseif LD_Head == "HELLO" then -- PERSONAJE ENTRA AL MUNDO
         AIO.Msg():Add("LDMsg", "ROLMD#A#A"):Send(player) 
         PrintInfo("[INFO]HandleLDMsg: :[" .. player:GetAccountName() .."(" .. LD_Body .. ")] - Enters the world")
      elseif LD_Head == "LDSET" then -- VARIABLE DE SESSION DE PJ
	     print (LD_Body)
	     local MyTable = mysplit ( LD_Body, "|" )
		 local MyLD_Pj    = MyTable[1]
		 local MyLD_Index = MyTable[2]
		 local MyLD_Value = MyTable[3] 
		 LD_SetPjVar ( MyLD_Pj, MyLD_Index, MyLD_Value )
      elseif LD_Head == "NPCSY" then -- HACER HABLAR A UN NPC
      else
         PrintInfo("[INFO]HandleLDMsg:114 Unhandled Message:[" .. msg .."]")
      end
   end
   PrintInfo("LD GUI Loaded ...")
else
   LD_RolFrame = nil
   if AIO_LD_CONFIG == nil then
      AIO_LD_CONFIG = {}
   end	  
   local senttime
   
   assert(not LDSendMsg, "SLD_GUI.lua: LDSendMsg is already defined")
   --
   -- Funcion de manejo de mensajes
   --
   function HandleLDMsg(player, msg)
      if (IsAddOnLoaded("TotalRP2")) then
           print("|cff00ffff [LoreDreams]:|c00ffff00 Este juego es incompatible con TotalRP2, desactiva este Addon por favor")
		   message("Este juego es incompatible con TotalRP2, desactiva este Addon por favor");
		   MainMenuBar:SetPoint("TOP", 3000, 3000)
           Minimap:Hide()
           PlayerFrame:Hide()
           MainMenuBar:Hide()
           return
      end
	  local LD_Head, LD_Pj, LD_Body = strsplit ( "#", tostring(msg) )
      local LD_AllFlds = { strsplit ( "#", tostring(msg) )}
      if (LD_Head == "PRTXT") then -- Imprime texto
         print (LD_Body)
      elseif (LD_Head == "ATTRL") then -- ENVIO DE ATRIBUTOS
      	  
      elseif (LD_Head == "ROLMD") then -- MODO ROL 
		 LD_RolFrame = LD_SetMainFrame()
		 MainMenuBarBackpackButton:SetParent (UIParent)
		 CharacterBag0Slot:SetParent(UIParent)
		 CharacterBag1Slot:SetParent(UIParent)
		 CharacterBag2Slot:SetParent(UIParent)
		 CharacterBag3Slot:SetParent(UIParent)
		 LD_DummyFrame = CreateFrame ( "Frame", "LD_DummyFrame", UIParent )
	     LD_DummyFrame:SetSize(20,20)
	     MainMenuBar:SetPoint("TOP", 3000, 3000)
		 MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT")
	     LD_DummyFrame:Show()
	     Minimap:SetParent (LD_DummyFrame)
	     -- PlayerFrame:SetParent (LD_DummyFrame)
	     MainMenuBar:SetParent (LD_DummyFrame)
	     
		 Minimap:Hide()
         -- PlayerFrame:Hide()
         MainMenuBar:Hide()
		 print ("Modo rol activado")
		 print ("Como la cosa no está terminada vas a tener que usar barras secundarias y esas mandangas")
		 print ("¿Te molesta verdad? .... Vaaaale perdona")
      elseif LD_Head == "LDVAR" then -- VARIABLE DE SESION
	     LD_Index, LD_Value = mysplit(LD_Body, "=")
		 AIO_LD_CONFIG[LD_Index] = LD_Value
      end
   end
    -- Funcion de envio de mensaje
    function LDSendMsg( Msg )
        senttime = time()
        AIO.Msg():Add("LDMsg", Msg):Send()
    end
    LDSendMsg("HELLO#" .. UnitName("player") .. "#WORLD")
    -- ChatFrame_OnEvent = LD_OnEvent
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", LD_OnEvent)
	

end

AIO.RegisterEvent("LDMsg", HandleLDMsg)


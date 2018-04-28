local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Events = SLD_Events or require("SLD_Events")
local SLD_Frames = SLD_Frames or require("SLD_Frames")
local SLD_Frames2 = SLD_Frames2 or require("SLD_Frames2")

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
      -- PrintInfo("[DEBUG]SendAddonMsgGroup:847[" .. tostring(MyGrp) .. "][" .. tostring(NumGrPj) .."]")
      for LoopVar=1,NumGrPj do
         AIO.Msg():Add("LDMsg", msg ):Send(GrPj[LoopVar])
         -- PrintInfo("[DEBUG]SendMsgGroup:31[" .. tostring(GrPj[LoopVar]:GetAccountName()) .. "]Sending")
      end
   end
   
   function LD_SetPjVar ( LD_Pj, LD_Index, LD_Value, LD_Type, LD_UpTime )
      local MySQLCommand= "INSERT INTO LD_SessionVars" .. 
	  " (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. LD_Pj .. 
	  "','" .. LD_Index .. "','" .. LD_Value .. "','" .. LD_Type .. "', " ..
	  LD_UpTime .. ") ON DUPLICATE KEY UPDATE LD_VALUE = '" .. LD_Value .. 
	  "', LD_DATEUP = " .. LD_UpTime .. ";"
	  -- PrintInfo("[INFO]LD_SetPjVar:[" .. MySQLCommand .. "]")
	  CharDBExecute(MySQLCommand)
   end
   
   function LD_GetPjVar ( LD_Pj, LD_Index, LD_Value, LD_Type )
      local MyVal = nil
      local MySQLCommand= "SELECT LD_VALUE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. 
	  "' AND LD_INDEX='" .. LD_Index .. "' AND LD_TYPE='" .. LD_Type .. "';"
	  -- PrintInfo("[INFO]LD_GetPjVar:[" .. MySQLCommand .. "]")
	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyVal = MyRes:GetString( 0 )
            MyRes:NextRow()
         end
      end
      return MyVal	  
   end
   
   function LD_SavePjPlayer ( LD_Pj, LD_Player )
      local MySQLCommand= "INSERT INTO LD_PlayerPJ (LD_PJ, LD_Player) VALUES('" .. LD_Pj .. "','" .. LD_Player .. "') ON DUPLICATE KEY UPDATE LD_PJ = '" .. LD_Pj .. "';"
	  CharDBExecute(MySQLCommand)
   end
   function LD_GetPjPlayer ( LD_Pj )
      local MySQLCommand= "SELECT LD_Player FROM LD_PlayerPJ WHERE LD_PJ='" .. LD_Pj .. "';"
	  local MyRes = CharDBQuery(MySQLCommand)
	  local MyVal = nil
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyVal = MyRes:GetString( 0 )
            MyRes:NextRow()
         end
      end
	  return MyVal
   end
   
   function LD_GetPjVarDef ( LD_Pj, LD_Index, LD_Value, LD_Type, LD_Default )
      local MyVal = nil
      local MySQLCommand= "SELECT LD_VALUE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. 
	  "' AND LD_INDEX='" .. LD_Index .. "' AND LD_TYPE='" .. LD_Type .. "';"
	  -- PrintInfo("[INFO]LD_GetPjVarDef:[" .. MySQLCommand .. "]")
	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyVal = MyRes:GetString( 0 )
            MyRes:NextRow()
         end
      end
	  if MyVal == nil then
	     MyVal = LD_Default	
         MySQLCommand= "INSERT INTO LD_SessionVars (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. LD_Pj .. "','" .. LD_Index .. "','" .. MyVal .. "','" .. LD_Type .. 
		 "', 0) ON DUPLICATE KEY UPDATE LD_VALUE = '" .. MyVal .. "';"
		 -- PrintInfo("[INFO]LD_GetPjVarDef:[" .. MySQLCommand .. "]")
 	     CharDBExecute(MySQLCommand)		 
	  end
      return MyVal	  
   end

   function LD_GetAllType ( LD_Pj, LD_Type, MyPlayer )
      local MyRow   = nil
      local MyIndex = nil
      local MyValue = nil
      local MySQLCommand= "SELECT LD_INDEX, LD_VALUE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. 
	  "' AND LD_TYPE='" .. LD_Type .. "';"

	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyIndex = MyRes:GetString( 0 )
            MyValue = MyRes:GetString( 1 )
			MyRow[MyIndex] = MyValue
            MyRes:NextRow()
			AIO.Msg():Add("LDMsg","LDGET#".. MyIndex .. "#" .. MyValue .. "#" .. LD_Type):Send(MyPlayer)		
         end
      end
   end
   
   function LD_GetHistory ( LD_Pj )
      local MyRow   = nil
      local MyIndex = nil
      local MyValue = nil
      local MySQLCommand= "SELECT LD_INDEX, LD_VALUE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. 
	  "' AND LD_TYPE='ROL';"

	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
	     MyRow = {}
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyIndex = MyRes:GetString( 0 )
            MyValue = MyRes:GetString( 1 )
			MyRow[MyIndex] = MyValue
			-- PrintInfo("[INFO]LD_GetHistory:MYRow[" .. MyIndex .. "]=" .. MyRow[MyIndex] )
            MyRes:NextRow()
         end
      end
      return MyRow
   end

   function LD_GetAllPj ( LD_Pj , MyPlayer )
      local MyIndex = nil
      local MyValue = nil
	  local MyType  = nil
      local MySQLCommand= "SELECT LD_INDEX, LD_VALUE, LD_TYPE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. "';"

	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyIndex = MyRes:GetString( 0 )
            MyValue = MyRes:GetString( 1 )
            MyType  = MyRes:GetString( 2 )
			AIO.Msg():Add("LDMsg","LDGET#".. MyIndex .. "#" .. MyValue .. "#" .. MyType):Send(MyPlayer)
            MyRes:NextRow()
         end
      end
      return MyRow
   end
   
   function LD_GetSysVars ( MyPlayer)
	  local MyType  = nil
      local MyStype = nil
      local MyName = nil
      local MyValue = nil
      local MySQLCommand= "SELECT LD_TYPE, LD_SUBTYPE, LD_NAME, LD_VALUE FROM LD_SystemVars ORDER BY LD_TYPE, LD_SUBTYPE;"

	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyType   = MyRes:GetString( 0 )
            MyStype  = MyRes:GetString( 1 )
            MyName   = MyRes:GetString( 2 )
            MyValue  = MyRes:GetString( 3 )
			AIO.Msg():Add("LDMsg","LDSYS#".. MyType .. "#" .. MyStype .. "#" .. MyName .. "#" .. MyValue):Send(MyPlayer)
			-- PrintInfo("LDSYS#".. MyType .. "#" .. MyStype .. "#" .. MyName .. "#" .. MyValue)
			MyRes:NextRow()
         end
      end
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
		 LD_SavePjPlayer ( LD_Table[2], player:GetAccountName() )
		 
      elseif LD_Head == "ROLMD" then -- PERSONAJE EN MODO ROL
         AIO.Msg():Add("LDMsg", "ROLMD#A#A"):Send(player) 
         PrintInfo("[INFO]HandleLDMsg: :[" .. player:GetAccountName() .."(" .. LD_Body .. ")] - Enters rol mode")
		 
      elseif LD_Head == "PVEMD" then -- PERSONAJE EN MODO PVE
         AIO.Msg():Add("LDMsg", "PVEMD#A#A"):Send(player) 
         PrintInfo("[INFO]HandleLDMsg: :[" .. player:GetAccountName() .."(" .. LD_Body .. ")] - Exits rol mode")
		 
      elseif LD_Head == "LDSET" then -- SET VARIABLE DE SESSION DE PJ
		 local MyLD_Pj     = LD_Table[2]
		 local MyLD_Index  = LD_Table[3]
		 local MyLD_Type   = LD_Table[4]
		 local MyLD_Value  = LD_Table[5] 
		 local MyLD_UpTime = LD_Table[6] 
		 LD_SetPjVar ( MyLD_Pj, MyLD_Index, MyLD_Value, MyLD_Type, MyLD_UpTime )

      elseif LD_Head == "LDGET" then -- GET VARIABLE DE SESSION DE PJ
	     PrintInfo ("[INFO]HandleLDMsg: " .. msg)
		 local MyLD_Pj     = LD_Table[2]
		 local MyLD_Index  = LD_Table[3]
		 local MyLD_Type   = LD_Table[4]
		 local MyLD_Value  = LD_Table[5] 
		 local MyVal = LD_GetPjVar ( MyLD_Pj, MyLD_Index, MyLD_Value, MyLD_Type  )
		 if MyVal ~= nil then
		    -- PrintInfo("[INFO]HandleLDMsg: :[" .. player:GetAccountName() .."(GETVAR)] - " .. MyLD_Value .. " = " .. MyVal)
			AIO.Msg():Add("LDMsg", "LDGET#" .. MyLD_Value .. "#" .. MyVal .. "#" .. MyLD_Type):Send(player)
		 end

	  elseif LD_Head == "LDSYS" then -- GET VARIABLES DE SISTEMA
		 LD_GetSysVars(player)
		 
      elseif LD_Head == "GTALL" then -- GET CONJUNTO DE VARIABLES DE UN TIPO
		 local MyLD_Pj     = LD_Table[2]
		 local MyLD_Type   = LD_Table[3]
         LD_GetAllType ( MyLD_Pj, MyLD_Type, player )
		 
      elseif LD_Head == "GTAPJ" then -- TODAS LAS VARIABLES DE UN PJ
		 local MyLD_Pj     = LD_Table[2]
		 local MyVal = LD_GetAllPj ( MyLD_Pj , player)
		 
      elseif LD_Head == "LDGDF" then -- VARIABLE DE SESSION DE PJ CON VALOR POR DEFECTO
	     -- PrintInfo ("[INFO]HandleLDMsg: " .. msg)
		 local MyLD_Pj     = LD_Table[2]
		 local MyLD_Index  = LD_Table[3]
		 local MyLD_Type   = LD_Table[4]
		 local MyLD_Value  = LD_Table[5] 
		 local MyLD_Default = LD_Table[6] 
		 local MyVal = LD_GetPjVarDef ( MyLD_Pj, MyLD_Index, MyLD_Value, MyLD_Type, MyLD_Default  )
         AIO.Msg():Add("LDMsg", "LDGET#" .. MyLD_Value .. "#" .. MyVal .. "#" .. MyLD_Type):Send(player)
		 
      elseif LD_Head == "NPSAY" then -- HACER HABLAR A UN NPC
		 local MyNPCId  = tonumber(LD_Table[4],16)
		 local MyNPCLow = tonumber(LD_Table[3],16)
		 local MyCreature = player:GetMap():GetWorldObject((GetUnitGUID( MyNPCLow, MyNPCId )))
	     MyCreature:SendUnitSay(LD_Table[5], 0)
		 
	  elseif LD_Head == "SEENK" then -- VEO DESNUDO
		 if (player:HasAura(54844)) then
		    player:RemoveAura(54844)
		 else	
		    player:AddAura(54844,player)
		 end
		 
	  elseif LD_Head == "LDEVT" then -- CLICK SOBRE NPC
		 AIO.Msg():Add("LDMsg", msg ):Send(player)
		 
	  elseif LD_Head == "HISPJ" then -- HISTORIA DE PJS
		 PrintInfo("[INFO]HandleLDMsg: :[HISPJ]" .. msg )
	     if player:IsGM() == false then
	        AIO.Msg():Add("LDMsg", "PRTXT#System#\nFunción solo para MJ\n" ):Send(player)
			PrintInfo("[INFO]HandleLDMsg: :[HISPJ] Player is not GM" )
		    return
         end			
	     local MyLD_Pj = LD_Table[2]
	     local PjHistory = LD_GetHistory(MyLD_Pj)
		 if PjHistory ~= nil then
		    for J,K in pairs(PjHistory) do
               -- for M in pairs(K) do
               AIO.Msg():Add("LDMsg", "HISPJ#" .. MyLD_Pj.. "#" .. J .. "#" .. K):Send(player)
               PrintInfo("[INFO]HandleLDMsg: HISPJ#" .. MyLD_Pj.. "#" .. J .. "#" .. K)
               -- end	  
			end   
		 end		 
         AIO.Msg():Add("LDMsg", "HISPJ#" .. MyLD_Pj.. "#SHOW#SHOW"):Send(player)
		 
	  elseif LD_Head == "APPHI" then -- APROBAR HISTORIA
		 PrintInfo("[INFO]HandleLDMsg: :[APPHI]" .. msg )
	     if player:IsGM() == false then
	        AIO.Msg():Add("LDMsg", "PRTXT#System#\nFunción solo para MJ\n" ):Send(player)
			PrintInfo("[INFO]HandleLDMsg: :[APPHI] Player is not GM" )
		    return
         end			
	     local MyLD_Pj = LD_Table[2]
	     local MyPlayerName = LD_GetPjPlayer(MyLD_Pj)
		 if MyPlayerName == nil then
		    AIO.Msg():Add("LDMsg", "PRTXT#S#" .. MyLD_Pj .. ": No registrado en Base de Datos\n" ):Send(player)
			return
		 end
		 
		 LD_SetPjVar ( MyLD_Pj, "APP", "A", "ROL", 0 )
		 local MyPlayer = GetPlayerByName( MyLD_Pj )
		 if MyPlayer ~= nil then
            AIO.Msg():Add("LDMsg", "LDGET#APP#A#ROL"):Send(MyPlayer)
            AIO.Msg():Add("LDMsg", "PRTXT#SYS#Tu ficha ha sido aprobada"):Send(MyPlayer)
		 end
         AIO.Msg():Add("LDMsg", "PRTXT#SYS#Ficha de " .. MyLD_Pj .. " aprobada"):Send(player)
		 
	  elseif LD_Head == "TPPJS" then -- TELEPORT
	     local MyLD_Pj = LD_Table[2]
		 local MyLD_Index  = LD_Table[3]
		 player:Teleport( Teleports[MyLD_Index]["map"], 
		                  Teleports[MyLD_Index]["position_x"], 
						  Teleports[MyLD_Index]["position_y"], 
						  Teleports[MyLD_Index]["position_z"], 
						  Teleports[MyLD_Index]["orientation"] )
      else
         PrintInfo("[INFO]HandleLDMsg:114 Unhandled Message:[" .. msg .."]")
      end
   end
   PrintInfo("LD GUI Loaded ...")
else
   LD_RolFrame = nil
   Saved_point, Saved_relativeTo, Saved_relativePoint, Saved_xOfs, Saved_yOfs = MainMenuBar:GetPoint()
   Saved_p1, Saved_f1, Saved_r1, Saved_x1, Saved_y1 = MainMenuBarBackpackButton:GetPoint()
   Saved_p2, Saved_f2, Saved_r2, Saved_x2, Saved_y2 = CharacterBag0Slot:GetPoint()
   BL_p, BL_f, BL_r, BL_x, BL_y = MultiBarBottomLeft:GetPoint()
   BR_p, BR_f, BR_r, BR_x, BR_y = MultiBarBottomRight:GetPoint()
   ML_p, ML_f, ML_r, ML_x, ML_y = MultiBarLeft:GetPoint()
   MR_p, MR_f, MR_r, MR_x, MR_y = MultiBarRight:GetPoint()
   
   BL_Visible = MultiBarBottomLeft:IsVisible()
   BR_Visible = MultiBarBottomRight:IsVisible()
   ML_Visible = MultiBarLeft:IsVisible()
   MR_Visible = MultiBarRight:IsVisible()

   
   if AIO_LD_CONFIG == nil then
      AIO_LD_CONFIG = {}
   end	  
   AIO_LD_CONFIG["ROLMODE"] = false
   local senttime
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
	     -- print(msg)
         print (LD_Body)
      elseif (LD_Head == "PVEMD") then -- MODO PVE
         AIO_LD_CONFIG["ROLMODE"] = false
	     LD_RolFrame:Hide()
		 LD_ROLFrame:Hide()
		 LD_ATRFrame:Hide()
		 LD_MacroFrame:Hide()
		 LD_StatusBars:Hide()
		 MainMenuBar:SetParent(Saved_relativeTo)
      	 MainMenuBar:SetPoint(Saved_point, 
		                      Saved_relativeTo, 
							  Saved_relativePoint, 
							  Saved_xOfs, 
							  Saved_yOfs)
		 MainMenuBarBackpackButton:SetParent(Saved_f1)
		 MainMenuBarBackpackButton:SetPoint (Saved_p1, Saved_f1, Saved_r1, Saved_x1, Saved_y1)
		 CharacterBag0Slot:SetParent(Saved_f2)
		 CharacterBag1Slot:SetParent(Saved_f2)
		 CharacterBag2Slot:SetParent(Saved_f2)
		 CharacterBag3Slot:SetParent(Saved_f2)
		 if BL_Visible then
		    MultiBarBottomLeft:SetParent(BL_f)
		    MultiBarBottomLeft:Show()
		 end
		 if BR_Visible then
		    MultiBarBottomRight:SetParent(BR_f)
		    MultiBarBottomRight:Show()
		 end
		 if ML_Visible then
		    MultiBarLeft:SetParent(ML_f)
		    MultiBarLeft:Show()
		 end
		 if MR_Visible then
		    MultiBarRight:SetParent(MR_f)
		    MultiBarRight:Show()
		 end
		 MainMenuBar:Show()
		 Minimap:Show()
		 MinimapCluster:Show()
		 PlayerFrame:Show()
		 SysPrint ("Modo PVE activado")
		 
      elseif (LD_Head == "ROLMD") then -- MODO ROL
         if AIO_LD_CONFIG["ROL"] == nil then
		    AIO_LD_CONFIG["ROL"] = {}
		 end
         if AIO_LD_CONFIG["ROL"]["PATTR"] == nil then
            AIO_LD_CONFIG["ROL"]["PATTR"] = 6
			LD_SetPjVar("ROL", "PATTR", 6 , 0)
		 end
   	     if AIO_LD_CONFIG["ATRIBUTO"] == nil then
            local MyRaceLoc, MyRace = UnitRace("player")
            AIO_LD_CONFIG["ATRIBUTO"] = {}
            AIO_LD_CONFIG["ATRIBUTO"]["FUERZA"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["FUERZA_MIN"]
            LD_SetPjVar ( "FUERZA", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["CONSTI"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["CONSTI_MIN"]
            LD_SetPjVar ( "CONSTI", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["DESTRE"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["DESTRE_MIN"]
            LD_SetPjVar ( "DESTRE", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["AGILID"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["AGILID_MIN"]
            LD_SetPjVar ( "AGILID", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["INTELE"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["INTELE_MIN"]
            LD_SetPjVar ( "INTELE", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["SABIDU"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["SABIDU_MIN"]
            LD_SetPjVar ( "SABIDU", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["PERCEP"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["PERCEP_MIN"]
            LD_SetPjVar ( "PERCEP", "ATRIBUTO", 5, 0 )
         end

         AIO_LD_CONFIG["ROLMODE"] = true
		 LD_RolFrame = LD_SetMainFrame()
         LD_StatusBars:Show()
		 MainMenuBar:SetParent(LD_DummyFrame)
	     MainMenuBar:SetPoint(Saved_point, 
		                      LD_DummyFrame,
							  Saved_relativePoint,
							  3000, 
							  3000)
         MainMenuBar:Hide()
         BL_Visible = MultiBarBottomLeft:IsVisible()
         BR_Visible = MultiBarBottomRight:IsVisible()
         ML_Visible = MultiBarLeft:IsVisible()
         MR_Visible = MultiBarRight:IsVisible()
         
		 if BL_Visible then
		    MultiBarBottomLeft:SetParent(LD_DummyFrame)
		    MultiBarBottomLeft:Hide()
		 end
		 if BR_Visible then
		    MultiBarBottomRight:SetParent(LD_DummyFrame)
		    MultiBarBottomRight:Hide()
		 end
		 if ML_Visible then
		    MultiBarLeft:SetParent(LD_DummyFrame)
		    MultiBarLeft:Hide()
		 end
		 if MR_Visible then
		    MultiBarRight:SetParent(LD_DummyFrame)
		    MultiBarRight:Hide()
		 end
         LD_DummyFrame:Hide()
		 
		 MainMenuBarBackpackButton:SetParent (UIParent)
		 CharacterBag0Slot:SetParent(UIParent)
		 CharacterBag1Slot:SetParent(UIParent)
		 CharacterBag2Slot:SetParent(UIParent)
		 CharacterBag3Slot:SetParent(UIParent)
		 MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT")
		 MinimapCluster:Hide()
		 Minimap:Hide()
         PlayerFrame:Hide()
		 
		 MyBt1 = ActionButton1
		 MyBt1:Show()
		 
		 SysPrint ("Modo rol activado")
		 -- print ("Como la cosa no está terminada vas a tener que usar barras secundarias y esas mandangas")
		 -- print ("¿Te molesta verdad? .... Vaaaale perdona")
		 
      elseif LD_Head == "LDSYS" then -- VARIABLE DE SISTEMA
	     -- print ("DEBUG: " .. msg )
	     local LD_Type  = LD_AllFlds[2]
	     local LD_SType = LD_AllFlds[3]
		 local LD_Name  = LD_AllFlds[4]
		 local LD_Value = LD_AllFlds[5]
		 if AIO_LD_CONFIG["SYS"] == nil then
		    AIO_LD_CONFIG["SYS"] = {}
		 end
		 if AIO_LD_CONFIG["SYS"][LD_Type] == nil then
		    AIO_LD_CONFIG["SYS"][LD_Type] = {}
		end
		if AIO_LD_CONFIG["SYS"][LD_Type][LD_SType] == nil then
	       AIO_LD_CONFIG["SYS"][LD_Type][LD_SType] = {}
        end			   
		AIO_LD_CONFIG["SYS"][LD_Type][LD_SType][LD_Name] = LD_Value
		-- print("DEBUG: AIO_LD_CONFIG[SYS][" .. LD_Type .. "][" .. LD_SType .. "][" .. LD_Name .. "]=" .. AIO_LD_CONFIG["SYS"][LD_Type][LD_SType][LD_Name])

	 elseif LD_Head == "LDGET" then -- VARIABLE DE SESION
	     -- print ("DEBUG: " .. msg )
	     local LD_Index = LD_AllFlds[2]
	     local LD_Value = LD_AllFlds[3]
		 local LD_Type  = LD_AllFlds[4]
		 if AIO_LD_CONFIG[LD_Type] == nil then
		    AIO_LD_CONFIG[LD_Type] = {}
		 end
		 AIO_LD_CONFIG[LD_Type][LD_Index] = LD_Value
		 -- print ("DEBUG: AIO_LD_CONFIG[" .. LD_Type .. "][" .. LD_Index .. "] = " .. LD_Value )
		 
      elseif LD_Head == "LDEVT" then -- MAESTROS DE ATRIBUTO
	     -- print ("DEBUG: " .. LD_AllFlds[3] )
	     if LD_AllFlds[3] == "Zipeau Magicfingers" or
		    LD_AllFlds[3] == "Oraculus Coscotodo" or
			LD_AllFlds[3] == "Muelleflojo Parcour" or
			LD_AllFlds[3] == "Seneca Kerabiadas" or
			LD_AllFlds[3] == "Martinez Gordobiceps" or
			LD_AllFlds[3] == "Poveda Cuatroojos" or
			LD_AllFlds[3] == "Noremasti Todoinmune" then
            if AIO_LD_CONFIG["ROLMODE"] ~= true then
               message("Debes estar en modo rol para comerciar aqui")
            return
            end	
            if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               message("No tienes el personaje activo para Rol, manda tu historia primero.")
               return
            end	
			LD_AttrVendFrame.MyVend:SetText(LD_AllFlds[3])
			LD_AttrVendFrame.MyVendTx:SetText("Maestro de " .. LD_ATRVendors[LD_AllFlds[3]][2] .. 
			"\n________________________")
			LD_AttrVendFrame.MyVendTxl:SetText (LD_ATRVendors[LD_AllFlds[3]][3])
			LD_AttrVendFrame.AttrDesc  = LD_ATRVendors[LD_AllFlds[3]][2]
			LD_AttrVendFrame.AttrBBDD  = LD_ATRVendors[LD_AllFlds[3]][1]
		    LD_AttrVendFrame:Show()
         else
		    LD_AttrVendFrame:Hide()
         end
		 
      elseif LD_Head == "HISPJ" then -- HISTORA PARA APROBAR
	     LD_ApproFrame.PjName = LD_AllFlds[2]
	     if LD_AllFlds[3] == "NOMBRE" then
		    LD_ApproFrame.Nombre:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "APELLIDO" then
		    LD_ApproFrame.Apellidos:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "EDAD" then
		    LD_ApproFrame.Edad:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "HIST1" then
		    LD_ApproFrame.Hist1:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "HIST2" then
		    LD_ApproFrame.Hist2:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "APP" then
		    if LD_AllFlds[4] == "A" then
			   LD_ApproFrame.Cabecera:SetText( LD_AllFlds[2] .. " FICHA YA APROVADA!!!")
			else
			   LD_ApproFrame.Cabecera:SetText( LD_AllFlds[2] .. ": Ficha pendiente de aprobacion")
			end   
		 elseif LD_AllFlds[3] == "SHOW" then
			LD_ApproFrame:Show()
         end
      end
   end     	  
   
   -- assert(not LDSendMsg, "SLD_GUI.lua: LDSendMsg is already defined")
   --
   -- CARGA DE DATOS Y FRAME OCULTA
   --
   LD_LoadPjData()
   
   
   LD_DummyFrame=CreateFrame ( "Frame", "LD_DummyFrame", UIParent )
   LD_DummyFrame:SetSize(20,20)
   LD_DummyFrame:RegisterEvent("TARGET_UNIT")
   LD_DummyFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
   LD_DummyFrame:SetScript("OnEvent", LDDummy_OnEvent)
  

    -- Funcion de envio de mensaje
    -- function LDSendMsg( Msg )
    --    senttime = time()
    --    AIO.Msg():Add("LDMsg", Msg):Send()
    -- end
	
	
	LDSendMsg("HELLO#" .. UnitName("player") )   
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


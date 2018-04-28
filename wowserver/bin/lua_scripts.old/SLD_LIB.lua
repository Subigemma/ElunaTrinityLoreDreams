local AIO = AIO or require("AIO")
assert(not SLD_LIB, "SLD_LIB is already loaded. Possibly different versions!")
-- SLD_LIB main table
SLD_LIB =
{
    -- SLD_LIB flavour functions
    unpack = unpack,
}

local SLD_LIB = SLD_LIB
if not AIO.AddAddon() then
   -- function LDSendMsg( Msg )
   --     senttime = time()
   --     AIO.Msg():Add("LDMsg", Msg):Send()
   -- end
   --
   -- VARIABLES GLOBALES
   --
   LD_Saved_ChatFrameEvent = nil
   --
   -- Funciones varias de utilidad
   --
   function LD_deciToHexa(number)
	number = math.floor(number*255);
	local num1 = math.fmod(number, 16);
	local num2 = math.floor(number/16);
	if num2 == 10 then
		num2 = "A";
	elseif num2 == 11 then
		num2 = "B";
	elseif num2 == 12 then
		num2 = "C";
	elseif num2 == 13 then
		num2 = "D";
	elseif num2 == 14 then
		num2 = "E";
	elseif num2 == 15 then
		num2 = "F";
	end
	if num1 == 10 then
		num1 = "A";
	elseif num1 == 11 then
		num1 = "B";
	elseif num1 == 12 then
		num1 = "C";
	elseif num1 == 13 then
		num1 = "D";
	elseif num1 == 14 then
		num1 = "E";
	elseif num1 == 15 then
		num1 = "F";
	end
	return ""..num2..num1;
   end
   function LD_ColorToHexa(r,g,b)
      return "|cff"..LD_deciToHexa(r)..LD_deciToHexa(g)..LD_deciToHexa(b);
   end
   function PG (text)
      LDSendMsg ( "PRTXT"  .. "#" .. UnitName("player") .. "#" .. text )
   end
   function LT ( Player, Attr, Value)
      LDSendMsg ( "CATTR" .. "#" .. tostring(Player) .. "." .. tostring(Attr) .. "." .. tostring(Value))
   end
   function RD (MyMin, MyMax)
      MyRnd = random (MyMin, MyMax)
      PG ( "|cff00ffff[" .. UnitName("Player") .. "]|cffffff00 tira los dados y obtiene " .. MyRnd .. " (" ..MyMin .. "-" .. MyMax .. ")")
      return MyRnd
   end
   -- /run LD_SetVar ( "HP", "30" )
   function LD_SetVar ( MyIndex, MyValue )
      LDSendMsg ("LDSET#" .. UnitName("Player") .. "|" .. tostring(MyIndex) .. "|" .. tostring(MyValue) )
   end
else
   PrintInfo("LD Libraries loaded") 
end
   
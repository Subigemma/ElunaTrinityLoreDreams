local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
assert(not SLD_Events, "SLD_Events is already loaded. Possibly different versions!")
-- SLD_Events main table
SLD_Events =
{
    -- SLD_Events flavour functions
    unpack = unpack,
}

local SLD_Events = SLD_Events
if not AIO.AddAddon() then
      function LD_OnEvent ( self, events, ...)
         local texte, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16 = ...;
         local Affiche=1;
         local coloredName = GetColoredName(event, texte, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
         local couleur = LD_ColorToHexa(ChatTypeInfo["EMOTE"].r,ChatTypeInfo["EMOTE"].g,ChatTypeInfo["EMOTE"].b);
         texte = string.gsub(texte,"%<.-%>",couleur.."%1|r");
         texte = string.gsub(texte,"%*.-%*",couleur.."%1|r");
         DEFAULT_CHAT_FRAME:AddMessage("[" .. coloredName .. "] dice: " .. texte)
		 return true
      end	
else   
   PrintInfo("SLD Events Loaded ...")
end


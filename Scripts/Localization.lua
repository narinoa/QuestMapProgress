Global("localization", nil)

Global("Locales", {
	["rus"] = { -- Russian, Win-1251
    ["FindW"] = "����� ������ � ����",
    ["FindZ"] = "����� ������ � ����",
    ["Comp"] = "���������: ",
    ["From"] = " �� ",
	},
		
	["eng_eu"] = { -- English, Latin-1
	["FindW"] = "Quests in the world",
    ["FindZ"] = "Quests in the zone",
    ["Comp"] = "complete: ",
    ["From"] = " from ",
	}
})

--We can now use an official method to get the client language
localization = common.GetLocalization()
function GTL( strTextName )
	return Locales[ localization ][ strTextName ] or Locales[ "eng_eu" ][ strTextName ] or strTextName
end

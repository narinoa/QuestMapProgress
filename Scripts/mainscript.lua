local allprogress, impsize, colsize, impsizemap, colsizemap = 0
local MainPanel = mainForm:GetChildChecked( "MainPanel", false )
local Button = mainForm:GetChildChecked( "ShowButton", false ) 
Button:SetVal("button_label", userMods.ToWString("QMP")) 
if Active then MainPanel:Show(true) else MainPanel:Show(false) end
local MapPanel = mainForm:GetChildChecked( "MapPanel", false)
local MainMap = stateMainForm:GetChildChecked("Map",false):GetChildChecked( "MainPanel", false )
MainMap:SetOnShowNotification( true )
local ProgressPanel = MainMap:GetChildChecked("LayoutMain",false):GetChildChecked("LayoutFrameLeft",false):GetChildChecked("LayoutFrameLeftHor",false):GetChildChecked("ToolbarPanel",false):GetChildChecked("QuestProgress",false)
ProgressPanel:Show(ShowOnMap)
local ToolbarPanel = MainMap:GetChildChecked("LayoutMain",false):GetChildChecked("LayoutFrameLeft",false):GetChildChecked("LayoutFrameLeftHor",false):GetChildChecked("ToolbarPanel",false)
local wtName = MainMap:GetChildChecked("LayoutMain",false):GetChildChecked("LayoutFrameLeft",false):GetChildChecked("LayoutFrameLeftHor",false):GetChildChecked("LayoutFrameLeftVert",false):GetChildChecked("MapEnginePanel",false):GetChildChecked("Markers",false):GetChildChecked("MapTextPanel",false)
local ppbar = ProgressPanel:GetChildChecked("Gauge",false)
ppbar:Show(false)
local pptext = ProgressPanel:GetChildChecked("Label",false)
pptext:Show(false)
local wtMainPanel = MainPanel:GetChildChecked( "Window", false )
local wtMapPanel = mainForm:CreateWidgetByDesc( MapPanel:GetWidgetDesc() )
MainMap:AddChild(wtMapPanel)
local wtProgressPanel = wtMainPanel:GetChildChecked( "ProgressBar", false )
local wtBar = wtProgressPanel:GetChildChecked( "Bar", false )
wtBar:SetBackgroundColor({ r = 0.1; g = 0.74; b = 1; a = 1 })
local PBBG = mainForm:CreateWidgetByDesc( wtBar:GetWidgetDesc() )
local p = PBBG:GetPlacementPlain()
	p.alignY = WIDGET_ALIGN_LOW 
		p.posY = 10
		p.posX = 30
		p.sizeY = 15
		p.sizeX = 298
		PBBG:SetPlacementPlain(p)
PBBG:SetBackgroundColor({ r = 0.2; g = 0.2; b = 0.1; a = 1 })
PBBG:SetPriority( 5 )
wtProgressPanel:AddChild(PBBG)
local wtFindQ = MainPanel:GetChildChecked( "Button", false )
local wtFindA = MainPanel:GetChildChecked( "ButtonAll", false )
wtFindA:SetVal("button_label", userMods.ToWString(GTL("FindW")) )
wtFindQ:SetVal("button_label", userMods.ToWString(GTL("FindZ")) )
local Text = wtMainPanel:GetChildChecked( "Text", false )
local Desc = wtMainPanel:GetChildChecked( "Desc", false )
local wtAllod = mainForm:CreateWidgetByDesc( Text:GetWidgetDesc() )
wtMainPanel:AddChild(wtAllod)
local p = wtAllod:GetPlacementPlain()
		p.sizeX = 366
		p.posX = 0
		p.sizeY = 45
		p.posY = 10
		wtAllod:SetPlacementPlain(p)
local wtText = mainForm:CreateWidgetByDesc( Text:GetWidgetDesc() )
wtMainPanel:AddChild(wtText)
local p = wtText:GetPlacementPlain()
		p.sizeX = 366
		p.posX = 0
		p.sizeY = 45
		p.posY = 57
		wtText:SetPlacementPlain(p)
local wtText2 = mainForm:CreateWidgetByDesc( Text:GetWidgetDesc() )
wtMainPanel:AddChild(wtText2)
local p = wtText2:GetPlacementPlain()
		p.alignX = WIDGET_ALIGN_CENTER
		p.posX = 0
		p.sizeX = 366
		p.sizeY = 30
		p.posY = 90
		wtText2:SetPlacementPlain(p)
local wtText3 = mainForm:CreateWidgetByDesc( Text:GetWidgetDesc() )
wtMainPanel:AddChild(wtText3)
local p = wtText3:GetPlacementPlain()
		p.alignX = WIDGET_ALIGN_CENTER
		p.posX = 0
		p.sizeX = 366
		p.sizeY = 30
		p.posY = 115
		wtText3:SetPlacementPlain(p)
local wtDescZone = mainForm:CreateWidgetByDesc( Text:GetWidgetDesc() )
wtMainPanel:AddChild(wtDescZone)
local p = wtDescZone:GetPlacementPlain()
		p.posX = 0
		p.sizeX = 360
		p.sizeY = 30
		p.posY = 30
		wtDescZone:SetPlacementPlain(p)
wtDescZone:SetEllipsis( true )	
local wtImp = mainForm:GetChildChecked( "ImageImp", false )
wtMainPanel:AddChild(wtImp)
wtImp:Show(true)
local p = wtImp:GetPlacementPlain()
		p.posX = 0
		p.sizeY = 30
		p.sizeX = 30
		p.posY = 85
		wtImp:SetPlacementPlain(p)
local wtCol	= mainForm:GetChildChecked( "ImageLow", false )
wtMainPanel:AddChild(wtCol)
wtCol:Show(true)
local p = wtCol:GetPlacementPlain()
		p.posX = 0
		p.sizeY = 30
		p.sizeX = 30
		p.posY = 110
		wtCol:SetPlacementPlain(p)
local wtImpMap = mainForm:CreateWidgetByDesc( wtImp:GetWidgetDesc() )
wtMapPanel:AddChild(wtImpMap)
wtImpMap:Show(true)
local p = wtImpMap:GetPlacementPlain()
		p.posX = 0
		p.sizeY = 20
		p.sizeX = 20
		p.posY = 27
		wtImpMap:SetPlacementPlain(p)
local wtColMap	= mainForm:CreateWidgetByDesc( wtCol:GetWidgetDesc() )
wtMapPanel:AddChild(wtColMap)
wtColMap:Show(true)
local p = wtColMap:GetPlacementPlain()
		p.posX = 0
		p.sizeY = 20
		p.sizeX = 20
		p.posY = 57
		wtColMap:SetPlacementPlain(p)

function math.round(num, ind)
local nur = 10^(ind or 0)
  return math.floor(num * nur + 0.5) / nur 
end

function setPlacement( widget, place )
	local p = widget:GetPlacementPlain()
	for k, v in pairs(place) do	
		p[k] = place[k] or v
	end
	widget:SetPlacementPlain(p)
end

function GetQuests()
if Active then
local zoneInfo = cartographer.GetCurrentZoneInfo()
local zonesMapId = zoneInfo.zonesMapId
local zoneQuests = cartographer.GetZonesMapQuests( zonesMapId )
local zoneLowQuests = cartographer.GetZonesMapLowQuests( zonesMapId )
allprogress =  math.round(((zoneLowQuests.completedCount+zoneQuests.completedCount)/(zoneLowQuests.totalCount+zoneQuests.totalCount))*100, 2)
if allprogress~=allprogress then allprogress=0 end
local progress = math.round((zoneQuests.completedCount/zoneQuests.totalCount)*100, 2)  if progress~=progress then progress=0 end
local progressLow = math.round((zoneLowQuests.completedCount/zoneLowQuests.totalCount)*100, 2) if progressLow~=progressLow then progressLow=0 end
wtText:SetVal("name", allprogress.."%" )
wtText2:SetVal("name", GTL("Comp")..zoneQuests.completedCount..GTL("From")..zoneQuests.totalCount.." ("..progress.."%"..")" ) 
wtText3:SetVal("name", GTL("Comp")..zoneLowQuests.completedCount..GTL("From")..zoneLowQuests.totalCount.." ("..progressLow.."%"..")" )
local textimp = string.len(userMods.FromWString(common.ExtractWStringFromValuedText(wtText2:GetValuedText())))
local textcol = string.len(userMods.FromWString(common.ExtractWStringFromValuedText(wtText3:GetValuedText())))
impsize = tonumber(textimp)
colsize = tonumber(textcol)
local p = wtImp:GetPlacementPlain()
		p.posX = 100 - impsize*2
				wtImp:SetPlacementPlain(p)
local p = wtCol:GetPlacementPlain()
		p.posX = 100 - colsize*2
				wtCol:SetPlacementPlain(p)
wtDescZone:SetVal("name", userMods.FromWString(zoneInfo.zoneName) )  
wtAllod:SetVal("name", userMods.FromWString(zoneInfo.allod) )
setPlacement(wtBar, {sizeX = 297 * allprogress / 100})
if zoneQuests.totalCount == 0 then MainPanel:Show(false) else MainPanel:Show(true) return end
	end
end 
local wtMapText1 = mainForm:CreateWidgetByDesc( Text:GetWidgetDesc() )
local wtMapText2 = mainForm:CreateWidgetByDesc( Text:GetWidgetDesc() )
local wtTexter = mainForm:CreateWidgetByDesc( Text:GetWidgetDesc() )
local BARR = mainForm:CreateWidgetByDesc( wtBar:GetWidgetDesc() )
ProgressPanel:AddChild(wtTexter)
ProgressPanel:AddChild(BARR)
wtTexter:SetPriority(5)
BARR:SetPriority(4)
local p = BARR:GetPlacementPlain()
		p.posX = 28
		p.posY = 12
		p.sizeY = 15
BARR:SetPlacementPlain(p)
local p = wtTexter:GetPlacementPlain()
		p.posY = 10
wtTexter:SetPlacementPlain(p)

function Visible()
if MainMap:IsVisible() then
MapProgress()
wtTexter:Show(true)
BARR:Show(true)
else 
wtTexter:Show(false)
BARR:Show(false)
	end
end

function CurrentMap(id)
local children = wtName:GetNamedChildren()
for i = 0, GetTableSize( children ) - 1 do
 local wtChild = children[i]
 local name = wtChild:GetName()
	if wtChild:IsVisible() then
	local id = cartographer.GetZonesMapId(name)
	return id
		end
	end
end

function CheckMap()
if MainMap:IsVisible() then
		local p = wtMapText1:GetPlacementPlain()
		p.sizeX = 366
		p.posX = 10
		p.sizeY = 45
		p.posY = 27
		wtMapText1:SetPlacementPlain(p)
		local p = wtMapText2:GetPlacementPlain()
		p.sizeX = 366
		p.posX = 10
		p.sizeY = 45
		p.posY = 57
		wtMapText2:SetPlacementPlain(p)
		wtMapPanel:AddChild(wtMapText1) wtMapPanel:AddChild(wtMapText2)
		local desc = CurrentMap()
		local ZQ = cartographer.GetZonesMapQuests( desc )
		local ZLQ = cartographer.GetZonesMapLowQuests( desc  )
		local apg =  math.round(((ZLQ.completedCount+ZQ.completedCount)/(ZLQ.totalCount+ZQ.totalCount))*100, 2)
		if apg~=apg then apg=0 ProgressPanel:Show(false) else ProgressPanel:Show(true) end
		local prgr = math.round((ZQ.completedCount/ZQ.totalCount)*100, 2)  if prgr~=prgr then prgr=0 end
		local prgrL = math.round((ZLQ.completedCount/ZLQ.totalCount)*100, 2) if prgrL~=prgrL then prgrL=0 end
		wtMapText1:SetVal("name", GTL("Comp")..ZQ.completedCount..GTL("From")..ZQ.totalCount.." ("..prgr.."%"..")" ) 
		wtMapText2:SetVal("name", GTL("Comp")..ZLQ.completedCount..GTL("From")..ZLQ.totalCount.." ("..prgrL.."%"..")" )
		local textimpmap = string.len(userMods.FromWString(common.ExtractWStringFromValuedText(wtMapText1:GetValuedText())))
		local textcolmap = string.len(userMods.FromWString(common.ExtractWStringFromValuedText(wtMapText2:GetValuedText())))
		impsizemap = tonumber(textimpmap)
		colsizemap = tonumber(textcolmap)
		local p = wtImpMap:GetPlacementPlain()
		p.posX = 90 - impsizemap*2
				wtImpMap:SetPlacementPlain(p)
		local p = wtColMap:GetPlacementPlain()
		p.posX = 90 - colsizemap*2
				wtColMap:SetPlacementPlain(p)
		wtTexter:ClearValues() 
		wtTexter:SetVal("name", apg.."%" )
		wtTexter:SetClassVal("class", "tip_white" )
		setPlacement(BARR, {sizeX = 412 * apg / 100})
	end
end

function MapProgress()
wtTexter:ClearValues() 
wtTexter:SetVal("name", allprogress.."%" )
wtTexter:SetClassVal("class", "tip_white" )
setPlacement(BARR, {sizeX = 412 * allprogress / 100})
end 

function ChangeWiew()
if DnD:IsDragging() then
		return
	end
if Active then Active = false
MainPanel:Show(false)
elseif not Active then Active = true
MainPanel:Show(true)
	end
end

function SlashCMD( params )
	local text = userMods.FromWString(params.text)
if text == "/qmp" then 
	ChangeWiew()
	end
end

function CloseWindow()
if Active then Active = false
MainPanel:Show(false)
	end
end 

function FindQuestsZone()
avatar.FindNextQuest( QUEST_FIND_NEXT_QUEST_MODE_ZONE )
end

function FindQuestsAll()
avatar.FindNextQuest( QUEST_FIND_NEXT_QUEST_MODE_ALL )
end

local IsAOPanelEnabled = GetConfig( "EnableAOPanel" ) or GetConfig( "EnableAOPanel" ) == nil

function onAOPanelStart( params )
	if IsAOPanelEnabled then
		local SetVal = { val1 = userMods.ToWString("QMP"), class1 = "LogColorBlue" }
		local params = { header = SetVal, ptype = "button", size = 45}
		userMods.SendEvent( "AOPANEL_SEND_ADDON", { name = common.GetAddonName(), sysName = common.GetAddonName(), param = params } )
		Button:Show( false )
	end 
end

function OnAOPanelButtonLeftClick( params ) 
	if params.sender == common.GetAddonName() then 
	ChangeWiew()
	end 
end

function onAOPanelChange( params )
	if params.unloading and params.name == "UserAddon/AOPanelMod" then
		Button:Show( true )
	end
end

function enableAOPanelIntegration( enable )
	IsAOPanelEnabled = enable
	SetConfig( "EnableAOPanel", enable )
	if enable then
		onAOPanelStart()
	else
		Button:Show( true )
	end
end

function ReactionOnPointing(params)
if MainMap:IsVisible() then
	if params.active then
	wtMapPanel:Show(true)
	else
	wtMapPanel:Show(false)
		end
	end
end

function Init()
GetQuests()
MapProgress()
common.RegisterEventHandler( SlashCMD, "EVENT_UNKNOWN_SLASH_COMMAND" )
common.RegisterEventHandler( Visible, "EVENT_WIDGET_SHOW_CHANGED" )
common.RegisterEventHandler(MapProgress, "EVENT_AVATAR_ZONE_CHANGED")
common.RegisterEventHandler(GetQuests, "EVENT_AVATAR_CLIENT_ZONE_CHANGED")
common.RegisterEventHandler(GetQuests, "EVENT_QUEST_COMPLETED")
common.RegisterEventHandler(CheckMap, "EVENT_SECOND_TIMER")
common.RegisterReactionHandler(CloseWindow, "mouse_left_click")
common.RegisterReactionHandler(ChangeWiew, "ShowHide")
common.RegisterReactionHandler(FindQuestsZone, "ButtonFind")
common.RegisterReactionHandler(FindQuestsAll, "ButtonFindAll")
common.RegisterEventHandler( onAOPanelStart, "AOPANEL_START" )
common.RegisterEventHandler( OnAOPanelButtonLeftClick, "AOPANEL_BUTTON_LEFT_CLICK" )  
common.RegisterEventHandler( onAOPanelChange, "EVENT_ADDON_LOAD_STATE_CHANGED" )
common.RegisterReactionHandler( ReactionOnPointing, "mouse_over" )
DnD.Init(MainPanel,MainPanel, true, true, nil, KBF_SHIFT )
DnD.Init(Button,Button, true, true )
end

if (avatar.IsExist()) then Init()
else common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")	
end
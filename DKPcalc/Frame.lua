local Channel = "RAID";
local Character = "main";
DKPCalc_Selected_Bid_ID = 25;
local fSendDKP, hideStuff, showStuff;
local check = true;

SlashCmdList["DKPCALC"] = function()
	if (DKPcalc:IsVisible()) then
		HideUIPanel(DKPcalc);
	else
		ShowUIPanel(DKPcalc);
	end
end
SLASH_DKPCALC1 = "/dkp";

function DKPcalc_OnShow()
	if DKP then
		DKPcalc_EditDKP:SetText(DKP);
		CalcDKP(DKP);
	end
	getglobal("DKPcalc_DKPlabel"):SetPoint("RIGHT", DKPcalc, "TOPLEFT", 90 - (12 - strlen(UnitName("player"))) * 2.1, -55);
	getglobal("DKPcalc_DKPplayer"):SetText("|c"..DKPCalc_CLASS_COLORS[UnitClass("player")]..UnitName("player")..FONT_COLOR_CODE_CLOSE);
end

if GetLocale() == "ruRU" then
DKPCalc_CLASS_COLORS = {
    ["Охотник"] = "ffabd473",
    ["Чернокнижник"] = "ff9482c9",
    ["Жрец"] = "ffffffff",
    ["Паладин"] = "fff58cba",
    ["Маг"] = "ff69ccf0",
    ["Разбойник"] = "fffff569",
    ["Друид"] = "ffff7d0a",
    ["Шаман"] = "ff0070de",
    ["Воин"] = "ffc79c6e",
};
else
DKPCalc_CLASS_COLORS = {
	["Hunter"] = "ffabd473",
    ["Warlock"] = "ff9482c9",
    ["Priest"] = "ffffffff",
    ["Paladin"] = "fff58cba",
    ["Mage"] = "ff69ccf0",
    ["Rogue"] = "fffff569",
    ["Druid"] = "ffff7d0a",
    ["Shaman"] = "ff0070de",
    ["Warrior"] = "ffc79c6e",
};
end
FONT_COLOR_CODE_CLOSE = "|r";

hideStuff = function(bool)
	getglobal("DKPcalc_BidsTitle"):Hide();
	local f = "DKPcalc";
	if bool == true then
		for i = 25, 100, 25 do
			getglobal(f.."Text"..i):Hide();
			getglobal(f.."DKP"..i):Hide();
			getglobal(f.."Check"..i):Hide();
			getglobal(f.."_BIDbutton"):Hide();
			getglobal(f.."_ROLLbutton"):Hide();
			getglobal("DKPsendFrameDropDown"):Hide();
			getglobal("DKPcharFrameDropDown"):Hide();
			getglobal(f.."_EditDKP"):Hide();
			getglobal(f.."ClearFocus"):Hide();
			getglobal(f.."_DKPlabel"):Hide();
			getglobal(f.."_DKPplayer"):Hide();
			getglobal(f.."_ChannelLabel"):Hide();
			getglobal(f.."_CharLabel"):Hide();
			getglobal("DKPcalc_BidSuccess_Button_Yes"):Show();
			getglobal("DKPcalc_BidSuccess_Button_No"):Show();
			getglobal(f.."_CheckBidLabel"):Show();
			check = false;
		end
	else
		for i = 25, 100, 25 do
			getglobal(f.."Text"..i):Show();
			getglobal(f.."DKP"..i):Show();
			getglobal(f.."Check"..i):Show();
			getglobal(f.."_BIDbutton"):Show();
			getglobal(f.."_ROLLbutton"):Show();
			getglobal("DKPsendFrameDropDown"):Show();
			getglobal("DKPcharFrameDropDown"):Show();
			getglobal(f.."_EditDKP"):Show();
			getglobal(f.."_DKPlabel"):Show();
			getglobal(f.."_DKPplayer"):Show();
			getglobal(f.."_ChannelLabel"):Show();
			getglobal(f.."_CharLabel"):Show();
			getglobal("DKPcalc_BidSuccess_Button_Yes"):Hide();
			getglobal("DKPcalc_BidSuccess_Button_No"):Hide();
			getglobal(f.."_CheckBidLabel"):Hide();
			check = true;
		end
	end
end


function DKPCalc_SendDKP_Button_OnClick()
	fSendDKP = function(bid)
		local dkp_color = "|cffffffff";
		local dkp = getglobal("DKPcalcDKP"..bid):GetText();
		if bid == 25 then
			dkp_color = "|cffe2e86f";
		elseif bid == 50 then
			dkp_color = "|cffc9dd0a";
		elseif bid == 75 then
			dkp_color = "|cfff8ad51";
		elseif bid == 100 then
			dkp_color = "|cffff7000";
		end
		local str = "|cffffffff"..dkp.."|r "..dkp_color.."["..bid.."%]|r";
		return str;
	end

	local charColor = "|cffffffff";
	if Character == "main" then
		charColor = "|cffabd473";
	else
		charColor = "|cffc79c6e";
	end
	SendChatMessage(fSendDKP(DKPCalc_Selected_Bid_ID)..charColor.." ("..Character..")"..FONT_COLOR_CODE_CLOSE, Channel);

	hideStuff(true);
	--getglobal("DKPcalc_BidSuccess_Button_Yes"):Show();
	--getglobal("DKPcalc_BidSuccess_Button_No"):Show();
end

function DKPcalc_BidSuccess_Button_Yes_OnClick()
	local dkp = getglobal("DKPcalc_EditDKP"):GetText();
	local bid = getglobal("DKPcalcDKP"..DKPCalc_Selected_Bid_ID):GetText();
	if dkp then
		getglobal("DKPcalc_EditDKP"):SetText(dkp - bid);
	end
	getglobal("DKPcalcClearFocus"):Hide();
	hideStuff(false);
end

function DKPcalc_BidSuccess_Button_No_OnClick()
	hideStuff(false);
end

function DKPcalc_ClearFocus_OnShow()
	if (check ~= true) then
		getglobal("DKPcalcClearFocus"):Hide();
	end
end


function DKPCalc_Roll_Button_OnClick()
	SendChatMessage("/roll", Channel);
end

function DKPCalc_DKP_OnCheck(bid)
	DKPCalc_Color_Selected_Bid_OnClick(bid);
	DKPCalc_Selected_Bid_ID = bid;
	local f = "DKPcalc";
	if bid == 25 then
		DKPCalc_Selected_Bid_ID = 25;
		getglobal(f.."Check25"):SetChecked(true);
		getglobal(f.."Check50"):SetChecked(false);
		getglobal(f.."Check75"):SetChecked(false);
		getglobal(f.."Check100"):SetChecked(false);
	elseif bid == 50 then
		DKPCalc_Selected_Bid_ID = 50;
		getglobal(f.."Check25"):SetChecked(false);
		-- getglobal(f.."Check50"):SetChecked(true);
		getglobal(f.."Check75"):SetChecked(false);
		getglobal(f.."Check100"):SetChecked(false);
	elseif bid == 75 then
		DKPCalc_Selected_Bid_ID = 75;
		getglobal(f.."Check25"):SetChecked(false);
		getglobal(f.."Check50"):SetChecked(false);
		-- getglobal(f.."Check75"):SetChecked(true);
		getglobal(f.."Check100"):SetChecked(false);
	elseif bid == 100 then
		DKPCalc_Selected_Bid_ID = 100;
		getglobal(f.."Check25"):SetChecked(false);
		getglobal(f.."Check50"):SetChecked(false);
		getglobal(f.."Check75"):SetChecked(false);
		-- getglobal(f.."Check100"):SetChecked(true);
	end
end

function DKPCalc_Color_Selected_Bid_OnClick(bid_id)
	for i = 25, 100, 25 do
		getglobal("DKPcalcText"..i):SetTextColor(1, 1, 1, 1);
	end

	local c = function ( colorChannel )
		convertColor = colorChannel / 255;
		return convertColor;
	end

	if bid_id == 25 then
		getglobal("DKPcalcText25"):SetTextColor(c(226), c(232), c(111), 1);
	elseif bid_id == 50 then
		getglobal("DKPcalcText50"):SetTextColor(c(201), c(221), c(10), 1);
	elseif bid_id == 75 then
		getglobal("DKPcalcText75"):SetTextColor(c(248), c(173), c(81), 1);
	elseif bid_id == 100 then
		getglobal("DKPcalcText100"):SetTextColor(c(255), c(112), c(0), 1);
	end
end

function CalcDKP(DKP)
	local round;
	round = function ( num )
		under = math.floor(num);
		upper = math.floor(num) + 1;
		underV = -(under - num);
		upperV = upper - num;
		if (upperV > underV) then
			return under;
		else
			return upper;
		end
	end

	local showDKPfunc;
	showDKPfunc = function ( frame_name, dkp )
		local frame = getglobal(frame_name);
		if dkp > 0 then
			frame:SetTextColor(0,1,0,1);
		else
			frame:SetTextColor(0.75,0.75,0.75,1);
		end
		frame:SetText(dkp);
	end

	if (DKP > 0) then
		getglobal("DKPcalcClearFocus"):Show();
	end
	showDKPfunc("DKPcalcDKP25", round(DKP * 0.25));
	showDKPfunc("DKPcalcDKP50", round(DKP * 0.5));
	showDKPfunc("DKPcalcDKP75", round(DKP * 0.75));
	showDKPfunc("DKPcalcDKP100", DKP);
end

function DKPsendFrameDropDown_OnShow()
	UIDropDownMenu_Initialize(DKPsendFrameDropDown, DKPsendFrameDropDown_Initialize);
	UIDropDownMenu_SetWidth(75, DKPsendFrameDropDown);
end

Dkp_Channels_List = {
	[1] = {
			["name"] = "Рейд",
			["var"] = "RAID",
		},
	[2] = {
			["name"] = "Гильдия",
			["var"] = "GUILD",
		},
	[3] = {
			["name"] = "Группа",
			["var"] = "PARTY",
		},
	[4] = {
			["name"] = "Сказать",
			["var"] = "SAY",
		},
};

function DKPsendFrameDropDown_Initialize()
	local info;
	for i = 1, getn(Dkp_Channels_List), 1 do
		info = {
			text = Dkp_Channels_List[i]["name"];
			func = DKPsendFrameDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function DKPsendFrameDropDown_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(DKPsendFrameDropDown, i);

	Channel = Dkp_Channels_List[i]["var"];
	DKPchanID = i;
end

function DKPcharFrameDropDown_OnShow()
	UIDropDownMenu_Initialize(DKPcharFrameDropDown, DKPcharFrameDropDown_Initialize);
	UIDropDownMenu_SetWidth(85, DKPcharFrameDropDown);
end

Char_DKP_source = {
	[1] = {
			["name"] = "Основной",
			["var"] = "main",
		},
	[2] = {
			["name"] = "Твинк",
			["var"] = "twink",
		},
};

function DKPcharFrameDropDown_Initialize()
	local info;
	for i = 1, getn(Char_DKP_source), 1 do
		info = {
			text = Char_DKP_source[i]["name"];
			func = DKPcharFrameDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function DKPcharFrameDropDown_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(DKPcharFrameDropDown, i);

	Character = Char_DKP_source[i]["var"];
	DKPcharID = i;
end
local G=_G.BLOODAIM
if not G then warn("run 1+2+3+4 first");return end

local Players=G.Players
local RunService=G.RunService
local UIS=G.UIS
local CoreGui=G.CoreGui
local Cam=G.Cam
local Tween=G.Tween
local LP=G.LP
local Stats=G.Stats
local C=G.C
local PLB=G.PRIORITY_LB
local ALB=G.AIM_LB
local SLB=G.SILENT_LB
local PRIO=G.PRIORITIES
local AP=G.AIM_PARTS
local SP=G.SILENT_PARTS

local bg=Color3.fromRGB(10,10,12)
local pnl=Color3.fromRGB(16,16,19)
local hdr=Color3.fromRGB(26,26,31)
local sb=Color3.fromRGB(13,13,16)
local btn=Color3.fromRGB(24,24,29)
local btnH=Color3.fromRGB(36,36,42)
local btnA=Color3.fromRGB(130,20,20)
local acc=Color3.fromRGB(220,45,45)
local accG=Color3.fromRGB(255,80,80)
local txt=Color3.fromRGB(235,235,238)
local txtD=Color3.fromRGB(150,150,158)
local txtM=Color3.fromRGB(100,100,108)
local suc=Color3.fromRGB(80,220,130)
local wrn=Color3.fromRGB(255,180,60)
local dgr=Color3.fromRGB(255,80,80)
local pnk=Color3.fromRGB(255,105,180)
local cyn=Color3.fromRGB(90,220,255)

G.col={bg=bg,pnl=pnl,hdr=hdr,sb=sb,btn=btn,btnH=btnH,btnA=btnA,acc=acc,accG=accG,txt=txt,txtD=txtD,txtM=txtM,suc=suc,wrn=wrn,dgr=dgr,pnk=pnk,cyn=cyn}

local SG=Instance.new("ScreenGui")
SG.Name="_bloodaim_"
SG.Parent=CoreGui
SG.ResetOnSpawn=false
SG.IgnoreGuiInset=true
SG.DisplayOrder=999
G.SG=SG

local HM=Instance.new("Frame")
HM.Size=UDim2.new(0,24,0,24)
HM.Position=UDim2.new(0.5,-12,0.5,-12)
HM.BackgroundTransparency=1
HM.BorderSizePixel=0
HM.Visible=false
HM.ZIndex=8
HM.Parent=SG

local HML={}
for i=1,4 do
local l=Instance.new("Frame")
l.Size=UDim2.new(0,8,0,2)
l.BackgroundColor3=C.HitmarkerColor
l.BorderSizePixel=0
l.AnchorPoint=Vector2.new(0.5,0.5)
l.ZIndex=8
l.Parent=HM
table.insert(HML,l)
end
HML[1].Position=UDim2.new(0.5,-6,0.15,0);HML[1].Rotation=45
HML[2].Position=UDim2.new(0.5,6,0.15,0);HML[2].Rotation=-45
HML[3].Position=UDim2.new(0.5,-6,0.85,0);HML[3].Rotation=-45
HML[4].Position=UDim2.new(0.5,6,0.85,0);HML[4].Rotation=45

local function hmv()
if not C.HitmarkerOn then return end
HM.Visible=true;HM.Size=UDim2.new(0,24,0,24);HM.Position=UDim2.new(0.5,-12,0.5,-12)
for _,l in ipairs(HML)do l.BackgroundTransparency=0;l.BackgroundColor3=C.HitmarkerColor end
task.spawn(function()
task.wait(0.08)
for _,l in ipairs(HML)do Tween:Create(l,TweenInfo.new(0.15),{BackgroundTransparency=1}):Play()end
Tween:Create(HM,TweenInfo.new(0.15),{Size=UDim2.new(0,34,0,34)}):Play()
task.wait(0.2);HM.Visible=false
end)
end
G.playHitmarkerVisual=hmv

local Circle=Instance.new("Frame")
Circle.Size=UDim2.new(0,C.Circle,0,C.Circle)
Circle.Position=UDim2.new(0.5,-C.Circle/2,0.5,-C.Circle/2)
Circle.BackgroundTransparency=1
Circle.BorderSizePixel=0
Circle.ZIndex=5
Circle.Parent=SG
local RC=Instance.new("UICorner");RC.CornerRadius=UDim.new(1,0);RC.Parent=Circle
local RS=Instance.new("UIStroke");RS.Color=acc;RS.Thickness=1.5;RS.Transparency=0.2;RS.Parent=Circle

local CH=Instance.new("Frame")
CH.Size=UDim2.new(0,14,0,1);CH.Position=UDim2.new(0.5,-7,0.5,-0.5)
CH.BackgroundColor3=accG;CH.BorderSizePixel=0;CH.BackgroundTransparency=0.1;CH.ZIndex=5;CH.Parent=SG
local CH2=Instance.new("Frame")
CH2.Size=UDim2.new(0,1,0,14);CH2.Position=UDim2.new(0.5,-0.5,0.5,-7)
CH2.BackgroundColor3=accG;CH2.BorderSizePixel=0;CH2.BackgroundTransparency=0.1;CH2.ZIndex=5;CH2.Parent=SG

local TR=Instance.new("Frame")
TR.Size=UDim2.new(0,44,0,44);TR.BackgroundTransparency=1;TR.BorderSizePixel=0;TR.Visible=false;TR.ZIndex=5;TR.Parent=SG
local TRC=Instance.new("UICorner");TRC.CornerRadius=UDim.new(1,0);TRC.Parent=TR
local TRS=Instance.new("UIStroke");TRS.Color=wrn;TRS.Thickness=1.5;TRS.Parent=TR

G.Circle=Circle
G.CH=CH
G.CH2=CH2
G.TR=TR

local IP=Instance.new("Frame")
IP.Size=UDim2.new(0,160,0,104);IP.Position=UDim2.new(1,-170,0,90)
IP.BackgroundColor3=pnl;IP.BackgroundTransparency=0.15;IP.BorderSizePixel=0;IP.ZIndex=10;IP.Parent=SG
local IPC=Instance.new("UICorner");IPC.CornerRadius=UDim.new(0,8);IPC.Parent=IP
local IPS=Instance.new("UIStroke");IPS.Color=pnk;IPS.Thickness=1;IPS.Parent=IP

local IT=Instance.new("Frame")
IT.Size=UDim2.new(1,0,0,22);IT.BackgroundColor3=hdr;IT.BorderSizePixel=0;IT.ZIndex=10;IT.Parent=IP
local ITC=Instance.new("UICorner");ITC.CornerRadius=UDim.new(0,8);ITC.Parent=IT

local ITi=Instance.new("TextLabel")
ITi.Size=UDim2.new(1,-10,1,0);ITi.Position=UDim2.new(0,8,0,0)
ITi.BackgroundTransparency=1;ITi.Text="LOKIO MADE BY AQUARIUMAN1🩷";ITi.TextColor3=pnk;ITi.Font=Enum.Font.GothamBold;ITi.TextSize=9;ITi.TextXAlignment=Enum.TextXAlignment.Left;ITi.ZIndex=10;ITi.Parent=IT

local FL=Instance.new("TextLabel")
FL.Size=UDim2.new(1,-16,0,14);FL.Position=UDim2.new(0,8,0,26)
FL.BackgroundTransparency=1;FL.Text="FPS  --";FL.TextColor3=txt;FL.Font=Enum.Font.Code;FL.TextSize=11;FL.TextXAlignment=Enum.TextXAlignment.Left;FL.ZIndex=10;FL.Parent=IP

local PL=Instance.new("TextLabel")
PL.Size=UDim2.new(1,-16,0,14);PL.Position=UDim2.new(0,8,0,40)
PL.BackgroundTransparency=1;PL.Text="PING --";PL.TextColor3=txt;PL.Font=Enum.Font.Code;PL.TextSize=11;PL.TextXAlignment=Enum.TextXAlignment.Left;PL.ZIndex=10;PL.Parent=IP

local TL=Instance.new("TextLabel")
TL.Size=UDim2.new(1,-16,0,14);TL.Position=UDim2.new(0,8,0,54)
TL.BackgroundTransparency=1;TL.Text="TARGET --";TL.TextColor3=wrn;TL.Font=Enum.Font.Code;TL.TextSize=11;TL.TextXAlignment=Enum.TextXAlignment.Left;TL.ZIndex=10;TL.Parent=IP

local SL=Instance.new("TextLabel")
SL.Size=UDim2.new(1,-16,0,14);SL.Position=UDim2.new(0,8,0,68)
SL.BackgroundTransparency=1;SL.Text="K/D 0/0";SL.TextColor3=txtD;SL.Font=Enum.Font.Code;SL.TextSize=10;SL.TextXAlignment=Enum.TextXAlignment.Left;SL.ZIndex=10;SL.Parent=IP

local SSL=Instance.new("TextLabel")
SSL.Size=UDim2.new(1,-16,0,14);SSL.Position=UDim2.new(0,8,0,82)
SSL.BackgroundTransparency=1;SSL.Text="SESSION 0s";SSL.TextColor3=txtD;SSL.Font=Enum.Font.Code;SSL.TextSize=10;SSL.TextXAlignment=Enum.TextXAlignment.Left;SSL.ZIndex=10;SSL.Parent=IP

G.FL=FL
G.PL=PL
G.TL=TL
G.SL=SL
G.SSL=SSL

local KF=Instance.new("Frame")
KF.Size=UDim2.new(0,220,0,140);KF.Position=UDim2.new(1,-230,0,200)
KF.BackgroundTransparency=1
KF.ZIndex=11
KF.Parent=SG
local KFL=Instance.new("UIListLayout");KFL.Padding=UDim.new(0,3);KFL.Parent=KF

local function kfe(t,c)
local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,0,0,18)
l.BackgroundColor3=pnl
l.BackgroundTransparency=0.3
l.Text="  "..t
l.TextColor3=c or txt
l.Font=Enum.Font.GothamBold
l.TextSize=10
l.TextXAlignment=Enum.TextXAlignment.Left
l.ZIndex=11
l.Parent=KF
local lc=Instance.new("UICorner");lc.CornerRadius=UDim.new(0,4);lc.Parent=l
Tween:Create(l,TweenInfo.new(0.3),{BackgroundTransparency=0.7,TextTransparency=0.5}):Play()
G.Debris:AddItem(l,4)
end
G.addKillFeedEntry=kfe
G.kfe=kfe

local P=Instance.new("Frame")
P.Size=UDim2.new(0,540,0,360);P.Position=UDim2.new(0.5,-270,0.5,-180)
P.BackgroundColor3=pnl;P.BorderSizePixel=0;P.Active=true;P.Draggable=true;P.ZIndex=20;P.Parent=SG
local PC=Instance.new("UICorner");PC.CornerRadius=UDim.new(0,10);PC.Parent=P
local PS=Instance.new("UIStroke");PS.Color=pnk;PS.Thickness=1;PS.Parent=P

local H=Instance.new("Frame")
H.Size=UDim2.new(1,0,0,48);H.BackgroundColor3=hdr;H.BorderSizePixel=0;H.ZIndex=21;H.Parent=P
local HC=Instance.new("UICorner");HC.CornerRadius=UDim.new(0,10);HC.Parent=H

local HCv=Instance.new("Frame")
HCv.Size=UDim2.new(1,0,0,10);HCv.Position=UDim2.new(0,0,1,-10)
HCv.BackgroundColor3=hdr;HCv.BorderSizePixel=0;HCv.ZIndex=21;HCv.Parent=H

local AB=Instance.new("Frame")
AB.Size=UDim2.new(0,4,1,-12);AB.Position=UDim2.new(0,10,0,6)
AB.BackgroundColor3=pnk;AB.BorderSizePixel=0;AB.ZIndex=22;AB.Parent=H
local ABC=Instance.new("UICorner");ABC.CornerRadius=UDim.new(0,2);ABC.Parent=AB

local T=Instance.new("TextLabel")
T.Size=UDim2.new(0,380,0,22);T.Position=UDim2.new(0,22,0,4)
T.BackgroundTransparency=1;T.Text="LOKIO MADE BY AQUARIUMAN1🩷";T.TextColor3=pnk;T.Font=Enum.Font.GothamBlack;T.TextSize=14;T.TextXAlignment=Enum.TextXAlignment.Left;T.ZIndex=22;T.Parent=H

local Sub=Instance.new("TextLabel")
Sub.Size=UDim2.new(0,380,0,16);Sub.Position=UDim2.new(0,22,0,26)
Sub.BackgroundTransparency=1;Sub.Text="v9.0 6-part";Sub.TextColor3=txtM;Sub.Font=Enum.Font.Gotham;Sub.TextSize=10;Sub.TextXAlignment=Enum.TextXAlignment.Left;Sub.ZIndex=22;Sub.Parent=H

local SD=Instance.new("Frame")
SD.Size=UDim2.new(0,8,0,8);SD.Position=UDim2.new(1,-110,0,20)
SD.BackgroundColor3=dgr;SD.BorderSizePixel=0;SD.ZIndex=22;SD.Parent=H
local SDC=Instance.new("UICorner");SDC.CornerRadius=UDim.new(1,0);SDC.Parent=SD

local ST=Instance.new("TextLabel")
ST.Size=UDim2.new(0,60,0,20);ST.Position=UDim2.new(1,-98,0,14)
ST.BackgroundTransparency=1;ST.Text="IDLE";ST.TextColor3=txtD;ST.Font=Enum.Font.Code;ST.TextSize=11;ST.TextXAlignment=Enum.TextXAlignment.Left;ST.ZIndex=22;ST.Parent=H

local MB=Instance.new("TextButton")
MB.Size=UDim2.new(0,26,0,22);MB.Position=UDim2.new(1,-60,0,13)
MB.BackgroundColor3=btn;MB.Text="—";MB.TextColor3=txtD;MB.Font=Enum.Font.GothamBold;MB.TextSize=12;MB.AutoButtonColor=false;MB.ZIndex=22;MB.Parent=H
local MBC=Instance.new("UICorner");MBC.CornerRadius=UDim.new(0,5);MBC.Parent=MB

local CB=Instance.new("TextButton")
CB.Size=UDim2.new(0,26,0,22);CB.Position=UDim2.new(1,-32,0,13)
CB.BackgroundColor3=btn;CB.Text="X";CB.TextColor3=txtD;CB.Font=Enum.Font.GothamBold;CB.TextSize=12;CB.AutoButtonColor=false;CB.ZIndex=22;CB.Parent=H
local CBC=Instance.new("UICorner");CBC.CornerRadius=UDim.new(0,5);CBC.Parent=CB

local OB=Instance.new("TextButton")
OB.Size=UDim2.new(0,50,0,50);OB.Position=UDim2.new(0,20,0.5,-25)
OB.BackgroundColor3=pnl;OB.Text="L";OB.TextColor3=pnk;OB.Font=Enum.Font.GothamBlack;OB.TextSize=17;OB.Active=true;OB.Draggable=true;OB.Visible=false;OB.ZIndex=20;OB.Parent=SG
local OBC=Instance.new("UICorner");OBC.CornerRadius=UDim.new(1,0);OBC.Parent=OB
local OBS=Instance.new("UIStroke");OBS.Color=pnk;OBS.Thickness=1.5;OBS.Parent=OB

G.P=P
G.ST=ST
G.SD=SD
G.MB=MB
G.CB=CB
G.OB=OB

local Tb=Instance.new("Frame")
Tb.Size=UDim2.new(0,100,1,-64);Tb.Position=UDim2.new(0,6,0,54)
Tb.BackgroundColor3=sb;Tb.BorderSizePixel=0;Tb.ZIndex=21;Tb.Parent=P
local TbC=Instance.new("UICorner");TbC.CornerRadius=UDim.new(0,8);TbC.Parent=Tb
local TbL=Instance.new("UIListLayout");TbL.Padding=UDim.new(0,3);TbL.Parent=Tb
local TbP=Instance.new("UIPadding");TbP.PaddingTop=UDim.new(0,6);TbP.PaddingLeft=UDim.new(0,5);TbP.PaddingRight=UDim.new(0,5);TbP.Parent=Tb

local Pg=Instance.new("Frame")
Pg.Size=UDim2.new(1,-114,1,-64)
Pg.Position=UDim2.new(0,108,0,54)
Pg.BackgroundTransparency=1
Pg.ZIndex=21
Pg.Parent=P

local function mkTab(n,o)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,0,0,32);b.BackgroundColor3=btn;b.Text=n;b.TextColor3=txtD;b.Font=Enum.Font.GothamBold;b.TextSize=11;b.LayoutOrder=o;b.AutoButtonColor=false;b.ZIndex=22;b.Parent=Tb
local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,6);c.Parent=b
return b
end

local function mkPg()
local p=Instance.new("ScrollingFrame")
p.Size=UDim2.new(1,0,1,0);p.BackgroundTransparency=1;p.BorderSizePixel=0;p.ScrollBarThickness=3;p.ScrollBarImageColor3=pnk;p.CanvasSize=UDim2.new(0,0,0,0);p.AutomaticCanvasSize=Enum.AutomaticSize.Y;p.Visible=false;p.ZIndex=22;p.Parent=Pg
local l=Instance.new("UIListLayout");l.Padding=UDim.new(0,6);l.Parent=p
return p
end

local TA=mkTab("AIM",1)
local TV=mkTab("VISUAL",2)
local TP=mkTab("PLAYER",3)
local TW=mkTab("WORLD",4)
local TM=mkTab("MISC",5)
local TS=mkTab("STATS",6)

local PA=mkPg()
local PV=mkPg()
local PP=mkPg()
local PW=mkPg()
local PM=mkPg()
local PSt=mkPg()

local AT={TA,TV,TP,TW,TM,TS}
local APG={PA,PV,PP,PW,PM,PSt}

local function show(i)
for k,p in ipairs(APG)do
p.Visible=(k==i)
AT[k].BackgroundColor3=(k==i) and btnA or btn
AT[k].TextColor3=(k==i) and Color3.fromRGB(255,255,255) or txtD
end
end

TA.MouseButton1Click:Connect(function()show(1)end)
TV.MouseButton1Click:Connect(function()show(2)end)
TP.MouseButton1Click:Connect(function()show(3)end)
TW.MouseButton1Click:Connect(function()show(4)end)
TM.MouseButton1Click:Connect(function()show(5)end)
TS.MouseButton1Click:Connect(function()show(6)end)
show(1)

local function mkSec(par,ttl)
local h=Instance.new("Frame");h.Size=UDim2.new(1,0,0,20);h.BackgroundTransparency=1;h.ZIndex=23;h.Parent=par
local b=Instance.new("Frame");b.Size=UDim2.new(0,3,0,12);b.Position=UDim2.new(0,0,0,4);b.BackgroundColor3=pnk;b.BorderSizePixel=0;b.ZIndex=23;b.Parent=h
local bc=Instance.new("UICorner");bc.CornerRadius=UDim.new(0,2);bc.Parent=b
local l=Instance.new("TextLabel");l.Size=UDim2.new(1,-10,1,0);l.Position=UDim2.new(0,10,0,0);l.BackgroundTransparency=1;l.Text=ttl;l.TextColor3=txtD;l.Font=Enum.Font.GothamBold;l.TextSize=10;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=23;l.Parent=h
return h
end

local function mkB(par,txt)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,0,0,30);b.BackgroundColor3=btn;b.Text=txt;b.TextColor3=txt;b.Font=Enum.Font.GothamBold;b.TextSize=11;b.AutoButtonColor=false;b.ZIndex=23;b.Parent=par
local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,6);c.Parent=b
b.MouseEnter:Connect(function()if b.BackgroundColor3==btn then Tween:Create(b,TweenInfo.new(0.12),{BackgroundColor3=btnH}):Play()end end)
b.MouseLeave:Connect(function()if b.BackgroundColor3==btnH then Tween:Create(b,TweenInfo.new(0.12),{BackgroundColor3=btn}):Play()end end)
return b
end

local function mkSl(par,lbl)
local h=Instance.new("Frame");h.Size=UDim2.new(1,0,0,40);h.BackgroundTransparency=1;h.ZIndex=23;h.Parent=par
local l=Instance.new("TextLabel");l.Size=UDim2.new(0.7,0,0,16);l.BackgroundTransparency=1;l.Text=lbl;l.TextColor3=txtD;l.Font=Enum.Font.Gotham;l.TextSize=11;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=23;l.Parent=h
local v=Instance.new("TextLabel");v.Size=UDim2.new(0.3,0,0,16);v.Position=UDim2.new(0.7,0,0,0);v.BackgroundTransparency=1;v.Text="";v.TextColor3=pnk;v.Font=Enum.Font.Code;v.TextSize=11;v.TextXAlignment=Enum.TextXAlignment.Right;v.ZIndex=23;v.Parent=h
local b=Instance.new("Frame");b.Size=UDim2.new(1,0,0,14);b.Position=UDim2.new(0,0,0,20);b.BackgroundColor3=bg;b.BorderSizePixel=0;b.ZIndex=23;b.Parent=h
local bc=Instance.new("UICorner");bc.CornerRadius=UDim.new(1,0);bc.Parent=b
local f=Instance.new("Frame");f.Size=UDim2.new(0.5,0,1,0);f.BackgroundColor3=acc;f.BorderSizePixel=0;f.ZIndex=23;f.Parent=b
local fc=Instance.new("UICorner");fc.CornerRadius=UDim.new(1,0);fc.Parent=f
local k=Instance.new("Frame");k.Size=UDim2.new(0,10,0,10);k.Position=UDim2.new(0.5,-5,0,2);k.BackgroundColor3=Color3.fromRGB(255,255,255);k.BorderSizePixel=0;k.ZIndex=24;k.Parent=b
local kc=Instance.new("UICorner");kc.CornerRadius=UDim.new(1,0);kc.Parent=k
return l,v,b,f,k
end

local function sl(b,f,k,cb)
local d=false
b.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then d=true end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then d=false end end)
UIS.InputChanged:Connect(function(i)
if not d then return end
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement then
local p=math.clamp((i.Position.X-b.AbsolutePosition.X)/b.AbsoluteSize.X,0,1)
f.Size=UDim2.new(p,0,1,0);k.Position=UDim2.new(p,-5,0,2);cb(p)
end
end)
end

G.mkTab=mkTab
G.mkPg=mkPg
G.mkSec=mkSec
G.mkB=mkB
G.mkSl=mkSl
G.sl=sl
G.show=show
G.PA=PA
G.PV=PV
G.PP=PP
G.PW=PW
G.PM=PM
G.PSt=PSt

print("[P5/6] loaded — paste PART 6")

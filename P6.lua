local G=_G.BLOODAIM
if not G then warn("run 1-5 first");return end

local Players=G.Players
local RunService=G.RunService
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

local bg=G.col.bg
local pnl=G.col.pnl
local btn=G.col.btn
local btnA=G.col.btnA
local acc=G.col.acc
local txt=G.col.txt
local txtD=G.col.txtD
local suc=G.col.suc
local wrn=G.col.wrn
local dgr=G.col.dgr
local pnk=G.col.pnk
local cyn=G.col.cyn

local mkB=G.mkB
local mkSl=G.mkSl
local mkSec=G.mkSec
local sl=G.sl
local kfe=G.kfe

local PA=G.PA
local PV=G.PV
local PP=G.PP
local PW=G.PW
local PM=G.PM
local PSt=G.PSt

local Circle=G.Circle
local CH=G.CH
local CH2=G.CH2
local TR=G.TR
local ST=G.ST
local SD=G.SD
local FL=G.FL
local PL=G.PL
local TL=G.TL
local SL=G.SL
local SSL=G.SSL
local P=G.P
local MB=G.MB
local CB=G.CB
local OB=G.OB
local SG=G.SG

mkSec(PA,"TARGETING")
local AB_=mkB(PA,"AIM  OFF")
local TB=mkB(PA,"TEAM CHECK  ON")
local PB=mkB(PA,"PREDICTION  OFF")
local APB=mkB(PA,"AIM PART  UPPER TORSO")
local PrioB=mkB(PA,"PRIORITY  CLOSEST")

mkSec(PA,"SILENT AIM")
local SiB=mkB(PA,"SILENT AIM  OFF")
local SPB=mkB(PA,"SILENT PART  HEAD")

mkSec(PA,"AIM SETTINGS")
local CL,CV,CBar,CFill,CKnob=mkSl(PA,"CIRCLE")
local SLL,SV,SBar,SFill,SKnob=mkSl(PA,"SMOOTH")
local StL,StV,StBar,StFill,StKnob=mkSl(PA,"STICKY")
local FlL,FlV,FlBar,FlFill,FlKnob=mkSl(PA,"FLICK")
local ML,MV,MBar,MFill,MKnob=mkSl(PA,"MISS CHANCE")

mkSec(PA,"OVERLAY")
local CirB=mkB(PA,"CIRCLE  ON")
local CrB=mkB(PA,"CROSSHAIR  ON")

mkSec(PV,"HITBOX")
local HiB=mkB(PV,"HITBOX EXPAND  OFF")
local ShB=mkB(PV,"SHRINK SELF  OFF")
local HL,HV,HBar,HFill,HKnob=mkSl(PV,"HITBOX SCALE")
local SHL,SHV,SHBar,SHFill,SHKnob=mkSl(PV,"SHRINK SCALE")

mkSec(PV,"PLAYER OVERLAY")
local TrB=mkB(PV,"TRACER  OFF")
local NB=mkB(PV,"NAMETAG  OFF")
local HPB=mkB(PV,"HEALTHBAR  OFF")
local EB=mkB(PV,"ESP BOX  OFF")
local ChB=mkB(PV,"CHAMS  OFF")
local HMB=mkB(PV,"HITMARKER  ON")

mkSec(PP,"MOVEMENT")
local SpB=mkB(PP,"SPEED  OFF")
local JmB=mkB(PP,"JUMP  OFF")
local IJB=mkB(PP,"INFINITE JUMP  OFF")
local SpL,SpV,SpBar,SpFill,SpKnob=mkSl(PP,"SPEED")
local JpL,JpV,JpBar,JpFill,JpKnob=mkSl(PP,"JUMP")

mkSec(PP,"SURVIVAL")
local AVB=mkB(PP,"ANTI VOID  OFF")
local RB=mkB(PP,"FAST RESPAWN  OFF")
local RjB=mkB(PP,"AUTO REJOIN  OFF")
local HB=mkB(PP,"SERVER HOP")

mkSec(PW,"VISUALS")
local FB=mkB(PW,"FULLBRIGHT  OFF")
local FgB=mkB(PW,"NO FOG  OFF")
local ShdB=mkB(PW,"NO SHADOWS  OFF")
local PtB=mkB(PW,"NO PARTICLES  OFF")
local GrB=mkB(PW,"NO GRASS  OFF")

mkSec(PW,"CAMERA")
local FOVL,FOVV,FOVBar,FOVFill,FOVKnob=mkSl(PW,"FIELD OF VIEW")
local TmB=mkB(PW,"TIME OF DAY  OFF")
local TmL,TmV,TmBar,TmFill,TmKnob=mkSl(PW,"CLOCK TIME")
local FPSB=mkB(PW,"FPS UNLOCK  OFF")

mkSec(PM,"FEEDBACK")
local KSB=mkB(PM,"KILL SAY  OFF")
local FPSLB=mkB(PM,"SHOW FPS  ON")
local PingLB=mkB(PM,"SHOW PING  ON")

mkSec(PM,"PREDICTION")
local PrSL,PrV,PrBar,PrFill,PrKnob=mkSl(PM,"PRED STRENGTH")

mkSec(PSt,"LIVE")
local SKL=Instance.new("TextLabel")
SKL.Size=UDim2.new(1,0,0,22);SKL.BackgroundColor3=btn;SKL.Text="  KILLS  0";SKL.TextColor3=txt;SKL.Font=Enum.Font.GothamBold;SKL.TextSize=11;SKL.TextXAlignment=Enum.TextXAlignment.Left;SKL.ZIndex=23;SKL.Parent=PSt
local SKC=Instance.new("UICorner");SKC.CornerRadius=UDim.new(0,6);SKC.Parent=SKL

local SDL=Instance.new("TextLabel")
SDL.Size=UDim2.new(1,0,0,22);SDL.BackgroundColor3=btn;SDL.Text="  DEATHS  0";SDL.TextColor3=txt;SDL.Font=Enum.Font.GothamBold;SDL.TextSize=11;SDL.TextXAlignment=Enum.TextXAlignment.Left;SDL.ZIndex=23;SDL.Parent=PSt
local SDC2=Instance.new("UICorner");SDC2.CornerRadius=UDim.new(0,6);SDC2.Parent=SDL

local SKDL=Instance.new("TextLabel")
SKDL.Size=UDim2.new(1,0,0,22);SKDL.BackgroundColor3=btn;SKDL.Text="  K/D  0.00";SKDL.TextColor3=wrn;SKDL.Font=Enum.Font.GothamBold;SKDL.TextSize=11;SKDL.TextXAlignment=Enum.TextXAlignment.Left;SKDL.ZIndex=23;SKDL.Parent=PSt
local SKDC=Instance.new("UICorner");SKDC.CornerRadius=UDim.new(0,6);SKDC.Parent=SKDL

mkSec(PSt,"PLAYERS")
local PLF=Instance.new("Frame")
PLF.Size=UDim2.new(1,0,0,220)
PLF.BackgroundColor3=bg
PLF.BackgroundTransparency=0.3
PLF.BorderSizePixel=0
PLF.ZIndex=23
PLF.Parent=PSt
local PLC=Instance.new("UICorner");PLC.CornerRadius=UDim.new(0,6);PLC.Parent=PLF
local PLS=Instance.new("ScrollingFrame")
PLS.Size=UDim2.new(1,-4,1,-4)
PLS.Position=UDim2.new(0,2,0,2)
PLS.BackgroundTransparency=1
PLS.BorderSizePixel=0
PLS.ScrollBarThickness=3
PLS.ScrollBarImageColor3=pnk
PLS.CanvasSize=UDim2.new(0,0,0,0)
PLS.AutomaticCanvasSize=Enum.AutomaticSize.Y
PLS.ZIndex=23
PLS.Parent=PLF
local PLL=Instance.new("UIListLayout");PLL.Padding=UDim.new(0,2);PLL.Parent=PLS

local pRows={}
local function refreshPL()
for _,r in ipairs(pRows)do r:Destroy()end
pRows={}
for _,p in ipairs(Players:GetPlayers())do
local d=0
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
d=math.floor((p.Character.HumanoidRootPart.Position-Cam.CFrame.Position).Magnitude)
end
local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,0,0,22)
l.BackgroundColor3=(p==LP) and btnA or btn
l.Text="  "..p.Name:sub(1,14).." · "..d.."m"
l.TextColor3=txt
l.Font=Enum.Font.GothamBold
l.TextSize=10
l.TextXAlignment=Enum.TextXAlignment.Left
l.ZIndex=23
l.Parent=PLS
local lc=Instance.new("UICorner");lc.CornerRadius=UDim.new(0,4);lc.Parent=l
l.MouseButton1Click:Connect(function()
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
LP.Character.HumanoidRootPart.CFrame=p.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
kfe("teleported to "..p.Name,cyn)
end
end)
table.insert(pRows,l)
end
end

sl(CBar,CFill,CKnob,function(p)C.Circle=math.floor(40+p*360);CV.Text=tostring(C.Circle);Circle.Size=UDim2.new(0,C.Circle,0,C.Circle);Circle.Position=UDim2.new(0.5,-C.Circle/2,0.5,-C.Circle/2)end)
sl(SBar,SFill,SKnob,function(p)C.Assist=math.floor((0.1+p*0.9)*100)/100;SV.Text=tostring(C.Assist)end)
sl(StBar,StFill,StKnob,function(p)C.StickyTime=math.floor((0.05+p*1.45)*100)/100;StV.Text=C.StickyTime.."s"end)
sl(FlBar,FlFill,FlKnob,function(p)C.FlickThreshold=math.floor(5+p*95);FlV.Text=C.FlickThreshold.."px"end)
sl(MBar,MFill,MKnob,function(p)C.MissChance=math.floor(p*100)/100;MV.Text=math.floor(C.MissChance*100).."%"end)
sl(HBar,HFill,HKnob,function(p)C.HitboxScale=math.floor((1+p*9)*10)/10;HV.Text=C.HitboxScale.."x";if C.HitboxOn then G.applyHitboxAll()end end)
sl(SHBar,SHFill,SHKnob,function(p)C.ShrinkScale=math.floor((0.1+p*0.7)*100)/100;SHV.Text=C.ShrinkScale.."x";if C.ShrinkOn then G.applyShrinkSelf()end end)
sl(SpBar,SpFill,SpKnob,function(p)C.SpeedValue=math.floor(16+p*84);SpV.Text=tostring(C.SpeedValue);if C.SpeedOn then G.applySpeed()end end)
sl(JpBar,JpFill,JpKnob,function(p)C.JumpValue=math.floor(50+p*150);JpV.Text=tostring(C.JumpValue);if C.JumpOn then G.applyJump()end end)
sl(FOVBar,FOVFill,FOVKnob,function(p)C.FOVValue=math.floor(70+p*60);FOVV.Text=tostring(C.FOVValue);G.applyFOV()end)
sl(PrBar,PrFill,PrKnob,function(p)C.PredStrength=math.floor(p*40)/100;PrV.Text=tostring(C.PredStrength)end)
sl(TmBar,TmFill,TmKnob,function(p)C.TimeOfDay=math.floor(p*24);TmV.Text=tostring(C.TimeOfDay).."h";if C.TimeOn then G.applyLighting()end end)

CV.Text="140";SV.Text="1";StV.Text="0.35s";FlV.Text="30px";MV.Text="0%";HV.Text="3x";SHV.Text="0.35x";SpV.Text="22";JpV.Text="80";FOVV.Text="90";PrV.Text="0.15";TmV.Text="0h"

local function tg(b,k,l,fn)
b.MouseButton1Click:Connect(function()
C[k]=not C[k]
b.Text=l.."  "..(C[k] and "ON" or "OFF")
b.BackgroundColor3=C[k] and btnA or btn
if fn then fn()end
end)
end

tg(AB_,"AimOn","AIM")
tg(TB,"TeamCheck","TEAM CHECK")
tg(PB,"Prediction","PREDICTION")
tg(SiB,"SilentOn","SILENT AIM")
tg(CirB,"CircleVisible","CIRCLE",function()Circle.Visible=C.CircleVisible end)
tg(CrB,"CrosshairOn","CROSSHAIR",function()CH.Visible=C.CrosshairOn;CH2.Visible=C.CrosshairOn end)
tg(HiB,"HitboxOn","HITBOX EXPAND",G.applyHitboxAll)
tg(ShB,"ShrinkOn","SHRINK SELF",G.applyShrinkSelf)
tg(TrB,"TracerOn","TRACER")
tg(NB,"NameTagOn","NAMETAG")
tg(HPB,"HealthBarOn","HEALTHBAR")
tg(EB,"ESPBoxOn","ESP BOX")
tg(ChB,"ChamsOn","CHAMS")
tg(HMB,"HitmarkerOn","HITMARKER")
tg(SpB,"SpeedOn","SPEED",G.applySpeed)
tg(JmB,"JumpOn","JUMP",G.applyJump)
tg(IJB,"InfiniteJump","INFINITE JUMP")
tg(AVB,"AntiVoidOn","ANTI VOID")
tg(RB,"FastRespawn","FAST RESPAWN")
tg(RjB,"AutoRejoin","AUTO REJOIN")
tg(FB,"FullbrightOn","FULLBRIGHT",G.applyLighting)
tg(FgB,"NoFog","NO FOG",G.applyLighting)
tg(ShdB,"NoShadows","NO SHADOWS",G.applyLighting)
tg(PtB,"NoParticles","NO PARTICLES",G.applyParticles)
tg(GrB,"NoGrass","NO GRASS",G.applyNoGrass)
tg(TmB,"TimeOn","TIME OF DAY",G.applyLighting)
tg(FPSB,"FPSUnlock","FPS UNLOCK",G.applyFPSUnlock)
tg(KSB,"KillSay","KILL SAY")
tg(FPSLB,"ShowFPS","SHOW FPS",function()FL.Visible=C.ShowFPS end)
tg(PingLB,"ShowPing","SHOW PING",function()PL.Visible=C.ShowPing end)

APB.MouseButton1Click:Connect(function()
local i=G.getAimIdx()+1;if i>#AP then i=1 end
G.setAimIdx(i)
C.AimPart=AP[i]
APB.Text="AIM PART  "..ALB[C.AimPart]
end)

SPB.MouseButton1Click:Connect(function()
local i=G.getSilIdx()+1;if i>#SP then i=1 end
G.setSilIdx(i)
C.SilentPart=SP[i]
SPB.Text="SILENT PART  "..SLB[C.SilentPart]
end)

PrioB.MouseButton1Click:Connect(function()
local i=G.getPrioIdx()+1;if i>#PRIO then i=1 end
G.setPrioIdx(i)
C.AimPriority=PRIO[i]
PrioB.Text="PRIORITY  "..PLB[C.AimPriority]
end)

HB.MouseButton1Click:Connect(function()HB.Text="HOPPING...";G.serverHop()end)
MB.MouseButton1Click:Connect(function()P.Visible=false;OB.Visible=true end)
OB.MouseButton1Click:Connect(function()P.Visible=true;OB.Visible=false end)
CB.MouseButton1Click:Connect(function()SG:Destroy()end)

local function uti(p)
if p and p.Character then
local hum=p.Character:FindFirstChildOfClass("Humanoid")
local hrp=p.Character:FindFirstChild("HumanoidRootPart")
if hum and hrp then
local d=(hrp.Position-Cam.CFrame.Position).Magnitude
TL.Text=p.Name:sub(1,12).." "..math.floor(d).."m"
end
else TL.Text="TARGET --" end
end

local lastKill=0
local lastRefresh=0
local chams={}

local function applyChams(p)
if not p.Character then return end
if C.ChamsOn then
if not chams[p] then
local h=Instance.new("Highlight")
h.Name="_c_"..p.Name
h.FillColor=Color3.fromRGB(255,80,80)
h.FillTransparency=0.5
h.OutlineColor=Color3.fromRGB(255,255,255)
h.OutlineTransparency=0
h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
h.Parent=p.Character
chams[p]=h
end
else
if chams[p] then chams[p]:Destroy();chams[p]=nil end
end
end

RunService.RenderStepped:Connect(function(dt)
local st=G.getSticky()
if C.AimOn and st then
local part=G.aimPart(st)
if part then
local pp=G.predictPos(st,part)
local sp,on=Cam:WorldToViewportPoint(pp)
if on then
TR.Visible=true
TR.Position=UDim2.new(0,sp.X-22,0,sp.Y-22)
else TR.Visible=false end
ST.Text="LOCKED";ST.TextColor3=suc;SD.BackgroundColor3=suc
uti(st)
end
else
TR.Visible=false
ST.Text="IDLE";ST.TextColor3=txtD;SD.BackgroundColor3=dgr
uti(nil)
end

if C.ShowFPS then FL.Text="FPS  "..G.getFpsValue() end
if C.ShowPing then pcall(function()local pg=Stats.Network.ServerStatsItem["Data Ping"]:GetValue();PL.Text="PING "..math.floor(pg)end)end
local k=G.getKillCount()
local d2=G.getDeathCount()
SL.Text="K/D "..k.."/"..d2
local ss=math.floor(tick()-G.getSessionStart())
SSL.Text="SESSION "..ss.."s"
local kd=d2>0 and (k/d2) or k
SKL.Text="  KILLS  "..k
SDL.Text="  DEATHS  "..d2
SKDL.Text="  K/D  "..string.format("%.2f",kd)

local now=tick()
if k>lastKill then
lastKill=k
kfe("kill · total "..k,suc)
end

if now-lastRefresh>2 then
lastRefresh=now
refreshPL()
end

for _,p in ipairs(Players:GetPlayers())do
if p~=LP then
if C.ChamsOn then applyChams(p) end
local tag=SG:FindFirstChild("tag_"..p.Name)
local box=SG:FindFirstChild("box_"..p.Name)
local line=SG:FindFirstChild("line_"..p.Name)
local hpbg=SG:FindFirstChild("hpbg_"..p.Name)
local hpb=SG:FindFirstChild("hpb_"..p.Name)
if G.isEnemy(p) and p.Character then
local hrp=p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChild("Head")
local head=p.Character:FindFirstChild("Head")
local hum=p.Character:FindFirstChildOfClass("Humanoid")
if hrp then
local sp,on=Cam:WorldToViewportPoint(hrp.Position)
if on then
local topY=sp.Y-40
local botY=sp.Y+40
if head then local hp,hs=Cam:WorldToViewportPoint(head.Position+Vector3.new(0,0.5,0));if hs then topY=hp.Y end end
local h=botY-topY
local w=h*0.55
if C.NameTagOn then
if not tag then
tag=Instance.new("TextLabel");tag.Name="tag_"..p.Name;tag.Size=UDim2.new(0,100,0,14);tag.BackgroundTransparency=1;tag.TextColor3=txt;tag.Font=Enum.Font.GothamBold;tag.TextSize=11;tag.TextStrokeTransparency=0;tag.ZIndex=5;tag.Parent=SG
end
tag.Visible=true;tag.Text=p.Name;tag.Position=UDim2.new(0,sp.X-50,0,topY-16)
elseif tag then tag.Visible=false end
if C.ESPBoxOn then
if not box then
box=Instance.new("Frame");box.Name="box_"..p.Name;box.BackgroundTransparency=1;box.BorderSizePixel=0;box.ZIndex=5;box.Parent=SG
local bc=Instance.new("UICorner");bc.CornerRadius=UDim.new(0,2);bc.Parent=box
local bs=Instance.new("UIStroke");bs.Color=acc;bs.Thickness=1.5;bs.Parent=box
end
box.Visible=true;box.Size=UDim2.new(0,w,0,h);box.Position=UDim2.new(0,sp.X-w/2,0,topY)
elseif box then box.Visible=false end
if C.HealthBarOn and hum then
local pct=hum.Health/hum.MaxHealth
if not hpbg then
hpbg=Instance.new("Frame");hpbg.Name="hpbg_"..p.Name;hpbg.BackgroundColor3=bg;hpbg.BorderSizePixel=0;hpbg.ZIndex=5;hpbg.Parent=SG
local bgc=Instance.new("UICorner");bgc.CornerRadius=UDim.new(0,1);bgc.Parent=hpbg
hpb=Instance.new("Frame");hpb.Name="hpb_"..p.Name;hpb.BorderSizePixel=0;hpb.ZIndex=6;hpb.Parent=SG
local bhc=Instance.new("UICorner");bhc.CornerRadius=UDim.new(0,1);bhc.Parent=hpb
end
hpbg.Visible=true;hpbg.Size=UDim2.new(0,3,0,h);hpbg.Position=UDim2.new(0,sp.X-w/2-5,0,topY)
hpb.Visible=true;hpb.Size=UDim2.new(0,3,0,h*pct);hpb.Position=UDim2.new(0,sp.X-w/2-5,0,topY+h*(1-pct))
hpb.BackgroundColor3=pct>0.5 and suc or pct>0.2 and wrn or dgr
else
if hpbg then hpbg.Visible=false end
if hpb then hpb.Visible=false end
end
if C.TracerOn then
if not line then
line=Instance.new("Frame");line.Name="line_"..p.Name;line.BorderSizePixel=0;line.BackgroundColor3=acc;line.BackgroundTransparency=0.4;line.ZIndex=5;line.Parent=SG
end
line.Visible=true
local fx=Cam.ViewportSize.X/2
local fy=Cam.ViewportSize.Y-10
local dx=sp.X-fx
local dy=botY-fy
local len=math.sqrt(dx*dx+dy*dy)
local ang=math.atan2(dy,dx)
line.Size=UDim2.new(0,len,0,1);line.Position=UDim2.new(0,fx,0,fy);line.Rotation=math.deg(ang);line.AnchorPoint=Vector2.new(0,0.5)
elseif line then line.Visible=false end
else
if tag then tag.Visible=false end
if box then box.Visible=false end
if line then line.Visible=false end
if hpbg then hpbg.Visible=false end
if hpb then hpb.Visible=false end
end
end
else
if tag then tag.Visible=false end
if box then box.Visible=false end
if line then line.Visible=false end
if hpbg then hpbg.Visible=false end
if hpb then hpb.Visible=false end
end
end
end
end)

print("[P6/6] loaded — LOKIO MADE BY AQUARIUMAN1🩷")

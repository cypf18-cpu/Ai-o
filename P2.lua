local G=_G.BLOODAIM
if not G then warn("run PART 1 first");return end

local C={
AimOn=false,TeamCheck=true,Circle=140,CircleVisible=true,
Assist=1,MaxRange=500,StickyTime=0.35,FlickThreshold=30,
AimPart="UpperTorso",AimPriority="ClosestToCrosshair",
MissChance=0,AimSmoothing="Linear",
HitboxOn=false,HitboxScale=3,ShrinkOn=false,ShrinkScale=0.35,
Prediction=false,PredStrength=0.15,FastRespawn=false,AutoRejoin=false,
TracerOn=false,NameTagOn=false,HealthBarOn=false,ESPBoxOn=false,
SkeletonOn=false,ChamsOn=false,DamageNumbersOn=false,
CrosshairOn=true,SilentOn=false,SilentPart="Head",
InfiniteJump=false,KillSay=false,KillSayMsg="lakas mo",
SpeedOn=false,SpeedValue=22,JumpOn=false,JumpValue=80,
FullbrightOn=false,NoFog=false,NoParticles=false,NoShadows=false,
TimeOfDay=0,TimeOn=false,NoGrass=false,MuteAmbient=false,
FOVValue=90,FPSUnlock=false,ShowFPS=true,ShowPing=true,
HitmarkerOn=true,HitmarkerVol=0.5,HitmarkerColor=Color3.fromRGB(255,255,255),
AntiVoidOn=false,AutoRunOn=false,
}
G.C=C

local PRIORITIES={"ClosestToCrosshair","LowestHP","ClosestDistance","HighestHP"}
local PRIORITY_LB={ClosestToCrosshair="CLOSEST",LowestHP="LOWEST HP",ClosestDistance="NEAREST",HighestHP="HIGHEST HP"}
local prioIdx=1

local AIM_PARTS={"Head","UpperTorso","Torso","HumanoidRootPart","LeftLeg","RightLeg"}
local AIM_LB={Head="HEAD",UpperTorso="UPPER TORSO",Torso="TORSO",HumanoidRootPart="ROOT",LeftLeg="LEFT LEG",RightLeg="RIGHT LEG"}
local aimIdx=2

local SILENT_PARTS={"Head","UpperTorso","Torso","HumanoidRootPart","LeftLeg","RightLeg"}
local SILENT_LB={Head="HEAD",UpperTorso="UPPER TORSO",Torso="TORSO",HumanoidRootPart="ROOT",LeftLeg="LEFT LEG",RightLeg="RIGHT LEG"}
local silIdx=1

G.PRIORITIES=PRIORITIES
G.PRIORITY_LB=PRIORITY_LB
G.AIM_PARTS=AIM_PARTS
G.AIM_LB=AIM_LB
G.SILENT_PARTS=SILENT_PARTS
G.SILENT_LB=SILENT_LB
G.getPrioIdx=function()return prioIdx end
G.setPrioIdx=function(v)prioIdx=v end
G.getAimIdx=function()return aimIdx end
G.setAimIdx=function(v)aimIdx=v end
G.getSilIdx=function()return silIdx end
G.setSilIdx=function(v)silIdx=v end

local sticky=nil
local stickyUntil=0
local lastMouse=nil
local lastMouseTime=0
local fpsValue=0
local silentTarget=nil
local sessionStart=tick()
local killCount=0
local deathCount=0

G.getSticky=function()return sticky end
G.setSticky=function(v)sticky=v end
G.getStickyUntil=function()return stickyUntil end
G.setStickyUntil=function(v)stickyUntil=v end
G.getSilentTarget=function()return silentTarget end
G.setSilentTarget=function(v)silentTarget=v end
G.getFpsValue=function()return fpsValue end
G.setFpsValue=function(v)fpsValue=v end
G.getSessionStart=function()return sessionStart end
G.getKillCount=function()return killCount end
G.getDeathCount=function()return deathCount end
G.addKill=function(n)killCount=killCount+n end
G.addDeath=function()deathCount=deathCount+1 end
G.getLastMouse=function()return lastMouse end
G.setLastMouse=function(v)lastMouse=v end
G.getLastMouseTime=function()return lastMouseTime end
G.setLastMouseTime=function(v)lastMouseTime=v end

print("[P2/5] loaded — paste PART 3")

local G=_G.BLOODAIM
if not G then warn("run PART 1 + 2 first");return end

local Players=G.Players
local RS=G.RS
local Cam=G.Cam
local LP=G.LP
local C=G.C

local function partFor(ch,name)
if not ch then return nil end
local p=ch:FindFirstChild(name)
if p and p:IsA("BasePart") then return p end
for _,f in ipairs({"UpperTorso","Torso","HumanoidRootPart","Head"})do
local fp=ch:FindFirstChild(f)
if fp and fp:IsA("BasePart") then return fp end
end
return nil
end

local function aimPart(p) return partFor(p.Character,C.AimPart)end
local function silentPart(p) return partFor(p.Character,C.SilentPart)end
G.partFor=partFor
G.aimPart=aimPart
G.silentPart=silentPart

local function isEnemy(p)
if not p or p==LP then return false end
if not p.Character then return false end
local h=p.Character:FindFirstChildOfClass("Humanoid")
if not h or h.Health<=0 then return false end
if C.TeamCheck and p.Team and LP.Team and p.Team==LP.Team then return false end
return true
end
G.isEnemy=isEnemy

local function predictPos(p,part)
if not C.Prediction then return part.Position end
local hrp=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
if not hrp then return part.Position end
local v=hrp.AssemblyLinearVelocity or Vector3.new(0,0,0)
return part.Position+(v*C.PredStrength)
end
G.predictPos=predictPos

local function inRange(p)
local part=aimPart(p)
if not part then return nil end
if (part.Position-Cam.CFrame.Position).Magnitude>C.MaxRange then return nil end
return part
end
G.inRange=inRange

local function pickTarget()
local c=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)
local r=C.Circle/2
local best,bestScore=nil,math.huge
for _,p in ipairs(Players:GetPlayers())do
if isEnemy(p) then
local part=inRange(p)
if part then
local pp=predictPos(p,part)
local sp,on=Cam:WorldToViewportPoint(pp)
if on then
local d=(Vector2.new(sp.X,sp.Y)-c).Magnitude
if d<=r then
local score=d
if C.AimPriority=="LowestHP" then
local h=p.Character:FindFirstChildOfClass("Humanoid")
score=h and h.Health or 0
elseif C.AimPriority=="ClosestDistance" then
score=(part.Position-Cam.CFrame.Position).Magnitude
elseif C.AimPriority=="HighestHP" then
local h=p.Character:FindFirstChildOfClass("Humanoid")
score=-(h and h.Health or 0)
end
if score<bestScore then bestScore=score;best=p end
end
end
end
end
end
end
return best
end
G.pickTarget=pickTarget

pcall(function()
local ok,module=pcall(function()return require(RS.Blaster.Scripts.BlasterController)end)
if ok and module and module.getShotOrigin then
local orig=module.getShotOrigin
module.getShotOrigin=function(self,...)
if C.SilentOn and G.getSilentTarget() and G.getSilentTarget().Character then
local part=silentPart(G.getSilentTarget())
if part then
local ok2,muzzle=pcall(function()
if self.muzzleLocalOffset and self.handle then return (self.handle.CFrame*self.muzzleLocalOffset).Position
elseif self.muzzleAttachment then return self.muzzleAttachment.WorldPosition
elseif self.handle then return self.handle.Position end
return Cam.CFrame.Position
end)
if ok2 and muzzle then
local dir=part.Position-muzzle
if dir.Magnitude>0.001 then return CFrame.lookAt(muzzle,muzzle+dir.Unit),dir.Magnitude end
end
end
end
return orig(self,...)
end
end
end)

G.updateLoop=G.RunService.RenderStepped:Connect(function(dt)
local now=tick()
local sticky=G.getSticky()
local stickyUntil=G.getStickyUntil()
local t=nil
if sticky and stickyUntil>now and isEnemy(sticky) and inRange(sticky) then t=sticky
else G.setSticky(nil);G.setStickyUntil(0) end
if not t then
if math.random()>C.MissChance then t=pickTarget();if t then G.setSticky(t);G.setStickyUntil(now+C.StickyTime) end end
end

if C.SilentOn then
if sticky and isEnemy(sticky) then G.setSilentTarget(sticky) else G.setSilentTarget(pickTarget())end
else G.setSilentTarget(nil) end

if C.AimOn and t then
local part=aimPart(t)
if part then
local pp=predictPos(t,part)
local camPos=Cam.CFrame.Position
local dir=(pp-camPos).Unit
local want=CFrame.new(camPos,camPos+dir)
local alpha=math.clamp(C.Assist*(dt*60),0,1)
if C.AimSmoothing=="EaseIn" then alpha=alpha*alpha
elseif C.AimSmoothing=="EaseOut" then alpha=1-(1-alpha)*(1-alpha)end
Cam.CFrame=Cam.CFrame:Lerp(want,alpha)
end
end

if C.AntiVoidOn and LP.Character then
local hrp=LP.Character:FindFirstChild("HumanoidRootPart")
if hrp and hrp.Position.Y<-50 then hrp.CFrame=CFrame.new(0,100,0)end
end

G.setFpsValue(math.floor(1/math.max(dt,0.001)))
end)

print("[P3/5] loaded — paste PART 4")

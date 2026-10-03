local G=_G.BLOODAIM
if not G then warn("run 1+2+3 first");return end

local Players=G.Players
local UIS=G.UIS
local Workspace=G.Workspace
local RS=G.RS
local Lighting=G.Lighting
local TCS=G.TCS
local TPS=G.TPS
local Sound=G.Sound
local Debris=G.Debris
local Http=G.Http
local LP=G.LP
local Cam=G.Cam
local C=G.C

local originals={}
local savedParticles={}
local lastHealth={}

local function scalePart(part,f)
if not part then return end
pcall(function()
if not part:IsA("BasePart") then return end
local ov=part:FindFirstChild("_origSize")
if not ov then ov=Instance.new("Vector3Value");ov.Name="_origSize";ov.Value=part.Size;ov.Parent=part end
part.Size=ov.Value*f
end)
end

local function restorePart(part)
if not part then return end
pcall(function()
local ov=part:FindFirstChild("_origSize")
if ov then part.Size=ov.Value;ov:Destroy()end
end)
end

local function applyHitbox(p)
if not p.Character then return end
for _,n in ipairs({"Head","HumanoidRootPart","UpperTorso","Torso","LowerTorso","LeftLeg","RightLeg"})do
local part=p.Character:FindFirstChild(n)
if part then if C.HitboxOn then scalePart(part,C.HitboxScale)else restorePart(part)end end
end
end
G.applyHitbox=applyHitbox

local function applyHitboxAll()
for _,p in ipairs(Players:GetPlayers())do if p~=LP then applyHitbox(p)end end
end
G.applyHitboxAll=applyHitboxAll

local function applyShrinkSelf()
if not LP.Character then return end
for _,n in ipairs({"Head","UpperTorso","Torso","HumanoidRootPart","LowerTorso"})do
local part=LP.Character:FindFirstChild(n)
if part then if C.ShrinkOn then scalePart(part,C.ShrinkScale)else restorePart(part)end end
end
end
G.applyShrinkSelf=applyShrinkSelf

local function applySpeed()
local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
if h then
if C.SpeedOn then if not originals.ws then originals.ws=h.WalkSpeed end;h.WalkSpeed=C.SpeedValue
else if originals.ws then h.WalkSpeed=originals.ws end end
end
end
G.applySpeed=applySpeed

local function applyJump()
local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
if h then
if C.JumpOn then if not originals.jp then originals.jp=h.JumpPower end;h.JumpPower=C.JumpValue;h.UseJumpPower=true
else if originals.jp then h.JumpPower=originals.jp end end
end
end
G.applyJump=applyJump

local function applyLighting()
if C.FullbrightOn then
if not originals.amb then originals.amb=Lighting.Ambient end
if not originals.out then originals.out=Lighting.OutdoorAmbient end
Lighting.Ambient=Color3.fromRGB(180,180,180);Lighting.OutdoorAmbient=Color3.fromRGB(180,180,180);Lighting.Brightness=3
else
if originals.amb then Lighting.Ambient=originals.amb end
if originals.out then Lighting.OutdoorAmbient=originals.out end
end
if C.NoFog then if not originals.fog then originals.fog=Lighting.FogEnd end;Lighting.FogEnd=100000
else if originals.fog then Lighting.FogEnd=originals.fog end end
if C.TimeOn then Lighting.ClockTime=C.TimeOfDay end
Lighting.GlobalShadows=not C.NoShadows
end
G.applyLighting=applyLighting

local function applyParticles()
if C.NoParticles then
for _,d in ipairs(Workspace:GetDescendants())do
if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") then
if savedParticles[d]==nil then savedParticles[d]=d.Enabled end
pcall(function()d.Enabled=false end)
end
end
else
for d,s in pairs(savedParticles)do pcall(function()if d.Parent then d.Enabled=s end end)end
savedParticles={}
end
end
G.applyParticles=applyParticles

local function applyNoGrass()
if C.NoGrass then
pcall(function() for _,d in ipairs(Workspace:GetDescendants())do if d:IsA("TerrainDecoration") or (d:IsA("BasePart") and d.Name:lower():find("grass")) then d.Transparency=1 end end end)
else
pcall(function() for _,d in ipairs(Workspace:GetDescendants())do if d:IsA("TerrainDecoration") or (d:IsA("BasePart") and d.Name:lower():find("grass")) then d.Transparency=0 end end end)
end
end
G.applyNoGrass=applyNoGrass

local function applyFOV() Cam.FieldOfView=C.FOVValue end
G.applyFOV=applyFOV

local function applyFPSUnlock()
pcall(function() if setfpscap then if C.FPSUnlock then setfpscap(240)else setfpscap(60)end end end)
end
G.applyFPSUnlock=applyFPSUnlock

local function serverHop()
task.spawn(function()
local ok=pcall(function()
local servers=Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
local ids={}
for _,s in ipairs(servers.data or{})do if s.id and s.playing and s.maxPlayers and s.playing<s.maxPlayers then table.insert(ids,s.id)end end
if #ids==0 then return end
local pick=ids[math.random(1,#ids)]
TPS:TeleportToPlaceInstance(game.PlaceId,pick,LP)
end)
if not ok then pcall(function()TPS:Teleport(game.PlaceId,LP)end)end
end)
end
G.serverHop=serverHop

local hmSound=Instance.new("Sound")
hmSound.SoundId="rbxassetid://4833497113"
hmSound.Volume=C.HitmarkerVol
hmSound.Parent=Sound
G.hmSound=hmSound

local function playHitmarker()
if not C.HitmarkerOn then return end
pcall(function()
local s=hmSound:Clone();s.Volume=C.HitmarkerVol;s.Parent=Sound;s:Play();Debris:AddItem(s,1.5)
end)
end
G.playHitmarker=playHitmarker

local function watchHealth(p)
if not p or p==LP then return end
local function bind(ch)
local h=ch:WaitForChild("Humanoid",5)
if not h then return end
lastHealth[p]=h.Health
h.HealthChanged:Connect(function(nh)
local old=lastHealth[p] or nh
if nh<old then playHitmarker();if G.playHitmarkerVisual then G.playHitmarkerVisual()end end
lastHealth[p]=nh
end)
end
if p.Character then bind(p.Character)end
p.CharacterAdded:Connect(bind)
end

for _,p in ipairs(Players:GetPlayers())do watchHealth(p)end
Players.PlayerAdded:Connect(watchHealth)

local function fireKillSay()
pcall(function()
local cr=RS:FindFirstChild("DefaultChatSystemChatEvents")
if cr then local s=cr:FindFirstChild("SayMessageRequest");if s then s:FireServer(C.KillSayMsg,"All");return end end
if TCS and TCS.TextChannels then local ch=TCS.TextChannels:FindFirstChild("RBXGeneral");if ch then ch:SendAsync(C.KillSayMsg)end end
end)
end

local function watchKills()
for _,a in ipairs({"Kills","KillCount","Streak","Takedowns","Score"})do
pcall(function()
local s=LP:GetAttribute(a) or 0
LP:GetAttributeChangedSignal(a):Connect(function()
local n=LP:GetAttribute(a) or 0
if n>s then G.addKill(n-s);if C.KillSay then fireKillSay()end end
s=n
end)
end)
end
pcall(function()
for _,r in ipairs(RS:GetDescendants())do
if r:IsA("RemoteEvent") and (r.Name:lower():find("kill") or r.Name:lower():find("feed"))then
r.OnClientEvent:Connect(function(...)
if not C.KillSay then return end
for _,a in ipairs({...})do
if a==LP or a==LP.Name then fireKillSay();return end
if typeof(a)=="table" then for _,v in pairs(a)do if v==LP or v==LP.Name then fireKillSay();return end end end
end
end)
end
end
end)
end
watchKills()

UIS.JumpRequest:Connect(function()
if not C.InfiniteJump then return end
local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end
end)

LP.CharacterAdded:Connect(function(ch)
local h=ch:WaitForChild("Humanoid",5)
if h and C.FastRespawn then h.Died:Connect(function()task.wait(0.1);pcall(function()LP:LoadCharacter()end)end)end
if h then h.Died:Connect(function()G.addDeath()end)end
task.wait(1)
if C.ShrinkOn then applyShrinkSelf()end
if C.SpeedOn then applySpeed()end
if C.JumpOn then applyJump()end
end)

pcall(function()
LP.OnTeleport:Connect(function()
if C.AutoRejoin then task.wait(2);pcall(function()TPS:Teleport(game.PlaceId,LP)end)end
end)
end)

local function hookPlayer(p)
p.CharacterAdded:Connect(function()
task.wait(1)
if C.HitboxOn then applyHitbox(p)end
end)
end

Players.PlayerAdded:Connect(hookPlayer)
for _,p in ipairs(Players:GetPlayers())do if p~=LP then hookPlayer(p)end end

UIS.InputBegan:Connect(function(i,gp)
if gp then return end
G.setLastMouse(i.Position)
G.setLastMouseTime(tick())
end)

UIS.InputChanged:Connect(function(i,gp)
if gp then return end
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement then
local lm=G.getLastMouse()
if lm then
local dt=tick()-(G.getLastMouseTime() or 0)
if dt>0 then local d=(i.Position-lm).Magnitude;if d>C.FlickThreshold then G.setSticky(nil);G.setStickyUntil(0)end end
end
G.setLastMouse(i.Position)
G.setLastMouseTime(tick())
end
end)

print("[P4/5] loaded — paste PART 5")

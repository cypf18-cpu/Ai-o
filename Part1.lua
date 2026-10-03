local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local CoreGui=game:GetService("CoreGui")
local Workspace=game:GetService("Workspace")
local RS=game:GetService("ReplicatedStorage")
local Tween=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
local Stats=game:GetService("Stats")
local TCS=game:GetService("TextChatService")
local TPS=game:GetService("TeleportService")
local Sound=game:GetService("SoundService")
local Debris=game:GetService("Debris")
local Http=game:GetService("HttpService")
local LP=Players.LocalPlayer
local Cam=Workspace.CurrentCamera

_G.BLOODAIM={}
local G=_G.BLOODAIM

G.Players=Players
G.RunService=RunService
G.UIS=UIS
G.CoreGui=CoreGui
G.Workspace=Workspace
G.RS=RS
G.Tween=Tween
G.Lighting=Lighting
G.Stats=Stats
G.TCS=TCS
G.TPS=TPS
G.Sound=Sound
G.Debris=Debris
G.Http=Http
G.LP=LP
G.Cam=Cam

local function applyPC()
pcall(function()
LP:SetAttribute("Platform","Windows")
LP:SetAttribute("IsMobile",false)
LP:SetAttribute("DeviceType","Desktop")
LP:SetAttribute("InputType","Keyboard")
LP:SetAttribute("ClientType","PC")
LP:SetAttribute("IsPhone",false)
LP:SetAttribute("IsTablet",false)
LP:SetAttribute("OS","Windows")
LP:SetAttribute("PC",true)
LP:SetAttribute("Mobile",false)
LP:SetAttribute("IsTouch",false)
LP:SetAttribute("TouchEnabled",false)
end)
end

local function spoofVal(v)
if not v then return end
if v:IsA("BoolValue") then
local n=v.Name:lower()
if n:find("mobile") or n:find("phone") or n:find("tablet") or n:find("touch") then v.Value=false
elseif n:find("desktop") or n:find("pc") or n:find("keyboard") or n:find("mouse") then v.Value=true end
elseif v:IsA("StringValue") then
local n=v.Name:lower()
if n:find("platform") or n:find("devicetype") or n:find("clienttype") or n=="os" then v.Value="Windows"
elseif n:find("inputtype") then v.Value="Keyboard" end
elseif v:IsA("NumberValue") then
local n=v.Name:lower()
if n:find("ismobile") or n:find("isphone") then v.Value=0 end
if n:find("isdesktop") or n:find("ispc") then v.Value=1 end
end
end

local function hideMobileIcons()
pcall(function()
local pg=LP:FindFirstChild("PlayerGui")
if not pg then return end
for _,d in ipairs(pg:GetChildren())do
local targets={d}
if d:IsA("GuiObject") then for _,c in ipairs(d:GetChildren())do table.insert(targets,c)end end
for _,g in ipairs(targets)do
if g:IsA("ImageLabel") or g:IsA("ImageButton") or g:IsA("TextLabel") or g:IsA("TextButton") then
local n=(g.Name or ""):lower()
if n:find("mobile") or n:find("phone") or n:find("touch") or n:find("device") or n:find("platform") or n:find("tablet") then g.Visible=false end
end
end
end
end)
end

local function spoofAll()
applyPC()
pcall(function()
for _,c in ipairs(RS:GetChildren())do if c:IsA("BoolValue") or c:IsA("StringValue") or c:IsA("NumberValue") then spoofVal(c)end end
end)
pcall(function() for _,c in ipairs(LP:GetChildren())do spoofVal(c)end end)
hideMobileIcons()
end

G.applyPC=applyPC
G.spoofVal=spoofVal
G.hideMobileIcons=hideMobileIcons
G.spoofAll=spoofAll

spoofAll()

task.spawn(function()
while true do task.wait(5); spoofAll()end
end)
task.spawn(function()
while true do task.wait(2); hideMobileIcons()end
end)

print("[P1/5] loaded — paste PART 2")

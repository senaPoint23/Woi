-- SENA HUB v15.2 - Steal an Egg | Chilli-inspired compact grid + egg teleport
-- For your own Roblox Studio experience / authorized testing.
-- This is a UI shell only; it does not download or execute external code.
-- Put this LocalScript in StarterPlayer > StarterPlayerScripts in your own experience.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("SenaHubUI")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(5, 12, 29),
    panel = Color3.fromRGB(8, 20, 44),
    panel2 = Color3.fromRGB(10, 30, 61),
    blue = Color3.fromRGB(0, 128, 255),
    cyan = Color3.fromRGB(0, 220, 255),
    text = Color3.fromRGB(235, 247, 255),
    muted = Color3.fromRGB(140, 179, 211),
    violet = Color3.fromRGB(119, 87, 255),
    mint = Color3.fromRGB(66, 255, 210),
    card = Color3.fromRGB(8, 27, 55),
}

local gui = Instance.new("ScreenGui")
gui.Name = "SenaHubUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false -- respect Roblox top bar safe area
gui.DisplayOrder = 100
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function corner(parent, radius)
    return make("UICorner", {CornerRadius = UDim.new(0, radius or 12)}, parent)
end

local function stroke(parent, color, thickness, transparency)
    return make("UIStroke", {
        Color = color or C.blue,
        Thickness = thickness or 1,
        Transparency = transparency or 0
    }, parent)
end

local function label(parent, text, size, pos, font, color)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextSize = size or 14,
        Font = font or Enum.Font.Gotham,
        TextColor3 = color or C.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Position = pos or UDim2.new(),
        Size = UDim2.new(1, 0, 0, 24),
        TextWrapped = true
    }, parent)
end

local function button(parent, text, size, pos)
    local b = make("TextButton", {
        AutoButtonColor = false,
        Text = text,
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        TextColor3 = C.text,
        BackgroundColor3 = C.panel2,
        Size = size,
        Position = pos
    }, parent)
    corner(b, 10)
    stroke(b, C.blue, 1, 0.15)
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(13, 48, 91)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = C.panel2}):Play()
    end)
    return b
end

local main = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.51),
    Size = UDim2.new(0.94, 0, 0.92, 0),
    BackgroundColor3 = C.bg,
    ClipsDescendants = true,
    Visible = false
}, gui)
corner(main, 24)
stroke(main, C.cyan, 1.2, 0.12)
make("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(7, 18, 42)),
        ColorSequenceKeypoint.new(0.55, Color3.fromRGB(5, 12, 29)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 24, 52))
    }),
    Rotation = 25
}, main)

make("UISizeConstraint", {
    MinSize = Vector2.new(300, 280),
    MaxSize = Vector2.new(1400, 900)
}, main)

local top = make("Frame", {
    Name = "Header",
    BackgroundColor3 = C.panel,
    Size = UDim2.new(1, 0, 0, 58),
    ZIndex = 2
}, main)
corner(top, 24)
make("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 34, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 18, 40))
    }),
    Rotation = 0
}, top)

local logo = make("ImageLabel", {
    Name = "Logo",
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(44, 44),
    Position = UDim2.fromOffset(16, 10),
    Image = "rbxassetid://111099731853513",
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 3
}, top)

local title = label(top, "SENA HUB", 24, UDim2.fromOffset(70, 7), Enum.Font.GothamBlack, C.text)
title.Size = UDim2.new(1, -190, 0, 29)
title.ZIndex = 3
local subtitle = label(top, "STEAL AN EGG • NEON BLUE", 9, UDim2.fromOffset(71, 35), Enum.Font.GothamMedium, C.cyan)
subtitle.Size = UDim2.new(1, -190, 0, 14)
subtitle.ZIndex = 3

local statusPill = make("Frame", {
    Name = "StatusPill",
    BackgroundColor3 = Color3.fromRGB(7, 48, 57),
    BackgroundTransparency = 0.05,
    Position = UDim2.new(1, -132, 0, 21),
    Size = UDim2.fromOffset(76, 22),
    ZIndex = 3
}, top)
corner(statusPill, 11)
stroke(statusPill, C.mint, 1, 0.35)
local statusDot = make("Frame", {
    BackgroundColor3 = C.mint,
    Position = UDim2.fromOffset(8, 8),
    Size = UDim2.fromOffset(6, 6),
    ZIndex = 4
}, statusPill)
corner(statusDot, 6)
local statusText = label(statusPill, "READY", 8, UDim2.fromOffset(19, 2), Enum.Font.GothamBold, C.mint)
statusText.Size = UDim2.new(1, -21, 1, -4)
statusText.ZIndex = 4

local close = button(top, "×", UDim2.fromOffset(34, 34), UDim2.new(1, -46, 0, 15))
close.TextSize = 25
close.ZIndex = 4
-- Floating reopen button stays visible when the main panel is hidden.
local reopen = make("ImageButton", {
    Name = "FloatingReopen",
    Image = "rbxassetid://111099731853513",
    ScaleType = Enum.ScaleType.Fit,
    BackgroundColor3 = C.panel,
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.new(0, 18, 0.45, 0),
    Size = UDim2.fromOffset(46, 46),
    Visible = false,
    ZIndex = 20,
}, gui)
corner(reopen, 15)
stroke(reopen, C.cyan, 2, 0)

-- Allow the floating logo to be moved with touch or mouse.
-- A short tap still reopens the hub; movement beyond the threshold is treated as dragging.
local reopenDragging = false
local reopenMoved = false
local reopenStartInput = nil
local reopenStartPos = nil
local reopenStartPoint = nil
local reopenDragThreshold = 8

reopen.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.Touch
        and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return
    end

    reopenDragging = true
    reopenMoved = false
    reopenStartInput = input
    reopenStartPoint = input.Position
    reopenStartPos = reopen.Position
end)

UserInputService.InputChanged:Connect(function(input)
    if not reopenDragging or not reopenStartPoint or not reopenStartPos then
        return
    end

    local isRelevant = input.UserInputType == Enum.UserInputType.MouseMovement
        or (input.UserInputType == Enum.UserInputType.Touch and input == reopenStartInput)
    if not isRelevant then return end

    local delta = input.Position - reopenStartPoint
    if math.abs(delta.X) + math.abs(delta.Y) > reopenDragThreshold then
        reopenMoved = true
    end

    if reopenMoved then
        local camera = workspace.CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
        local size = reopen.AbsoluteSize
        local x = math.clamp(reopenStartPos.X.Offset + delta.X, 0, math.max(0, viewport.X - size.X))
        local y = math.clamp(reopenStartPos.Y.Offset + delta.Y, 0, math.max(0, viewport.Y - size.Y))
        reopen.Position = UDim2.fromOffset(x, y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if not reopenDragging then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or (input.UserInputType == Enum.UserInputType.Touch and input == reopenStartInput) then
        local wasMoved = reopenMoved
        reopenDragging = false
        reopenStartInput = nil
        reopenStartPoint = nil
        reopenStartPos = nil
        -- Suppress the Activated reopen action after a drag; taps are handled by Activated below.
        reopen:SetAttribute("WasDragged", wasMoved)
        task.defer(function()
            if reopen.Parent then
                reopen:SetAttribute("WasDragged", false)
            end
        end)
    end
end)

local function hideHub()
    main.Visible = false
    reopen.Visible = true
end

local function showHub()
    main.Visible = true
    reopen.Visible = false
end

close.Activated:Connect(hideHub)
reopen.Activated:Connect(function()
    if reopen:GetAttribute("WasDragged") then return end
    showHub()
end)

local body = make("Frame", {
    Name = "Body",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(10, 64),
    Size = UDim2.new(1, -20, 1, -74)
}, main)

-- New layout: horizontal navigation across the top, not the old tall sidebar.
local nav = make("Frame", {
    Name = "Navigation",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 38),
    ClipsDescendants = true
}, body)

local navScroll = make("ScrollingFrame", {
    Name = "NavScroll",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.X,
    ScrollingDirection = Enum.ScrollingDirection.X,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.cyan,
    ScrollBarImageTransparency = 0.18,
    ScrollingEnabled = true,
    Active = true
}, nav)
local navLayout = make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center
}, navScroll)
make("UIPadding", {
    PaddingLeft = UDim.new(0, 1),
    PaddingRight = UDim.new(0, 4)
}, navScroll)

local content = make("Frame", {
    Name = "Content",
    BackgroundColor3 = Color3.fromRGB(6, 16, 36),
    Position = UDim2.new(0, 0, 0, 44),
    Size = UDim2.new(1, 0, 1, -44),
    ClipsDescendants = true
}, body)
corner(content, 20)
stroke(content, Color3.fromRGB(31, 92, 151), 1, 0.35)

-- Chilli-inspired compact layout: two-column feature cards to show 4-5 options at once.

local pageArea = make("ScrollingFrame", {
    Name = "PageArea",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(8, 8),
    Size = UDim2.new(1, -16, 1, -16),
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 6,
    ScrollBarImageColor3 = C.cyan,
    ScrollingEnabled = true,
    Active = true,
    ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
    ScrollBarImageTransparency = 0.05
}, content)
local pageGrid = make("UIGridLayout", {
    CellSize = UDim2.new(0.5, -6, 0, 76),
    CellPadding = UDim2.fromOffset(8, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
    FillDirection = Enum.FillDirection.Horizontal,
    FillDirectionMaxCells = 2,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    VerticalAlignment = Enum.VerticalAlignment.Top
}, pageArea)
make("UIPadding", {
    PaddingTop = UDim.new(0, 1),
    PaddingBottom = UDim.new(0, 4)
}, pageArea)

local function clearPage()
    for _, child in ipairs(pageArea:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIGridLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function card(titleText, bodyText)
    local f = make("Frame", {
        BackgroundColor3 = Color3.fromRGB(10, 29, 58),
        BackgroundTransparency = 0.04,
        Size = UDim2.new(0.5, -6, 0, 76)
    }, pageArea)
    corner(f, 10)
    stroke(f, Color3.fromRGB(30, 82, 132), 1, 0.30)
    local accent = make("Frame", {
        BackgroundColor3 = C.cyan,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 7),
        Size = UDim2.new(0, 3, 0, 32)
    }, f)
    corner(accent, 2)
    local t = label(f, titleText, 11, UDim2.fromOffset(12, 5), Enum.Font.GothamBold, C.cyan)
    t.Size = UDim2.new(1, -22, 0, 18)
    local d = label(f, bodyText, 9, UDim2.fromOffset(12, 26), Enum.Font.Gotham, C.muted)
    d.Size = UDim2.new(1, -22, 0, 44)
    d.TextWrapped = true
    d.TextYAlignment = Enum.TextYAlignment.Top
    return f
end

local tabs = {"Home", "Eggs", "Player", "Progress", "Settings", "About"}
local tabIcons = {
    Home = "⌂",
    Eggs = "✦",
    Player = "◉",
    Progress = "▥",
    Settings = "⚙",
    About = "ⓘ",
}
local navButtons = {}

local function showPage(name)
    clearPage()
    pageArea.CanvasPosition = Vector2.new(0, 0)

    if name == "Home" then
        card("STEAL AN EGG", "SENA HUB v15 • panel UI ringkas untuk pengalaman Steal an Egg.")
        card("NAVIGASI", "Semua menu utama berada di bagian atas. Geser tab ke samping jika sebagian menu belum terlihat.")
        card("NEON BLUE", "Tema gelap, aksen cyan, grid dua kolom, dan panel yang bisa digeser.")
        card("SCROLL KONTEN", "Geser area isi ke atas atau bawah untuk melihat semua kartu pada halaman ini.")
        card("FITUR TERUJI", "UI dan navigasi aktif. Otomasi gameplay belum tersedia atau diverifikasi.")
    elseif name == "Eggs" then
        card("AUTO TELEPORT TO EGG", "Cari objek bernama Egg di Workspace, lalu pindah ke dekatnya. Untuk testing di experience milikmu atau yang kamu berwenang uji.")
        local eggInput = make("TextBox", {
            Text = "", PlaceholderText = "Nama egg (kosong = egg terdekat)",
            ClearTextOnFocus = false, TextSize = 11, Font = Enum.Font.Gotham,
            TextColor3 = C.text, PlaceholderColor3 = C.muted,
            BackgroundColor3 = C.panel2, Size = UDim2.new(1, -10, 0, 38),
            TextXAlignment = Enum.TextXAlignment.Left
        }, pageArea)
        eggInput.LayoutOrder = 10
        corner(eggInput, 9); stroke(eggInput, C.blue, 1, 0.2)

        local teleportStatus = label(pageArea, "Status: siap mencari objek egg.", 10, UDim2.new(), Enum.Font.Gotham, C.muted)
        teleportStatus.Size = UDim2.new(1, -10, 0, 42)
        teleportStatus.LayoutOrder = 11

        local function findEggTarget(searchName)
            local character = player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not root then return nil, "Karakter belum siap." end
            local query = string.lower(string.gsub(searchName or "", "^%s*(.-)%s*$", "%1"))
            local best, bestDistance = nil, math.huge
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj ~= character and (obj:IsA("Model") or obj:IsA("BasePart")) then
                    local lowerName = string.lower(obj.Name)
                    local isEgg = string.find(lowerName, "egg", 1, true) ~= nil
                    local matchesQuery = query == "" or string.find(lowerName, query, 1, true) ~= nil
                    if isEgg and matchesQuery then
                        local ancestor = obj.Parent
                        local nestedInEgg = false
                        while ancestor and ancestor ~= workspace do
                            if ancestor:IsA("Model") and string.find(string.lower(ancestor.Name), "egg", 1, true) then
                                nestedInEgg = true
                                break
                            end
                            ancestor = ancestor.Parent
                        end
                        if not nestedInEgg then
                            local ok, targetCFrame = pcall(function()
                                if obj:IsA("Model") then return obj:GetPivot() end
                                return obj.CFrame
                            end)
                            if ok and targetCFrame then
                                local distance = (root.Position - targetCFrame.Position).Magnitude
                                if distance < bestDistance then best, bestDistance = targetCFrame, distance end
                            end
                        end
                    end
                end
            end
            if not best then
                local message = query == "" and "Tidak menemukan objek yang namanya mengandung 'egg'." or ("Tidak menemukan egg yang cocok: " .. searchName)
                return nil, message
            end
            return best, nil, bestDistance
        end

        local teleportButton = button(pageArea, "⌖  Teleport ke egg", UDim2.new(1, -10, 0, 40), UDim2.new())
        teleportButton.LayoutOrder = 12
        teleportButton.Activated:Connect(function()
            local target, err, distance = findEggTarget(eggInput.Text)
            if not target then
                teleportStatus.Text = "Status: " .. tostring(err)
                teleportStatus.TextColor3 = Color3.fromRGB(255, 150, 150)
                return
            end
            local character = player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not root then
                teleportStatus.Text = "Status: karakter belum siap."
                return
            end
            root.CFrame = target + Vector3.new(0, 4, 0)
            teleportStatus.Text = string.format("Status: dipindahkan ke egg (jarak awal %.0f studs).", distance or 0)
            teleportStatus.TextColor3 = C.mint
        end)

        local refreshEggs = button(pageArea, "↻  Cari egg terdekat", UDim2.new(1, -10, 0, 38), UDim2.new())
        refreshEggs.LayoutOrder = 13
        refreshEggs.Activated:Connect(function()
            local target, err, distance = findEggTarget(eggInput.Text)
            if target then
                teleportStatus.Text = string.format("Status: egg ditemukan, jarak %.0f studs. Tekan Teleport ke egg.", distance or 0)
                teleportStatus.TextColor3 = C.mint
            else
                teleportStatus.Text = "Status: " .. tostring(err)
                teleportStatus.TextColor3 = Color3.fromRGB(255, 150, 150)
            end
        end)

        -- Selection/config UI. These controls only save local preferences; they do not automate stealing.
        local function sectionTitle(text, order)
            local t = label(pageArea, text, 12, UDim2.new(), Enum.Font.GothamBold, C.cyan)
            t.Size = UDim2.new(1, -10, 0, 26)
            t.LayoutOrder = order
            return t
        end

        sectionTitle("PILIH ZONA EGG", 14)
        local zoneOptions = {"Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Semua zona"}
        local selectedZones = {["Semua zona"] = true}
        local zoneFrame = make("Frame", {
            BackgroundTransparency = 1, Size = UDim2.new(1, -10, 0, 78), LayoutOrder = 15
        }, pageArea)
        make("UIGridLayout", {
            CellSize = UDim2.new(0.32, 0, 0, 32),
            CellPadding = UDim2.new(0.02, 0, 0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder
        }, zoneFrame)
        local function makeToggle(parent, text, selected, callback)
            local b = button(parent, (selected and "✓ " or "＋ ") .. text, UDim2.new(1, 0, 1, 0), UDim2.new())
            b.TextSize = 10
            if selected then b.BackgroundColor3 = Color3.fromRGB(8, 68, 86) end
            b.Activated:Connect(function()
                callback()
                -- visual state is refreshed by callback's return value
            end)
            return b
        end
        local zoneButtons = {}
        local function refreshZoneButtons()
            for name, b in pairs(zoneButtons) do
                local on = selectedZones[name] == true
                b.Text = (on and "✓ " or "＋ ") .. name
                b.BackgroundColor3 = on and Color3.fromRGB(8, 68, 86) or C.panel2
            end
        end
        for i, zone in ipairs(zoneOptions) do
            local b = makeToggle(zoneFrame, zone, selectedZones[zone], function()
                if zone == "Semua zona" then
                    local turnOn = not selectedZones[zone]
                    table.clear(selectedZones)
                    if turnOn then selectedZones[zone] = true end
                else
                    selectedZones["Semua zona"] = nil
                    selectedZones[zone] = not selectedZones[zone] or nil
                    local any = false
                    for _, z in ipairs(zoneOptions) do
                        if z ~= "Semua zona" and selectedZones[z] then any = true end
                    end
                    if not any then selectedZones["Semua zona"] = true end
                end
                refreshZoneButtons()
            end)
            b.LayoutOrder = i
            zoneButtons[zone] = b
        end

        sectionTitle("JENIS EGG", 16)
        local eggKinds = {"Basic", "Forest", "Desert", "Ice", "Lava", "Event"}
        local selectedKinds = {}
        local kindFrame = make("Frame", {
            BackgroundTransparency = 1, Size = UDim2.new(1, -10, 0, 78), LayoutOrder = 17
        }, pageArea)
        make("UIGridLayout", {
            CellSize = UDim2.new(0.32, 0, 0, 32),
            CellPadding = UDim2.new(0.02, 0, 0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder
        }, kindFrame)
        local kindButtons = {}
        local function refreshKindButtons()
            for name, b in pairs(kindButtons) do
                local on = selectedKinds[name] == true
                b.Text = (on and "✓ " or "＋ ") .. name
                b.BackgroundColor3 = on and Color3.fromRGB(8, 68, 86) or C.panel2
            end
        end
        for i, kind in ipairs(eggKinds) do
            local b = makeToggle(kindFrame, kind, false, function()
                selectedKinds[kind] = not selectedKinds[kind] or nil
                refreshKindButtons()
            end)
            b.LayoutOrder = i
            kindButtons[kind] = b
        end

        sectionTitle("TIER YANG DIAMBIL", 18)
        local tierOptions = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic"}
        local selectedTiers = {}
        local tierFrame = make("Frame", {
            BackgroundTransparency = 1, Size = UDim2.new(1, -10, 0, 78), LayoutOrder = 19
        }, pageArea)
        make("UIGridLayout", {
            CellSize = UDim2.new(0.32, 0, 0, 32),
            CellPadding = UDim2.new(0.02, 0, 0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder
        }, tierFrame)
        local tierButtons = {}
        local function refreshTierButtons()
            for name, b in pairs(tierButtons) do
                local on = selectedTiers[name] == true
                b.Text = (on and "✓ " or "＋ ") .. name
                b.BackgroundColor3 = on and Color3.fromRGB(8, 68, 86) or C.panel2
            end
        end
        for i, tier in ipairs(tierOptions) do
            local b = makeToggle(tierFrame, tier, false, function()
                selectedTiers[tier] = not selectedTiers[tier] or nil
                refreshTierButtons()
            end)
            b.LayoutOrder = i
            tierButtons[tier] = b
        end

        local saveSelection = button(pageArea, "✓  Simpan pilihan", UDim2.new(1, -10, 0, 38), UDim2.new())
        saveSelection.LayoutOrder = 20
        local selectionStatus = label(pageArea, "Pilihan belum disimpan. Nama zona/jenis/tier di atas adalah contoh, bukan daftar terverifikasi dari game.", 10, UDim2.new(), Enum.Font.Gotham, C.muted)
        selectionStatus.Size = UDim2.new(1, -10, 0, 44)
        selectionStatus.LayoutOrder = 21
        saveSelection.Activated:Connect(function()
            local function joined(t)
                local a = {}
                for k, v in pairs(t) do if v then table.insert(a, k) end end
                table.sort(a)
                return #a > 0 and table.concat(a, ", ") or "Tidak dipilih"
            end
            selectionStatus.Text = "Pilihan tersimpan lokal:\nZona: " .. joined(selectedZones)
                .. "\nJenis: " .. joined(selectedKinds) .. "\nTier: " .. joined(selectedTiers)
            selectionStatus.TextColor3 = C.mint
        end)

        card("BATASAN", "Panel pilihan ini hanya menyimpan preferensi lokal. Auto Steal/Instant Steal, terbang untuk menghindari serangan, dan teleport ke safe zone tidak diaktifkan: mekanisme server serta daftar zona/egg/tier asli belum diverifikasi. Untuk game milikmu sendiri, logika yang aman harus dibuat dan divalidasi di server Roblox Studio.")
    elseif name == "Player" then
        local function readCharacter()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local root = character and character:FindFirstChild("HumanoidRootPart")
            local hp = humanoid and math.floor(humanoid.Health) or 0
            local maxHp = humanoid and math.floor(humanoid.MaxHealth) or 0
            local speed = humanoid and math.floor(humanoid.WalkSpeed) or 0
            local pos = root and root.Position
            return string.format("Pemain: %s\nHealth: %d/%d\nWalkSpeed: %d\nPosisi: %s", player.Name, hp, maxHp, speed, pos and string.format("%.0f, %.0f, %.0f", pos.X, pos.Y, pos.Z) or "Karakter belum siap")
        end
        card("PLAYER STATUS", readCharacter())
        local refresh = button(pageArea, "↻  Refresh status pemain", UDim2.new(1, -10, 0, 38), UDim2.new())
        refresh.LayoutOrder = 10
        refresh.Activated:Connect(function()
            showPage("Player")
        end)
        local reset = button(pageArea, "Reset karakter", UDim2.new(1, -10, 0, 38), UDim2.new())
        reset.LayoutOrder = 11
        reset.Activated:Connect(function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.Health = 0 end
        end)
        card("CATATAN", "Refresh membaca status lokal karakter. Reset karakter meminta respawn normal; tidak mengubah server atau memberi keuntungan gameplay.")
    elseif name == "Progress" then
        local stats = player:FindFirstChild("leaderstats")
        local found = {}
        if stats then
            for _, value in ipairs(stats:GetChildren()) do
                if value:IsA("IntValue") or value:IsA("NumberValue") or value:IsA("StringValue") then
                    table.insert(found, value.Name .. ": " .. tostring(value.Value))
                end
            end
        end
        card("PROGRESS OVERVIEW", "Nama pemain: " .. player.Name)
        card("LEADERSTATS", #found > 0 and table.concat(found, "\n") or "Belum ada leaderstats yang bisa dibaca dari client.")
        local refreshStats = button(pageArea, "↻  Refresh progress", UDim2.new(1, -10, 0, 38), UDim2.new())
        refreshStats.LayoutOrder = 10
        refreshStats.Activated:Connect(function() showPage("Progress") end)
        card("CATATAN", "Hanya menampilkan nilai leaderstats yang memang direplikasi oleh pengalaman game.")
    elseif name == "Settings" then
        card("PREFERENSI UI", "Tempat pengaturan tampilan antarmuka SENA HUB.")
        card("UKURAN & POSISI", "Slot untuk preferensi ukuran panel dan posisi tombol mengambang.")
        card("TAMPILAN", "Slot untuk tema dan preferensi visual antarmuka.")
        card("KONTROL", "Pengaturan akan berfungsi setelah kontrolnya dihubungkan ke kode terkait.")
        local hideButton = button(pageArea, "Tutup SENA HUB", UDim2.new(1, -10, 0, 42), UDim2.new())
        hideButton.LayoutOrder = 10
        hideButton.Activated:Connect(hideHub)
    else
        card("ABOUT SENA HUB", "Informasi singkat mengenai antarmuka dan versi UI.")
        card("VERSI", "SENA HUB — Neon Blue Interface.")
        card("CATATAN", "UI shell ini tidak mengunduh atau menjalankan kode eksternal.")
        card("KETERBATASAN", "Fitur game perlu diimplementasikan secara terpisah untuk pengalaman Roblox milikmu sendiri.")
    end

    for tabName, b in pairs(navButtons) do
        local selected = tabName == name
        b.BackgroundColor3 = selected and Color3.fromRGB(0, 91, 139) or Color3.fromRGB(9, 26, 52)
        b.TextColor3 = selected and C.cyan or C.muted
        local outline = b:FindFirstChildOfClass("UIStroke")
        if outline then
            outline.Color = selected and C.cyan or Color3.fromRGB(33, 75, 119)
            outline.Transparency = selected and 0.12 or 0.48
        end
        local indicator = b:FindFirstChild("ActiveIndicator")
        if indicator then indicator.Visible = selected end
    end
end

for i, tabName in ipairs(tabs) do
    local b = button(navScroll, tabIcons[tabName] .. "   " .. tabName, UDim2.fromOffset(104, 38), UDim2.new())
    b.LayoutOrder = i
    b.TextXAlignment = Enum.TextXAlignment.Center
    b.TextSize = 11
    b.BackgroundColor3 = Color3.fromRGB(9, 26, 52)
    corner(b, 19)
    local indicator = make("Frame", {
        Name = "ActiveIndicator",
        BackgroundColor3 = C.cyan,
        Position = UDim2.new(0.28, 0, 1, -3),
        Size = UDim2.new(0.44, 0, 0, 2),
        Visible = tabName == "Home",
        ZIndex = b.ZIndex + 2
    }, b)
    corner(indicator, 2)

    navButtons[tabName] = b
    b.Activated:Connect(function() showPage(tabName) end)
end

-- Drag the panel by its header using mouse or touch.
-- Ignore drags that begin on interactive header controls such as the close button.
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

top.InputBegan:Connect(function(input)
    local isPointer = input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
    if not isPointer then return end

    -- The close button is a child of the header; don't start a drag from its area.
    local p = input.Position
    local closePos, closeSize = close.AbsolutePosition, close.AbsoluteSize
    local overClose = p.X >= closePos.X and p.X <= closePos.X + closeSize.X
        and p.Y >= closePos.Y and p.Y <= closePos.Y + closeSize.Y
    if overClose then return end

    dragging = true
    dragInput = input
    dragStart = input.Position
    startPos = main.Position
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or (input.UserInputType == Enum.UserInputType.Touch and input == dragInput) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or (input.UserInputType == Enum.UserInputType.Touch and input == dragInput) then
        dragging = false
        dragInput = nil
    end
end)

-- Compact layout on narrow screens.
local function applyResponsive()
    local width = main.AbsoluteSize.X
    if width < 520 then
        title.TextSize = 20
        for _, b in pairs(navButtons) do
            b.Size = UDim2.fromOffset(88, 36)
            b.TextSize = 10
        end
    else
        title.TextSize = 24
        for _, b in pairs(navButtons) do
            b.Size = UDim2.fromOffset(104, 38)
            b.TextSize = 11
        end
    end
end
main:GetPropertyChangedSignal("AbsoluteSize"):Connect(applyResponsive)
task.defer(applyResponsive)
showPage("Home")


-- Full-screen loading screen shown every time this LocalScript runs.
-- It covers the entire screen, then fades away to reveal the Sena Hub menu.
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "SenaHubLoadingScreen"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 10000
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingGui.Parent = playerGui

-- Hide the hub ScreenGui during loading so its floating toggle cannot overlap the logo.
gui.Enabled = false

local loadingBg = Instance.new("Frame")
loadingBg.Name = "Background"
loadingBg.Size = UDim2.fromScale(1, 1)
loadingBg.Position = UDim2.fromScale(0, 0)
loadingBg.BorderSizePixel = 0
loadingBg.BackgroundColor3 = Color3.fromRGB(3, 8, 22)
loadingBg.ZIndex = 1
loadingBg.Parent = loadingGui

local loadingGradient = Instance.new("UIGradient")
loadingGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(4, 15, 38)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(7, 25, 54)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(3, 8, 22))
})
loadingGradient.Rotation = 35
loadingGradient.Parent = loadingBg

local loadingPanel = Instance.new("Frame")
loadingPanel.Name = "LoadingPanel"
loadingPanel.AnchorPoint = Vector2.new(0.5, 0.5)
loadingPanel.Position = UDim2.fromScale(0.5, 0.5)
loadingPanel.Size = UDim2.new(0.78, 0, 0.78, 0)
loadingPanel.BackgroundColor3 = Color3.fromRGB(5, 17, 38)
loadingPanel.BackgroundTransparency = 0.18
loadingPanel.BorderSizePixel = 0
loadingPanel.ZIndex = 2
loadingPanel.Parent = loadingBg
local panelConstraint = Instance.new("UISizeConstraint")
panelConstraint.MinSize = Vector2.new(290, 330)
panelConstraint.MaxSize = Vector2.new(560, 500)
panelConstraint.Parent = loadingPanel
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 24)
panelCorner.Parent = loadingPanel
local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(0, 174, 255)
panelStroke.Thickness = 1.2
panelStroke.Transparency = 0.48
panelStroke.Parent = loadingPanel

local panelInset = Instance.new("UIPadding")
panelInset.PaddingLeft = UDim.new(0, 20)
panelInset.PaddingRight = UDim.new(0, 20)
panelInset.Parent = loadingPanel

local glow = Instance.new("Frame")
glow.Name = "Glow"
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.Position = UDim2.fromScale(0.5, 0.31)
glow.Size = UDim2.fromOffset(170, 170)
glow.BackgroundColor3 = Color3.fromRGB(0, 133, 255)
glow.BackgroundTransparency = 0.91
glow.BorderSizePixel = 0
glow.ZIndex = 3
glow.Parent = loadingPanel
local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(1, 0)
glowCorner.Parent = glow

local logoRing = Instance.new("Frame")
logoRing.Name = "LogoRing"
logoRing.AnchorPoint = Vector2.new(0.5, 0.5)
logoRing.Position = UDim2.fromScale(0.5, 0.28)
logoRing.Size = UDim2.fromOffset(96, 96)
logoRing.BackgroundColor3 = Color3.fromRGB(6, 24, 52)
logoRing.BorderSizePixel = 0
logoRing.ZIndex = 4
logoRing.Parent = loadingPanel
local ringCorner = Instance.new("UICorner")
ringCorner.CornerRadius = UDim.new(1, 0)
ringCorner.Parent = logoRing
local ringStroke = Instance.new("UIStroke")
ringStroke.Color = C.cyan
ringStroke.Thickness = 2
ringStroke.Transparency = 0.08
ringStroke.Parent = logoRing

local loadingLogo = Instance.new("ImageLabel")
loadingLogo.Name = "Logo"
loadingLogo.BackgroundTransparency = 1
loadingLogo.AnchorPoint = Vector2.new(0.5, 0.5)
loadingLogo.Position = UDim2.fromScale(0.5, 0.5)
loadingLogo.Size = UDim2.fromOffset(78, 78)
loadingLogo.Image = "rbxassetid://111099731853513"
loadingLogo.ScaleType = Enum.ScaleType.Fit
loadingLogo.ZIndex = 5
loadingLogo.Parent = logoRing

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Name = "Title"
loadingTitle.BackgroundTransparency = 1
loadingTitle.AnchorPoint = Vector2.new(0.5, 0)
loadingTitle.Position = UDim2.new(0.5, 0, 0.43, 0)
loadingTitle.Size = UDim2.new(1, 0, 0, 38)
loadingTitle.Font = Enum.Font.GothamBlack
loadingTitle.Text = "SENA HUB v15"
loadingTitle.TextColor3 = Color3.fromRGB(235, 247, 255)
loadingTitle.TextSize = 27
loadingTitle.TextXAlignment = Enum.TextXAlignment.Center
loadingTitle.ZIndex = 4
loadingTitle.Parent = loadingPanel

local loadingSubtitle = Instance.new("TextLabel")
loadingSubtitle.Name = "Subtitle"
loadingSubtitle.BackgroundTransparency = 1
loadingSubtitle.AnchorPoint = Vector2.new(0.5, 0)
loadingSubtitle.Position = UDim2.new(0.5, 0, 0.43, 39)
loadingSubtitle.Size = UDim2.new(1, 0, 0, 20)
loadingSubtitle.Font = Enum.Font.GothamMedium
loadingSubtitle.Text = "STEAL AN EGG • CHILLI STYLE"
loadingSubtitle.TextColor3 = C.cyan
loadingSubtitle.TextSize = 11
loadingSubtitle.TextXAlignment = Enum.TextXAlignment.Center
loadingSubtitle.ZIndex = 4
loadingSubtitle.Parent = loadingPanel

local progressBack = Instance.new("Frame")
progressBack.Name = "ProgressBackground"
progressBack.AnchorPoint = Vector2.new(0.5, 0)
progressBack.Position = UDim2.new(0.5, 0, 0.68, 0)
progressBack.Size = UDim2.new(0.84, 0, 0, 7)
progressBack.BackgroundColor3 = Color3.fromRGB(17, 38, 68)
progressBack.BorderSizePixel = 0
progressBack.ZIndex = 4
progressBack.Parent = loadingPanel
local progressBackCorner = Instance.new("UICorner")
progressBackCorner.CornerRadius = UDim.new(1, 0)
progressBackCorner.Parent = progressBack

local progressFill = Instance.new("Frame")
progressFill.Name = "ProgressFill"
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = C.cyan
progressFill.BorderSizePixel = 0
progressFill.ZIndex = 5
progressFill.Parent = progressBack
local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(1, 0)
progressFillCorner.Parent = progressFill
local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 128, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 255, 210))
})
progressGradient.Parent = progressFill

local progressStatus = Instance.new("TextLabel")
progressStatus.Name = "LoadingStatus"
progressStatus.BackgroundTransparency = 1
progressStatus.AnchorPoint = Vector2.new(0.5, 0)
progressStatus.Position = UDim2.new(0.5, 0, 0.68, 15)
progressStatus.Size = UDim2.new(0.84, 0, 0, 22)
progressStatus.Font = Enum.Font.GothamMedium
progressStatus.Text = "Menyiapkan antarmuka..."
progressStatus.TextColor3 = Color3.fromRGB(140, 179, 211)
progressStatus.TextSize = 11
progressStatus.TextXAlignment = Enum.TextXAlignment.Center
progressStatus.ZIndex = 4
progressStatus.Parent = loadingPanel

local percentLabel = Instance.new("TextLabel")
percentLabel.Name = "Percentage"
percentLabel.BackgroundTransparency = 1
percentLabel.AnchorPoint = Vector2.new(0.5, 0)
percentLabel.Position = UDim2.new(0.5, 0, 0.68, 39)
percentLabel.Size = UDim2.new(0.84, 0, 0, 20)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.Text = "0%"
percentLabel.TextColor3 = C.text
percentLabel.TextSize = 10
percentLabel.TextXAlignment = Enum.TextXAlignment.Center
percentLabel.ZIndex = 4
percentLabel.Parent = loadingPanel

local footer = Instance.new("TextLabel")
footer.Name = "Footer"
footer.BackgroundTransparency = 1
footer.AnchorPoint = Vector2.new(0.5, 1)
footer.Position = UDim2.new(0.5, 0, 1, -18)
footer.Size = UDim2.new(0.9, 0, 0, 18)
footer.Font = Enum.Font.Gotham
footer.Text = "SENA HUB v15  •  STEAL AN EGG"
footer.TextColor3 = Color3.fromRGB(73, 112, 155)
footer.TextSize = 9
footer.TextXAlignment = Enum.TextXAlignment.Center
footer.ZIndex = 4
footer.Parent = loadingPanel

-- A brief, staged progress animation plays on every script run.
task.spawn(function()
    local stages = {
        {value = 22, text = "Memuat komponen UI..."},
        {value = 48, text = "Menyiapkan navigasi..."},
        {value = 76, text = "Menyelaraskan tampilan..."},
        {value = 100, text = "Sena Hub siap digunakan!"}
    }

    for _, stage in ipairs(stages) do
        progressStatus.Text = stage.text
        local duration = stage.value == 100 and 0.45 or 0.62
        local tween = TweenService:Create(
            progressFill,
            TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(stage.value / 100, 0, 1, 0)}
        )
        tween:Play()
        local startValue = tonumber(string.match(percentLabel.Text, "%d+")) or 0
        local startedAt = os.clock()
        while true do
            local elapsed = os.clock() - startedAt
            local alpha = math.clamp(elapsed / duration, 0, 1)
            local current = math.floor(startValue + (stage.value - startValue) * alpha)
            percentLabel.Text = tostring(current) .. "%"
            if alpha >= 1 then break end
            task.wait(0.03)
        end
        percentLabel.Text = tostring(stage.value) .. "%"
        -- Do not wait on Completed here: the tween may finish during the
        -- progress-label loop, before a Completed:Wait() listener is attached.
        -- That race could leave the loading screen stuck at 22%.
        if tween.PlaybackState ~= Enum.PlaybackState.Completed then
            local remaining = math.max(0, duration - (os.clock() - startedAt))
            if remaining > 0 then task.wait(remaining) end
        end
    end

    task.wait(0.35)
    main.Visible = true
    gui.Enabled = true

    local fadeInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    for _, item in ipairs(loadingBg:GetDescendants()) do
        if item:IsA("Frame") then
            TweenService:Create(item, fadeInfo, {BackgroundTransparency = 1}):Play()
        elseif item:IsA("TextLabel") then
            TweenService:Create(item, fadeInfo, {TextTransparency = 1}):Play()
        elseif item:IsA("ImageLabel") then
            TweenService:Create(item, fadeInfo, {ImageTransparency = 1}):Play()
        elseif item:IsA("UIStroke") then
            TweenService:Create(item, fadeInfo, {Transparency = 1}):Play()
        end
    end
    TweenService:Create(loadingBg, fadeInfo, {BackgroundTransparency = 1}):Play()
    task.wait(0.4)
    loadingGui:Destroy()
end)

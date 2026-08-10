local colaUi = {}
colaUi.__index = colaUi

colaUi.Themes = {
    Rose = {
        Background = Color3.fromRGB(30, 20, 25),
        Sidebar = Color3.fromRGB(40, 25, 32),
        Accent = Color3.fromRGB(255, 105, 180),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(180, 160, 170)
    },
    Red = {
        Background = Color3.fromRGB(20, 20, 20),
        Sidebar = Color3.fromRGB(30, 22, 22),
        Accent = Color3.fromRGB(255, 50, 50),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(170, 160, 160)
    },
    Blue = {
        Background = Color3.fromRGB(15, 20, 30),
        Sidebar = Color3.fromRGB(22, 30, 42),
        Accent = Color3.fromRGB(50, 150, 255),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(160, 170, 180)
    },
    Green = {
        Background = Color3.fromRGB(15, 25, 20),
        Sidebar = Color3.fromRGB(22, 35, 28),
        Accent = Color3.fromRGB(50, 255, 120),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(160, 180, 170)
    }
}

function colaUi.new(title, currentTheme)
    local self = setmetatable({}, colaUi)
    self.Theme = colaUi.Themes[currentTheme] or colaUi.Themes.Rose
    
    if game:GetService("CoreGui"):FindFirstChild("ColaCheatUI") then
        game:GetService("CoreGui").ColaCheatUI:Destroy()
    end

    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "ColaCheatUI"
    self.ScreenGui.Parent = game:GetService("CoreGui")

    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = UDim2.new(0, 550, 0, 350)
    self.MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    self.MainFrame.BackgroundColor3 = self.Theme.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = self.MainFrame

    self.Sidebar = Instance.new("ScrollingFrame")
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.Size = UDim2.new(0, 140, 1, 0)
    self.Sidebar.BackgroundColor3 = self.Theme.Sidebar
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.ScrollBarThickness = 2
    self.Sidebar.Parent = self.MainFrame

    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 8)
    SidebarCorner.Parent = self.Sidebar

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 5)
    SidebarLayout.Parent = self.Sidebar

    self.PagesContainer = Instance.new("Folder")
    self.PagesContainer.Name = "PagesContainer"
    self.PagesContainer.Parent = self.MainFrame

    self.TabsCount = 0
    self.FirstTab = true

    return self
end

function colaUi:CreateTab(name)
    local Tab = {}
    local selfObj = self

    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, -10, 0, 35)
    TabButton.Position = UDim2.new(0, 5, 0, 0)
    TabButton.BackgroundColor3 = self.FirstTab and self.Theme.Accent or self.Theme.Sidebar
    TabButton.TextColor3 = self.Theme.Text
    TabButton.Text = name
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 14
    TabButton.Parent = self.Sidebar

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = TabButton

    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, -155, 1, -10)
    Page.Position = UDim2.new(0, 150, 0, 5)
    Page.BackgroundTransparency = 1
    Page.Visible = self.FirstTab
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.Parent = self.PagesContainer

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.Parent = Page

    TabButton.MouseButton1Click:Connect(function()
        for _, child in ipairs(self.PagesContainer:GetChildren()) do
            child.Visible = false
        end
        for _, child in ipairs(self.Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = self.Theme.Sidebar
            end
        end
        Page.Visible = true
        TabButton.BackgroundColor3 = self.Theme.Accent
    end)

    self.FirstTab = false

    function Tab:CreateButton(text, shape, callback)
        local Button = Instance.new("TextButton")
        Button.Text = (shape ~= "circle" and shape ~= "square") and text or ""
        Button.TextColor3 = selfObj.Theme.Text
        Button.BackgroundColor3 = selfObj.Theme.Accent
        Button.Font = Enum.Font.SourceSansBold
        Button.TextSize = 14
        Button.BorderSizePixel = 0

        local Corner = Instance.new("UICorner")

        if shape == "circle" then
            Button.Size = UDim2.new(0, 40, 0, 40)
            Corner.CornerRadius = UDim.new(1, 0)
        elseif shape == "square" then
            Button.Size = UDim2.new(0, 40, 0, 40)
            Corner.CornerRadius = UDim.new(0, 6)
        else
            Button.Size = UDim2.new(1, 0, 0, 35)
            Corner.CornerRadius = UDim.new(0, 6)
        end

        Corner.Parent = Button
        Button.Parent = Page

        Button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)

        return Button
    end

    return Tab
end

return colaUi


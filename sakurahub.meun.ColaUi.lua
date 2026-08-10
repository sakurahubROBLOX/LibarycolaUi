local colaUi = {}
colaUi.__index = colaUi

colaUi.Themes = {
    Rose = {
        Background = Color3.fromRGB(24, 18, 22),
        Sidebar = Color3.fromRGB(32, 22, 28),
        Accent = Color3.fromRGB(255, 105, 180),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(170, 150, 160),
        Notification = Color3.fromRGB(40, 25, 35)
    },
    Red = {
        Background = Color3.fromRGB(18, 18, 18),
        Sidebar = Color3.fromRGB(26, 20, 20),
        Accent = Color3.fromRGB(255, 50, 50),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(160, 150, 150),
        Notification = Color3.fromRGB(30, 22, 22)
    },
    Blue = {
        Background = Color3.fromRGB(13, 18, 26),
        Sidebar = Color3.fromRGB(18, 25, 36),
        Accent = Color3.fromRGB(50, 150, 255),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(150, 160, 170),
        Notification = Color3.fromRGB(20, 28, 40)
    },
    Green = {
        Background = Color3.fromRGB(13, 22, 18),
        Sidebar = Color3.fromRGB(18, 30, 24),
        Accent = Color3.fromRGB(50, 255, 120),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(150, 170, 160),
        Notification = Color3.fromRGB(20, 35, 28)
    }
}

function colaUi.new(title, currentTheme)
    local self = setmetatable({}, colaUi)
    self.Theme = colaUi.Themes[currentTheme] or colaUi.Themes.Rose
    
    if game:GetService("CoreGui"):FindFirstChild("ColaTestUi") then
        game:GetService("CoreGui").ColaTestUi:Destroy()
    end

    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "ColaTestUi"
    self.ScreenGui.Parent = game:GetService("CoreGui")

    -- Контейнер для уведомлений (в стиле WindUI справа сверху)
    self.NotifContainer = Instance.new("Frame")
    self.NotifContainer.Name = "NotifContainer"
    self.NotifContainer.Size = UDim2.new(0, 250, 1, 0)
    self.NotifContainer.Position = UDim2.new(1, -260, 0, 20)
    self.NotifContainer.BackgroundTransparency = 1
    self.NotifContainer.Parent = self.ScreenGui

    local NotifLayout = Instance.new("UIListLayout")
    NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NotifLayout.Padding = UDim.new(0, 10)
    NotifLayout.Parent = self.NotifContainer

    -- Главное окно
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = UDim2.new(0, 550, 0, 350)
    self.MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    self.MainFrame.BackgroundColor3 = self.Theme.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = self.MainFrame

    -- Верхняя шапка
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = self.MainFrame

    -- Заголовок меню
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = self.Theme.Text
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    -- Кнопка закрытия (-)
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 28, 0, 28)
    CloseButton.Position = UDim2.new(1, -34, 0, 6)
    CloseButton.BackgroundColor3 = self.Theme.Sidebar
    CloseButton.Text = "-"
    CloseButton.TextColor3 = self.Theme.Text
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextSize = 18
    CloseButton.Parent = TopBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton

    -- Круглая кнопка открытия (Cola)
    local OpenButton = Instance.new("TextButton")
    OpenButton.Size = UDim2.new(0, 45, 0, 45)
    OpenButton.Position = UDim2.new(0, 20, 0.5, -22)
    OpenButton.BackgroundColor3 = self.Theme.Accent
    OpenButton.Text = "Cola"
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.Font = Enum.Font.SourceSansBold
    OpenButton.TextSize = 12
    OpenButton.Visible = false
    OpenButton.Parent = self.ScreenGui

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = OpenButton

    CloseButton.MouseButton1Click:Connect(function()
        self.MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    OpenButton.MouseButton1Click:Connect(function()
        self.MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    -- Боковая панель
    self.Sidebar = Instance.new("ScrollingFrame")
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.Size = UDim2.new(0, 140, 1, -45)
    self.Sidebar.Position = UDim2.new(0, 0, 0, 40)
    self.Sidebar.BackgroundColor3 = self.Theme.Sidebar
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.ScrollBarThickness = 2
    self.Sidebar.Parent = self.MainFrame

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 5)
    SidebarLayout.Parent = self.Sidebar

    self.PagesContainer = Instance.new("Folder")
    self.PagesContainer.Name = "PagesContainer"
    self.PagesContainer.Parent = self.MainFrame

    self.FirstTab = true

    return self
end

-- Функция создания красивых уведомлений в стиле WindUI
function colaUi:Notify(titleText, descText, duration)
    duration = duration or 3
    
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(1, 0, 0, 60)
    Notif.BackgroundColor3 = self.Theme.Notification
    Notif.BorderSizePixel = 0
    Notif.Parent = self.NotifContainer

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 8)
    NotifCorner.Parent = Notif

    -- Акцентная полоска слева
    local AccentLine = Instance.new("Frame")
    AccentLine.Size = UDim2.new(0, 4, 1, 0)
    AccentLine.BackgroundColor3 = self.Theme.Accent
    AccentLine.BorderSizePixel = 0
    AccentLine.Parent = Notif

    local LineCorner = Instance.new("UICorner")
    LineCorner.CornerRadius = UDim.new(0, 2)
    LineCorner.Parent = AccentLine

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 22)
    Title.Position = UDim2.new(0, 12, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.TextColor3 = self.Theme.Text
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Notif

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -20, 0, 20)
    Desc.Position = UDim2.new(0, 12, 0, 30)
    Desc.BackgroundTransparency = 1
    Desc.Text = descText
    Desc.TextColor3 = self.Theme.SecondaryText
    Desc.Font = Enum.Font.SourceSans
    Desc.TextSize = 12
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.Parent = Notif

    -- Авто-удаление уведомления через время
    task.spawn(function()
        task.wait(duration)
        Notif:Destroy()
    end)
end

function colaUi:CreateTab(name)
    local Tab = {}
    local selfObj = self

    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, -10, 0, 35)
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
    Page.Size = UDim2.new(1, -155, 1, -50)
    Page.Position = UDim2.new(0, 150, 0, 45)
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


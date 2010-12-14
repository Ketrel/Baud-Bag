--This file is UTF-8
local Locale = GetLocale();

if (Locale=="zhTW") then -- Translator: Isler
  BaudBagLocalized = {
    LockPosition = "鎖定窗口",
    UnlockPosition = "解鎖窗口",
    ShowBank = "顯示銀行",
    Options = "選項",
    Free = " 剩餘",
    Offline = " (離線銀行)",
    AutoOpen = "自動開啟",
    AutoOpenTooltip = "勾選後，在交易,使用郵箱和銀行時自動打開背包(如果可用)",
    BlankOnTop = "頂部留空",
    BlankOnTopTooltip = "勾選後，剩餘的未使用空間上升到整合背包頂部(開啟背包整合後生效)",
    RarityColoring = "品質邊框",
    RarityColoringTooltip = "勾選後，物品圖示的邊框按品質著色(開啟背包整合後生效)",
    Columns = "每行列數 - %d",
    ColumnsTooltip = "每行顯示的背包格數.",
    Scale = "縮放 - %d%%",
    ScaleTooltip = "縮放整合背包.",
    AddMessage = "Baud Bag: 已載入. 輸入 /baudbag 打開設置視窗.",
    CheckTooltip = "啟用的背包",
    Enabled = "啟用整合功能",
    EnabledTooltip = "啟用或禁用整合功能",
    KeyRing = "鑰匙鏈",
    Of = " 的",
    Inventory = "背包",
    BankBox = "銀行",
    BlizInventory = "暴雪背包風格",
    BlizBank = "暴雪銀行風格",
    BlizKeyring = "暴雪鑰匙鏈風格",
    Transparent = "水晶風格",
    Solid = "Solid風格",
    BagSet = "背包設定",
    ContainerName = "背包名稱:",
    Background = "風格設定",
    FeatureFrameName = "背包設定",
    FeatureFrameTooltip = "設定背包整合的各種參數",
  };
elseif (Locale=="zhCN") then  -- Translator: Isler
  BaudBagLocalized = {
    StandardBag = "容器",
    LockPosition = "锁定窗口",
    UnlockPosition = "解锁窗口",
    ShowBank = "显示银行",
    Options = "选项",
    Free = " 剩余",
    Offline = " (离线银行)",
    AutoOpen = "自动开启",
    AutoOpenTooltip = "勾选后，在交易,使用邮箱和银行时自动打开背包(如果可用)",
    BlankOnTop = "顶部留空",
    BlankOnTopTooltip = "勾选后，剩余的未使用空间上升到整合背包顶部(开启背包整合后生效)",
    RarityColoring = "质量边框",
    RarityColoringTooltip = "勾选后，物品图标的边框按品质着色(开启背包整合后生效)",
    Columns = "每行列数 - %d",
    ColumnsTooltip = "每行显示的背包格数.",
    Scale = "缩放 - %d%%",
    ScaleTooltip = "缩放整合背包.",
    AddMessage = "Baud Bag: 已载入. 输入 /baudbag 打开设置窗口.",
    CheckTooltip = "启用的背包",
    Enabled = "启用整合功能",
    EnabledTooltip = "启用或禁用整合功能",
    KeyRing = "钥匙链",
    Of = " 的",
    Inventory = "背包",
    BankBox = "银行",
    BlizInventory = "暴雪背包风格",
    BlizBank = "暴雪银行风格",
    BlizKeyring = "暴雪钥匙链风格",
    Transparent = "水晶风格",
    Solid = "Solid风格",
    BagSet = "背包设定",
    ContainerName = "背包名称:",
    Background = "风格设定",
    FeatureFrameName = "背包设定",
    FeatureFrameTooltip = "设定背包整合的各种参数",
  };
elseif (Locale=="frFR") then  -- Translator: Isler
  BaudBagLocalized = {
    LockPosition = "Bloque position",
    UnlockPosition = "Débloque position",
    ShowBank = "Sac de Banque",
    Options = "Options",
    Free = " Libre",
    Offline = " (Hors ligne)",
    AutoOpen = "Ouverture automatique",
    AutoOpenTooltip = "Quand c'est possible, ouvre vos sac à l'ouverture de la boîte aux lettres, au vendeur, ou la banque (si possible)",
    BlankOnTop = "Espace au dessus",
    BlankOnTopTooltip = "Quand c'est possible, n'importe quel espace libre sera mis au dessus, au lieu du fond(bas).",
    RarityColoring = "Coloration des objets",
    RarityColoringTooltip = "Quand permis, les bordures de vos objets seront colorées selon leur rareté (vertes, bleu, etc).",
    Columns = "Colonnes - %d",
    ColumnsTooltip = "Largeur du Sac.",
    Scale = "Échelle - %d%%",
    ScaleTooltip = "Échelle du sac.",
    AddMessage = "Baud Bag: AddOn chargé. Taper /baudbag ou /bb pour les options.",
    CheckTooltip = "Sacs Joints",
    Enabled = "Activer",
    EnabledTooltip = "Permettre ou mettre hors service BaudBag pour vos sac.",
    KeyRing = "Trousseau de clef",
    Of = "'s ",
    Inventory = "votre sac",
    BankBox = "Sac de Banque",
    BlizInventory = "Bliz inventaire",
    BlizBank = "Bliz Banque",
    BlizKeyring = "Bliz clef",
    Transparent = "Transparent",
    Solid = "Solide",
    BagSet = "Sélection Sac",
    ContainerName = "Nom de vos sac:",
    Background = "Skin de votre sac",
    FeatureFrameName = "BaudBag Options",
    FeatureFrameTooltip = "BaudBag Options",
  };
elseif (Locale == "deDE") then -- Translator: Thurmal
  BaudBagLocalized = {
    LockPosition = "Fenster fixieren",
    UnlockPosition = "Fenster freigeben",
    ShowBank = "Bank anzeigen",
    Options = "Optionen",
    Free = " frei",
    Offline = " (Offline)",
    AutoOpen = "Automatisch Öffnen",
    AutoOpenTooltip = "Öffnet die gewählte Tasche automatisch wenn Post abgeholt wird, ein Verkäufer oder (wenn möglich) die Bank besucht wird.",
    BlankOnTop = "Leerplätze oben",
    BlankOnTopTooltip = "Nicht von Taschenplätzen belegter Platz im Fenster wird oben angezeigt anstatt unten.",
    RarityColoring = "Seltenheitseinfärbung",
    RarityColoringTooltip = "Der Rand von Gegenständen wird entsprechend der seltenheit eingefärbt (grün, blau, etc).",
    Columns = "Spalten - %d",
    ColumnsTooltip = "Anzahl der angezeigten Taschenplätze (Spalten) pro Zeile in der gewählten Tasche.",
    Scale = "Skalierung - %d%%",
    ScaleTooltip = "Skalierung des Fensters.",
    AddMessage = "Baud Bag: AddOn geladen. Tippe /baudbag oder /bb in den Chat um die Optionen aufzurufen.",
    CheckTooltip = "Taschen zusammenfassen",
    Enabled = "Aktiviert",
    EnabledTooltip = "Aktiviere oder Deaktiviere BaudBag für diesen Taschen-Typ.",
    KeyRing = "Schlüsselbund",
    Of = "s ",
    Inventory = "Inventar",
    BankBox = "Bankfach",
    BlizInventory = "Bliz Inventar",
    BlizBank = "Bliz Bank",
    BlizKeyring = "Bliz Schlüsselbund",
    Transparent = "Transparent",
    Solid = "Fest",
    BagSet = "Taschen-Typ",
    ContainerName = "Taschen-Name",
    Background = "Hintergrund",
    FeatureFrameName = "BaudBag Optionen",
    FeatureFrameTooltip = "BaudBag Optionen",
  };
elseif (Locale == "koKR") then -- Translator: talkswind
  BaudBagLocalized = {
	LockPosition = "위치 잠금",
	UnlockPosition = "위치 풀음",
	ShowBank = "은행 보이기",
	Options = "옵션",
	Free = "빈 칸",
	Offline = " (오프라인)",
	AutoOpen = "자동 열기",
	AutoOpenTooltip = "활성화시, (가능하다면)우편함, 상점, 혹은 은행에서 이 가방을 자동으로 엽니다.",
	BlankOnTop = "상단 비움",
	BlankOnTopTooltip = "활성화시, 하단 대신에 상단에 약간의 나머지 빈공간을 집어 넣습니다.",
	RarityColoring = "등급 색 입히기",
	RarityColoringTooltip = "활성화시, 아이템의 테두리는 그것의 등급(녹색, 청색 등등..)에 걸맞게 색이 입혀집니다.",
	Columns = "행 - %d",
	ColumnsTooltip = "가방의 너비를 칸으로 조절합니다.",
	Scale = "크기 비율 - %d%%",
	ScaleTooltip = "보관함의 크기 비율을 설정합니다.",
	AddMessage = "Baud Bag: 애드온을 불러들였습니다. 옵션을 위해서는 /baudbag을 입력하십시요.",
	CheckTooltip = "가방을 합칩니다.",
	Enabled = "활성화",
	EnabledTooltip = "이 가방 세트에 대해 BaudBag을 활성화 혹은 비활성화합니다.",
	KeyRing = "열쇠 고리",
	Of = "'의 ",
	Inventory = "소지품",
	BankBox = "은행 박스",
	BlizInventory = "블리즈 소지품",
	BlizBank = "블리즈 은행",
	BlizKeyring = "블리즈 열쇠고리",
	Transparent = "반투명한",
	Solid = "바탕 무늬 없는",
	BagSet = "가방 세트",
	ContainerName = "보관함 이름:",
	Background = "배경",
	FeatureFrameName = "BaudBag 옵션",
	FeatureFrameTooltip = "BaudBag 옵션입니다."
  };
elseif (Locale == "ruRU") then -- Translator: StingerSoft
  BaudBagLocalized = {
	LockPosition = "Заблокировать положение",
    UnlockPosition = "Разблокировать положение",
    ShowBank = "Показать банк",
    Options = "Настройки",
    Free = " Свободно",
    Offline = " (Оффлайн)",
    AutoOpen = "Авто открытие",
    AutoOpenTooltip = "Когда включено, автоматически открывает эту сумку (если возможно).",
    BlankOnTop = "Пустые сверху",
    BlankOnTopTooltip = "Когда включен, любые пустые ячейки будет отсортированы сверху, а не снизу.",
    RarityColoring = "Окрасить согласно качеству",
    RarityColoringTooltip = "Когда включено, окрашивает границы ячеек вещей согласно их качеству (зеленые, синие, и т.п.).",
    Columns = "Колонки - %d",
    ColumnsTooltip = "Количество колонок по ширине.",
    Scale = "Масштаб - %d%%",
    ScaleTooltip = "Масштаб ячейки.",
    AddMessage = "Baud Bag: Аддон загружен. введите /baudbag для открытия настроек.",
    CheckTooltip = "Присоединить сумку",
    Enabled = "Включить",
    EnabledTooltip = "Включить или отключить BaudBag.",
    KeyRing = "Связка ключей",
    Of = " ",
    Inventory = "Инвентарь",
    BankBox = "Банк",
    BlizInventory = "Bliz инвентарь",
    BlizBank = "Bliz банк",
    BlizKeyring = "Bliz ключи",
    Transparent = "Прозрачный",
    Solid = "Непрозрачный",
    BagSet = "Набор сумок",
    ContainerName = "Название:",
    Background = "Фон",
    FeatureFrameName = "BaudBag настройки",
    FeatureFrameTooltip = "BaudBag настройки"
  };
else --enUS (default)
  BaudBagLocalized = {
    LockPosition = "Lock Position",
    UnlockPosition = "Unlock Position",
    ShowBank = "Show Bank",
    Options = "Options",
    Free = " Free",
    Offline = " (Offline)",
    AutoOpen = "Auto Open",
    AutoOpenTooltip = "When enabled, automaticaly opens this bag at the mailbox, vendor, or bank (if possible).",
    BlankOnTop = "Blank on top",
    BlankOnTopTooltip = "When enabled, any leftover blank space will be put on the top, instead of the bottom.",
    RarityColoring = "Rarity Coloring",
    RarityColoringTooltip = "When enabled, the borders of items will be colored according to their rarity (green, blue, etc).",
    Columns = "Columns - %d",
    ColumnsTooltip = "Width of the container in slots.",
    Scale = "Scale - %d%%",
    ScaleTooltip = "Scale of the container.",
    AddMessage = "Baud Bag: AddOn loaded. Type /baudbag or /bb for options.",
    CheckTooltip = "Joined bags",
    Enabled = "Enabled",
    EnabledTooltip = "Enable or disable BaudBag for this bag set.",
    KeyRing = "Key Ring",
    Of = "'s ",
    Inventory = "Inventory",
    BankBox = "Bank Box",
    BlizInventory = "Bliz Inventory",
    BlizBank = "Bliz Bank",
    BlizKeyring = "Bliz Keyring",
    Transparent = "Transparent",
    Solid = "Solid",
    BagSet = "Bag Set",
    ContainerName = "Container Name:",
    Background = "Background",
    FeatureFrameName = "BaudBag Options",
    FeatureFrameTooltip = "BaudBag Options",
  };
end
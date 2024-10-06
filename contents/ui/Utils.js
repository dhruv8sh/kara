//Roman numerals 1..=50

const ROMAN = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX",
    "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX",
    "XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX",
    "XXXI", "XXXII", "XXXIII", "XXXIV", "XXXV", "XXXVI", "XXXVII", "XXXVIII", "XXXIX", "XL",
    "XLI", "XLII", "XLIII", "XLIV", "XLV", "XLVI", "XLVII", "XLVIII", "XLIX", "L"]
const HINDU = [
    '१', '२', '३', '४', '५', '६', '७', '८', '९', '१०',
    '११', '१२', '१३', '१४', '१५', '१६', '१७', '१८', '१९', '२०',
    '२१', '२२', '२३', '२४', '२५', '२६', '२७', '२८', '२९', '३०',
    '३१', '३२', '३३', '३४', '३५', '३६', '३७', '३८', '३९', '४०',
    '४१', '४२', '४३', '४४', '४५', '४६', '४७', '४८', '४९', '५०'
];
const MANDARIN = [
    '一', '二', '三', '四', '五', '六', '七', '八', '九', '十',
    '十一', '十二', '十三', '十四', '十五', '十六', '十七', '十八', '十九', '二十',
    '二十一', '二十二', '二十三', '二十四', '二十五', '二十六', '二十七', '二十八', '二十九', '三十',
    '三十一', '三十二', '三十三', '三十四', '三十五', '三十六', '三十七', '三十八', '三十九', '四十',
    '四十一', '四十二', '四十三', '四十四', '四十五', '四十六', '四十七', '四十八', '四十九', '五十'
];

function getRoman(pos) {
    return ROMAN[pos]
}
function getHindu(pos) {
    return HINDU[pos]
}
function getChinese(pos) {
    return MANDARIN[pos]
}
function get_breadth() {
    if(!is_vertical) {
        if(plasmoid.location == PlasmaCore.Types.Floating || plasmoid.location == PlasmaCore.Types.Desktop) return 40
            else return parent.height
    } else {
        if(plasmoid.location == PlasmaCore.Types.Floating || plasmoid.location == PlasmaCore.Types.Desktop) return 40
            else return parent.width
    }
}
function getLabel(pos,curr) {
    function replaceLabel(template) {
        return template
            .replace("%name",virtualDesktopInfo.desktopNames[pos])
            .replace("%d",pos+1)
            .replace("%roman",Utils.getRoman(pos))
            .replace("%hindu",Utils.getHindu(pos))
            .replace("%chinese",Utils.getChinese(pos))
    }
    switch(cfg.labelSource) {
        case 1: return virtualDesktopInfo.desktopNames[pos]
        case 2: return replaceLabel(cfg.template)
        case 3: return pos==curr ? replaceLabel(cfg.activeTemplate):(pos<curr?replaceLabel(cfg.beforeTemplate):replaceLabel(cfg.afterTemplate))
        case 4: return replaceLabel(root.customLabels[pos] ?? cfg.labelExtra)
        case 5: return getRoman(pos)
        case 6: return getHindu(pos)
        case 7: return getChinese(pos)
        default: return pos+1

    }
}
function getHighlightOpacity() {
    if(cfg.highlightOnHover && hovered) return 0.4
        else if(isActive) return 1
            else if(cfg.slightlyHighlight && hasWindows) return 0.6
                else return 0
}
function getRepSource() {
    switch(cfg.type) {
        case 1: return "representations/TextStyle.qml"
        case 2: return "representations/IconStyle.qml"
        default: return "representations/PillStyle.qml"
    }
}
function usesHighlight() {
    cfg.type != 0
}

function updateTaskCount() {
    taskCount = 0
    for (var i = 0; i < tasksModel.count; i++) {
        const currentTask = tasksModel.index(i, 0)
        if (currentTask === undefined) continue
        if (tasksModel.data(currentTask, isWindow)) {
            taskCount+=1
        }
    }
}

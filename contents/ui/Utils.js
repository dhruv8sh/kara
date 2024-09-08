//Roman numerals 1..=50

const ROMAN = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX",
"X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX",
"XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX",
"XXXI", "XXXII", "XXXIII", "XXXIV", "XXXV", "XXXVI", "XXXVII", "XXXVIII", "XXXIX", "XL",
"XLI", "XLII", "XLIII", "XLIV", "XLV", "XLVI", "XLVII", "XLVIII", "XLIX", "L"]

function get_roman(pos) {
    return ROMAN[pos]
}
function get_breadth() {
    if(!is_vertical) {
        if(plasmoid.location == PlasmaCore.Types.Floating || plasmoid.location == PlasmaCore.Types.Desktop) return 40
        else return parent.height
    } else {
        if(plasmoid.location == PlasmaCore.Types.Floating || plasmoid.location == PlasmaCore.Types.Desktop)
            return 40
        else return parent.width
    }
}

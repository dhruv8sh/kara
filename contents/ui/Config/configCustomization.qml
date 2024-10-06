import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import QtQuick.Controls as QQC2
import "../Common/" as Common
import org.kde.kquickcontrols as KQuickControls

Kirigami.ScrollablePage {
    title: i18nc("@title","General")

    property alias cfg_plasmaStyleColors: defHighlightColor.checked
    property alias cfg_plasmaTxtColors: defTextColor.checked
    property alias cfg_defaultAltTextColors: defTextAltColor.checked
    property alias cfg_plasmaSemiColors: defSemiHighlightColor.checked
    property alias cfg_pColor: defHighlightColor.color
    property alias cfg_txtColor: defTextColor.color
    property alias cfg_semiColor: defSemiHighlightColor.color
    property alias cfg_altColor: defTextAltColor.color
    property alias cfg_highlightOpacityFull: semiHighlightOpacityFull.checked
    property alias cfg_pillDontChangeOp: pillDontChangeOp.checked
    property alias cfg_slightlyHighlight: semiHighlight.checked
    property alias cfg_addAsterisk: asteriskCheck.checked

    property alias cfg_bold: bolden.checked
    property alias cfg_italic: italicize.checked
    property alias cfg_fontSize: textSize.value
    property alias cfg_activeBold: activeBolden.checked
    property alias cfg_activeItalic: activeItalicize.checked
    property alias cfg_activeFontSize: activeFontSize.value
    property var cfg_type: 0

    Kirigami.FormLayout {
        anchors.fill: parent
        wideMode: true

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Indicator Colors"
        }
        Common.ColorForm {
            id: defTextColor
            Kirigami.FormData.label: "Default Inactive Content:"
        }
        Common.ColorForm {
            id: defTextAltColor
            Kirigami.FormData.label: "Default Active Content:"
        }
        PC3.CheckBox {
            id: pillDontChangeOp
            Kirigami.FormData.label: "Inactive pills don't change opacity:"
            visible: cfg_type == 0
        }

        // Highlight Settings
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Highlight Colors"
            visible: cfg_type != 0
        }
        Common.ColorForm {
            id: defHighlightColor
            enabled: cfg_type > 0
            Kirigami.FormData.label: "Default Highlight Color:"
            visible: cfg_type != 0
        }
        PC3.CheckBox {
            id: semiHighlight
            Kirigami.FormData.label: "Semi-Highlight desktop with open windows:"
            visible: cfg_type != 0
        }
        Common.ColorForm {
            id: defSemiHighlightColor
            enabled: cfg_type > 0 && semiHighlight.checked
            Kirigami.FormData.label: "Default Semi-Highlight Color:"
            onCheckedChanged: if(checked) semiHighlightOpacityFull.checked = false
            visible: cfg_type != 0
        }
        PC3.CheckBox {
            id: semiHighlightOpacityFull
            enabled: !defSemiHighlightColor.checked
            Kirigami.FormData.label: "Do not alter opacity of custom\nsemi-highlight colors:"
            visible: cfg_type != 0
        }
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Text Emphases"
            visible: cfg_type == 1
        }
        RowLayout {
            Kirigami.FormData.label: "Active Title Emphasis:"
            visible: cfg_type == 1
            PC3.ToolButton {
                id: activeBolden
                checkable: true
                icon.name: "format-text-bold"
                PC3.ToolTip{ text: "Bold text" }
            }
            PC3.ToolButton {
                id: activeItalicize
                checkable: true
                icon.name: "format-text-italic"
                PC3.ToolTip{ text: "Italic text" }
            }
            PC3.SpinBox {
                id: activeFontSize
                from: 6
                to: 100
            }
        }
        RowLayout {
            Kirigami.FormData.label: "Inactive Title Emphasis:"
            visible: cfg_type == 1
            PC3.ToolButton {
                id: bolden
                checkable: true
                icon.name: "format-text-bold"
                PC3.ToolTip{ text: "Bold text" }
            }
            PC3.ToolButton {
                id: italicize
                checkable: true
                icon.name: "format-text-italic"
                PC3.ToolTip{ text: "Italic text" }
            }
            PC3.SpinBox {
                id: textSize
                from: 6
                to: 100
            }
        }
        PC3.CheckBox {
            visible: cfg_type == 1
            id: asteriskCheck
            Kirigami.FormData.label: "Add asterisk(*) for desktops with active window:"
        }
    }
}

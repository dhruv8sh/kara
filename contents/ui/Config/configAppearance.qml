import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import QtQuick.Controls as QQC2
import "../highlights/" as Highlight
import org.kde.kquickcontrols as KQuickControls

Kirigami.ScrollablePage {
    title: i18nc("@title","General")

    property alias cfg_type: type.currentIndex
    property alias cfg_highlightType: hType.currentIndex
    property alias cfg_slightlyHighlight: slightHighlight.checked
    property alias cfg_plasmaStyleColors: plasmaStyleColors.checked
    property alias cfg_t1width: t1width.value
    property alias cfg_t1height: t1height.value
    property alias cfg_t1activeHeight: t1activeHeight.value
    property alias cfg_t1activeWidth: t1activeWidth.value
    property alias cfg_template: template.text
    property alias cfg_addAsterisk: asteriskCheck.checked
    property alias cfg_fixedLen: fixedLen.value
    property alias cfg_iconsList: customIcons.text
    property alias cfg_iconOther: customIconsOther.text
    property alias cfg_labelsList: customLabels.text
    property alias cfg_labelExtra: customLabelsOther.text
    property alias cfg_t2bold: boldCheck.checked
    property alias cfg_t2italic: italicCheck.checked
    property alias cfg_pColor: customHighlightColor.color
    property alias cfg_txtColor: customTextColor.color
    property alias cfg_plasmaTxtColors: plasmaStyleTextColors.checked
    property alias cfg_iconExtra: customIconsOther.text

    Kirigami.FormLayout {
        anchors.fill: parent

        // ----------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Colors"
        }
        RowLayout {
            enabled: type.currentIndex > 0
            Kirigami.FormData.label: "Default Highlight Colors:"
            QQC2.CheckBox {
                id: plasmaStyleColors
            }
            KQuickControls.ColorButton {
                id: customHighlightColor
                enabled: !plasmaStyleColors.checked
            }
            PC3.Label {
                text: Kirigami.Theme.highlightColor
            }
        }
        RowLayout {
            Kirigami.FormData.label: "Default content color:"
            QQC2.CheckBox {
                id: plasmaStyleTextColors
            }
            KQuickControls.ColorButton {
                id: customTextColor
                enabled: !plasmaStyleTextColors.checked
            }
            PC3.Label {
                text: Kirigami.Theme.textColor
            }
        }

        // ----------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Indicator Settings"
        }
        QQC2.ComboBox {
            id: type
            Kirigami.FormData.label: "Indicator Style:"
            model: ["Pills","Text","Custom Icons","Custom Text"]
        }
        RowLayout {
            visible: type.currentIndex == 0
            Kirigami.FormData.label: "Inactive:"
            PC3.SpinBox {
                id: t1width
                from: 1
                to: 99
            }
            PC3.Label { text: "*" }
            PC3.SpinBox {
                id: t1height
                from: 1
                to: 99
            }
        }
        RowLayout {
            visible: type.currentIndex == 0
            Kirigami.FormData.label: "Active:"
            PC3.SpinBox {
                id: t1activeWidth
                from: 1
                to: 99
            }
            PC3.Label { text: "*" }
            PC3.SpinBox {
                id: t1activeHeight
                from: 1
                to: 99
            }
        }
        PC3.TextField {
            id: template
            visible: type.currentIndex == 1
            Kirigami.FormData.label: "Text template:"
        }
        PC3.Label {
            visible: template.visible
            text:` Replacements:
            %d - Desktop number
            %name - Desktop name
            %roman - Roman numerals
            `
        }
        PC3.SpinBox {
            id: fixedLen
            visible: type.currentIndex > 0
            Kirigami.FormData.label: "Fixed length:"
            from: 1
            to: 1000
            editable: true
        }
        PC3.CheckBox {
            visible: type.currentIndex == 1 || type.currentIndex == 3
            id: asteriskCheck
            Kirigami.FormData.label: "Add asterisk(*) for active window available:"
        }
        PC3.CheckBox {
            visible: type.currentIndex == 1 || type.currentIndex == 3
            id: boldCheck
            Kirigami.FormData.label: "Bold active title:"
        }
        PC3.CheckBox {
            visible: type.currentIndex == 1 || type.currentIndex == 3
            id: italicCheck
            Kirigami.FormData.label: "Italicize active title:"
        }
        PC3.TextArea {
            visible: type.currentIndex == 2
            id: customIcons
            placeholderText: "format-text-code\ninternet-services\nmusic-note-16th"
            Kirigami.FormData.label: "Custom icon ids:"
        }
        PC3.TextField {
            visible: type.currentIndex == 2
            id: customIconsOther
            placeholderText: "desktop-symbolic"
            Kirigami.FormData.label: "When extra desktops:"
        }
        PC3.TextArea {
            visible: type.currentIndex == 3
            id: customLabels
            placeholderText: "One konqi\nTwo konqis\nThree konqis"
            Kirigami.FormData.label: "Custom labels:"
        }
        PC3.TextField {
            visible: type.currentIndex == 3
            id: customLabelsOther
            placeholderText: "D%d"
            Kirigami.FormData.label: "When extra desktops:"
        }

        // ----------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Highlight Settings"
        }
        QQC2.ComboBox {
            id: hType
            Kirigami.FormData.label: "Highlight Style:"
            model: ["None","Line","Square","Full","Full with Line"]
        }
        PC3.CheckBox {
            id: slightHighlight
            Kirigami.FormData.label: "Semi-highlight desktop with\nactive windows:"
        }
    }
}

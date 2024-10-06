import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import QtQuick.Controls as QQC2
import "../Common/" as Common
import org.kde.kquickcontrols as KQuickControls

Kirigami.ScrollablePage {
    title: i18nc("@title","General")

    //Types-----------------------------------
    property alias cfg_type: type.style
    property alias cfg_highlightType: hType.currentIndex
    //Dimensions
    property alias cfg_spacing: spacing.value
    property alias cfg_t1width: pillDimen.w
    property alias cfg_t1height: pillDimen.h
    property alias cfg_t1activeHeight: activePillDimen.h
    property alias cfg_t1activeWidth: activePillDimen.w
    property alias cfg_fixedLen: fixedLen.value
    property alias cfg_t1radius: t1radius.value
    //Custom Lists
    property alias cfg_iconsList: customIcons.text
    property alias cfg_labelsList: customLabels.text
    property alias cfg_labelExtra: extraCustomLabel.text
    property alias cfg_iconExtra: extraCustomIcon.text
    //Decorations
    //Other
    property alias cfg_template: template.text
    property alias cfg_labelSource: labelSource.currentIndex
    property alias cfg_beforeTemplate: beforeTemplate.text
    property alias cfg_afterTemplate: afterTemplate.text
    property alias cfg_activeTemplate: activeTemplate.text
    property alias cfg_allowLabelRotate: allowLabelRotate.checked

    property string substituteText: '\n<b>Replacements:</b>\n%d - Desktop number\n%name - Desktop name\n%roman - Roman numerals'

    Kirigami.FormLayout {
        anchors.fill: parent
        wideMode: true

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Layout Settings"
        }
        Common.PixelSlider {
            id: spacing
            Kirigami.FormData.label: "Spacing:"
            from: 0
            to: 20
        }
        Common.PixelDimensions {
            id: pillDimen
            from: 1
            Kirigami.FormData.label: "Inactive:"
            visible: cfg_type == 0
        }
        Common.PixelDimensions {
            id: activePillDimen
            from: 1
            Kirigami.FormData.label: "Active:"
            visible: cfg_type == 0
        }
        PC3.Slider {
            id: t1radius
            from: 0
            to: 5
            stepSize: 0.5
            visible: cfg_type == 0
            Kirigami.FormData.label: "Pill radius:"
        }
        Common.PixelSlider {
            visible: cfg_type > 0
            Kirigami.FormData.label: "Fixed length:"
            id: fixedLen
            from: 1
            to: 150
        }
        PC3.CheckBox {
            visible: cfg_type == 1
            id: allowLabelRotate
            Kirigami.FormData.label: "Rotate Label for vertical panels:"
        }


        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Indicator Settings"
        }
        RowLayout {
            id: type
            Kirigami.FormData.label: "Indicator Style:"
            property int style
            PC3.RadioButton {
                text: "Pills"
                checked: type.style == 0
                onCheckedChanged: if(checked) type.style = 0
            }
            PC3.RadioButton {
                text: "Text"
                checked: type.style == 1
                onCheckedChanged: if(checked) type.style = 1
            }
            PC3.RadioButton {
                text: "Icons"
                checked: type.style == 2
                onCheckedChanged: if(checked) type.style = 2
            }
        }
        QQC2.ComboBox {
            id: labelSource
            visible: cfg_type == 1
            Kirigami.FormData.label: "Label source:"
            model: ["Desktop number","Desktop Name",
            "Custom Template","Before-After Templates",
            "Pre-defined Templates","Roman Numerals",
            "Hindu-Arabic Numerals","Chinese Numerals"]
        }
        PC3.TextField {
            id: template
            visible: cfg_type == 1 && cfg_labelSource== 2
            Kirigami.FormData.label: "Custom Template:"
        }
        PC3.TextField {
            id: beforeTemplate
            visible: cfg_type == 1 && cfg_labelSource == 3
            Kirigami.FormData.label: "Before Active Template:"
        }
        PC3.TextField {
            id: activeTemplate
            visible: cfg_type == 1 && cfg_labelSource == 3
            Kirigami.FormData.label: "Active Template:"
        }
        PC3.TextField {
            id: afterTemplate
            visible: cfg_type == 1 && cfg_labelSource == 3
            Kirigami.FormData.label: "After Active Template:"
        }
        PC3.TextArea {
            id: customLabels
            Kirigami.FormData.label: "Custom labels:"
            visible: cfg_type == 1 && cfg_labelSource == 4
            placeholderText: "One konqi\nTwo konqis\nThree konqis"
        }
        PC3.TextField {
            id: extraCustomLabel
            Kirigami.FormData.label: "Extra label:"
            visible: cfg_type == 1 && cfg_labelSource == 4
            placeholderText: "D%d"
        }
        PC3.Label {
            visible: cfg_type == 1 && (cfg_labelSource == 4
            || cfg_labelSource == 3 || cfg_labelSource == 2)
            Kirigami.FormData.label: "Replacements for templates:"
            Kirigami.FormData.labelAlignment: Qt.AlignTop
            text: "<b>%d</b>: Desktop Number<br>
            <b>%name</b>: Desktop Name<br>
            <b>%roman</b>: Roman Numerals<br>
            <b>%hindu</b>: Hindu-Arabic Numerals<br>
            <b>%chinese</b>: Chinese/Mandarin Numerals"
        }




        RowLayout {
            Kirigami.FormData.label: "Custom icons:"
            visible: cfg_type == 2
            PC3.TextArea {
                id: customIcons
                placeholderText: "format-text-code\ninternet-services\nmusic-note-16th"
            }
            Common.InfoButton {
                txt: 'Use an icon explorer like <b>Cuttlefish</b> to look for icon IDs.\n'+
                'First icon goes to the first desktop and so on.\n'+
                'If an icon name is wrong, it will fallback to the extra icon.'
            }
        }
        RowLayout {
            Kirigami.FormData.label: "Extra icon:"
            visible: cfg_type == 2
            PC3.TextField {
                id: extraCustomIcon
                placeholderText: "desktop-symbolic"
            }
            Common.InfoButton {
                txt: `This icon will be shown when the desktop IDs you entered are less than open desktops.`
            }
        }
        //For Custom Text Type-----------------------------------------
        // ----------------------------------------
        // Highlight Settings
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Highlight Settings"
        }
        QQC2.ComboBox {
            id: hType
            Kirigami.FormData.label: "Highlight Style:"
            model: ["None","Line","Square","Full","Full with Line"]
        }
    }
}

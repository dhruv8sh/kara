import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3

Kirigami.ScrollablePage {
    property alias cfg_wrapOn: wrap.checked
    property alias cfg_animationDuration: animTime.value
    property alias cfg_blinkOnAttentionRequired: blinkOnAttentionRequired.checked
    property alias cfg_highlightOnHover: hoveringShowsHighlight.checked
    property alias cfg_tooltipOnHover: hoveringShowsTooltip.checked
    title: i18nc("@title","General")
    Kirigami.FormLayout {
        anchors.fill: parent
        wideMode: true
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Mouse Actions"
        }
        PC3.CheckBox {
            Kirigami.FormData.label: i18n("Hovering reveals highlight:")
            id: hoveringShowsHighlight
        }
        PC3.CheckBox {
            Kirigami.FormData.label: i18n("Hovering reveals tooltip:")
            id: hoveringShowsTooltip
        }
        PC3.CheckBox {
            id: wrap
            Kirigami.FormData.label: i18n("Wraparound when scrolling:")
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Animations"
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Animation Duration:")
            PC3.Slider {
                id: animTime
                from: 0
                to: 1000
                stepSize: 10
                live: true
            }
            PC3.Label {
                text: animTime.value +"ms"
            }
        }
        PC3.CheckBox {
            id: blinkOnAttentionRequired
            Kirigami.FormData.label: "Blink when attention required:\n(This will not work when highlights are disabled)"
            Kirigami.FormData.labelAlignment: Qt.AlignTop
        }
    }
}

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3

Kirigami.ScrollablePage {
    property alias cfg_wrapOn: wrap.checked
    title: i18nc("@title","General")
    Kirigami.FormLayout {
        anchors.fill: parent
        PC3.CheckBox {
            id: wrap
            Kirigami.FormData.label: i18n("Wraparound destkops:")
        }
    }
}

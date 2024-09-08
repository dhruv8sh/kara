import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
Rectangle {
    id: full
    anchors.fill: parent
    color: root.pColor
    z: -2
    property alias op: full.opacity
    Behavior on opacity {
        NumberAnimation {
            duration: 500
        }
    }
}

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
Rectangle {
    id: full
    anchors.fill: parent
    z: -2
    property alias op: full.opacity
    property alias col: full.color
    Behavior on opacity {
        NumberAnimation {
            duration: cfg.animationDuration
        }
    }
}

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
Rectangle {
    id: full
    anchors.fill: parent
    color: (curr_page==pos||cfg.plasmaSemiColors)?root.pColor:cfg.semiColor
    z: -2
    property alias op: full.opacity
    Behavior on opacity {
        NumberAnimation {
            duration: cfg.animationDuration
        }
    }
}

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Rectangle {
    id: sq
    anchors.fill: parent
    color: "transparent"
    opacity: op
    property alias op: sq.opacity
    property alias col: rect.color
    Rectangle {
        id: rect
        anchors.centerIn: parent
        height: cfg.sqDefaultSize ? parent.height * 0.95 : cfg.sqHighlightHeight
        width : cfg.sqDefaultSize ? parent.width  * 0.95 : cfg.sqHighlightWidth
        radius: height*0.22
        z: -1
    }
    Behavior on opacity {
        NumberAnimation {
            duration: cfg.animationDuration
        }
    }
}

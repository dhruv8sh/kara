import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Rectangle {
    id: sq
    anchors.fill: parent
    color: "transparent"
    opacity: op
    property alias op: sq.opacity
    Rectangle {
        anchors.centerIn: parent
        height: cfg.sqDefaultSize ? parent.height * 0.8 : cfg.sqHighlightHeight
        width : cfg.sqDefaultSize ? parent.width  * 0.8 : cfg.sqHighlightWidth
        onHeightChanged: console.log(height)
        radius: height*0.22
        color: root.pColor
        z: -1
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 500
        }
    }
}

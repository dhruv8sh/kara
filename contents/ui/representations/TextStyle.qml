import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import "../Utils.js" as Utils
import org.kde.taskmanager as TaskManager
import org.kde.plasma.core as PlasmaCore

Rectangle {
    id: textStyle
    z: 5
    color: "transparent"
    rotation: {
        if(is_vertical && cfg.allowLabelRotate) {
            if(location === PlasmaCore.Types.LeftEdge) return -90
            else if(location === PlasmaCore.Types.RightEdge) return 90
        } else return 0
    }
    anchors.centerIn: parent

    width: is_vertical ? root.width : Math.max(root.height,cfg.fixedLen)
    height: is_vertical ? Math.max(root.width,cfg.fixedLen) : root.height

    Component.onCompleted:  updateGeometry(width, height)
    onWidthChanged:         updateGeometry(width, height)
    onHeightChanged:        updateGeometry(width, height)

    PC3.Label {
        id: label
        anchors.centerIn: parent
        z: 5
        text: Utils.getLabel(pos,curr_page) + (hasWindows&&cfg.addAsterisk?" *":"")
        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        elide: Text.ElideLeft
        width: is_vertical ? parent.height:parent.width
        color: contentColor
        font {
            bold: curr_page == pos ? cfg.activeBold : cfg.bold
            italic: curr_page == pos ? cfg.activeItalic : cfg.italic
            pixelSize: curr_page == pos ? cfg.activeFontSize : cfg.fontSize
            Behavior on pixelSize {NumberAnimation { duration: cfg.animationDuration }}
        }
    }
}

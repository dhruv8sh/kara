import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import "../highlights/" as Highlights
import "../Common/" as Common
import "../Utils.js" as Utils
import org.kde.taskmanager as TaskManager

Rectangle {
    id: iconStyle
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
    height: is_vertical ? Math.max(icon.width,cfg.fixedLen) : root.height

    Component.onCompleted:  updateGeometry(width, height)
    onWidthChanged:         updateGeometry(width, height)
    onHeightChanged:        updateGeometry(width, height)

    Kirigami.Icon {
        id: icon
        z: 5
        source: (root.customIcons[pos] ?? cfg.iconExtra).trim()
        fallback: cfg.iconExtra.trim()
        anchors.centerIn: parent
        height: Math.min(parent.width, parent.height)
        width: height
        color: contentColor
    }
}

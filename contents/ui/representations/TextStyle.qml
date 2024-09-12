import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import "../Utils.js" as Utils
import "../Common" as Common
import org.kde.taskmanager as TaskManager
import org.kde.plasma.core as PlasmaCore

Rectangle {
    id: cont
    z: 5
    property int pos
    property bool hasActiveWindow: tasksModel.count>0
    property alias attentionRequired: tasksModel.anyTaskDemandsAttention
    property real prevLen: 0
    property int rotate: {
        if(is_vertical && cfg.allowLabelRotate) {
            if(location === PlasmaCore.Types.LeftEdge) return -90
            else if(location === PlasmaCore.Types.RightEdge) return 90
        } else return 0
    }
    color: "transparent"
    Layout.fillWidth: is_vertical
    Layout.fillHeight: !is_vertical

    Component.onCompleted: reptRect.updateGeometry(width, height)
    onWidthChanged: reptRect.updateGeometry(width, height)
    onHeightChanged: reptRect.updateGeometry(width, height)

    width: is_vertical ? root.width : Math.max(root.height,cfg.fixedLen)
    height: is_vertical ? Math.max(label.height,cfg.fixedLen) : root.height

    Behavior on width   { NumberAnimation { duration: cfg.animationDuration }}
    Behavior on height  { NumberAnimation { duration: cfg.animationDuration }}
    Behavior on opacity { NumberAnimation { duration: cfg.animationDuration }}

    TapHandler {
        onTapped: pagerModel.changePage(pos)
    }

    TaskManager.TasksModel {
        id: tasksModel
        activity: activityInfo.currentActivity
        virtualDesktop: virtualDesktopInfo.desktopIds[pos]
        filterByVirtualDesktop: true
        filterByActivity: true
    }
    PC3.Label {
        id: label
        anchors.centerIn: cont
        z: 5
        text: Utils.getLabel(pos,curr_page) + (hasActiveWindow&&cfg.addAsterisk?" *":"")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        width: rotate == 0 ? parent.width : parent.height
        elide: Text.ElideLeft
        color: curr_page == pos && !cfg.defaultAltTextColors? cfg.altColor : root.txtColor
        rotation: rotate
        font {
            bold: curr_page == pos ? cfg.activeBold : cfg.bold
            italic: curr_page == pos ? cfg.activeItalic : cfg.italic
            pixelSize: curr_page == pos ? cfg.activeFontSize : cfg.fontSize
            Behavior on pixelSize {NumberAnimation { duration: cfg.animationDuration }}
        }
    }
    Common.HighlightLoader{}
}


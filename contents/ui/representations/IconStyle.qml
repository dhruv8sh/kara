import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import "../highlights/" as Highlights
import "../Common/" as Common
import "../Utils.js" as Utils
import org.kde.taskmanager as TaskManager

Rectangle {
    id: cont
    z: 5
    property int pos
    property bool hasActiveWindow: tasksModel.count>0
    property alias attentionRequired: tasksModel.anyTaskDemandsAttention
    Layout.fillWidth: is_vertical
    Layout.fillHeight: !is_vertical
    color: "transparent"
    clip: false

    Component.onCompleted: reptRect.updateGeometry(width, height)
    onWidthChanged: reptRect.updateGeometry(width, height)
    onHeightChanged: reptRect.updateGeometry(width, height)

    width:  is_vertical ? root.width : Math.max(root.height,cfg.fixedLen)
    height: is_vertical ? Math.max(root.width,cfg.fixedLen) : root.height

    Behavior on width   { NumberAnimation { duration: 300 }}
    Behavior on height  { NumberAnimation { duration: 300 }}
    Behavior on opacity { NumberAnimation { duration: 300 }}

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
    Kirigami.Icon {
        z: 5
        source: (root.customIcons[pos] ?? cfg.iconExtra).trim()
        fallback: cfg.iconExtra.trim()
        anchors.centerIn: parent
        height: Math.min(parent.width, parent.height)
        width: height
        color: curr_page == pos && !cfg.defaultAltTextColors? cfg.altColor : root.txtColor
    }
    Common.HighlightLoader{}
}


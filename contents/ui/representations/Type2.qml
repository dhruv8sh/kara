import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import "../Utils.js" as Util
import "../Common" as Common
import org.kde.taskmanager as TaskManager

Rectangle {
    id: cont
    z: 5
    property int pos
    property bool hasActiveWindow: tasksModel.count>0
    property real prevLen: 0
    color: "transparent"
    Layout.fillWidth: is_vertical
    Layout.fillHeight: !is_vertical

    Component.onCompleted: {
        reptRect.updateGeometry(width, height)
    }
    onWidthChanged: {
        reptRect.updateGeometry(width, height)
    }
    onHeightChanged: {
        reptRect.updateGeometry(width, height)
    }

    width: is_vertical ? root.width : Math.max(root.height,cfg.fixedLen)
    height: is_vertical ? Math.max(label.height,cfg.fixedLen) : root.height

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
    PC3.Label {
        id: label
        anchors.centerIn: cont
        z: 5
        text: cfg.template
            .replace("%d",pos+1)
            .replace("%roman",Util.get_roman(pos))
            .replace("%name",virtualDesktopInfo.desktopNames[pos])
            + (cfg.addAsterisk && hasActiveWindow ? " *":"")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        width: parent.width
        elide: Text.ElideLeft
        color: root.txtColor
        font {
            bold: cfg.t2bold && curr_page == pos
            italic: cfg.t2italic && curr_page == pos
        }
    }
    Common.HighlightLoader{}
}


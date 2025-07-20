import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import org.kde.taskmanager as TaskManager
import "./Utils.js" as Utils


Rectangle {
    id: reptRect
    visible: root.showOnlyActive ? (hasWindows || isActive) : true
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    color: "transparent"
    function updateGeometry(w,h) {
        reptRect.Layout.minimumHeight = h
        reptRect.Layout.maximumHeight = h
        reptRect.Layout.minimumWidth = w
        reptRect.Layout.maximumWidth = w
    }

    property int pos: 0
    property bool isActive: curr_page == pos
    property var abstractTasksModel: TaskManager.AbstractTasksModel
    property var isWindow: abstractTasksModel.IsWindow
    property int taskCount: 0
    property bool hasWindows: taskCount>0
    property bool needsAttention: tasksModel.anyTaskDemandsAttention
    property alias hovered: mouseArea.containsMouse
    property var contentColor: {
        if(isActive) return cfg.defaultAltTextColors
        ? Kirigami.Theme.textColor
        : cfg.altColor
        else return cfg.plasmaTxtColors
        ? Kirigami.Theme.textColor
        : cfg.txtColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: pagerModel.changePage(pos)
        acceptedButtons: Qt.LeftButton
        hoverEnabled: true
    }

    TaskManager.TasksModel {
        id: tasksModel
        activity: activityInfo.currentActivity
        virtualDesktop: virtualDesktopInfo.desktopIds[pos]
        filterByVirtualDesktop: true
        filterByActivity: true
        onCountChanged: {
            Qt.callLater(function() {
                Utils.updateTaskCount(reptRect, tasksModel)
            })
        }
    }
    Loader {
        id: reptLoader
        anchors.centerIn: parent
        source: Utils.getRepSource()
        onLoaded: item.widthChanged()
    }
    ToolTip {
        visible: cfg.tooltipOnHover && hovered
        text: virtualDesktopInfo.desktopNames[pos]
        delay: 2000
        timeout: 3000
    }
}

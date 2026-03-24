import org.kde.plasma.plasma5support as Plasma5Support
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
    property var virtualDesktopsRole: abstractTasksModel.VirtualDesktops
    property var demandsAttentionRole: abstractTasksModel.DemandsAttention
    property int taskCount: 0
    property bool hasWindows: taskCount>0
    property bool hasDemandingWindow: false
    property bool highlightActive: cfg.type != 0 && cfg.highlightType != 0
    property bool needsAttention: hasDemandingWindow
    property real highlightOpacity: Utils.getHighlightOpacity()
    property alias hovered: mouseArea.containsMouse
    property var highlightColor:  {
        if(isActive) return cfg.plasmaStyleColors
        ? Kirigami.Theme.highlightColor
        : cfg.pColor
        else return cfg.plasmaSemiColors
        ? Kirigami.Theme.highlightColor
        : cfg.semiColor
    }
    property var contentColor: {
        if(isActive) return cfg.defaultAltTextColors
        ? Kirigami.Theme.textColor
        : cfg.altColor
        else return cfg.plasmaTxtColors
        ? Kirigami.Theme.textColor
        : cfg.txtColor
    }

    Timer {
        id: blinkTimer
        interval: 1000
        running: hasDemandingWindow && cfg.blinkOnAttentionRequired
        onTriggered: highlightOpacity==0?1:0
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: executable.connectSource("qdbus6 org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.current " + virtualDesktopInfo.desktopIds[pos])
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
                Utils.updateTaskCount()
            })
        }
    }
    Loader {
        id: reptLoader
        anchors.centerIn: parent
        source: Utils.getRepSource()
        onLoaded: item.widthChanged()
    }
    HighlightLoader{}
    ToolTip {
        visible: cfg.tooltipOnHover && hovered
        text: virtualDesktopInfo.desktopNames[pos]
        delay: 2000
        timeout: 3000
    }
    Plasma5Support.DataSource {
        id: "executable"
        engine: "executable"
        connectedSources: []
        onNewData: function(sourceName, data) { disconnectSource(sourceName) }
    }
}

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore

Rectangle {
    anchors.fill: parent
    color: "transparent"
    property alias op: hRect.opacity
    property alias fill: fullRect.visible
    property var col
    onOpChanged: fullRect.opacity = op - 0.3
    opacity: 1
    Rectangle {
        id: fullRect
        anchors.fill: parent
        color: parent.col
        opacity: op - 0.3
        visible: false
    }
    Rectangle {
        id: hRect
        color: parent.col
        radius: height * cfg.highlightLineRadius
        height: cfg.highlightLineDefault?(is_vertical?parent.height:3):(is_vertical?cfg.highlightLineW:cfg.highlightLineH)
        width:  cfg.highlightLineDefault?(is_vertical?3:parent.width ):(is_vertical?cfg.highlightLineH:cfg.highlightLineW)
        states: [
            State {
                name: "leftPanel"; when: plasmoid.location === PlasmaCore.Types.LeftEdge
                AnchorChanges {
                    target: hRect
                    anchors.right: parent.right
                    anchors.top: undefined
                    anchors.left: undefined
                    anchors.bottom: undefined
                    anchors.horizontalCenter: undefined
                    anchors.verticalCenter: parent.verticalCenter
                }
            },State {
                name: "rightPanel"; when: plasmoid.location === PlasmaCore.Types.RightEdge
                AnchorChanges {
                    target: hRect
                    anchors.right: undefined
                    anchors.top: undefined
                    anchors.left: parent.left
                    anchors.bottom: undefined
                    anchors.horizontalCenter: undefined
                    anchors.verticalCenter: parent.verticalCenter
                }
            },State {
                name: "topPanel"; when: plasmoid.location === PlasmaCore.Types.TopEdge
                AnchorChanges {
                    target: hRect
                    anchors.right: undefined
                    anchors.top: undefined
                    anchors.left: undefined
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: undefined
                }
            },State {
                name: "bottomPanel"; when: plasmoid.location === PlasmaCore.Types.BottomEdge
                AnchorChanges {
                    target: hRect
                    anchors.right: undefined
                    anchors.top: parent.top
                    anchors.left: undefined
                    anchors.bottom: undefined
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: undefined
                }
            }
        ]
    }
    Behavior on op{
        NumberAnimation {
            duration: cfg.animationDuration
        }
    }
}

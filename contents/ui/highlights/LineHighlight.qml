import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore

Rectangle {
    anchors.fill: parent
    color: "transparent"
    property alias op: hRect.opacity
    property alias fill: fullRect.visible
    onOpChanged: fullRect.opacity = op - 0.3
    opacity: 1
    Rectangle {
        id: fullRect
        anchors.fill: parent
        color: root.pColor
        opacity: op - 0.3
        visible: false
    }
    Rectangle {
        id: hRect
        color : root.pColor
        radius: 3
        states: [
            State {
                name: "leftPanel"; when: plasmoid.location === PlasmaCore.Types.LeftEdge
                AnchorChanges {
                    target: hRect
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: undefined
                }
                PropertyChanges {
                    target: hRect
                    width: 3
                }
            },State {
                name: "rightPanel"; when: plasmoid.location === PlasmaCore.Types.RightEdge
                AnchorChanges {
                    target: hRect
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: undefined
                }
                PropertyChanges {
                    target: hRect
                    width: 3
                }
            },State {
                name: "topPanel"; when: plasmoid.location === PlasmaCore.Types.TopEdge
                AnchorChanges {
                    target: hRect
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.top: undefined
                }
                PropertyChanges {
                    target: hRect
                    height: 3
                }
            },State {
                name: "bottomPanel"; when: plasmoid.location === PlasmaCore.Types.BottomEdge
                AnchorChanges {
                    target: hRect
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: undefined
                }
                PropertyChanges {
                    target: hRect
                    height: 3
                }
            }
        ]
    }
    Behavior on op{
        NumberAnimation {
            duration: 300
        }
    }
}

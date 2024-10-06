import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

// NOT READY YET!
Rectangle {
    id: pill
    z: 5
    anchors.fill: parent
    opacity: isActive || !cfg.plasmaStyleColors ? 1 : 0.5
    color: "transparent"
    radius: (cfg.t1radius/10) * height
    width:  Math.min(root.width,grid.width)
    height: Math.min(root.height,grid.height)

    Component.onCompleted:  updateGeometry(grid.width, Math.min(grid.height,root.height))
    onWidthChanged:         updateGeometry(grid.width, Math.min(grid.height,root.height))
    onHeightChanged:        updateGeometry(grid.width, Math.min(grid.height,root.height))

    Behavior on width   {NumberAnimation{duration: cfg.animationDuration}}
    Behavior on height  {NumberAnimation{duration: cfg.animationDuration}}
    Behavior on opacity {NumberAnimation{duration: cfg.animationDuration}}
    Behavior on radius  {NumberAnimation{duration: cfg.animationDuration}}

    RowLayout {
        id: grid
        anchors.centerIn: parent
        Kirigami.Icon {
            source: "edit-clear-all"
        }
        Repeater {
            model: tasksModel.count
            delegate: Kirigami.Icon {
                source: tasksModel.sourceModel[index].icon
                fallback: "edit-clear"
                Component.onCompleted: console.log(tasksModel.sourceModel[index])
            }
        }
    }
}

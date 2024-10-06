import QtQuick
import QtQuick.Layouts

//Need a new component here because anchors.fill: parent
//makes it invisible inside the ParentRectangle
Loader {
    id: loader
    z: -5
    anchors.fill: parent
    active: highlightActive
    visible: active
    asynchronous: true
    source: {
        switch(cfg.highlightType) {
            case 1: return "highlights/LineHighlight.qml"
            case 2: return "highlights/SquareHighlight.qml"
            case 3: return "highlights/FullHighlight.qml"
            case 4: return "highlights/FullHighlightWithLine.qml"
            default: return null
        }
    }
    Binding {
        target: loader.item
        property: "op"
        value: highlightOpacity
        when: loader.status == Loader.Ready
    }
    Binding {
        target: loader.item
        property: "col"
        value: highlightColor
    }
}

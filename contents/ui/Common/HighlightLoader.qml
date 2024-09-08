import QtQuick
import QtQuick.Layouts

Loader {
    id: loader
    anchors.fill: parent
    asynchronous: true
    source: {
        switch(cfg.highlightType) {
            case 1: return "../highlights/LineHighlight.qml"
            case 2: return "../highlights/SquareHighlight.qml"
            case 3: return "../highlights/FullHighlight.qml"
            case 4: return "../highlights/FullHighlightWithLine.qml"
            default: return null
        }
    }
    onLoaded: item.opacity = op
    Binding {
        target: loader.item
        property: "op"
        value: {
            if(curr_page==pos) return 1
            else if(hasActiveWindow && cfg.slightlyHighlight) return 0.4
            else return 0
        }
        when: loader.status == Loader.Ready
    }
}

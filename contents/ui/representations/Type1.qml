import QtQuick
import org.kde.plasma.components
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid

Rectangle {
    id: pill
    z: 5
    property int pos
    property int cfg.spacing: 3
    property real prevLen: 0

    opacity: curr_page == pos || !(cfg.plasmaStyleColors||cfg.accentStyleColors)? 1 : 0.5
    color: root.txtColor
    radius: height * 0.5
    Component.onDestruction: len -= width + cfg.spacing
    onWidthChanged: {
        if(!is_vertical) {
            len += width + cfg.spacing
            len -= prevLen
            prevLen = width + cfg.spacing
        }
    }
    onHeightChanged: {
        if(is_vertical) {
            len += height + cfg.spacing - prevLen
            prevLen = height + cfg.spacing
        }
    }

    TapHandler {
        onTapped: pagerModel.changePage(pos)
    }

    Behavior on x {
        NumberAnimation {
            duration: !is_vertical?200:0
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: !is_vertical?0:200
        }
    }
    Behavior on width {
        NumberAnimation {
            duration: 200
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 200
        }
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 300
        }
    }
    states: [
        State {
            name: "horizontalActive"
            when: !is_vertical && curr_page == pos
            PropertyChanges{
                target: pill
                width: cfg.t1activeWidth
                height: cfg.t1activeHeight
                y: (root.height - cfg.t1activeHeight)/2
                x: pos * (cfg.t1width+cfg.spacing)
                opacity: 1
            }
        },State {
            name: "horizontalInactive"
            when: !is_vertical && curr_page != pos
            PropertyChanges{
                target: pill
                height: cfg.t1height
                width: cfg.t1width
                y: (root.height - height)/2
                x: curr_page < pos ? pos*(cfg.t1width+cfg.spacing)+cfg.t1activeWidth-cfg.t1width : pos * (cfg.t1width+spacing)
                opacity: 0.5
            }
        },State {
            name: "verticalActive"
            when: !!is_vertical && curr_page == pos
            PropertyChanges{
                target: pill
                width: cfg.t1activeHeight
                height: cfg.t1activeWidth
                y: pos * (cfg.t1width+cfg.spacing)
                x: (root.width - cfg.t1activeHeight)/2
                opacity: 1
            }
        },State {
            name: "verticalInactive"
            when: !!is_vertical && curr_page != pos
            PropertyChanges{
                target: pill
                y : curr_page < pos ? pos*(cfg.t1width+cfg.spacing)+cfg.t1activeWidth-cfg.t1width : pos*(cfg.t1width+spacing)
                x: (root.width - cfg.t1height)/2
                width: cfg.t1width
                height: cfg.t1height
                opacity: 0.5
            }
        }
    ]
}

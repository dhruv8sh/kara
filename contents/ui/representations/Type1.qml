import QtQuick
import org.kde.plasma.components
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid

Rectangle {
    id: pill
    z: 5
    property int pos
    property real prevLen: 0
    anchors.centerIn: parent
    opacity: curr_page == pos || !(cfg.plasmaStyleColors||cfg.accentStyleColors)? 1 : 0.5
    color: root.txtColor
    radius: height * 0.5
    
    Component.onCompleted: {
        reptRect.updateGeometry(width, height)
    }
    onWidthChanged: {
        reptRect.updateGeometry(width, height)
    }
    onHeightChanged: {
        reptRect.updateGeometry(width, height)
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
                opacity: 1
            }
        },State {
            name: "horizontalInactive"
            when: !is_vertical && curr_page != pos
            PropertyChanges{
                target: pill
                height: cfg.t1height
                width: cfg.t1width
                opacity: 0.5
            }
        },State {
            name: "verticalActive"
            when: !!is_vertical && curr_page == pos
            PropertyChanges{
                target: pill
                width: cfg.t1activeHeight
                height: cfg.t1activeWidth
                opacity: 1
            }
        },State {
            name: "verticalInactive"
            when: !!is_vertical && curr_page != pos
            PropertyChanges{
                target: pill
                width: cfg.t1width
                height: cfg.t1height
                opacity: 0.5
            }
        }
    ]
}

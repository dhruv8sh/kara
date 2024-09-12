import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.private.pager
import org.kde.kcmutils as KCM
import org.kde.config as KConfig
import org.kde.plasma.core as PlasmaCore
import org.kde.taskmanager as TaskManager
import org.kde.activities as Activities
import org.kde.kirigami as Kirigami
import "./Utils.js" as Utils

PlasmoidItem {
    id: root
    preferredRepresentation     : fullRepresentation
    property var cfg            : plasmoid.configuration
    property var location       : plasmoid.location
    property var form           : plasmoid.formFactor
    property bool is_vertical   : form == PlasmaCore.Types.Vertical
    property alias curr_page    : pagerModel.currentPage
    property var pColor         : cfg.plasmaStyleColors ? Kirigami.Theme.highlightColor : cfg.pColor
    property var txtColor       : cfg.plasmaTxtColors ? Kirigami.Theme.textColor : cfg.txtColor
    property var customLabels   : cfg.labelsList.split('\n')
    property var customIcons    : cfg.iconsList.split('\n')

    clip: false

    //Scrolling should change the page/desktop/workspace
    ScrllHndl{ anchors.fill: parent }

    // Pager and Tasks Models (required)
    PagerModel {
        id: pagerModel
        enabled: true
        pagerType: PagerModel.VirtualDesktops;
    }
    TaskManager.VirtualDesktopInfo { id: virtualDesktopInfo }
    TaskManager.ActivityInfo { id: activityInfo }
    Activities.ActivityInfo { id: fullActivityInfo; activityId: ":current" }

    //Only this will be visible to the user
    fullRepresentation: GridLayout {
        columnSpacing: is_vertical ? 0 : cfg.spacing
        rowSpacing: 0//is_vertical ? cfg.spacing : 0
        columns: is_vertical ? 1 : pagerModel.count
        rows: is_vertical ? pagerModel.count : 1
        Repeater {
            id: rep
            model: pagerModel.count
            delegate: Rectangle {
                id: reptRect
                function updateGeometry(w, h) {
                    reptRect.Layout.preferredWidth = w
                    reptRect.Layout.preferredHeight = h
                }
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: "transparent"
                Loader {
                    source: {
                        switch(cfg.type) {
                            case 1: return "representations/TextStyle.qml"
                            case 2: return "representations/IconStyle.qml"
                            default: return "representations/PillStyle.qml"
                        }
                    }
                    onLoaded: item.pos = index
                }
            }
        }
    }

    //Contextual (Right-Click menu) actions
    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18n("Add Virtual Desktop")
            icon.name: "list-add"
            visible: KConfig.KAuthorized.authorize("kcm_kwin_virtualdesktops")
            onTriggered: pagerModel.addDesktop()
        },
        PlasmaCore.Action {
            text: i18n("Remove Virtual Desktop")
            icon.name: "list-remove"
            visible: KConfig.KAuthorized.authorize("kcm_kwin_virtualdesktops")
            enabled: pagerModel.count > 1
            onTriggered: pagerModel.removeDesktop()
        },
        PlasmaCore.Action {
            text: i18n("Configure Virtual Desktops…")
            icon.name: "systemsettings"
            visible: KConfig.KAuthorized.authorize("kcm_kwin_virtualdesktops")
            onTriggered: KCM.KCMLauncher.openSystemSettings("kcm_kwin_virtualdesktops")
        }
    ]
}

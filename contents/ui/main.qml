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
    property real len           : 0
    property real breadth       : Utils.get_breadth()
    property var pColor         : cfg.plasmaStyleColors ? Kirigami.Theme.highlightColor : cfg.pColor
    property var txtColor       : cfg.plasmaTxtColors ? Kirigami.Theme.textColor : cfg.txtColor
    property var customLabels   : cfg.labelsList.split('\n')
    property var customIcons    : cfg.iconsList.split('\n')


    Layout.minimumWidth     : Math.max(40,is_vertical?breadth:len)
    Layout.minimumHeight    : Math.max(40,is_vertical?len:breadth)
    Layout.maximumWidth     : Layout.minimumWidth
    Layout.maximumHeight    : Layout.minimumHeight

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
    fullRepresentation: Item{
        Repeater {
            id: rep
            model: pagerModel
            delegate: Loader {
                source: {
                    switch(cfg.type) {
                        case 1: return "representations/Type2.qml"
                        case 2: return "representations/Type3.qml"
                        case 3: return "representations/Type4.qml"
                        default: return "representations/Type1.qml"
                    }
                }
                onLoaded: item.pos = index
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

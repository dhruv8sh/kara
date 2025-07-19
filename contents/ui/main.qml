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
    property var customLabels   : cfg.labelsList.split('\n')
    property var customIcons    : cfg.iconsList.split('\n')

    function updateHighlightOpacity() {
        if (fullRepresentation && 
            fullRepresentation.sharedHighlightLoader && 
            fullRepresentation.sharedHighlightLoader.item && 
            typeof fullRepresentation.highlightOpacity === 'number') {
            fullRepresentation.sharedHighlightLoader.item.op = fullRepresentation.highlightOpacity;
        }
    }

    function updateHighlightColor() {
        if (fullRepresentation && 
            fullRepresentation.sharedHighlightLoader && 
            fullRepresentation.sharedHighlightLoader.item) {
            fullRepresentation.sharedHighlightLoader.item.col = cfg.plasmaStyleColors ? 
                Kirigami.Theme.highlightColor : cfg.pColor;
        }
    }

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
        id: gridLayout
        columnSpacing: is_vertical ? 0 : cfg.spacing
        rowSpacing: is_vertical ? cfg.spacing : 0
        columns: is_vertical ? 1 : pagerModel.count
        rows: is_vertical ? pagerModel.count : 1
        
        Repeater {
            id: rep
            model: pagerModel.count
            delegate: RepresentationRectangle {
                id: repRect
                property bool isActive: curr_page == index
            }
            onItemAdded: function(index,item){
                item.pos = index
            }
        }
        
        // Shared highlight component
        Loader {
            id: sharedHighlightLoader
            active: true
            source: {
                switch(cfg.highlightType) {
                    case 0: return "highlights/FullHighlight.qml"
                    case 1: return "highlights/FullHighlightWithLine.qml"
                    case 2: return "highlights/LineHighlight.qml"
                    case 3: return "highlights/SquareHighlight.qml"
                    case 4: return "representations/PillStyle.qml"
                    case 5: return "highlights/CanvasHighlight.qml"
                    case 6: return "highlights/SquigglyCircleHighlight.qml"
                    default: return "highlights/FullHighlight.qml"
                }
            }
            z: -1
            opacity: highlightOpacity
            
            // Smooth sliding animation when switching desktops
            Behavior on x {
                NumberAnimation {
                    duration: cfg.animationDuration
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on y {
                NumberAnimation {
                    duration: cfg.animationDuration
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on width {
                NumberAnimation {
                    duration: cfg.animationDuration
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on height {
                NumberAnimation {
                    duration: cfg.animationDuration
                    easing.type: Easing.OutCubic
                }
            }
            
            Binding {
                target: sharedHighlightLoader.item
                property: "col"
                value: cfg.plasmaStyleColors ? Kirigami.Theme.highlightColor : cfg.pColor
                when: sharedHighlightLoader.status == Loader.Ready
            }
            
            onLoaded: {
                root.updateHighlightColor();
                // Initialize highlight position when loaded
                if (rep.itemAt(curr_page)) {
                    sharedHighlightLoader.x = rep.itemAt(curr_page).x
                    sharedHighlightLoader.y = rep.itemAt(curr_page).y
                    sharedHighlightLoader.width = rep.itemAt(curr_page).width
                    sharedHighlightLoader.height = rep.itemAt(curr_page).height
                }
            }
            
            // Initialize highlight position when repeater items are ready
            Connections {
                target: rep
                function onItemAdded(index, item) {
                    if (index === curr_page && sharedHighlightLoader.active) {
                        // Use a timer to ensure the item is fully positioned
                        Qt.callLater(function() {
                            if (rep.itemAt(curr_page)) {
                                sharedHighlightLoader.x = rep.itemAt(curr_page).x
                                sharedHighlightLoader.y = rep.itemAt(curr_page).y
                                sharedHighlightLoader.width = rep.itemAt(curr_page).width
                                sharedHighlightLoader.height = rep.itemAt(curr_page).height
                            }
                        })
                    }
                }
            }
            
            // Blinking state for attention
            property bool blinkVisible: true
            
            // Shared highlight opacity property (moved outside Loader)
            property real highlightOpacity: {
                // Base opacity for active page
                let baseOpacity = 1
                // If rep or current item is not available, return 0
                if (!rep || rep.count === 0 || !rep.itemAt(curr_page)) {
                    return 0;
                }
                // Check if any representation needs attention for blinking
                if (cfg.blinkOnAttentionRequired) {
                    for (let i = 0; i < rep.count; i++) {
                        if (rep.itemAt(i) && rep.itemAt(i).needsAttention) {
                            // This will be handled by the blink timer
                            return baseOpacity * (blinkVisible ? 1 : 0)
                        }
                    }
                }
                // Check hover state for the current representation
                if (cfg.highlightOnHover && rep.itemAt(curr_page) && rep.itemAt(curr_page).hovered) {
                    return 0.4
                }
                // Check if current page has windows for slight highlight
                if (cfg.slightlyHighlight && rep.itemAt(curr_page) && rep.itemAt(curr_page).hasWindows) {
                    return 0.6
                }
                // Check if current page is active
                if (rep.itemAt(curr_page) && rep.itemAt(curr_page).isActive) {
                    return baseOpacity
                }
                return 0;
            }
            
            Timer {
                id: updateTimer
                interval: 50
                repeat: false
                onTriggered: root.updateHighlightOpacity();
            }
            
            Timer {
                id: blinkTimer
                interval: 1000
                running: {
                    if (!cfg.blinkOnAttentionRequired) return false
                    // Check if any representation needs attention
                    for (let i = 0; i < rep.count; i++) {
                        if (rep.itemAt(i) && rep.itemAt(i).needsAttention) {
                            return true
                        }
                    }
                    return false
                }
                onTriggered: {
                    gridLayout.blinkVisible = !gridLayout.blinkVisible;
                    root.updateHighlightOpacity();
                }
            }
            
            // Update position and opacity when current page changes
            Connections {
                target: pagerModel
                function onCurrentPageChanged() {
                    if (rep.itemAt(curr_page)) {
                        var newX = rep.itemAt(curr_page).x
                        var newY = rep.itemAt(curr_page).y
                        var newWidth = rep.itemAt(curr_page).width
                        var newHeight = rep.itemAt(curr_page).height
                        
                        sharedHighlightLoader.x = newX
                        sharedHighlightLoader.y = newY
                        sharedHighlightLoader.width = newWidth
                        sharedHighlightLoader.height = newHeight
                        root.updateHighlightOpacity();
                    }
                }
            }
            
            // Monitor hover state changes
            Connections {
                target: rep
                function onItemAdded(index, item) {
                    if (item && item.hovered !== undefined) {
                        item.hoveredChanged.connect(function() {
                            updateTimer.restart();
                            root.updateHighlightOpacity();
                        })
                    }
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

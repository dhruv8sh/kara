import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PC3

PC3.ToolButton {
    property alias txt: t.text
    icon.name: "help-about-symbolic"
    PC3.ToolTip {
        id: t
    }
}

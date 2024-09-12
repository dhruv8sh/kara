import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import org.kde.kquickcontrols as KQuickControls

RowLayout {
    property alias checked: useColor.checked
    property alias color: colorButton.color
    PC3.CheckBox {
        id: useColor
    }
    KQuickControls.ColorButton {
        id: colorButton
        enabled: !useColor.checked
    }
    PC3.Label {
        text: colorButton.color
        enabled: colorButton.enabled
    }
}

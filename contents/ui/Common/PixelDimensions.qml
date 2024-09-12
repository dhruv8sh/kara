import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3

RowLayout {
    property alias w: widthBox.value
    property alias h: heightBox.value
    property real from: 0
    property real to: 100
    property real stepSize: 5
    PC3.SpinBox {
        id: widthBox
        from: parent.from
        to: parent.to
    }
    PC3.Label {text:'*'}
    PC3.SpinBox {
        id: heightBox
        from: parent.from
        to: parent.to
    }
    PC3.Label {text:'px.'}
}

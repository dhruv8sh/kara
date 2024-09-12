import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PC3

RowLayout {
    property alias from: slider.from
    property alias to: slider.to
    property alias value: slider.value
    PC3.Slider {id: slider; stepSize:1}
    PC3.Label {text: value+"px."}
}

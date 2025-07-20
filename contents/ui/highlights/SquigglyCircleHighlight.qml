import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Rectangle {
    id: squigglyHighlight
    anchors.fill: parent
    color: "transparent"
    opacity: op
    property alias op: squigglyHighlight.opacity
    property alias col: canvas.highlightColor
    
    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        property color highlightColor: Kirigami.Theme.highlightColor
        property real rotationAngle: 0
        
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            
            // Clear canvas
            ctx.clearRect(0, 0, width, height)
            
            // Save context for rotation
            ctx.save()
            ctx.translate(width / 2, height / 2)
            ctx.rotate(rotationAngle)
            
            // Create squiggly circle path
            var radius = Math.min(width, height) / 2 * 0.7
            var segments = 36
            var amplitude = radius * 0.15
            var frequency = 6
            
            ctx.beginPath()
            
            for (var i = 0; i <= segments; i++) {
                var angle = (i / segments) * Math.PI * 2
                var squigglyRadius = radius + amplitude * Math.sin(angle * frequency)
                var x = Math.cos(angle) * squigglyRadius
                var y = Math.sin(angle) * squigglyRadius
                
                if (i === 0) {
                    ctx.moveTo(x, y)
                } else {
                    ctx.lineTo(x, y)
                }
            }
            
            ctx.closePath()
            
            // Create gradient fill
            var gradient = ctx.createRadialGradient(0, 0, 0, 0, 0, radius)
            var alpha = op * 0.8
            gradient.addColorStop(0, Qt.rgba(highlightColor.r, highlightColor.g, highlightColor.b, alpha))
            gradient.addColorStop(0.7, Qt.rgba(highlightColor.r, highlightColor.g, highlightColor.b, alpha * 0.6))
            gradient.addColorStop(1, Qt.rgba(highlightColor.r, highlightColor.g, highlightColor.b, alpha * 0.3))
            
            // Fill the squiggly circle
            ctx.fillStyle = gradient
            ctx.fill()
            
            // Add a subtle stroke
            ctx.strokeStyle = Qt.rgba(highlightColor.r, highlightColor.g, highlightColor.b, op * 0.9)
            ctx.lineWidth = 2
            ctx.stroke()
            
            // Restore context
            ctx.restore()
        }
        
        // Rotation animation timer
        Timer {
            interval: 50
            repeat: true
            running: op > 0
            onTriggered: {
                canvas.rotationAngle += 0.05
                if (canvas.rotationAngle > Math.PI * 2) {
                    canvas.rotationAngle = 0
                }
                canvas.requestPaint()
            }
        }
        
        // Repaint when color changes
        onHighlightColorChanged: requestPaint()
    }
    
    // Repaint when opacity changes
    onOpChanged: canvas.requestPaint()
    
    Behavior on opacity {
        NumberAnimation {
            duration: cfg.animationDuration
        }
    }
} 
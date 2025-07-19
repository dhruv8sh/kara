import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Rectangle {
    id: canvasHighlight
    anchors.fill: parent
    color: "transparent"
    opacity: op
    property alias op: canvasHighlight.opacity
    property alias col: canvas.highlightColor
    
    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        property color highlightColor: Kirigami.Theme.highlightColor
        property real animationProgress: 0
        
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            
            // Clear canvas
            ctx.clearRect(0, 0, width, height)
            
            // Create gradient
            var gradient = ctx.createRadialGradient(
                width / 2, height / 2, 0,
                width / 2, height / 2, Math.max(width, height) / 2
            )
            
            // Add gradient stops with animation
            var alpha = op * (0.3 + 0.4 * Math.sin(animationProgress * Math.PI * 2))
            gradient.addColorStop(0, Qt.rgba(highlightColor.r, highlightColor.g, highlightColor.b, alpha))
            gradient.addColorStop(0.7, Qt.rgba(highlightColor.r, highlightColor.g, highlightColor.b, alpha * 0.5))
            gradient.addColorStop(1, Qt.rgba(highlightColor.r, highlightColor.g, highlightColor.b, 0))
            
            // Draw the gradient circle
            ctx.fillStyle = gradient
            ctx.beginPath()
            ctx.arc(width / 2, height / 2, Math.max(width, height) / 2 * 0.8, 0, Math.PI * 2)
            ctx.fill()
            
            // Draw animated border
            if (op > 0.3) {
                ctx.strokeStyle = Qt.rgba(highlightColor.r, highlightColor.g, highlightColor.b, op * 0.8)
                ctx.lineWidth = 2
                ctx.beginPath()
                ctx.arc(width / 2, height / 2, Math.max(width, height) / 2 * 0.9, 
                       animationProgress * Math.PI * 2, (animationProgress + 0.5) * Math.PI * 2)
                ctx.stroke()
            }
        }
        
        // Animation timer for the canvas effects
        Timer {
            interval: 50
            repeat: true
            running: op > 0
            onTriggered: {
                canvas.animationProgress += 0.02
                if (canvas.animationProgress > 1) {
                    canvas.animationProgress = 0
                }
                canvas.requestPaint()
            }
        }
        
        // Repaint when opacity or color changes
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
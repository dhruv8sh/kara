import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasma5support as Plasma5Support

MouseArea {
    property int wheelDelta : 0

    acceptedButtons: Qt.MiddleButton
    //Open Grid View on middle Click
    onClicked: executable.connectSource('qdbus org.kde.kglobalaccel /component/kwin invokeShortcut \"Grid View\"')

    //Scroll Handler
    onWheel : wheel => {
        wheelDelta += wheel.angleDelta.y || wheel.angleDelta.x;
        let increment = 0;
        while (wheelDelta >= 120) {
            wheelDelta -= 120;
            increment++;
        }
        while (wheelDelta <= -120) {
            wheelDelta += 120;
            increment--;
        }
        while (increment !== 0) {
            if (increment < 0) {
                const nextPage = cfg.wrapOn? (curr_page + 1) % pagerModel.count :
                Math.min(curr_page + 1, pagerModel.count - 1);
                pagerModel.changePage(nextPage);
            } else {
                const previousPage = cfg.wrapOn? (pagerModel.count + curr_page - 1) % pagerModel.count :
                Math.max(curr_page - 1, 0);
                pagerModel.changePage(previousPage);
            }
            increment += (increment < 0) ? 1 : -1;
            wheelDelta = 0;
        }
    }
    Plasma5Support.DataSource {
        id: "executable"
        engine: "executable"
        connectedSources: []
        onNewData:function(sourceName, data){
            disconnectSource(sourceName)
        }
    }
}


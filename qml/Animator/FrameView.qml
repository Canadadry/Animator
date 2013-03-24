import QtQuick 2.0
import "Style"

Box{
    id:root
    property real  zoom: 1.0
    property alias model: frameRepeater.model

    Flickable{
	contentWidth:row.width
	contentHeight: row.height

	Row{
	    id:row
	    Repeater{
		id:frameRepeater
		Rectangle {
		    width: root.model.globalWidth*root.zoom
		    height: root.model.globalHeight*root.zoom
		    border.width: 1
		    color: root.model.frameSelected == index ? "red":"white"

		    Tile{
			anchors.centerIn: parent
			scale: root.zoom
			source: root.model.source;
			frameX:    m_frameX;
			frameY:    m_frameY;
			frameWidth: m_frameWidth;
			frameHeight: m_frameHeight;
		    }

		    MouseArea{
			anchors.fill: parent
			onClicked: root.model.frameSelected = (root.model.frameSelected === index)?-1:index
			onDoubleClicked: root.model.removeFrame(index)
		    }
		}
	    }

	    Rectangle {
		width: root.model.globalWidth*root.zoom
		height: root.model.globalHeight*root.zoom
		border.width: 1
		color: ma_add.pressed ? "red":"white"

		Text {
		    anchors.fill: parent
		    font.pixelSize: 25
		    text: "Add"
		    horizontalAlignment: Text.AlignHCenter
		    verticalAlignment: Text.AlignVCenter

		}

		MouseArea{
		    id:ma_add
		    anchors.fill: parent
		    onClicked: root.model.addFrame();
		}


	    }
	}
    }
}

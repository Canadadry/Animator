import QtQuick 2.0
import "Style"

Box {
    id:root
    width: 360
    height: 360
    property alias model: frameRepeater.model
    property real  zoom: 1.0
    Item{
	anchors.fill: parent

	Item{
	    id:animation
	    anchors.centerIn: parent
	    Repeater{
		id:frameRepeater
		property int  currentIndex: -1
		Tile{
		    scale: root.zoom
		    anchors.centerIn: parent;
		    source: root.model.source;
		    frameX:    m_frameX;
		    frameY:    m_frameY;
		    frameWidth: m_frameWidth;
		    frameHeight: m_frameHeight;
		    visible: index === frameRepeater.currentIndex
		}
	    }
	}

	Timer{
	    id:frameTimer
	    interval: frameList.frameDuration
	    repeat: true
	    onTriggered:{
		frameRepeater.currentIndex++
		if(frameRepeater.currentIndex >= frameRepeater.count)
		{
//		    running = false;
		    frameRepeater.currentIndex = 0;
		}
	    }
	}

	MouseArea{
	    Keys.onSpacePressed: root.model.printModel()
	    anchors.fill: parent
	    onClicked: {
		//	    animation.x = mouseX;
		//	    animation.y = mouseY;
//		frameRepeater.currentIndex = 0;
//		frameTimer.start();
		frameTimer.running = ! frameTimer.running
		focus = true
	    }
	}
    }
}

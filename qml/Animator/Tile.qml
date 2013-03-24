import QtQuick 2.0

Item{
    id:root
    property int frameWidth: 16
    property int frameHeight: 16
    property int frameX:0
    property int frameY:0
    property alias source: img.source
    width:frameWidth
    height:frameHeight
    clip: true

    Image{
	id:img
	x:-root.frameX
	y:-root.frameY
        source:tileset.source
    }
//    MouseArea{
//        anchors.fill: parent
//        onReleased: console.log("tileId:"+tileId+" idx:"+idx+" idy:"+idy+" width:"+width+" height:"+height+" source:"+tileset.source)

//    }
//    Component.onCompleted: {
//        console.log(tileId:"+tileId+" idx:"+idx+" idy:"+idy+" width:"+width+" height:"+height+" source:"+tileset.source)
//    }

}

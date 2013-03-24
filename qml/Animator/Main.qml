import QtQuick 2.0
import IO 1.0

Rectangle {
    id: rectangle1
    width: 1440
    height: 900

    FileIO{
	id:file
//	source: file.openFileDialog();
	onReadingFile:frameList.loadData(content,folder)
    }

    FrameList{id:frameList}

    GlobalConf{
	id:globalConf
	anchors.left: parent.left
	anchors.top: parent.top
	anchors.right: parent.right
	model: frameList
	onSaved:{
	    if(file.fileOpened)
	    {
		file.content = frameList.printModel();
	    }
	    else
	    {
		file.source = file.openFileDialog();
	    }
	}
    }


    Preview {
	id: preview
	width: 300
	height: 300
	model:frameList
	anchors.left: parent.left
	anchors.top: globalConf.bottom
	//	zoom:3.0
    }

    AtlasView {
	id: atlasView
	model:frameList
	anchors.left: preview.right
	anchors.bottom: frameView.top
	anchors.top: globalConf.bottom
	anchors.right: parent.right
	//	zoom:3.0
    }

    FrameView{
	id:frameView
	anchors.right: parent.right
	anchors.left: parent.left
	anchors.bottom: parent.bottom
	height: 200
	model:frameList

	//	zoom:2.0
    }



    FrameForm{
	id:ui
	model:frameList
	anchors.bottom: frameView.top
	anchors.top: preview.bottom
	anchors.right: preview.right
	anchors.left: preview.left
    }




}

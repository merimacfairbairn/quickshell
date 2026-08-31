import QtQuick
import QtQuick.Layouts
import Quickshell

import "../Color.js" as Colors

import "../Components/"

Item {
  id: root

  property var buttons: [
	{
	  icon: "",
	  color: Colors.surface1
	},
	{
	  icon: "",
	  color: Colors.yellow
	},
	{
	  icon: "󰪶",
	  color: Colors.green
	},
	{
	  icon: "󰊻",
	  color: Colors.sky
	},
	{
	  icon: "",
	  color: Colors.mauve
	},
	{
	  icon: "󰼁",
	  color: Colors.red
	},
	{
	  icon: "󰈹",
	  color: Colors.peach
	}
  ]
  property real cx: width / 2
  property real cy: height / 2
  property bool hidden: true
  property real r: 120
  property double topMargin: 50

  implicitHeight: 300
  implicitWidth: 300

  states: [
	State {
	  name: "hidden"
	  when: root.hidden == true

	  PropertyChanges {
		root.r: 0
		root.topMargin: -300
	  }
	},
	State {
	  name: "shown"
	  when: root.hidden == false

	  PropertyChanges {
		root.r: 120
		root.topMargin: 50
	  }
	}
  ]
  //  Behavior on topMargin {
  // SpringAnimation {
  //   damping: 0.3
  //   spring: 5
  // }
  //  }
  transitions: [
	Transition {
	  from: "hidden"
	  to: "shown"

	  ParallelAnimation {
		SpringAnimation {
		  damping: 0.3
		  property: "topMargin"
		  spring: 5
		  target: root
		}

		SequentialAnimation {
		  PauseAnimation {
			duration: 220
		  }

		  SpringAnimation {
			damping: 0.3
			property: "r"
			spring: 4
			target: root
		  }
		}
	  }
	},
	Transition {
	  from: "shown"
	  to: "hidden"

	  ParallelAnimation {
		SpringAnimation {
		  damping: 0.3
		  property: "r"
		  spring: 4
		  target: root
		}

		SequentialAnimation {
		  PauseAnimation {
			duration: 130
		  }

		  NumberAnimation {
			duration: 250
			easing.type: Easing.InBack
			property: "topMargin"
			target: root
		  }
		}
	  }
	}
  ]

  anchors {
	horizontalCenter: parent.horizontalCenter
	top: parent.top
	topMargin: root.topMargin
  }

  Repeater {
	model: root.buttons

	delegate: Item {
	  id: itemRoot

	  required property int index
	  required property var modelData

	  x: index === 0 ? root.cx - width / 2 : root.cx + root.r * Math.cos((index - 1) * Math.PI / 3)
					   - width / 2
	  y: index === 0 ? root.cy - height / 2 : root.cy + root.r * Math.sin((index - 1) * Math.PI / 3)
					   - height / 2
	  z: index === 0 ? 10 : 0

	  Rectangle {
		color: itemRoot.modelData.color
		implicitHeight: 80 + (itemRoot.index === 0 ? 2 : 0)
		implicitWidth: 80 + (itemRoot.index === 0 ? 2 : 0)
		radius: 10

		anchors {
		  horizontalCenter: parent.horizontalCenter
		  verticalCenter: parent.verticalCenter
		}

		CenteredText {
		  color: itemRoot.index === 0 ? Colors.text : Colors.surface0
		  fontSize: 32
		  propo: true
		  text: itemRoot.modelData.icon
		}
	  }
	}
  }
}

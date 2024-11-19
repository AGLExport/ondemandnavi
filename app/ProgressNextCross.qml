import QtQuick
import QtQuick.Controls

Item {
	id: progress_next_cross

    visible: false

    // val [Input]
    //   distance to next cross. (unit = meter)
    //   when over the ProgressBar.maximumValue/m, progress bar indicates max (same as ProgressBar.maximumValue/m)
    function setProgress(val) {
        if ( (0 < val) && (val < bar.maximumValue ) ) {
            bar.value = val
        }else if ( bar.maximumValue < val ){
            bar.value = bar.maximumValue
        }else{
            bar.value = 0
        }
	}

	ProgressBar {
		id: bar
		width: 25
		height: 100
        rotation: 90
        value: 0
        from: 0
        to: 300

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 6
            color: "#e6e6e6"
            radius: 3
        }

        contentItem: Item {
            implicitWidth: 200
            implicitHeight: 4

            // Progress indicator for determinate state.
            Rectangle {
                width: bar.visualPosition * parent.width
                height: parent.height
                radius: 2
                color: "#17a81a"
                visible: !bar.indeterminate
            }

            // Scrolling animation for indeterminate state.
            Item {
                anchors.fill: parent
                visible: bar.indeterminate
                clip: true

                Row {
                    spacing: 20

                    Repeater {
                        model: bar.width / 40 + 1

                        Rectangle {
                            color: "#17a81a"
                            width: 20
                            height: bar.height
                        }
                    }
                    XAnimator on x {
                        from: 0
                        to: -40
                        loops: Animation.Infinite
                        running: bar.indeterminate
                    }
                }
            }
        }
	}
    states: [
        State {
            name: "visible"; PropertyChanges { target: progress_next_cross; visible: true }},
        State {
            name: "invisible"; PropertyChanges { target: progress_next_cross; visible: false }}
    ]

}

// Copyright (c) 2018 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.3
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4 as LegacyControls
import UM 1.3 as UM

Item {

    property var printer: null;
    property var printJob: printer ? printer.activePrintJob : null;
    property var collapsed: true;

    Behavior on height { NumberAnimation { duration: 100 } }
    Behavior on opacity { NumberAnimation { duration: 100 } }

    width: parent.width;
    height: collapsed ? 0 : childrenRect.height;
    opacity: collapsed ? 0 : 1;

    Column {
        id: contentColumn;
        anchors {
            left: parent.left;
            leftMargin: UM.Theme.getSize("default_margin").width;
            right: parent.right;
            rightMargin: UM.Theme.getSize("default_margin").width;
        }
        height: childrenRect.height + UM.Theme.getSize("wide_margin").height;
        spacing: UM.Theme.getSize("default_margin").height;
        width: parent.width;

        HorizontalLine {}

        PrinterInfoBlock {
            printer: root.printer;
            printJob: root.printer.activePrintJob;
        }

        HorizontalLine {}

        Row {
            width: parent.width;
            height: childrenRect.height;

            PrintJobTitle {
                job: root.printer.activePrintJob;
            }
            PrintJobContextMenu {
                id: contextButton;
                anchors {
                    right: parent.right;
                    rightMargin: UM.Theme.getSize("wide_margin").width;
                }
                printJob: root.printer.activePrintJob;
                visible: root.printer.activePrintJob;
            }
        }
        

        PrintJobPreview {
            job: root.printer.activePrintJob;
            anchors.horizontalCenter: parent.horizontalCenter;
        }
    }

    CameraButton {
        id: showCameraButton;
        anchors {
            bottom: contentColumn.bottom;
            bottomMargin: Math.round(1.5 * UM.Theme.getSize("default_margin").height);
            left: contentColumn.left;
            leftMargin: Math.round(0.5 * UM.Theme.getSize("default_margin").width);
        }
        iconSource: "../svg/camera-icon.svg";
    }
}
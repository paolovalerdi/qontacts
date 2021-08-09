import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12

Item {
    id: root

    ToolBar {
        id: toolbar

        anchors.top: root.top
        anchors.left: root.left
        anchors.right: root.right

        Material.primary: "#2B73D6";

        Text {
            anchors.centerIn: parent
            text: "Agenda"
            color: "white"
            font.pixelSize: 18
        }
    }

    signal addClicked()

    // Define the ListModel here so it's easier
    // to update once the state is provided
    // via the onStateChanged(state) callback
    ListModel {
        id: contactsModel
    }


    Component.onCompleted: {
        contactsController.update();
    }

    // "Listens" to the stateChange signal in
    // the ContactsController class.

    // The "onStateChange" it's autogenerated by QML.
    // QML automatically adds the "on" prefix to any signal name.
    // Something like "clicked" -> "onClicked"

    // The state argument it's a JSON formatted string
    Connections {
        target: contactsController

        function onStateChange(state) {
            contactsModel.clear();
            const contacts = JSON.parse(state);
            for (let i = 0; i <= contacts.length; i++) {
                contactsModel.append(contacts[i]);
            }
        }
    }

    ListView {
        id: listView
        anchors.top: toolbar.bottom
        anchors.left: root.left
        anchors.right: root.right
        anchors.bottom: root.bottom
        anchors.margins: 16
        clip: true

        spacing: 8
        model: contactsModel
        delegate: Contact {
            contact: model
        }
    }

    RoundButton{
        width: 64
        height: 64
        icon.source: "qrc:/add_black_24dp.svg"
        icon.width: 20
        icon.height: 20
        Material.background: "#2B73D6"
        Material.foreground: "white"
        anchors {
            bottom: root.bottom
            right: root.right
            margins: 16
        }
        onClicked: { addClicked(); }
    }

}
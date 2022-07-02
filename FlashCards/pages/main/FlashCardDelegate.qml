import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.LocalStorage
import "qrc:/Database.js" as JS

ItemDelegate {
    id: flashCardDelegate
    width: Boolean(parent) ? parent.width : 0
    checkable: true

    signal updateFlashCard(int index)
    signal deleteFlashCard(int index)

    //property alias labelNameText: labelname.text

    onClicked: ListView.view.currentIndex = index

    contentItem: ColumnLayout {
        spacing: 0
        RowLayout {
            ColumnLayout {
                id: flashCardColumn
                Label {
                    id: flashCardQuestion
                    //font.pixelSize: Qt.application.font.pixelSize * 2
                    font.pixelSize: text.length < 48 ? Qt.application.font.pixelSize * 2 : Qt.application.font.pixelSize * (text.length / 40)
                    text: model.question
                }
            }
            Item {
                Layout.fillWidth: true
            }

            Button {
                id: updateFlashCardItem
                text: qsTr("Uredi")
                leftPadding: 18
                rightPadding: 18
                onClicked: updateFlashCard(index)
            }

            Button {
                id: deleteFlashCardItem
                text: qsTr("Obriši")
                leftPadding: 18
                rightPadding: 18
                Material.background: Material.color(Material.Red, Material.Shade800)
                onClicked: deleteFlashCard(index)
            }
        }
        Label {
            id: flashCardAnswer
            visible: expandButton ? true : (flashCardDelegate.checked ? true : false)
            text: "Odgovor: " + model.answer
            //font.pixelSize: text.length < 48 ? Qt.application.font.pixelSize * 2 : Qt.application.font.pixelSize * (text.length / 40)
        }
        Label {
            id: flashCardKeyword
            //visible: flashCardDelegate.checked
            visible: expandButton ? true : (flashCardDelegate.checked ? true : false)
            text: "Ključna riječ: " + model.keyword
            //font.pixelSize: text.length < 48 ? Qt.application.font.pixelSize * 2 : Qt.application.font.pixelSize * (text.length / 40)
        }
    }
}

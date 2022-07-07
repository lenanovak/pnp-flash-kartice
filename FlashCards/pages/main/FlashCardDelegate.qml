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
    signal resetFlashCards(bool visiblity)

    onClicked: ListView.view.currentIndex = index

    contentItem: ColumnLayout {
        spacing: 0
        RowLayout {
            ColumnLayout {
                id: flashCardColumn
                Label {
                    id: flashCardQuestion
                    font.pixelSize: Qt.application.font.pixelSize * 2
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
            visible: flashCardDelegate.checked
            text: "Odgovor: " + model.answer
        }
        Label {
            id: flashCardKeyword
            visible: flashCardDelegate.checked
            text: "Ključna riječ: " + model.keyword
        }
    }
}

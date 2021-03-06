import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window
import QtQml.Models
import QtQuick.Dialogs
import QtQuick.LocalStorage
import "qrc:/Database.js" as JS

Page {
    id: page
    signal playQuiz(FlashCardModel flashCardModel)

    function expandOrCollapse(changeState) {
        for (var cardIndex in flashCardsList.contentItem.children){
            var card = flashCardsList.itemAtIndex(cardIndex)
            if (card !== null)
                card.checked = changeState
        }
    }

    header: MenuBar {
        Menu {
            title: qsTr("&Opcije")
            MenuItem {
                text: qsTr("&Uvezi pitanja...")
                onClicked: fileDialog.open()
            }
            MenuItem {
                text: qsTr("&Izvezi pitanja...")
                onClicked: {
                    var datamodel = []
                    for (var i = 0; i < flashCardsList.model.count; ++i) {
                        datamodel.push(flashCardsList.model.get(i))
                    }
                    fileio.write(desktopPath + "/exportedData.json", JSON.stringify(datamodel))
                }
            }
            MenuSeparator { }
            MenuItem {
                text: qsTr("&Ugasi aplikaciju")
                onClicked: Qt.quit()
            }
        }
        Menu {
            title: qsTr("&Pregled")
            MenuItem {
                text: qsTr("&Proširi kartice")
                onClicked: {
                    expandOrCollapse(true)
                }
            }
            MenuItem {
                text: qsTr("&Sažmi kartice")
                onClicked: {
                    expandOrCollapse(false)
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        nameFilters: ["JSON files (*.json)"]
        onAccepted: JS.loadData(this.selectedFile)
    }

    ListView {
        id: flashCardsList
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 58
        anchors.bottomMargin: 54
        clip: true
        ScrollBar.vertical: ScrollBar {
            parent: this.parent
        }
        model: FlashCardModel {}
        delegate: FlashCardDelegate {
            onUpdateFlashCard: {
                flashCardDialog.selectedFlashCardIndex = index
                flashCardDialog.visible = true
            }

            onDeleteFlashCard: {
                flashCardDeleteDialog.selectedFlashCardIndex = index
                flashCardDeleteDialog.visible = true
            }
        }
    }

    Button {
        id: addFlashCardButton
        text: qsTr("Dodaj karticu")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 20
        leftPadding: 30
        rightPadding: 30
        onClicked: {
            flashCardDialog.selectedFlashCardIndex = -1
            flashCardDialog.visible = true
        }
    }

    Button {
        id: playFlashCardQuizButton
        text: qsTr("Testiraj znanje")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 20
        leftPadding: 30
        rightPadding: 30
        onClicked: {
            flashCardsList.model.clear()
            JS.dbReadAll()
            playQuiz(flashCardsList.model)
        }
    }

    FlashCardDialog {
        id: flashCardDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        flashCardModel: flashCardsList.model
    }

    FlashCardDeleteDialog {
        id: flashCardDeleteDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        flashCardModel: flashCardsList.model
    }

    FlashCardDuplicateDialog {
        id: flashCardDuplicateDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
    }

    TextField {
        id: keywordSearch
        height: 46
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.leftMargin: 13
        anchors.topMargin: 18
        placeholderText: qsTr("Pretraži kartice")
        selectByMouse: true
        onTextChanged: {
            flashCardsList.model.clear()
            if (keywordSearch.text === "") {
                JS.dbReadAll()
            } else {
                var pattern = keywordSearch.text
                JS.filter(pattern)
            }
        }
    }
}


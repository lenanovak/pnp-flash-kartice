import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "qrc:/Database.js" as JS

Dialog {
    id: flashCardDialog
    modal: true
    standardButtons: DialogButtonBox.Save | DialogButtonBox.Cancel
    width: 400

    title: isNewItem() ? qsTr("Dodaj novu karticu") :qsTr("Ažuriraj postojeću karticu")

    property FlashCardModel flashCardModel
    property int selectedFlashCardIndex

    function isNewItem() {
        return selectedFlashCardIndex === -1
    }

    function addFlashCard() {
        JS.dbInsert(flashCardQuestionTextField.text, flashCardAnswerTextField.text, flashCardKeywordTextField.text)
    }

    function changeFlashCard() {
        JS.dbUpdate(flashCardQuestionTextField.text,
                    flashCardAnswerTextField.text,
                    flashCardKeywordTextField.text,
                    JS.getID(selectedFlashCardIndex),
                    selectedFlashCardIndex)
    }

    onAccepted: {
        isNewItem() ? addFlashCard() : changeFlashCard()
    }

    onRejected: flashCardDialog.close()

    contentItem: ColumnLayout {
        GridLayout {
            columns: 2

            Label {
                text: qsTr("Pitanje:")
            }

            TextField {
                id: flashCardQuestionTextField
                placeholderText: qsTr("Dodaj pitanje")
                cursorVisible: true
                Layout.fillWidth: true
                text: isNewItem() ? "" : flashCardsList.model.get(selectedFlashCardIndex).question
                selectByMouse: true
                maximumLength: 128
                //onTextChanged: if (length > limitQuestion) remove(limitQuestion, length)
            }

            Label {
                text: qsTr("Odgovor:")
            }

            TextField {
                id: flashCardAnswerTextField
                placeholderText: qsTr("Dodaj odgovor")
                cursorVisible: true
                Layout.fillWidth: true
                text: isNewItem() ? "" : flashCardsList.model.get(selectedFlashCardIndex).answer
                selectByMouse: true
                maximumLength: 128
                //onTextChanged: if (length > limitAnswer) remove(limitAnswer, length)
            }

            Label {
                text: qsTr("Ključna riječ:")
            }

            TextField {
                id: flashCardKeywordTextField
                placeholderText: qsTr("Dodaj ključnu riječ")
                cursorVisible: true
                Layout.fillWidth: true
                text: isNewItem() ? "" : flashCardsList.model.get(selectedFlashCardIndex).keyword
                selectByMouse: true
                maximumLength: 128
                //onTextChanged: if (length > limitQuestion) remove(limitQuestion, length)
            }
        }
    }
}

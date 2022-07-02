import QtQuick 2.0
import QtQuick.LocalStorage
import "qrc:/Database.js" as JS

ListModel {
    id: flashCardModel
    Component.onCompleted: {
        JS.dbReadAll()
    }

}

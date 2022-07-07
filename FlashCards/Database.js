function dbInit()
{
    var db = LocalStorage.openDatabaseSync("FlashCardsDB", "", "Opening database", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS flashcards (id integer primary key, question text, answer text, keyword text)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    }
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("FlashCardsDB", "",
                                               "", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbReadAll()
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT id,question,answer,keyword FROM flashcards order by id asc')
        for (var i = 0; i < results.rows.length; i++) {
            flashCardsList.model.append({
                                            "question": results.rows.item(i).question,
                                            "answer": results.rows.item(i).answer,
                                            "keyword": results.rows.item(i).keyword
                                        })

        }
    })
}

function dbInsert(question, answer, keyword)
{
    var db = dbGetHandle()
    var id = 0
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO flashcards (question, answer, keyword) VALUES (?, ?, ?)',
                      [question, answer, keyword])
    })

    //console.log("Adding a new flashcard")
    flashCardsList.model.append({
                                    //id: id,
                                    question: question,
                                    answer: answer,
                                    keyword: keyword
                                })

}

function checkDuplicates(question, answer, keyword)
{
    var db = dbGetHandle()
    var results
    db.transaction(function (tx) {
        results = tx.executeSql(
                    'SELECT * FROM flashcards WHERE 1=1 AND question = ? AND answer = ? AND keyword = ?', [question, answer, keyword])

    })
    return results.rows.length > 0
}

function getID(rowID)
{
    var id = 0
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var result = tx.executeSql(
                    'SELECT * FROM flashcards WHERE 1=1 AND question=? AND answer=? AND keyword=?',
                    [flashCardsList.model.get(rowID).question,
                     flashCardsList.model.get(rowID).answer,
                     flashCardsList.model.get(rowID).keyword])

        id = result.rows.item(0).id
    })
    return id
}

function dbUpdate(question, answer, keyword, id, rowID)
{
    var db = dbGetHandle()
    //console.log("---UPDATE---")
    db.transaction(function (tx) {
        tx.executeSql(
                    'update flashcards set question=?, answer=?, keyword=? where id = ?', [question, answer, keyword, id])
    })
    flashCardsList.model.set(rowID, ({   id: id,
                                         question: question,
                                         answer: answer,
                                         keyword: keyword
                                     }))
    checkDuplicates()
    //console.log("update ID: " + id)
    //console.log("update rowID: " + rowID)
}

function dbDeleteRow(id, rowID)
{
    var db = dbGetHandle()
    //console.log("---DELETE---")
    //console.log("delete ID: " + id)
    //console.log("delete rowID: " + rowID)
    db.transaction(function (tx) {
        tx.executeSql('delete from flashcards where id = ?', [id])
    })
    flashCardsList.model.remove(rowID, 1)
}

function filter(pattern) {
    var db = dbGetHandle()
    var patternFilter = '%' + pattern + '%'
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT DISTINCT question,answer,keyword FROM flashcards WHERE keyword LIKE ?', [patternFilter])
        for (var i = 0; i < results.rows.length; i++) {
            flashCardsList.model.append({
                                            question: results.rows.item(i).question,
                                            answer: results.rows.item(i).answer,
                                            keyword: results.rows.item(i).keyword
                                        })
        }
    })
}

function loadData(fileUrl)
{
    var xhr = new XMLHttpRequest
    xhr.open("GET", fileUrl)
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            var response = xhr.responseText
            var responseJSON = JSON.parse(response)
            for (var i = 0; i < responseJSON.length; i++) {
                if (!checkDuplicates(responseJSON[i].question, responseJSON[i].answer, responseJSON[i].keyword)) {
                    dbInsert(responseJSON[i].question, responseJSON[i].answer, responseJSON[i].keyword)
                }
            }
        }
    }
    xhr.send()
}


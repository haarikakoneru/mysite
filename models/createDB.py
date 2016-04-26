import sqlite3

def createTables():
    db = sqlite3.connect('sudoku.db')
    qry ='CREATE TABLE users1 (id INTEGER PRIMARY KEY, '
    qry += 'userName CHAR(100) NOT NULL,'
    qry += 'password CHAR(100) NOT NULL,'
    qry += 'zipCode CHAR(15) NOT NULL,'
    qry += 'email CHAR(100) NOT NULL,'
    qry += 'sQue CHAR(100) NOT NULL,'
    qry += 'sAns CHAR(100) NOT NULL)'
    db.execute(qry)
    db.commit()
    
def insertRecords():
    db = sqlite3.connect('sudoku.db')
    db.execute("INSERT INTO users (userName,password,zipCode,email, sQue, sAns) VALUES ('user1', 'pass1','zip1','email1@gmail.com','que1','ans1')")
    db.execute("INSERT INTO users (userName,password,zipCode,email, sQue, sAns) VALUES ('user2', 'pass2','zip2','email2@gmail.com','que2','ans2')")
    db.execute("INSERT INTO users (userName,password,zipCode,email, sQue, sAns) VALUES ('user3', 'pass3','zip3','email3@gmail.com','que3','ans3')")
    db.execute("INSERT INTO users (userName,password,zipCode,email, sQue, sAns) VALUES ('user4', 'pass4','zip4','email4@gmail.com','que4','ans4')")
    db.execute("INSERT INTO users (userName,password,zipCode,email, sQue, sAns) VALUES ('user5', 'pass5','zip5','email5@gmail.com','que5','ans5')")
    db.commit()
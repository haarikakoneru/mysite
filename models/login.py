import bottlesession
from bottle import response
from json import dumps, loads
import sqlite3



DB_NAME = 'sudoku.db'
conn = sqlite3.connect(DB_NAME)
session_manager = bottlesession.CookieSession()

def userLogin(email, password):
    qry = "SELECT *  from users WHERE email='" +email  +"' and password = '"+ password + "'"
    cursor = conn.execute(qry)
    data = cursor.fetchall()
    cursor.close()
    response.content_type = 'application/json'
    if len(data) > 0:
        session = session_manager.get_session()
        session['userId'] = data[0][0]
        session['userName'] = data[0][1]
        session['password'] = data[0][2]
        session['zipCode'] = data[0][3]
        session['email'] = data[0][4]
        session['sQue'] = data[0][5]
        session['sAns'] = data[0][6]
        session['id'] = data[0][0]
        session_manager.save(session)        
        return dumps({"success":True,
                      "redirect":"/",
                      "msg":"Logged in",
                      "data":data[0]
                      })
    else:
        return dumps({"success":False,
                      "redirect":"/login",
                      "msg":"Could not login please try again",
                      "data":None
                      })
        
        
def getSecreatQuestionByEmail(email):
    qry = "SELECT id, sQue from users WHERE email = '" + email + "'"
    cursor = conn.execute(qry)
    data = cursor.fetchall()
    cursor.close()
    response.content_type = 'application/json'
    if len(data) > 0 and data[0][1] != "":
        session = session_manager.get_session()
        session['userId'] = data[0][0]
        session['sQue'] = data[0][1]
        session_manager.save(session)        
        
        return dumps({"success":True,
                      "redirect":"/login",
                      "msg":"",
                      "data":data[0]
                      })
    else:
        return dumps({"success":False,
                      "redirect":"/login",
                      "msg":"Could not find secreat question for the given user name",
                      "data":None
                      })
        
def matchSecreatAnswers(ans):
    session = session_manager.get_session()
    userId = session.get('userId')
    qry = "SELECT sAns from users WHERE id= " + str(userId)
    cursor = conn.execute(qry)
    conn.commit
    data = cursor.fetchall()
    cursor.close()
    response.content_type = 'application/json'
    if len(data) > 0 and data[0][0] != "" and data[0][0] == ans.strip():        
        return dumps({"success":True,
                      "redirect":"/reset_password",
                      "msg":"",
                      "data":data[0]
                    })
    else:
        return dumps({"success":False,
                      "redirect":"/login",
                      "msg":"The secret answer is wrong.",
                      "data":None
                      })
        
def resetNewPassword(password):
    response.content_type = 'application/json'
    session = session_manager.get_session()    
    userId = session.get('userId')
    print("userId")
    print(userId)
    qry = "UPDATE users SET password = '" + password +"' WHERE id = " + str(userId)
    try:
        conn.execute(qry)
        conn.commit()
    
        return dumps({"success":True,
                      "redirect":"/login",
                      "msg":"Password reset successfully",
                      "data":None
                    })
    except:
        return dumps({"success":False,
                      "redirect":"/reset_password",
                      "msg":"Error while changing password",
                      "data":None
                      })
        
        
        


def registerNewUser(userName, password, zipCode, emailId, secretQue, secretAns):
    response.content_type = 'application/json'
    if not isEmailExists(emailId):
        qry = "INSERT INTO users (userName,"
        qry += "password,zipCode,email,sQue,sAns) values "  
        qry += "('" + userName +"',"  
        qry += "'" + password +"',"
        qry += "'" + zipCode +"',"
        qry += "'" + emailId +"',"
        qry += "'" + secretQue +"',"
        qry += "'" + secretAns +"'"
        qry += ")"
        print(qry)
        conn.execute(qry)
        conn.commit()
        return dumps({"success":True,
                      "redirect":"/login",
                      "msg":"Registered Successfully",
                      "data":None
                      })

    else:
        return dumps({"success":False,
                      "redirect":"/register",
                      "msg":"User already exists",
                      "data":None
                      })
        
    #Emaild Id must be unique
    #insert new record
    #redirect to login screen 
    pass

def isEmailExists(email):
    qry = "SELECT * FROM users WHERE email = '" + email + "'"
    cursor = conn.execute(qry)
    data = cursor.fetchall()
    cursor.close()
    print(len(data))
    if len(data) > 0:
        return True 
    else:
        return False
def getUserData(userId):
    qry = "SELECT * FROM users WHERE id = " + str(userId)
    cursor = conn.execute(qry)
    conn.commit
    data = cursor.fetchall()
    cursor.close()
    return  data
                          

def updateUserProfile(userName, password, zipCode, emailId, secretQue, secretAns):
    
    print("userName", userName)
    print("password", password)
    print("zipCode", zipCode)
    print("emailId", emailId)
    print("secretQue", secretQue)
    print("secretAns", secretAns)
    
    
    response.content_type = 'application/json'
    session = session_manager.get_session()
    userId = session.get('userId')
    qry = "SELECT * FROM users WHERE email = '" + emailId + "' AND id != " + str(userId)
    cursor = conn.execute(qry)
    data = cursor.fetchall()
    print (data)
    cursor.close()
    if len(data) > 0:
        return dumps({"success":False,
                      "redirect":"/edit_profile",
                      "msg":"User already exists with given email",
                      "data":None
                      })

    else:
        qry = "UPDATE users set " 
        qry += " userName = '" + userName +"',"  
        qry += " password = '" + password +"',"
        qry += " zipCode = '" + zipCode +"',"
        qry += " email = '" + emailId +"',"
        qry += " sQue = '" + secretQue +"',"
        qry += " sAns = '" + secretAns +"'"
        qry += " WHERE id = " + str(userId)

        try:
            conn.execute(qry)
            conn.commit()
            session['userName'] = userName
            session['password'] = password
            session['zipCode'] = zipCode
            session['email'] = emailId
            session['sQue'] = secretQue
            session['sAns'] = secretAns
            session_manager.save(session)
            return dumps({"success":True,
                          "redirect":"/edit_profile",
                          "msg":"Profile updated successfully",
                          "data":getUserData(userId)
                        })
        except:
            return dumps({"success":False,
                          "redirect":"/edit_profile",
                          "msg":"Could not update profile. Please try again...",
                          "data":getUserData(userId)
                          })

def logoutUser():
    session = session_manager.get_session()
    session = {}
    session['id'] = None
    session_manager.save(session)
    return dumps({"success":True,
                  "redirect":"/login",
                  "msg":"",
                  "data":None})
    

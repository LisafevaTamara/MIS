from tkinter import *
from tkinter import ttk
from database import DatabaseAuth
from admin import AdminPanel
from prometheus_client import start_http_server, Counter #monitoring

db = DatabaseAuth()
db.createTables()
db.createActiveSessions()

requests_counter = Counter('myapp_requests_total', 'Total number of requests received') #monitoring

def main():
    start_http_server(9090) #start monitoring server on port 9090
    root = Tk()
    root.title('Authorization')
    root.geometry('400x400')
    
    logFrame = ttk.Frame(borderwidth=1, relief=SOLID)
    logFrame.place(relx=0.5, rely=0.3, anchor=CENTER)

    signIntxt = ttk.Label(logFrame, text='Введите логин и пароль:')
    signIntxt.pack()

    usernameInput = Entry(logFrame)
    passwordInput = Entry(logFrame, show="*")
    usernameInput.pack(pady = 10, padx= 10)
    passwordInput.pack(pady = 10)

    def redirect():
        from doc_func import main
        nameGet = usernameInput.get()
        select = db.sel_role((nameGet, ))
        root.destroy()
        if select == 'user':
            main()
        elif select == 'admin':
            AdminPanel()

    def check():
        requests_counter.inc() #countt
        nameGet = usernameInput.get()
        passwordGet = passwordInput.get()
        inputData = (nameGet, passwordGet,)
        if (db.checkData((nameGet, ), (inputData, ))):
            db.userad((nameGet, ))
            select = db.sel_role((nameGet, ))
            if select == 'user':
                userID = db.get_user_id((nameGet, ))
                db.ins_session(userID)
            elif select == 'admin':
                print ("admin")
            redirect()
        else:   
            print("Wrong Credentials")
    signIn = Button(logFrame, text='Войти', command=check)
    signIn.pack()
    
    root.mainloop()

if __name__ == "__main__":
    main()

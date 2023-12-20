import unittest
from io import StringIO
from unittest.mock import patch
from tkinter import *
from tkinter import ttk
from tkinter.messagebox import showinfo
from database import DatabaseAuth
# from admin import AdminPanel
# unittest 


db = DatabaseAuth()


def redirect(username):
    from doc_func import main
    nameGet = username
    select = db.sel_role((nameGet, ))
    if select == 'user':
        print("main window is open")
    elif select == 'admin':
        print("Admin Panel is open")

def check(username,passwd):
    nameGet = username
    passwordGet = passwd
    inputData = (nameGet, passwordGet,)
    if (db.checkData((nameGet, ), (inputData, ))):
        db.userad((nameGet, ))
        select = db.sel_role((nameGet, ))
        if select == 'user':
            # print('user')
            userID = db.get_user_id((nameGet, ))
            print(select,userID)
            # db.ins_session(userID)
        elif select == 'admin':
            pass  # print('admin') in function userad
            # print ("admin")
        # redirect()
    else:   
        print("Wrong Credentials")
    

class TestRedirect(unittest.TestCase):

    def test_check_user(self):
        username = "maxim"
        passwd = "qwerty"
        expected_output = "user 3"
        with patch('sys.stdout', new=StringIO()) as fake_out:
            check(username,passwd)
            actual_output = fake_out.getvalue()
        self.assertEqual(actual_output.rstrip(), expected_output)

    def test_check_admin(self):
        username = "tamara"
        passwd = "lisafe"
        expected_output = "admin"
        with patch('sys.stdout', new=StringIO()) as fake_out:
            check(username,passwd)
            actual_output = fake_out.getvalue()
        self.assertEqual(actual_output.rstrip(), expected_output)

    def test_check_unsuccessful(self):
        username = "tamara"
        passwd = "qwerty"
        expected_output = "Wrong Credentials"
        with patch('sys.stdout', new=StringIO()) as fake_out:
            check(username,passwd)
            actual_output = fake_out.getvalue()
        self.assertEqual(actual_output.rstrip(), expected_output)


    def test_redirect_user(self):
        expected_output = "main window is open"
        username = "maxim"
        with patch('sys.stdout', new=StringIO()) as fake_out:
            redirect(username)
            actual_output = fake_out.getvalue()
        self.assertEqual(actual_output.rstrip(), expected_output)

    def test_redirect_admin(self):
        expected_output = "Admin Panel is open"
        username = "tamara"
        with patch('sys.stdout', new=StringIO()) as fake_out:
            redirect(username)
            actual_output = fake_out.getvalue()
        self.assertEqual(actual_output.rstrip(), expected_output)



if __name__ == '__main__':
    unittest.main()





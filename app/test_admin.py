from tkinter import *
from database import DatabaseAuth
import bcrypt
import unittest
from io import StringIO
from unittest.mock import patch

db = DatabaseAuth()


def register(FIO_entriesAdd, usernameAdd, passwdAdd, roleAdd):
            FIO_info = FIO_entriesAdd
            # FIO_to_string = ' '.join(FIO_info)
            nameGet = usernameAdd
            passwordGet = passwdAdd
            role = roleAdd
            bytes = passwordGet.encode('utf-8') 
            salt = bcrypt.gensalt()
            hash = bcrypt.hashpw(bytes, salt)
            hash1 = hash.decode('utf-8')
            print(FIO_info,nameGet,role)
            db.insertData(FIO_info, nameGet, hash1, role)

class TestRegistration(unittest.TestCase):
    
    def test_register(self):
        # Импорт вашей функции
        FIO_entriesAdd = "John Doe Smith"
        usernameAdd = "johndoe"
        passwdAdd = "password123"
        roleAdd = "user"
        expected_output = "John Doe Smith johndoe user"
        # Вызов функции с тестовыми данными
        with patch('sys.stdout', new=StringIO()) as fake_out:
            register(FIO_entriesAdd, usernameAdd, passwdAdd, roleAdd )
            actual_output = fake_out.getvalue()
        # Проверка ожидаемого результата
        # db.del_user(usernameAdd)
        self.assertEqual(actual_output.rstrip(), expected_output)
    
    def test_delete(self):
        usernameAdd = 'johndoe'
        expected_output = "User johndoe Deleted."
        with patch('sys.stdout', new=StringIO()) as fake_out:
            db.del_user(usernameAdd)
            actual_output = fake_out.getvalue()
        self.assertEqual(actual_output.rstrip(), expected_output)
    
if __name__ == '__main__':
    unittest.main()
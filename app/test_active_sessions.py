import unittest
from unittest.mock import Mock, patch
from tkinter import END 

class MockDB:
    @staticmethod
    def sel_session_id2():
        return []

class YourClass:
    def __init__(self, session_listbox):
        self.session_listbox = session_listbox
        self.active_sessions = []

    def show_active_sessions(self):
        self.session_listbox.delete(0, END)
        self.active_sessions = MockDB.sel_session_id2()
        for session in self.active_sessions:
            self.session_listbox.insert(END, session)

class TestShowActiveSessions(unittest.TestCase):
    def setUp(self):
        self.mock_listbox = Mock()
        self.instance = YourClass(self.mock_listbox)

    def test_show_active_sessions(self):
        with patch.object(MockDB, 'sel_session_id2', return_value=[]):
            self.instance.show_active_sessions()
            self.mock_listbox.delete.assert_called_once_with(0, END)
            self.mock_listbox.insert.assert_any_call(END, )

if __name__ == '__main__':
    unittest.main()

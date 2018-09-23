# -*- coding: utf-8 -*-
import os
import threading
from time import sleep, time
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from Data.list import fresh_task, done_task

class Func(QObject):


    def __init__(self):
        QObject.__init__(self)
        self.fresh_list = fresh_task
        self.done_list = done_task
        self.high_index = len(self.fresh_list) - 1
 
    send_first = pyqtSignal(list, arguments=['_start'])
    add_t = pyqtSignal(list, arguments=['_add'])


    def _start(self):



        self.send_first.emit(fresh_task)


    def _add(self, task_title):


        final = []
        task = {}
        self.high_index += 1
        task['id'] = self.high_index
        task['title'] = task_title
        task['date'] = time()
        task['ongoing'] = False
        self.fresh_list.append(task)
        final.append(task)
        self.add_t.emit(final)


    def _set_ongoing(self, ind):


        new_list = []
        for entry in self.fresh_list:

            if entry['id'] < ind:
                entry['id'] += 1

            elif entry['id'] == ind:
                entry['id'] = 0
                entry['ongoing'] = True

            new_list.append(entry)

        self.fresh_list = new_list
        self._refresh_list()


    def _remove(self, ind):


        new_list = []
        for entry in self.fresh_list:

            if entry['id'] > ind:
                entry['id'] -= 1

            elif entry['id'] == ind:
                entry['id'] = 0
                continue

            new_list.append(entry)

        self.fresh_list = new_list
        self._refresh_list()


    def _finish(self, ind):
        task = self.fresh_list[ind].copy()

        task.pop('id')
        task.pop('ongoing')

        task['completed_date'] = time()

        self.done_list.append(task)

        self._remove(ind)


    def _refresh_list(self):
        ff = []
        curr_index = 0
        while True:
            for entry in self.fresh_list:
                if entry['id'] == curr_index:
                    ff.append(entry)
                    curr_index += 1
            if len(ff) == len(self.fresh_list):
                break

        self.fresh_list = ff


    @pyqtSlot(str)
    def add(self, title):
        add_thread = threading.Thread(target = self._add, args=[title] )
        add_thread.start()


    @pyqtSlot()
    def start(self):
        start_thread = threading.Thread(target = self._start )
        start_thread.start()

    @pyqtSlot(int)
    def set_ongoing(self, index):
        ongoing_thread = threading.Thread(target = self._set_ongoing, args=[index] )
        ongoing_thread.start()


    @pyqtSlot(int)
    def finish(self, index):
        fin_thread = threading.Thread(target = self._finish, args=[index] )
        fin_thread.start()



    @pyqtSlot(int)
    def remove(self, index):
        r_thread = threading.Thread(target = self._remove, args=[index] )
        r_thread.start()

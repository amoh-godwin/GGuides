# -*- coding: utf-8 -*-
import os
import sys
from PyQt5.QtGui import QGuiApplication, QIcon
from PyQt5.QtQml import QQmlApplicationEngine
from functions import Func


class App():


    def __init__(self):


        super.__init__
        self.root_folder = os.path.split(sys.argv[0])[0].replace('\\', '/')
        self.main_qml = ''
        self.manager = ()
        self._preprocesses()


    def _postprocess(self):


        with open(self.root_folder + '/Data/list.py', 'w') as fresh_file:
            data = 'fresh_task = ' + str(self.manager.fresh_list) + '\n\n'
            data += 'done_task = ' + str(self.manager.done_list) + '\n'
            fresh_file.write(data)


    def _preprocesses(self):


        self.main_qml = os.path.join(self.root_folder, 'UI/main.qml')
        self._start()


    def _start(self):


        qApp = QGuiApplication(sys.argv)
        qApp.setWindowIcon(QIcon(self.root_folder + \
                                 "/assets/image/logo_GGuides.png"))

        engine = QQmlApplicationEngine()

        self.manager = Func()

        engine.rootContext().setContextProperty('manager', self.manager)
        engine.load(self.main_qml)
        engine.quit.connect(qApp.quit)

        qApp.aboutToQuit.connect(self._postprocess)
        qApp.exec_()

        sys.exit()


App()

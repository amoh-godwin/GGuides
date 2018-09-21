# -*- coding: utf-8 -*-
import os
import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from functions import Func


class App():
    
    
    def __init__(self):
        super.__init__
        self.root_folder = sys.argv[0].replace('main.py', '').replace('\\', '/')
        self.main_qml = ''
        self._preprocesses()
    

    def _postprocess(self):
        pass
    
    
    def _preprocesses(self):
        self.main_qml = os.path.join(self.root_folder, 'UI/main.qml')
        self._start()


    def _start(self):


        print('hljh')
        qApp = QGuiApplication(sys.argv)
        manager = Func()
        engine = QQmlApplicationEngine()
        engine.rootContext().setContextProperty('manager', manager)
        engine.load(self.main_qml)
        engine.quit.connect(qApp.quit)
        qApp.aboutToQuit.connect(self._postprocess)
        print(self.main_qml)
        sys.exit(qApp.exec_())
        

App()


"""print('hljh')
app = QGuiApplication(sys.argv)
#manager = Func()
engine = QQmlApplicationEngine()
#engine.rootContext().setContextProperty('manager', manager)
engine.load("C:/Users/GODWIN/Documents/GitHub/GGuides/UI/main.qml")
#engine.quit.connect(app.quit)
#qApp.aboutToQuit.connect(self._postprocess)
#print(self.main_qml)
sys.exit(app.exec_())"""


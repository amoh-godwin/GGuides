# -*- coding: utf-8 -*-
import os
import sys
import json
from PyQt5.QtGui import QGuiApplication, QIcon
from PyQt5.QtQml import QQmlApplicationEngine
from functions import Func


class App():


    def __init__(self):


        super.__init__
        self.root_folder = os.path.split(sys.argv[0])[0].replace('\\', '/')
        self.user_folder = os.environ['USERPROFILE'].replace('\\', '/')
        self.prefs = os.path.join(self.root_folder, '.GGuides').replace('\\', '/')
        self.datastore_file = self.prefs + '/' + '_datastore.js'
        self.main_qml = ''
        self.manager = ()
        self._preprocesses()


    def _postprocess(self):


        with open(self.datastore_file, 'w') as fresh_file:

            data = {}
            data['fresh_task'] = self.manager.fresh_list.copy()
            data['done_task'] = self.manager.done_list.copy()
            final = json.dumps(data, sort_keys=True, indent=4)
            fresh_file.write(final + "\n")


    def _preprocesses(self):


        self.main_qml = os.path.join(self.root_folder, 'UI/main.qml')

        if not os.path.exists(self.prefs):
            os.makedirs(self.prefs)

        if not os.path.exists(self.datastore_file):
            with open(self.datastore_file, 'w') as file:
                # initialise
                file.write('{"fresh_task":[], "done_task":[]}')

        """
        
            Start the Manager class
        
        """
        self.manager = Func()

        self._start()


    def _start(self):


        qApp = QGuiApplication(sys.argv)
        qApp.setWindowIcon(QIcon(self.root_folder + \
                                 "/assets/image/logo_GGuides.ico"))

        engine = QQmlApplicationEngine()
        engine.rootContext().setContextProperty('manager', self.manager)
        engine.load(self.main_qml)
        engine.quit.connect(qApp.quit)

        qApp.aboutToQuit.connect(self._postprocess)
        qApp.exec_()

        sys.exit()


App()

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
        self.prefs = os.path.join(self.user_folder, '.GGuides').replace('\\', '/')
        self.main_qml = ''
        self.manager = ()
        self._preprocesses()


    def _postprocess(self):


        with open(self.prefs, 'w') as fresh_file:

            data = {}
            data['fresh_task'] = self.manager.fresh_list.copy()
            print('\n***********************', data['fresh_task'], '\n')
            data['done_task'] = self.manager.done_list.copy()
            final = json.dumps(data, sort_keys=True, indent=4)
            fresh_file.write(final)


    def _preprocesses(self):


        self.main_qml = os.path.join(self.root_folder, 'UI/main.qml')

        datastore_file = os.path.join(self.prefs, '_datastore.js')

        if not os.path.exists(self.prefs):
            os.makedirs(self.prefs)

        if not os.path.exists(datastore_file):
            print('True')
            with open(datastore_file, 'w') as file:
                # initialise
                file.write('{"fresh_task":[], "done_task":[]}')

        with open(datastore_file, encoding='utf-8') as fp:
            raw_d = fp.read()
            ds = json.loads(raw_d)

        """
        
            Start the Manager class
        
        """
        self.manager = Func()

        # pass the JSON to it
        print(ds)
        self.manager.data =  ds

        self._start()


    def _start(self):


        qApp = QGuiApplication(sys.argv)
        qApp.setWindowIcon(QIcon(self.root_folder + \
                                 "/assets/image/logo_GGuides.png"))

        engine = QQmlApplicationEngine()
        engine.rootContext().setContextProperty('manager', self.manager)
        engine.load(self.main_qml)
        engine.quit.connect(qApp.quit)

        qApp.aboutToQuit.connect(self._postprocess)
        qApp.exec_()

        sys.exit()


App()

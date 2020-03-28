import os
import sys
from PySide2 import QtCore, QtGui, QtQml


def qt_bind(engine):
    directory = os.path.dirname(os.path.abspath(__file__))
    engine.load(QtCore.QUrl.fromLocalFile(os.path.join(directory, 'frontend/qml/main.qml')))
    if not engine.rootObjects():
        print("Error while enumerating root objects..")


if __name__ == "__main__":
    app = QtGui.QGuiApplication(sys.argv)
    app_engine = QtQml.QQmlApplicationEngine()
    qt_bind(app_engine)
    app.exec_()

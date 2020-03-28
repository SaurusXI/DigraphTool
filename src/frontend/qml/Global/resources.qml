pragma Singleton
import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0

QtObject {
    property var windowBackgroundColor: "#2f2d52"
    property var windowCornerRadius: 6
    property var windowDropShadowHorizontalPadding: 8
    property var windowDropShadowVerticalPadding: 8

    property var windowTitleBarHeight: 30
    property var windowTitleBarBackgroundColor: "#242345"
    property var windowTitleBarForegroundColor: "#f0d4ff"
    property var windowTitleBarCloseButtonBackgroundColor: "#ff6256"
    property var windowTitleBarRestoreButtonBackgroundColor: "#ffbf2f"
    property var windowTitleBarMinimizeButtonBackgroundColor: "#29cb42"
    property var windowTitleBarButtonOffset: 7
    property var windowTitleBarButtonRadius: 6
    property var windowTitleBarFontPointSize: 10
    property var windowTitleBarBottomOffset: 20

}
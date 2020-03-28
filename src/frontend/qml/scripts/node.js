var component;

function createNode(text, x, y) {
    component = Qt.createComponent("../res/node.qml")
    var nodeObject = component.createObject(window, {text: text, x: x, y: y});
    if (nodeObject == null) {
        // Error Handling
        console.log("Error creating object");
    }
}
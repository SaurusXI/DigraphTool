var component;

function Node(nodeId, text) {
    this.id = nodeId
    this.text = text
}

function createNode(parent, x, y, node) {
    component = Qt.createComponent("../res/node.qml")
    var nodeObject = component.createObject(parent, {nodeId: node.id, text: node.text, x: x, y: y});
    if (nodeObject == null) {
        // Error Handling
        console.log("Error creating object");
    }
}

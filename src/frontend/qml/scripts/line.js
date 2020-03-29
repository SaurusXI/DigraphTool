var component;

function Line(startX, startY, endX, endY) {
    this.startX = startX
    this.startY = startY
    this.endX = endX
    this.endY = endY
}

function createLine(parent, line) {
    component = Qt.createComponent("../res/line.qml")
    var lineObject = component.createObject(parent, {startX: line.startX, startY: line.startY, endX: line.endX, endY: line.endY});
    if (lineObject == null) {
        // Error Handling
        console.log("Error creating object");
    }
    return lineObject
}

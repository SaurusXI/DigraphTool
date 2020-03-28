NodeCounter = 0 # Used to assign node id
NodesMap = {}   # Hash map to retrieve node from node id

class Node:
    def __init__(self, NodeCount):
        self.text = ''
        self.NodeId = NodeCount

    def insert_text(self, node_text):
        self.text = node_text

    def insert_Lnode(self, NodeCount):
        self.lnode = Node(NodeCount)
        NodesMap.update({self.lnode.NodeId : self.lnode})

    def insert_Rnode(self, NodeCount):
        self.rnode = Node(NodeCount)
        NodesMap.update({self.rnode.NodeId : self.rnode})
    
class NullNode(Node):
    def __init__(self):
        Node.__init__(self, -1)

class Digraph:
    def __init__(self):
        self.Root = Node(NodeCounter)
        NodeCounter += 1
        self.selected_Id = -1

    def select_node(self, NodeId):
        self.selected_Id = NodeId

    def insert_Lnode(self):
        if self.selected_Id == -1:
            print('Must select a node first')
            return

        selected_node = NodesMap[self.selected_Id]
        selected_node.insert_Lnode(NodeCounter)
        NodeCounter += 1

    def insert_Rnode(self):
        if self.selected_Id == -1:
            print('Must select a node first')
            return

        selected_node = NodesMap[self.selected_Id]
        selected_node.insert_Rnode(NodeCounter)
        NodeCounter += 1

    def insert_text(self, text):
        if self.selected_Id == -1:
            print('Must select a node first')
            return

        selected_node = NodesMap[self.selected_Id]
        selected_node.insert_text(text)
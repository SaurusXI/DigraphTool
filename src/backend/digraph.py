class Node:
    def __init__(self, node_count, node_map=None):
        self.node_map = node_map
        if node_map is None:
            self.node_map = {}
        self.text = ''
        self.node_id = node_count
        self.lnode = None
        self.rnode = None

    def insert_text(self, node_text):
        self.text = node_text

    def insert_lnode(self, node_count):
        self.lnode = Node(node_count, self.node_map)
        self.node_map[self.lnode.node_id] = self.lnode

    def insert_rnode(self, node_count):
        self.rnode = Node(node_count, self.node_map)
        self.node_map[self.rnode.node_id] = self.rnode


class NullNode(Node):
    def __init__(self):
        Node.__init__(self, -1, None)


class Digraph:
    def __init__(self, initial_node_count=0):
        self.node_map = {}
        self.node_count = initial_node_count
        self.root = Node(self.node_count, self.node_map)
        self.node_count += 1
        self.selected_Id = -1

    def select_node(self, node_id):
        self.selected_Id = node_id

    def insert_lnode(self):
        if self.selected_Id == -1:
            print('Must select a node first')
            return

        selected_node = self.node_map[self.selected_Id]
        selected_node.insert_lnode(self.node_count)
        self.node_count += 1

    def insert_rnode(self):
        if self.selected_Id == -1:
            print('Must select a node first')
            return

        selected_node = self.node_map[self.selected_Id]
        selected_node.insert_rnode(self.node_count)
        self.node_count += 1

    def insert_text(self, text):
        if self.selected_Id == -1:
            print('Must select a node first')
            return

        selected_node = self.node_map[self.selected_Id]
        selected_node.insert_text(text)

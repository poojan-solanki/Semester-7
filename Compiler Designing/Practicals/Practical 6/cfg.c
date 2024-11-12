#include <stdio.h>
#include <stdlib.h>

// Structure to represent a node in the adjacency list
struct Node {
    int vertex;
    struct Node* next;
};

// Structure to represent an adjacency list
struct AdjacencyList {
    struct Node* head;
};

// Structure to represent a graph
struct Graph {
    int numVertices;
    struct AdjacencyList* array;
};

// Function to create a new node
struct Node* newNode(int vertex) {
    struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
    new_node->vertex = vertex;
    new_node->next = NULL;
    return new_node;
}

// Function to create a graph of given vertices
struct Graph* createGraph(int vertices) {
    struct Graph* graph = (struct Graph*)malloc(sizeof(struct Graph));
    graph->numVertices = vertices;

    // Create an array of adjacency lists
    graph->array = (struct AdjacencyList*)malloc(vertices * sizeof(struct AdjacencyList));

    // Initialize each adjacency list as empty
    for (int i = 0; i < vertices; i++) {
        graph->array[i].head = NULL;
    }

    return graph;
}

// Function to add an edge to the graph
void addEdge(struct Graph* graph, int src, int dest) {
    // Add an edge from src to dest
    struct Node* new_node = newNode(dest);
    new_node->next = graph->array[src].head;
    graph->array[src].head = new_node;

    // Add an edge from dest to src for predecessors
    new_node = newNode(src);
    new_node->next = graph->array[dest].head;
    graph->array[dest].head = new_node;
}

// Function to print predecessors and successors
void printPredecessorsSuccessors(struct Graph* graph) {
    printf("Predecessors:\n");
    for (int i = 0; i < graph->numVertices; i++) {
        printf("%d: ", i);
        struct Node* current = graph->array[i].head;
        int first = 1; // To format output
        while (current != NULL) {
            if (current->vertex != i) { // Exclude self-loops
                if (!first) {
                    printf(", ");
                }
                printf("%d", current->vertex);
                first = 0;
            }
            current = current->next;
        }
        printf("\n");
    }

    printf("\nSuccessors:\n");
    for (int i = 0; i < graph->numVertices; i++) {
        printf("%d: ", i);
        struct Node* current = graph->array[i].head;
        int first = 1; // To format output
        while (current != NULL) {
            if (current->vertex != i) { // Exclude self-loops
                if (!first) {
                    printf(", ");
                }
                printf("%d", current->vertex);
                first = 0;
            }
            current = current->next;
        }
        printf("\n");
    }
}

int main() {
    int vertices = 6; // Define the number of vertices
    struct Graph* graph = createGraph(vertices);

    // Define the edges of the control flow graph
    addEdge(graph, 0, 1);
    addEdge(graph, 0, 2);
    addEdge(graph, 1, 3);
    addEdge(graph, 2, 3);
    addEdge(graph, 3, 4);
    
    // Print predecessors and successors
    printPredecessorsSuccessors(graph);

    // Free allocated memory (cleanup)
    for (int i = 0; i < vertices; i++) {
        struct Node* current = graph->array[i].head;
        while (current != NULL) {
            struct Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph->array);
    free(graph);

    return 0;
}

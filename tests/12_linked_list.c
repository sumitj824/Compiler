
struct Node
{
	int key;
	struct Node* next;
};

void push(struct Node *head, int new_key)
{
	struct Node *new_node,*cur;
    cur=head;
	new_node->key = new_key;
	new_node->next = 0;
    while (cur->next!=0)
    {
        cur = cur->next;
    }
    cur->next = new_node;
    return ;
}

// int search(struct Node* head, int x)
// {
// 	struct Node* current = head; 
// 	while (current != 0)
// 	{
// 		if (current->key == x)
// 			return 1;
// 		current = current->next;
// 	}
// 	return 0;
// }

int main()
{
	struct Node* head;
	int x = 21,found;

	/* Use push() to construct below list
	14->21->11->30->10 */
	push(head, 14);
	push(head, 21);
	push(head, 11);
	push(head, 30);
	push(head, 10);

	// found=search(head, 21);
    // printf(found);
	return 0;
}

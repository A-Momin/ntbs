"""An ordered symbol table implementation of key-value pairs."""

from typing import Iterable, Generic, Optional
from ._nodes import AVLNode as Node, T, V
#==============================================================================


class AVLTreeST(Generic[T, V]):
    """Symbol table implementation using AVL tree.

    The class represents an ordered symbol table of key-value pairs.
    A symbol table implements the associative array abstraction: when
    associating a value with a key that is already in the symbol table, the
    convention is to replace the old value with the new value. Setting the
    value associated with a key to None is equivalent to deleting the key from
    the table.

    The implementation uses AVL tree (https://en.wikipedia.org/wiki/AVL_tree),
    which is a self-balancing BST. In an AVL tree, the heights of the two
    child subtrees of any node differ by at most one; if at any time
    they differ by more than one, re-balancing is done to restore this
    property.
    """
    def __init__(self, node=Node):
        """It initializes an ordered symbol table. """
        self._root: Optional[Node[T, V]] = None  # root of BST
        self._Node: Node[T, V] = node  # internal node of this bst

    def is_empty(self) -> bool:
        """Check whether this symbol table is empty or not. """
        return self._root is None

    def size(self) -> int:
        """Counts the number of key-value pairs in the symbol table. """
        return self._size(self._root)

    def _size(self, x: Node) -> int:
        """Return the number of elements in the subtree. """
        return 0 if x is None else x._size

    def height(self) -> int:
        """Computes the height of the AVL tree.

        The convention is that the height of a empty subtree is -1 and subtree
        with one element is 0.

        Returns:
            The height of this tree.
        """
        return self._height(self._root)

    def _height(self, x: Node) -> int:
        """Return the height of the given subtree.
        
        Args:
            x : A subtree of this tree.
        """
        return -1 if x is None else x._height

    def contains(self, key: T) -> bool:
        """Check whether the symbol table contains the given key or not.

        Args:
            key: The key to check if it's in the symbol table.

        Returns:
            True if the tree contains the given key or False otherwise.

        Raises:
            KeyError: if the given key is None.
        """
        if key is None: raise KeyError("Can't search 'None'")
        return self.get(key) is not None

    def get(self, key: T) -> Node:
        """Returns the value associated with given key or None if no such key.

        Args:
            key: The key of which value to be gotten.

        Returns:
            Subtree corresponding to the given key if it's in the symbol table
            and None if it's not in the symbol table.

        Raises:
            KeyError: if the given key is None.
        """
        if key is None: raise KeyError("Can't get 'None'")
        x = self._get(self._root, key)
        if x is None: return None
        return x._value

    def _get(self, x: Node, key: T) -> Node:
        """Return the subtree associate with the given key.

        Args:
            x  : A subtree of this tree.
            key: The key with which a value is associated.

        Returns:
            Subtree corresponding to the given key if it's in the symbol table
            and None if it's not in the symbol table.
        """
        if x is None: return None
        elif key < x._key: return self._get(x._left, key)
        elif key > x._key: return self._get(x._right, key)
        else: return x

    def put(self, key: T, value: V):
        """Inserts the key-value pair into the symbol table.

        It overwrites the old value with the new value if the key is already
        in the symbol table. If the value is None, this effectively deletes the
        key from the table.

        Args:
            key  : The key to be inserted into the table.
            value: The value associated with the given key.

        Raises:
            KeyError: if attempts to put 'None'.
        """
        if key is None: raise KeyError("Can't insert 'None' in the table")
        if value is None:
            self._delete(self._root, key)
            return
        self._root = self._put(self._root, key, value)

    def _put(self, x: Node, key: T, value: V) -> Node:
        """Add the given key-value pair in the subtree rooted at x.

        If the key is already in the tree, its value gets updated.

        Args:
            x    : A subtree of this tree.
            key  : The key to be inserted into the symbol table.
            value: The value associated with the given key.

        Returns:
            The updated subtree.
        """
        if x is None: return self._Node(key, value, 1, 0)
        if key < x._key: x._left = self._put(x._left, key, value)
        elif key > x._key: x._right = self._put(x._right, key, value)
        else:
            x._value = value
            return x
        x._size = 1 + self._size(x._left) + self._size(x._right)
        x._height = 1 + max(self._height(x._left), self._height(x._right))
        return self._balance(x)

    def _balance_factor(self, x: Node) -> int:
        """Compute the difference in height of two children of the subtree, x.

        The balance factor is positive if the height of left subtree of x is
        greater than its right subtree, zero if they are equal, or negative
        otherwise.

        Args:
            x : A subtree of this tree.

        Returns:
            Height difference between the children of the given subtree.
        """
        return self._height(x._left) - self._height(x._right)

    def _balance(self, x: Node) -> Node:
        """Balance the given subtree 'x' if it violates AVL Tree property.

        Args:
            x : A subtree of this tree.

        Returns:
            The subtree with restored AVL Tree property.
        """
        if self._balance_factor(x) < -1:
            if self._balance_factor(x._right) > 0:
                x._right = self._rotate_right(x._right)
            x = self._rotate_left(x)
        elif self._balance_factor(x) > 1:
            if self._balance_factor(x._left) < 0:
                x._left = self._rotate_left(x._left)
            x = self._rotate_right(x)

        return x

    def _rotate_right(self, x: Node) -> Node:
        """Rotate the given subtree 'x' to the right.

        Args:
            x : A subtree of this tree.

        Returns:
            The right rotated subtree.
        """
        y = x._left
        x._left = y._right
        y._right = x
        y._size = x._size
        x._size = 1 + self._size(x._left) + self._size(x._right)
        x._height = 1 + max(self._height(x._left), self._height(x._right))
        y._height = 1 + max(self._height(y._left), self._height(y._right))

        return y

    def _rotate_left(self, x: Node) -> Node:
        """Rotate the given subtree (x) to the left.

        Args:
            x : A subtree of this tree.

        Returns:
            The left rotated subtree.
        """
        y = x._right
        x._right = y._left
        y._left = x
        y._size = x._size
        x._size = 1 + self._size(x._left) + self._size(x._right)
        x._height = 1 + max(self._height(x._left), self._height(x._right))
        y._height = 1 + max(self._height(y._left), self._height(y._right))

        return y

    def delete(self, key: T) -> None:
        """Remove the given key and associated value with it from the table.

        Args:
            key: The key to be removed.

        Raises:
            KeyError: if the given key is None.
        """
        if key is None: raise KeyError()
        if not self.contains(key): return
        self._root = self._delete(self._root, key)

    def _delete(self, x: Node, key: T) -> Node:
        """Remove the given key and associated value with it from the table.

        Args:
            x : A subtree of this tree.
            key     : The key to be removed from this tree.

        Returns:
            The updated subtree.
        """
        if x is None: return
        elif key < x._key: x._left = self._delete(x._left, key)
        elif key > x._key: x._right = self._delete(x._right, key)
        else:
            if x._left is None: return x._right
            elif x._right is None: return x._left
            else:
                y = x
                x = self._min(y._right)
                x._right = self._delete_min(y._right)
                x._left = y._left

        x._size = 1 + self._size(x._left) + self._size(x._right)
        x._height = 1 + max(self._height(x._left), self._height(x._right))
        return self._balance(x)

    def delete_min(self) -> None:
        """Removes the smallest key and its value from the table."""
        if self.is_empty(): raise RuntimeError()
        self._root = self._delete_min(self._root)

    def _delete_min(self, x: Node) -> Node:
        """Delete the minimum key and its value from the table.

        Args:
            x : A subtree of this tree.

        Returns:
            The updated subtree.
        """
        if x._left is None: return x._right
        x._left = self._delete_min(x._left)
        x._size = 1 + self._size(x._left) + self._size(x._right)
        x._height = 1 + max(self._height(x._left), self._height(x._right))
        return self._balance(x)

    def delete_max(self) -> None:
        """Remove the largest key and its value from the symbol table"""
        if self.is_empty(): return RuntimeError()
        self._root = self._delete_max(self._root)

    def _delete_max(self, x: Node) -> Node:
        """Remove the largest key and its value from the given subtree

        Args:
            x : A subtree of this tree.

        Returns:
            The updated subtree.
        """
        if x._right is None: return x._right
        x._right = self._delete_max(x._right)
        x._size = 1 + self._size(x._left) + self._size(x._right)
        x._height = 1 + max(self._height(x._left), self._height(x._right))
        return self._balance(x)

    def max(self) -> Node:
        """Finds the largest key in the Symbol table.

        Returns:
            The node of largest key.

        Raises:
            RuntimeError: if calls on empty table.
        """
        if self.is_empty(): return RuntimeError()
        return self._max(self._root)

    def _max(self, x: Node) -> Node:
        """Finds the subtree with the largest key in the table

        Returns:
            The node of largest key.
        """
        if x._right is None: return x
        else: return self._max(x._right)

    def min(self) -> Node:
        """Finds the smallest key in the Symbol table.

        Returns:
            The node of smallest key.

        Raises:
            RuntimeError: if calls on empty table.
        """
        if self.is_empty(): return RuntimeError()
        return self._min(self._root)

    def _min(self, x: Node) -> Node:
        """Finds the subtree with the smallest key in the Symbol table.

        Returns:
            The node of smallest key.
        """
        if x._left is None: return x
        else: return self._min(x._left)

    def floor(self, key: T):
        """Finds the largest key less than or equal to the given key.

        Args:
            key: The key of which floor to be computed.

        Returns:
            The largest key less than or equal to the given key.
        
        Raises:
            KeyError: if the given key is None.
        """
        if key is None: raise KeyError("Can't search 'None' in the table")
        if self.is_empty(): raise RuntimeError("underflow")
        x = self._floor(self._root, key)
        if x is None: return None
        return x._key

    def _floor(self, x: Node, key: T) -> Node:
        """Finds the subtree with the largest key ≤ the given key.

        Args:
            x  : The subtree.
            key: The key of which floor to be computed.

        Returns:
            Subtree with the largest key less than or equal to the given key.
        """
        if x is None: return None
        elif key == x._key: return x
        elif key < x._key: return self._floor(x._left, key)

        y = self._floor(x._right, key)
        if y is not None: return y
        else: return x

    def ceiling(self, key: T) -> T:
        """Finds the smallest key greater than or equal to the given key.

        Args:
            key: The key of which ceiling to be computed.

        Returns:
            The smallest key greater than or equal to the given key
        
        Raises:
            KeyError: if the given key is None.
        """
        if key is None: raise KeyError("Can't search 'None' from the table")
        if self.is_empty(): raise RuntimeError("underflow")
        x = self._ceiling(self._root, key)
        if x is None: return None
        return x._key

    def _ceiling(self, x: Node, key: T) -> Node:
        """Finds the subtree with the smallest key ≥ the given key.

        Args:
            x  : A subtree of this tree.
            key: The key of which ceiling to be computed.

        Returns:
            Subtree with the smallest key greater than or equal to
            the given key.
        """
        if x is None: return None
        if key == x._key: return x
        if key > x._key: return self._ceiling(x._right, key)
        y = self._ceiling(x._left, key)
        if y is not None: return y
        else: return x

    def select(self, k: int) -> T:
        """Finds the kth smallest key in the symbol table.

        Args:
            k: The kth smallest key in the subtree.

        Returns:
            T: The kth smallest key in the table.
        """
        if not (0 <= k < self.size()):
            raise ValueError("k is out of range")
        x = self._select(self._root, k)
        return x._key

    def _select(self, x: Node, k: T) -> Node:
        """Finds the subtree with the kth smallest key.

        Args:
            x: A subtree of this tree.
            k: The kth smallest key in the subtree.

        Returns:
            The subtree with the kth smallest key.
        """
        if x is None: return None
        elif k < self._size(x._left): return self._select(x._left, k)
        elif k > self._size(x._left):
            return self._select(x._right, (k - self._size(x._left)) - 1)
        else:
            return x

    def rank(self, key: T) -> int:
        """Counts the number of keys in the table strictly less than key.

        Args:
            key: The key of which rank to be computed.

        Returns:
            The number of keys strictly less than the given key.
        
        Raises:
            KeyError: if the given key is None.
        """
        if key is None: raise KeyError("key can't be 'None'")
        return self._rank(self._root, key)

    def _rank(self, x: Node, key: T) -> int:
        """Counts the number of keys in the subtree less than key.

        Args:
            x  : A subtree of this tree.
            key: The key of which rank to be computed.

        Returns:
            The number of keys in the subtree less than key.
        """
        if x is None: return 0
        elif key < x._key: return self._rank(x._left, key)
        elif key > x._key:
            return 1 + self._size(x._left) + self._rank(x._right, key)
        else:
            return self._size(x._left)

    def keys(self) -> Iterable[T]:
        """Returns all keys in the symbol table.

        Returns:
            An iterable containing all keys in the symbol table.
        """
        return self.keys_inorder()

    def keys_inorder(self) -> Iterable[T]:
        """Returns all keys in the table following the in-order traversal.

        Returns:
            An iterable containing all keys in the table.
        """
        q = []
        self._keys_inorder(self._root, q)
        return q

    def _keys_inorder(self, x: Node, queue: Iterable[T]):
        """Adds the keys to queue following an in-order traversal.

        Args:
            x    : A subtree of this tree.
            queue: The queue to hold the keys.
        """
        if x is None: return
        self._keys_inorder(x._left, queue)
        queue.append(x._key)
        self._keys_inorder(x._right, queue)

    def keys_level_order(self) -> Iterable[T]:
        """Returns all keys in the table following the in-order traversal.

        Returns:
            An iterable containing all keys in the table.
        """
        q1 = []
        if not self.is_empty():
            q2 = []
            q2.append(self._root)
            while len(q2) > 0:
                x = q2.pop(0)
                q1.append(x._key)
                if x._left is not None:
                    q2.append(x._left)
                if x._right is not None:
                    q2.append(x._right)

        return q1

    def keys_inrange(self, low_key: T, high_key: T) -> Iterable[T]:
        """Collects all keys in between low_key and high_key (exclusive).

        Args:
            low_key : The lowest key of the given range.
            high_key: The highest key of the given range.

        Returns:
            An iterable containing all keys in between low_key (inclusive) and
            high_key (exclusive).

        Raises:
            KeyError: if the given low_key or high_key is None.
        """
        if low_key is None: raise KeyError("keys can't be 'None'")
        if high_key is None: raise KeyError("keys can't be 'None'")
        q = []
        self._keys_inrange(self._root, q, low_key, high_key)
        return q

    def _keys_inrange(self, x: Node, q: Iterable[T], low_key: T, high_key: T):
        """Collects all keys in between low_key and high_key as iterable.

        Args:
            x       : A subtree of this tree.
            queue   : The queue to hold the keys.
            low_key : The lowest key.
            high_key: The highest key.
        """
        if x is None: return None
        if low_key < x._key: self._keys_inrange(x._left, q, low_key, high_key)
        if low_key == x._key and high_key >= x._key: q.append(x._key)
        if high_key > x._key:
            self._keys_inrange(x._right, q, low_key, high_key)

    def size_inrange(self, low_key: T, high_key: T) -> int:
        """Counts the number of keys in in between low_key and high_key.

        Args:
            low_key : The lowest key of the given range.
            high_key: The highest key of the given range.

        Returns:
            The number of keys in between low_key (inclusive) and
            high_key (inclusive).

        Raises:
            KeyError: if the given low_key or high_key is None.
        """
        if low_key is None: raise KeyError("keys can't be 'None'")
        if high_key is None: raise KeyError("keys can't be 'None'")
        if low_key > high_key:
            return 0
        if self.contains(high_key):
            return self.rank(high_key) - self.rank(low_key) + 1
        return self.rank(high_key) - self.rank(low_key)

    def checked(self) -> bool:
        """Check if all the representational invariantsis are consistent.

        Returns:
            True if all the representational invariantsis are consistent or
            False otherwise.
        """
        if not self.is_BST():
            print("Symmetric order not consistent")
        if not self.is_AVL():
            print("AVL property not consistent")
        if not self.is_size_consistent():
            print("Subtree counts not consistent")
        if not self.is_rank_consistent():
            print("Ranks not consistent")
        return (self.is_BST() and self.is_AVL() and self.is_size_consistent()
                and self.is_rank_consistent())

    def is_AVL(self) -> bool:
        """Check if the AVL property of the tree is consistent.

        Returns:
            True if AVL property is consistent or False otherwise.
        """
        return self._is_AVL(self._root)

    def _is_AVL(self, x: Node) -> bool:
        """Check if the AVL property of the subtree is consistent.

        Args:
            x : A subtree of this tree.

        Returns:
            True if AVL property is consistent or False otherwise.
        """
        if x is None:
            return True
        bf = self._balance_factor(x)
        if bf < -1 or bf > 1:
            return False
        else:
            return self._is_AVL(x._left) and self._is_AVL(x._right)

    def is_BST(self) -> bool:
        """Check if the BST property of the tree is consistent.

        Returns:
            True if BST property is consistent or False otherwise.
        """
        return self._is_BST(self._root, None, None)

    def _is_BST(self, x: Node, smaller: T, larger: T) -> bool:
        """Check if the BST property of the subtree (x) is consistent.

        Args:
            x : A subtree of this tree.

        Returns:
            True if BST property of subtree is consistent or False
            otherwise.
        """
        if x is None:
            return True
        if smaller is not None and x._key <= smaller:
            return False
        if larger is not None and x._key >= larger:
            return False
        return self._is_BST(x._left, smaller, x._key) and self._is_BST(
            x._right, x._key, larger)

    def is_size_consistent(self) -> bool:
        """Check if the size of the AVL tree is consistent.

        Returns:
            True if the size of the AVL tree is consistent or False otherwise.
        """
        return self._is_size_consistent(self._root)

    def _is_size_consistent(self, x: Node) -> bool:
        """Check if the size of the subtree (x) is consistent.

        Args:
            x : A subtree of this tree.

        Returns:
            True if the size of the subtree is consistent or False otherwise.
        """
        if x is None: return True
        if self._size(x) != 1 + self._size(x._left) + self._size(x._right):
            return False
        return self._is_size_consistent(x._left) and self._is_size_consistent(
            x._right)

    def is_rank_consistent(self) -> bool:
        """Check if the rank of the AVL tree is consistent.

        Returns:
            True if the rank of the AVL tree is consistent or False otherwise.
        """
        for i in range(self.size()):
            if i != self.rank(self.select(i)): return False
        for key in self.keys():
            if key != self.select(self.rank(key)): return False
        return True

    # ************************ Python Special Methods: ************************#
    def __len__(self):
        return self._size()

    def __setitem__(self, key: T, value: V):
        self.put(key, value)

    def __getitem__(self, key: T):
        return self.get(key)

    def __contains__(self, key: T):
        return self.contains(key)

    def __delitem__(self, key: T):
        self.delete(key)

    def __iter__(self):
        if self._root is not None: return iter(self._root)
        else: return iter([])

    # ********************* End of Python Special Methods *********************#

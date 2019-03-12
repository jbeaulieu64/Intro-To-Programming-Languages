{-|
  | This module implements a binary tree that satisfies the properties of a maximum heap.
  | The heap is used as a priority queue, with the highest priority found at the root of
  | the heap. The heap holds patient information, including the patient's name, an
  | integer priority, and the amount they owe.
  |
  | The module has the expected insert, delete, and peek that works with single patients.
  | In addition, the module supports several other operations to get information about
  | the heap's current properties.
-}

module PA1 where

type Patient = (Name, Priority, Bill)
type Name = String
type Priority = Int
type Bill = Double

-- data type for a binary tree where Patient values are stored at each HeapNode and
-- Tips are valueless leaf node markers
data Heap a = Tip | HeapNode a (Heap a) (Heap a) deriving (Eq, Ord, Show)

-- insert a Patient value into the heap by merging a heap with only the patient with the rest of the heap
insert :: Patient -> Heap Patient -> Heap Patient
insert p h = merge (HeapNode p Tip Tip) h

-- delete the root of the heap and merge the two child nodes
delete :: Heap Patient -> Heap Patient
delete (HeapNode p l r) = merge l r

-- get the priority of a patient
getPriority :: Patient -> Priority
getPriority (_,prio,_) = prio


{- TODO: implement the functions below-}
-- merge two heaps together while maintaining heap properties
merge :: Heap Patient -> Heap Patient -> Heap Patient
merge (Tip) (Tip) = (Tip)
merge l@(HeapNode _ _ _) (Tip) = l
merge (Tip) r@(HeapNode _ _ _) = r
merge h1@(HeapNode p1 l1 r1) h2@(HeapNode p2 l2 r2)
      | prio1 > prio2 = (HeapNode p1 (merge h2 r1) (l1))
      | prio1 <= prio2 = (HeapNode p2 (merge h1 r2) (l2))
      where prio1 = getPriority p1
            prio2 = getPriority p2

-- return the patient with the highest priority
peek :: Heap Patient -> Patient
peek (Tip) = ("",-1,0.0)
peek (HeapNode p _ _) = p

-- convert a heap to a list of patients, with the list showing the tree from left to right
heap2InList :: Heap Patient -> [Patient]
heap2InList (Tip) = []
heap2InList (HeapNode pat l r) = (heap2PreList l) ++ [pat] ++ (heap2PreList r)

-- convert a heap to a list of patients with each node printed before its children
heap2PreList :: Heap Patient -> [Patient]
heap2PreList (Tip) = []
heap2PreList (HeapNode pat l r) = [pat] ++ (heap2PreList l) ++ (heap2PreList r)

-- extract all of the patient names in order of top-to-bottom, left-to-right
heap2Names :: Heap Patient -> [Name]
heap2Names (Tip) = []
heap2Names h = [ n | (n,_,_) <- (heap2PreList h) ]

-- return whether the heap has no patients in it
isEmpty :: Heap Patient -> Bool
isEmpty (Tip) = True
isEmpty _ = False

-- return the height of the heap
height :: Heap Patient -> Int
height (Tip) = 0
height (HeapNode _ l r) = 1 + max (height l) (height r)

-- return the heap with a function applied to all Bills in the heap
heapMap :: (Bill -> Bill) -> Heap Patient -> Heap Patient
heapMap _ (Tip) = (Tip)
heapMap f (HeapNode (name,prio,bill)) = (HeapNode (name,prio, f bill) (heapMap f l) (heapMap f r))

size :: Heap Patient -> Int
size (Tip) = 0
size (HeapNode _ l r) = 1 + (size l) + (size r)

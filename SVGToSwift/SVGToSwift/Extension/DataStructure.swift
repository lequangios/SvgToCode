//
//  DataStructure.swift
//  SVGToSwift
//
//  Created by Le Quang on 5/3/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

enum ErrorCode {
    case Overflow
    case Success
    case Failed
    case Empty
}

typealias DataOut<T> = (node:T?, errorcode:ErrorCode)
typealias ListDataOut<T> = (node:[T]?, errorcode:ErrorCode)
typealias DataOperation<T,V> = (T)->V

public protocol NodeProtocol : Equatable, NSCopying {
    func nodeInfo()->String
}

public class Node<T:NodeProtocol> {
    var data: T
    var next : Node?
    weak var previous: Node?
    public init(data: T){
        self.data = data
        self.next = nil
        self.previous = nil
    }
    
    public var size:Int {
        return MemoryLayout<Node>.stride
    }
    
    deinit {
        print("deinit Node")
    }
}

//MARK:--
//MARK: LinkedList

public class LinkedList<T:NodeProtocol> {
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    private var size:Int = 0
    private var length:Int = 0
    private var maxSize:Int = -1 // Mean unlimited
    private var itemSize:Int = 0
    
    public var name:String = ""
    
    init() {
        head = nil
        tail = nil
        name = String(describing: LinkedList.Type.self)
        itemSize = MemoryLayout<Node<T>>.stride
    }
    
    init(maxSize:Int){
        self.maxSize = maxSize
        head = nil
        tail = nil
        name = String(describing: LinkedList.Type.self)
        itemSize = MemoryLayout<Node<T>>.stride
    }
    
    private func increaseSize() {
        length = length + 1
        size = size + itemSize
    }
    
    private func decreaseSize() {
        length = length - 1
        size = size - itemSize
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var isFull : Bool {
        return size >= maxSize && maxSize > 0
    }
    
    public var isHaveSpace : Bool {
        return maxSize < 0 || size <= maxSize - itemSize
    }

    public var first: Node<T>? {
        return head
    }

    public var last: Node<T>? {
        return tail
    }
    
    func getSize() -> Int { return size }
    func getLength() -> Int { return length }
    
    func insertHead(node:Node<T>) -> ErrorCode {
        if isHaveSpace {
            if isEmpty {
                head = node
                tail = node
            }
            else {
                node.next = head
                node.previous = nil
                head = node
            }
            increaseSize()
            return .Success
        }
        return .Overflow
    }
    
    func insertTail(node:Node<T>) -> ErrorCode {
        if isHaveSpace {
            if isEmpty {
                head = node
                tail = node
            }
            else {
                tail?.next = node
                node.previous = tail
                tail = node
            }
            increaseSize()
            return .Success
        }
        return .Overflow
    }
    
    func insert(node:Node<T>, position:Int) -> ErrorCode {
        if position >= length || position < 0 || !isHaveSpace { return .Overflow }
        if position == 0 { return insertHead(node: node) }
        else if position == length-1 { return insertTail(node: node) }
        else {
            var pWalker = head
            var index = 0
            while index != position {
                pWalker = pWalker?.next
                index = index + 1
            }
            
            node.next = pWalker
            node.previous = pWalker?.previous
            pWalker?.previous?.next = node
            pWalker?.previous = node
            
            increaseSize()
        }
        return .Success
    }
    
    func replace(inNode:Node<T>, position:Int) -> DataOut<T> {
        if position < 0 || position >= length { return (nil, .Overflow) }
        else  if position == 0 { return replaceHead(inNode: inNode) }
        else if position == length - 1 { return replaceTail(inNode: inNode) }
        else {
            var pUpdate = head
            var index = 0
            while index != position {
                pUpdate = pUpdate?.next
                index = index + 1
            }
            
            let data = pUpdate?.data.copy() as? T
            pUpdate?.data = inNode.data
            return (data, .Success)
        }
    }
    
    func replaceHead(inNode:Node<T>) -> DataOut<T> {
        if isEmpty {
            return (nil, .Empty)
        }
        else {
            let data = head?.data.copy() as? T
            head?.data = inNode.data
            return (data, .Success)
        }
    }
    
    func replaceTail(inNode:Node<T>) -> DataOut<T> {
        if isEmpty {
            return (nil, .Empty)
        }
        else {
            let data = tail?.data.copy() as? T
            tail?.data = inNode.data
            return (data, .Success)
        }
    }
    
    func remove(position:Int) -> DataOut<T> {
        if position >= length || position < 0 { return (nil, .Overflow) }
        if position == 0 { return removeHead() }
        else if position == length-1 { return removeTail() }
        else {
            var index = 0
            var pDel = head
            while index < position{
                pDel = pDel?.next
                index = index + 1
            }
            
            pDel?.previous?.next = pDel?.next
            pDel?.next?.previous = pDel?.previous
            let data = pDel?.data.copy() as? T
            pDel = nil
            decreaseSize()
            return (data, .Success)
            
        }
    }
    
    func removeHead() -> DataOut<T> {
        if isEmpty {
            return (nil, .Empty)
        }
        else {
            let data = head?.data.copy() as? T
            var pDel = head
            head = pDel?.next
            head?.previous = nil
            pDel = nil
            decreaseSize()
            if length == 0 {
                tail = nil
            }
            
            return (data, .Success)
        }
    }
    
    func removeTail() -> DataOut<T> {
        if isEmpty {
            return (nil, .Empty)
        }
        else {
            let data = tail?.data.copy() as? T
            var pDel = tail
            tail = pDel?.previous
            tail?.next = nil
            pDel = nil
            decreaseSize()
            if length == 0 {
                head = nil
            }
            return (data, .Success)
        }
    }
    
    func linearSearch(operation:(_ index:Int, _ node:Node<T>)->Bool) -> ListDataOut<T> {
        var pPre:[T]? = []
        var pLoc = head
        var index = 0
        var count = 0
        while pLoc != nil {
            if operation(index, pLoc!) {
                count = count + 1
                pPre?.append(pLoc!.data)
            }
            index = index + 1
            pLoc = pLoc?.next
        }
        if count > 0 {
            return (pPre, .Success)
        }
        else {
            return (nil, .Failed)
        }
    }
    
    func traverse(operation:(_ index:Int, _ node:Node<T>) -> Void){
        if !isEmpty {
            let index = 0
            var pWalk = head
            while pWalk != nil {
                if let walk = pWalk {
                    operation(index, walk)
                }
                pWalk = pWalk?.next
            }
        }
    }
    
    func transform(operation:(_ index:Int, _ node:Node<T>) -> Node<T>){
        if !isEmpty {
            let index = 0
            var pWalk = head
            while pWalk != nil {
                if let walk = pWalk {
                    let newnode = operation(index, walk)
                    newnode.next = pWalk?.next
                    newnode.previous = pWalk?.previous
                    pWalk = newnode
                }
                pWalk = pWalk?.next
            }
        }
    }
    
    func clear() {
        if !isEmpty {
            var pDel = head
            while pDel != nil {
                head = head?.next
                head?.previous = nil
                pDel = nil
                pDel = head
            }
            tail = nil
            size = 0
            length = 0
        }
    }
    
    public func printData() {
        var pWalk = head
        var log:[String] = []
        while pWalk != nil {
            log.append(pWalk?.data.nodeInfo() ?? "☠️")
            pWalk = pWalk?.next
        }
        let str = "List \(name) : \(log.joined(separator: "-->"))\nsize = \(size) byte\nlength = \(length)"
        print(str)
    }
    
    deinit {
        clear()
        print("deinit LinkedList")
    }
}

//MARK:--
//MARK: Stack
public class Stack<T:NodeProtocol> : LinkedList<T> {
    override init() {
        super.init()
    }
    
    override init(maxSize: Int) {
        super.init(maxSize: maxSize)
    }
    
    func push(node:Node<T>) -> ErrorCode {
        return insertHead(node: node)
    }
    
    func pop() -> DataOut<T> {
        return removeHead()
    }
    
    func top() -> Node<T>? {
        return first
    }
}

//MARK:--
//MARK: Queue
public class Queue<T:NodeProtocol> : LinkedList<T> {
    override init() {
        super.init()
    }
    
    override init(maxSize: Int) {
        super.init(maxSize: maxSize)
    }
    
    func enQueue(node:Node<T>) -> ErrorCode {
        return super.insertTail(node: node)
    }
    
    func deQueue() -> DataOut<T> {
        return super.removeHead()
    }
    
    func queueFront() -> Node<T>? {
        return first
    }
    
    func queueRear() -> Node<T>? {
        return last
    }
}

class ExampleData : NodeProtocol {
    var number:Int
    
    init(number:Int) {
        self.number = number
    }
    
    func nodeInfo() -> String {
        return "\(number) "
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return ExampleData(number: number)
    }
    
    static func == (lhs: ExampleData, rhs: ExampleData) -> Bool {
        return lhs.number == rhs.number
    }
}

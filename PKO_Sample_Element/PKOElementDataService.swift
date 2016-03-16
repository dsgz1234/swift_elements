//
//  PKOElementDataService.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-13.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOElementDataService {//这里的“元素”均指业务上的化学元素，不要误会为技术词汇
    var elementDictionarys = [String:PKOElementDataModel]()//[元素名字：元素对象]
    
    var symbolLetterArray = [String]()
    var stateArray = [String]()
    
    var elementByNameArray = [PKOElementDataModel]()
    var elementByNumberArray = [PKOElementDataModel]()
    var elementSymbolDictionarys = [String:[PKOElementDataModel]]()//[元素简称首字母：元素对象集合]
    var elementStateDictionarys = [String:[PKOElementDataModel]]()//[元素状态：元素对象集合]
    
    struct Inner {//单例模式的对象
        static var instance: PKOElementDataService?
        static var token: dispatch_once_t = 0
    }
    
    class var sharedElementDataService: PKOElementDataService {//使用gcd技术保证线程安全
    dispatch_once(&Inner.token) {
        Inner.instance = PKOElementDataService()
        }
        return Inner.instance!
    }
    
    init() {
        self.initElementArray()
    }
    
    func initElementArray() {
        var thePath = NSBundle.mainBundle().pathForResource("Elements", ofType: "plist")!
        
        var elementArray = NSArray(contentsOfFile: thePath)!//解析plist
        
        self.elementDictionarys = [String:PKOElementDataModel]()
        self.elementStateDictionarys = [String:[PKOElementDataModel]]()
        self.elementSymbolDictionarys = [String:[PKOElementDataModel]]()
        
        self.stateArray = [String]()
        self.symbolLetterArray = [String]()
        
        for elementArrayDictionary in elementArray {
            
            var elementDataModel = PKOElementDataModel().initWithDictionary(elementArrayDictionary as! NSDictionary)
            self.elementDictionarys[elementDataModel.name] = elementDataModel
            if (self.elementStateDictionarys[elementDataModel.state] != nil) {
                self.elementStateDictionarys[elementDataModel.state]?.append(elementDataModel)
            } else {
                self.stateArray.append(elementDataModel.state)
                self.elementStateDictionarys[elementDataModel.state] = [PKOElementDataModel]()
                self.elementStateDictionarys[elementDataModel.state]?.append(elementDataModel)
            }
            
            var symbolLetter = elementDataModel.symbol.substringToIndex(elementDataModel.symbol.startIndex.advancedBy(1))//获取首字母，需要用advance构建一个String.index，具体方法请看advance的官方文档
            
            if (self.elementSymbolDictionarys[symbolLetter] != nil) {
                self.elementSymbolDictionarys[symbolLetter]?.append(elementDataModel)
            } else {
                self.symbolLetterArray.append(symbolLetter)
                
                self.elementSymbolDictionarys[symbolLetter] = [PKOElementDataModel]()
                self.elementSymbolDictionarys[symbolLetter]?.append(elementDataModel)
            }
        }
        
        self.elementByNameArray = self.presortElementsByName()
        
        self.elementByNumberArray = self.presortElementsByNumber()
        
        self.symbolLetterArray = self.presortSymbolLetters()
        for letter in self.symbolLetterArray {
            self.presortElementsBySymbol(letter as String)
        }
        
        self.stateArray = self.presortStates()
        for state in self.stateArray {
            self.presortElementsByState(state as NSString as String)
        }
    }
    
    // sort the elementsSortedByName array
    func presortElementsByName() -> [PKOElementDataModel] {//下面多个方法分类别为元素集合排序
        let values = self.elementDictionarys.values
        let sortedElements = values.sort { (s1, s2) -> Bool in
            return s1.name < s2.name
        }
        return sortedElements
    }
    
    // sort the elementsSortedByNumber array
    func presortElementsByNumber() -> [PKOElementDataModel] {
        let values = self.elementDictionarys.values
        let sortedElements = values.sort({
            (s1 , s2) -> Bool in
            return s1.atomicNumber > s2.atomicNumber
        })
        return sortedElements
    }
    
    // sort the symbolLetter array
    func presortSymbolLetters() -> [String] {
        let keys = self.elementSymbolDictionarys.keys
        let sortedElement = keys.sort({
            (s1 , s2) ->Bool in
            return s2 > s1
        })
        return sortedElement
    }
    
    // sort the elementsSortedByName array
    func presortElementsBySymbol(letter : String) {
        self.elementSymbolDictionarys[letter]?.sortInPlace({
            (s1 , s2) ->Bool in
            return s1.name > s2.name
        })
    }
    
    // sort the state array
    func presortStates () -> [String]{
        let keys = self.elementStateDictionarys.keys
        let sortedElements = keys.sort({
            (s1 , s2) ->Bool in
            return s2 > s1
        })
        return sortedElements
    }
    
    // sort the elementsSortedByName array
    func presortElementsByState (state : String) {
        
        self.elementStateDictionarys[state]?.sortInPlace({
            (s1 , s2) ->Bool in
            return s2.name > s1.name
        })
    }
}

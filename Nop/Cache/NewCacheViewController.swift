//
//  NewCacheViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/11/11.
//

import UIKit
import SwiftyJSON
import SDWebImage

public typealias SMJDataLoaderCompletedBlock<T> = (Swift.Result<T, Error>) -> Void
public typealias SMJDataLoaderProgressBlock = (Float) -> Void

public protocol SMJDataLoaderProtocol {
    func request<Decoder: SMJDataDecoder>(decoder: Decoder, progress: SMJDataLoaderProgressBlock?, completion: SMJDataLoaderCompletedBlock<Decoder.ResultType>?)
}

public protocol SMJDataDecoder {
    associatedtype ResultType
    func decode(from data: Data) -> ResultType?
}


public struct SMJJsonLoader: SMJDataLoaderProtocol {
    
    public func request<Decoder: SMJDataDecoder>(decoder: Decoder, progress: SMJDataLoaderProgressBlock?, completion: SMJDataLoaderCompletedBlock<Decoder.ResultType>?) {
        
    }
}

//
//  Loading.swift
//  AdvancedCollectionView
//
//  Created by Zachary Waldowski on 12/14/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

import Foundation

public enum LoadingState {

    /// The initial state.
    case Initial
    /// The first load of content.
    case Loading
    /// Subsequent loads after the first.
    case Refreshing
    /// Content has loaded successfully.
    case Loaded
    /// No content is available.
    case NoContent
    /// An error occurred while loading content.
    case Error(NSError)
    
    var error: NSError? {
        switch self {
        case .Error(let error):
            return error
        default:
            return nil
        }
    }
    
}

public final class Loader {
    
    public typealias Update = () -> ()
    public typealias CompletionHandler = (LoadingState?, Update?) -> ()

    private var completionHandler: CompletionHandler!
    init(completionHandler: CompletionHandler) {
        self.completionHandler = completionHandler
    }
    
    public var isCurrent = true
    
    private func done(newState state: LoadingState?, update: Update? = nil) {
        if completionHandler == nil { return }
        let block = completionHandler
        
        async(Queue.mainQueue) {
            block(state, update)
        }
        
        completionHandler = nil
    }
    
    public func ignore() {
        done(newState: nil)
    }
    
    public func update(content update: Update) {
        done(newState: .Loaded, update: update)
    }
    
    public func error(error: NSError) {
        done(newState: .Error(error), update: nil)
    }
    
    public func noContent(update: Update) {
        done(newState: .NoContent, update: update)
    }
    
}
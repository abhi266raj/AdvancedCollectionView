//
//  GridLayoutAttributes.swift
//  AdvancedCollectionView
//
//  Created by Zachary Waldowski on 12/15/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

import UIKit

public final class GridLayoutAttributes: UICollectionViewLayoutAttributes {
    
    /// If this is a header, is it pinned to the top of the collection view?
    public var pinned = false
    /// If this is pinned, where is our minY when we unpin it?
    public var unpinned: CGFloat? = nil
    /// The background color for the view
    public var backgroundColor: UIColor? = nil
    /// The background color when selected
    public var selectedBackgroundColor: UIColor? = nil
    /// The background color for the view
    public var tintColor: UIColor? = nil
    /// The background color when selected
    public var selectedTintColor: UIColor? = nil
    /// Used by supplementary items
    public var padding = UIEdgeInsetsZero
    
    /// What is the column index for this item?
    var columnIndex = 0
    
    public override var hash: Int {
        var hash = super.hash
        func update(value: Int?) {
            hash = 31 &* (value ?? 0) &+ hash
        }
        update(pinned.hashValue)
        update(unpinned?.hashValue)
        update(backgroundColor?.hashValue)
        update(selectedBackgroundColor?.hashValue)
        update(tintColor?.hashValue)
        update(selectedTintColor?.hashValue)
        update(padding.top.hashValue)
        update(padding.left.hashValue)
        update(padding.bottom.hashValue)
        update(columnIndex.hashValue)
        return hash
    }
    
    public override func isEqual(object: AnyObject?) -> Bool {
        if !super.isEqual(object) { return false }
        if let other = object as? GridLayoutAttributes {
            if pinned != other.pinned { return false }
            if unpinned != other.unpinned { return false }
            if backgroundColor != other.backgroundColor { return false }
            if selectedBackgroundColor != other.selectedBackgroundColor { return false }
            if tintColor != other.tintColor { return false }
            if selectedTintColor != other.selectedTintColor { return false }
            if padding != other.padding { return false }
            if columnIndex != other.columnIndex { return false }
            return true
        } else {
            return false
        }
    }
    
    public override func copyWithZone(zone: NSZone) -> AnyObject {
        var attributes = super.copyWithZone(zone) as GridLayoutAttributes
        attributes.pinned = pinned
        attributes.unpinned = unpinned
        attributes.backgroundColor = backgroundColor
        attributes.selectedBackgroundColor = selectedBackgroundColor
        attributes.tintColor = tintColor
        attributes.selectedTintColor = selectedTintColor
        attributes.padding = padding
        attributes.columnIndex = columnIndex
        return attributes
    }
    
}

public class GridLayoutInvalidationContext: UICollectionViewLayoutInvalidationContext {

    public var invalidateLayoutMetrics = true
    public var invalidateLayoutOrigin = false
    
}
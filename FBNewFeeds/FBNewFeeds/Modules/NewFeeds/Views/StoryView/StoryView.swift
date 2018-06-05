//
//  StoryView.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/31/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class StoryView: UIView {

    @IBOutlet weak var storyCollectionView: UICollectionView!
    private let cellIdentifier: String = "cellStore"
    private let itemSize = CGSize(width: 50, height: 80)
    var stories: [Stories] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        storyCollectionView.register(StoryCollectionViewCell.nibDefault(), forCellWithReuseIdentifier: cellIdentifier)
    }

    func reloadData(_ data: [Stories]) {
        stories = data
        storyCollectionView.reloadData()
    }

}

extension StoryView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODOs: did select item stories
    }

}

extension StoryView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
            for: indexPath) as? StoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.binding(stories[indexPath.row])
        return cell
    }

}

extension StoryView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }

}

extension StoryView {

    class func initWithDefaultNib() -> StoryView? {
        let list = Bundle.main.loadNibNamed("StoryView", owner: self, options: nil)
        let view = list?.first as? StoryView
        return view
    }

}

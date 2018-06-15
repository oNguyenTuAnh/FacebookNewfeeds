//
//  StoryTableViewCell.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/7/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var storyCollectionView: UICollectionView!
    private let cellIdentifier = "cellStore"
    private let itemSize = CGSize(width: 50, height: 80)
    var stories: [Stories] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        storyCollectionView.register(StoryCollectionViewCell.nibDefault(), forCellWithReuseIdentifier: cellIdentifier)
    }

    func bindingData(_ data: [Stories]) {
        stories = data
        storyCollectionView.reloadData()
    }

}

extension StoriesTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODOs: did select item stories
    }

}

extension StoriesTableViewCell: UICollectionViewDataSource {

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

extension StoriesTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }

}

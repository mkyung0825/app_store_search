//
//  SearchDetailReleaseNoteCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/26.
//

import UIKit

class SearchDetailReleaseNoteCell: UITableViewCell {
    
    @IBOutlet weak var mVersionLabel: UILabel!
    @IBOutlet weak var mReleaseDateLabel: UILabel!
    @IBOutlet weak var mReleaseNoteLabel: UILabel!
    @IBOutlet weak var mMoreButton: UIButton!
    
    var mProtocol:SearchViewProtocol!
    var mResult:Result!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        
        // 더보기 버튼
        mMoreButton.isUserInteractionEnabled = false
    }

    func setData(searchProtocol: SearchViewProtocol, result: Result, isExpand: Bool) {
        mProtocol = searchProtocol
        mResult = result
        
        // 버전
        mVersionLabel.text = "버전 \(result.version)"
        
        // 릴리즈 날짜
        mReleaseDateLabel.text = Common.getDiffDateString(dateStr: result.currentVersionReleaseDate)
        
        // 릴리즈 노트
        mReleaseNoteLabel.text = result.releaseNotes
        
        let noteHeight:CGFloat = mReleaseNoteLabel.sizeThatFits(mReleaseNoteLabel.frame.size).height
        
        // 더보기 버튼
        if result.releaseNotes.isEmpty || noteHeight < 20 {
            mMoreButton.isHidden = true
        } else {
            mMoreButton.isHidden = false
            
            // 릴리즈 노트 확장 여부 체크
            if isExpand {
                mMoreButton.isHidden = true
                mReleaseNoteLabel.numberOfLines = 0
            } else {
                mMoreButton.isHidden = false
                mReleaseNoteLabel.numberOfLines = 3
            }
        }
    }
}

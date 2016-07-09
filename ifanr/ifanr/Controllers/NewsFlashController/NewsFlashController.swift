//
//  NewsFlashControllerViewController.swift
//  ifanr
//
//  Created by sys on 16/6/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

class NewsFlashController: BasePageController {
    
    var dataSource : Array<HomePopularModel> = Array()

    //MARK:-----life cycle-----
    
    override func viewDidLoad() {
        
        self.backgroundImgName  = "buzz_header_background"
        self.tagImgName         = "tag_happeningnow"
        
        super.viewDidLoad()
        
        self.getData()
    }
    
    //MARK:-----custom function-----
    
    internal override func getData() {
        Alamofire.request(.GET, "https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=1&post_type=buzz&posts_per_page=12&sign=19eb476eb0c1fc74bee104316c626fd3&timestamp=1467296130", parameters: [:])
            .responseJSON { response in
                
                if let dataAny = response.result.value {
                    
                    let dataDic : NSDictionary = (dataAny as? NSDictionary)!
                    if dataDic["data"] is NSArray {
                        let dataArr : NSArray = (dataDic["data"] as? NSArray)!
                        for item in dataArr {
                            self.dataSource.append(HomePopularModel(dict: item as! NSDictionary))
                        }
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
    //MARK:-----getter setter-----
    
    
        /*
        // HAPPENING NOW
        let categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .Center
        categoryLabel.font = UIFont.boldSystemFontOfSize(12)
        
        let attrs = NSMutableAttributedString(string: "HAPPENING NOW")
        // 设置不同颜色
        attrs.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(10, 3))
        categoryLabel.attributedText = attrs
        // 获得合适高度
        let size = CGSizeMake(320,2000)
        let labelRect : CGRect = (categoryLabel.text)!.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: nil , context: nil);
        categoryLabel.frame = CGRectMake(UIConstant.SCREEN_WIDTH/2.0 - labelRect.width/2.0 - 15,
                                         backgroundImageView.bottom + 50 - labelRect.height - 5,
                                         labelRect.width + 30,
                                         labelRect.height + 10)
        categoryLabel.layer.borderColor = UIColor.darkGrayColor().CGColor
        categoryLabel.layer.borderWidth = 1
        headerView.addSubview(categoryLabel)
        */
        
    
    //MARK:-----UITableViewDelegate UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = NewsFlashTableViewCell.cellWithTableView(tableView)
        cell.model = self.dataSource[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)

        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NewsFlashTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!) + 30
    }
    
 }
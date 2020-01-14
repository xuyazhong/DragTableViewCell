//
//  Daily.swift
//  DragTableViewCell
//
//  Created by xuyazhong on 2020/1/14.
//  Copyright © 2020 xyz. All rights reserved.
//

import UIKit

class Daily: UITableViewController {
        
    let cellId = "DailyCell"
    
    /// 正在拖拽的indexpath
    var dragingIndexPath: IndexPath?
    /// 目标位置
    var targetIndexPath: IndexPath?
        
    var dataArray = [
        ["title": "头条版面"],
        ["title": "今日热词"],
        ["title": "营销"],
        ["title": "人工智能"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DailyCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DailyCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DailyCell
        let item = dataArray[indexPath.row]
        cell.refresh(item["title"])
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

extension Daily: SortDragCellDelegate {
    func dragCellWithTap(tap: UILongPressGestureRecognizer) {
        let point = tap.location(in: tableView)
        switch tap.state {
        case .began:
            dragBegin(point)
            break
        case .changed:
            dragChanged(point)
            break
        case .ended:
            dragEnd()
            break
        default:
            break;
        }
    }

    /// 拖拽开始 找到被拖拽的item
    func dragBegin(_ point: CGPoint) {
        dragingIndexPath = tableView.indexPathForRow(at: point)
        /// 通过点击的点来获得indexpath
        guard let dragIndexPath = dragingIndexPath else {
            return
        }
        
        /// 触发长按手势的cell
        let cell: DailyCell = tableView.cellForRow(at: dragIndexPath) as! DailyCell
        cell.isMoving = true
        cell.bgView.backgroundColor = UIColor.init(red: 53/255, green: 115/255, blue: 250/255, alpha: 0.3)
    }

    /// 正在被拖拽ing
    func dragChanged(_ startPoint: CGPoint) {
        targetIndexPath = tableView.indexPathForRow(at: startPoint)
        guard let drag = dragingIndexPath , let target = targetIndexPath else {
            return
        }
        /// 交换位置 如果没有找到_targetIndexPath则不交换位置
        if (drag.row != target.row) {
            /// 更新数据源
            updateSortDatas()
            /// 更新item位置
            tableView.moveRow(at: drag, to: target)
            dragingIndexPath = targetIndexPath
        }
    }

    /// 拖拽结束
    func dragEnd() {
        guard let drag = dragingIndexPath else {
            return
        }
        let cell: DailyCell = tableView.cellForRow(at: drag) as! DailyCell
        cell.isMoving = false
        cell.bgView.backgroundColor = .white
        tableView.reloadData()
    }
    
    /// 拖拽排序后需要重新排序数据源
    func updateSortDatas() {
        guard let drag = dragingIndexPath, let target = targetIndexPath else {
            return
        }
        let obj = dataArray.remove(at: drag.row)
        dataArray.insert(obj, at: target.row)
    }

}

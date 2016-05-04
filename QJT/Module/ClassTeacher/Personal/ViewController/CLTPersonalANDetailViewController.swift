//
//  CLTPersonalANDetailViewController.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit
import ObjectMapper

class CLTPersonalANDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var attDetailArrData = [AttendanceDetail]()
    lazy var tempAttDetailArrData = [AttendanceDetail]()
    var attendanceID: Int!
    var tempAttDetail: AttendanceDetail!
    var rowInTable: Int!
    var tempRow = 0
    let statusArr = ["缺课","迟到","早退","请假","出勤"]
    var isNeedModify: Bool = true
    
    lazy var pickView:UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y:0, width:  UIScreen.mainScreen().bounds.width - 20, height: 180))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        configUI()
        setupItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "refreshNote", object: nil)
    }

}

extension CLTPersonalANDetailViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        NetWorkManager.httpRequest(Methods.attendance_getAttendanceDetailInfo, params: ["attendanceID":attendanceID], modelType: AttendanceDetail(), listType: AttendanceDetail(), completed: { (responseData) in
            
            self.tableView.mj_header.endRefreshing()
            self.attDetailArrData = responseData["list"] as! [AttendanceDetail]
            self.tableView.reloadData()
            
        }) { [weak self] (errorMsg) in
            
            self?.tableView.mj_header.endRefreshing()
            
        }
        
    }
}

// MARK: - private Method
extension CLTPersonalANDetailViewController {
    func configUI() {
        navigationItem.title = "考勤明细"
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self
    }
    
    func setupItem() {
        
        if isNeedModify {
            let rightItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveMainViewController.rightItemClicked))
            
            navigationItem.rightBarButtonItem = rightItem
        }
    }
    
    func rightItemClicked() {
        if tempAttDetailArrData.count != 0 {
            
            var params = [String:AnyObject]()
            
            params.updateValue(Mapper().toJSONString(tempAttDetailArrData)!, forKey: "attendanceDetailString")
            
            self.pleaseWait()
            NetWorkManager.httpRequest(Methods.attendance_updateStudentAttendanceInfos, params: params, modelType: EmptyModel(), listType: EmptyModel(), completed: { (responseData) in
                self.clearAllNotice()
                self.successNotice("提交成功")
                NSNotificationCenter.defaultCenter().postNotificationName("refreshNote", object: nil)
                
            }) { [weak self] (errorMsg) in
                self?.clearAllNotice()
                self?.errorNotice(errorMsg!)
            }
            
        }else {
            self.errorNotice("请修改后再提交")
        }
        
        
    }
    

    
    //状态字符串拼接
    func getStatusStr(queke: Int, chidao: Int, zaotui: Int, qingjia: Int) -> String {
        
        let statusStr = NSMutableString()
        if queke == 1 {
            statusStr.appendString("缺课,")
        }
        if chidao == 1 {
            statusStr.appendString("迟到,")
        }
        if zaotui == 1 {
            statusStr.appendString("早退,")
        }
        if qingjia == 1 {
            statusStr.appendString("请假,")
        }
        if queke == 0 && chidao == 0 && zaotui == 0 && qingjia == 0 {
            statusStr.appendString("出勤.")
        }
        
        return statusStr.substringToIndex(statusStr.length - 1) as String
    }
    
    //提示选择状态
    func alertPcikerView() {
        let alertVC = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel) { [weak self] (alertAction) -> Void in
            
            //提示添加或修改
            let msgAlertVC = UIAlertController(title: "请选择操作类型", message: "", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            let addAction = UIAlertAction(title: "添加", style: .Default,handler: {action in
                
                
                if self!.tempRow == 0 {
                    self!.attDetailArrData[self!.rowInTable].queke = 1
                    self!.attDetailArrData[self!.rowInTable].chidao = 0
                    self!.attDetailArrData[self!.rowInTable].zaotui = 0
                    self!.attDetailArrData[self!.rowInTable].qingjia = 0
                }
                if self!.tempRow == 1 {
                    self!.attDetailArrData[self!.rowInTable].queke = 0
                    self!.attDetailArrData[self!.rowInTable].chidao = 1
                    self!.attDetailArrData[self!.rowInTable].qingjia = 0
                }
                if self!.tempRow == 2 {
                    self!.attDetailArrData[self!.rowInTable].queke = 0
                    self!.attDetailArrData[self!.rowInTable].zaotui = 1
                    self!.attDetailArrData[self!.rowInTable].qingjia = 0
                }
                if self!.tempRow == 3 {
                    self!.attDetailArrData[self!.rowInTable].queke = 0
                    self!.attDetailArrData[self!.rowInTable].chidao = 0
                    self!.attDetailArrData[self!.rowInTable].zaotui = 0
                    self!.attDetailArrData[self!.rowInTable].qingjia = 1
                }
                if self!.tempRow == 4 {
                    self!.attDetailArrData[self!.rowInTable].queke = 0
                    self!.attDetailArrData[self!.rowInTable].chidao = 0
                    self!.attDetailArrData[self!.rowInTable].zaotui = 0
                    self!.attDetailArrData[self!.rowInTable].qingjia = 0
                }
                
                
                if self!.tempAttDetailArrData.count == 0 {
                    self!.tempAttDetailArrData.append(self!.attDetailArrData[self!.rowInTable])
                }
                for temp in 0..<self!.tempAttDetailArrData.count {
                    if self!.tempAttDetailArrData[temp].studentID == self!.attDetailArrData[self!.rowInTable].studentID {
                        self!.tempAttDetailArrData[temp] = self!.attDetailArrData[self!.rowInTable]
                        break
                    }
                    if temp == self!.tempAttDetailArrData.count-1{
                        self!.tempAttDetailArrData.append(self!.attDetailArrData[self!.rowInTable])
                    }
                    
                    
                }
                
                self!.tableView.reloadData()
                
            })
            let changeAction = UIAlertAction(title: "修改", style: .Default,handler: {action in
                
                
                if self!.tempRow == 0 {
                    self!.tempAttDetail = self!.attDetailArrData[self!.rowInTable]
                    self!.tempAttDetail.queke = 1
                    self!.tempAttDetail.chidao = 0
                    self!.tempAttDetail.zaotui = 0
                    self!.tempAttDetail.qingjia = 0
                }
                if self!.tempRow == 1 {
                    
                    self!.tempAttDetail = self!.attDetailArrData[self!.rowInTable]
                    self!.tempAttDetail.queke = 0
                    self!.tempAttDetail.chidao = 1
                    self!.tempAttDetail.zaotui = 0
                    self!.tempAttDetail.qingjia = 0
                }
                if self!.tempRow == 2 {
                    self!.tempAttDetail = self!.attDetailArrData[self!.rowInTable]
                    self!.tempAttDetail.queke = 0
                    self!.tempAttDetail.chidao = 0
                    self!.tempAttDetail.zaotui = 1
                    self!.tempAttDetail.qingjia = 0
                }
                if self!.tempRow == 3 {
                    self!.tempAttDetail = self!.attDetailArrData[self!.rowInTable]
                    self!.tempAttDetail.queke = 0
                    self!.tempAttDetail.chidao = 0
                    self!.tempAttDetail.zaotui = 0
                    self!.tempAttDetail.qingjia = 1
                }
                if self!.tempRow == 4 {
                    self!.tempAttDetail = self!.attDetailArrData[self!.rowInTable]
                    self!.tempAttDetail.queke = 0
                    self!.tempAttDetail.chidao = 0
                    self!.tempAttDetail.zaotui = 0
                    self!.tempAttDetail.qingjia = 0
                }
                
                if self!.tempAttDetailArrData.count == 0 {
                    self!.tempAttDetailArrData.append(self!.attDetailArrData[self!.rowInTable])
                }
                
                for temp in 0..<self!.tempAttDetailArrData.count {
                    if self!.tempAttDetailArrData[temp].studentID == self!.attDetailArrData[self!.rowInTable].studentID {
                        self!.tempAttDetailArrData[temp] = self!.attDetailArrData[self!.rowInTable]
                        break
                    }
                    if temp == self!.tempAttDetailArrData.count-1{
                        self!.tempAttDetailArrData.append(self!.attDetailArrData[self!.rowInTable])
                    }
                    
                    
                }
                
                
                self!.tableView.reloadData()

            })

            msgAlertVC.addAction(cancelAction)
            msgAlertVC.addAction(addAction)
            msgAlertVC.addAction(changeAction)
            self!.presentViewController(msgAlertVC, animated: true, completion: nil)
            
        }
        alertVC.view.addSubview(pickView)
        alertVC.addAction(cancelAction)
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
}

// MARK: - UIPickerViewDataSource
extension CLTPersonalANDetailViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
}

// MARK: - UIPickerViewDelegate
extension CLTPersonalANDetailViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempRow = 0
        if component == 0 {
            if row == 0 {
                
                tempRow = row
                
            }
            if row == 1 {
                
                tempRow = row
            }
            if row == 2 {
                
                tempRow = row
            }
            if row == 3 {
                
                tempRow = row
            }
            if row == 4 {
                
                tempRow = row
            }
            
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            
            return statusArr[row]
        }
        return nil
    }
}

// MARK: - UITableViewDelegate
extension CLTPersonalANDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isNeedModify {
            rowInTable = indexPath.row
            self.alertPcikerView()
        }
    }
    
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForANDetail = "CLTPersonalANDetailCell"
extension CLTPersonalANDetailViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attDetailArrData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForANDetail, forIndexPath: indexPath) as! CLTPersonalANDetailCell
        let attDetail = self.attDetailArrData[indexPath.row]
        cell.studentNameLabel.text = attDetail.studentName
        cell.studentIDLabel.text = attDetail.studentID
        cell.statusLabel.text = getStatusStr(attDetail.queke, chidao: attDetail.chidao, zaotui: attDetail.zaotui, qingjia: attDetail.qingjia)
        
        return cell
    }
    
}



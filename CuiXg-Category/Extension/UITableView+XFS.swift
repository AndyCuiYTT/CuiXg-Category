//
//  UITableView+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/12/10.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit

extension UITableView {

    /// 根据 cell 类名注册 cell (代码创建 cell 使用,xib 使用cxg_register(nibName:))
    /// - Parameter name: cell类名
    func cxg_register(cellClassName name: String) {
        self.register(NSClassFromString(name), forCellReuseIdentifier: name)
    }

    /// 根据 nib 名称注册 cell (xib 创建 cell 使用,代码使用cxg_register(cellClassName:))
    /// - Parameter name: nib名(xib 名称)
    func cxg_register(nibName name: String) {
        self.register(UINib(nibName: name, bundle: Bundle.main), forCellReuseIdentifier: name)
    }

    /// 设置刷新
    /// - Parameters:
    ///   - http: 网络请求
    ///   - url: 地址
    ///   - pageSize: 每页数目
    ///   - parameters: 需要参数
    ///   - totalCount: 总数据条数 回调
    ///   - list: 已有数据源
    ///   - noDataView: 没有数据时显示视图(不需没数据显示时传 nil)
    ///   - updateList: 更新数据源(只需将回调数组赋值给原数组)
    func cxg_setRefresh<T: Decodable>(http: QWNetworkManager, url: String, pageSize: Int = 10, parameters: (() -> [String: Any])? = nil, modelType: T.Type, noDataView: UIView? = CXGPageListNodataView(), totalCount: ((Int) -> Void)? = nil, updateList: @escaping([T]) -> Void) {
        var tempList: [T] = []
        self.mj_header = CXGRefreshHeader.cxg_refreshingBlock {
            var param: [String: Any] =  ["pageNo": 1, "pageSize": pageSize]
            if let tempParam = parameters?() {
                for (key, value) in tempParam {
                    param[key] = value
                }
            }

            http.cxg_request(url: url, parameters: param, modelType: CXGPageDataStruct<T>.self, cacheType: .refresh, response: { (response) in
                response.isSuccess { (pageModel) in
                    if pageModel.isFirstPage() {
                        self.mj_header.endRefreshing()
                    }
                    if pageModel.isLastPage() {
                        self.mj_footer.endRefreshingWithNoMoreData()
                    }else {
                        self.mj_footer.endRefreshing()
                    }
                    tempList = pageModel.list
                    if noDataView != nil {
                        if tempList.count > 0 {
                            self.tableFooterView = UIView()
                        }else {
                            if noDataView?.frame == CGRect.zero {
                                noDataView?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - (self.tableHeaderView?.bounds.height ?? 0))
                            }
                            self.tableFooterView = noDataView
                        }
                    }
                    totalCount?(pageModel.count)
                }.isFailed { (error) in
                    assertionFailure(error.localizedDescription)
                    self.mj_header.endRefreshing()
                }.finally {
                    updateList(tempList)
                    self.reloadData()
                }
            }, isShowHUD: false)
        }

        self.mj_footer = CXGRefreshFooter.cxg_refreshingBlock {

            var param: [String: Any] =  ["pageNo": (tempList.count / pageSize) + 1, "pageSize": pageSize]
            if let tempParam = parameters?() {
                for (key, value) in tempParam {
                    param[key] = value
                }
            }

            http.cxg_request(url: url, parameters: param, modelType: CXGPageDataStruct<T>.self, cacheType: .never, response: { (response) in
                response.isSuccess { (pageModel) in
                    if pageModel.isFirstPage() {
                        tempList.removeAll()
                        self.mj_header.endRefreshing()
                    }
                    if pageModel.isLastPage() {
                        self.mj_footer.endRefreshingWithNoMoreData()
                    }else {
                        self.mj_footer.endRefreshing()
                    }
                    tempList += pageModel.list
                    if noDataView != nil {
                        if tempList.count > 0 {
                            self.tableFooterView = UIView()
                        }else {
                            if noDataView?.frame == CGRect.zero {
                                noDataView?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - (self.tableHeaderView?.bounds.height ?? 0))
                            }
                            self.tableFooterView = noDataView
                        }
                    }
                    totalCount?(pageModel.count)
                }.isFailed { (error) in
                    assertionFailure(error.localizedDescription)
                    self.mj_footer.endRefreshing()
                }.finally {
                    updateList(tempList)
                    self.reloadData()
                }
            }, isShowHUD: false)
        }
        self.mj_header.beginRefreshing()
    }
}

class CXGPageListNodataView: UIView {

    init(frame: CGRect = .zero, title: String = "暂无内容", subtitle: String? = nil, iconName: String = "img_deflaut_nodata") {
        super.init(frame: frame)
        let imageView = UIImageView()
        self.addSubview(imageView)

        let titleLabel = UILabel.init()
        titleLabel.cxg_setAttribute(title, font: QWFont.R_17PT, textColor: QWColor.text_6E6A6A)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)

        let subtitleLabel = UILabel()
        subtitleLabel.cxg_setAttribute(subtitle, font: QWFont.R_13PT, textColor: QWColor.text_A09C9C)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        self.addSubview(subtitleLabel)

        imageView.image = UIImage(named: iconName)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalToSuperview().offset(-100)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().offset(30)
        }

        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().offset(15)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

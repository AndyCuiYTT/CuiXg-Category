//
//  UICollectionView+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2020/9/23.
//  Copyright © 2020 CuiXg. All rights reserved.
//

import UIKit

extension UICollectionView {
    /// 根据 cell 类名注册 cell (代码创建 cell 使用,xib 使用cxg_register(nibName:))
    /// - Parameter name: cell类名
    func cxg_register(cellClassName name: String) {
        self.register(NSClassFromString(name), forCellWithReuseIdentifier: name)
    }

    /// 根据 nib 名称注册 cell (xib 创建 cell 使用,代码使用cxg_register(cellClassName:))
    /// - Parameter name: nib名(xib 名称)
    func cxg_register(nibName name: String) {
        self.register(UINib(nibName: name, bundle: Bundle.main), forCellWithReuseIdentifier: name)
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
                    if let noView = noDataView {
                        if tempList.count > 0 {
                            if noView.superview != nil {
                                noView.removeFromSuperview()
                            }
                        }else {
                            if noDataView?.frame == CGRect.zero {
                                noDataView?.frame = self.bounds
                            }
                            self.addSubview(noView)
                        }
                    }
                    totalCount?(pageModel.count)
                }.isFailed { (_) in
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
                    if let noView = noDataView {
                        if tempList.count > 0 {
                            if noView.superview != nil {
                                noView.removeFromSuperview()
                            }
                        }else {
                            self.addSubview(noView)
                        }
                    }
                    totalCount?(pageModel.count)
                }.isFailed { (_) in
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

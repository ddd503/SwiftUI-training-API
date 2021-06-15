//
//  Stateful.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/15.
//


/// データの取得に関する状態を表す
enum Stateful<Value> {
    case idle // まだデータを取得しにいっていない
    case loading // 読み込み中
    case failed(Error) // 読み込み失敗、遭遇したエラーを保持
    case loaded(Value) // 読み込み完了、読み込まれたデータを保持
}

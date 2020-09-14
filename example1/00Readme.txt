README for Hard Disk Drive Benchmark Problem (example1: following)
Authour(s): H.Uchida, T.Hara
Ver.1.0 2006-12-06
Copyright (c) 2004-2005, MSS benchmark working group
Copyright (c) 2006-, HDD benchmark working group

フォロイング系制御問題設定および設計例デモ

■ 問題設定

* この問題設定は2005年9月に開催された電気学会産業計測制御研究会のベン
  チマークセッションで用いられたものです。

  制御対象：HDDのフォロイング系モデル (Ver.1)
  問題設定：フォロイング系の設計

・与えららたプラントおよび外乱モデルについてフォロイング制御系を設計し， 
  1000周（8.4秒）の時間軸シミュレーションを実行する

・性能評価：定常的な位置誤差（最初の10msのデータは無視）

    ・RPEp-p 値
    ・NRPE3σ値
  ※）
  RPE  (Repeatable Position Error)
  NRPE (None Repeatable Position Error)

・すべての変動モデル（全30通り）について計算し，平均および最悪値を評価

    ・アクチュエータ共振のばらつき・変動モデル10種類
    ・ゲイン変動3種類（ノミナル，±10%）

・サンプリング周波数は固定だが2倍までの入力マルチレートは可

・制御器の次数，入力値の制限無し

・安定性：与えられたすべての変動モデルについて安定であれば良い


■ 設計例

離散時間PIDコントローラおよび2倍マルチレート多段ノッチフィルタを用いた
設計。


■ 実行方法

あらかじめ HDDBench.m を実行して Ver.1 のパラメータファイルから生成さ
れる以下のファイルをexample1 のフォルダ内にコピーしておきます（コピー
しない場合は，パスを通しておく）。

  mainPlantDataV1.mat
  mainDistDataV1.mat

そして，followdemo.m を実行すると，PID+2倍マルチレートノッチフィルタに
よる設計例によるデモが走ります。


■ スクリプトファイル

  followdemo.m - PID+2倍マルチレートノッチフィルタによる設計例
  evperf.m     - 制御性能評価用スクリプト（followdemo.mで使用）


■ simulink model

  SimTrackFollowing.mdl  - PID Controller + 2x Multi-rate Notch Filter
  SimTrackFollowing5.mdl - 同 (MATLAB5.x用)

このサンプルモデルは，制御系の構成がシングルレートまたはZOHアップサン
プラによる2倍のマルチレートである場合には sys_C1, sys_C2 を適切に設定
するだけでそのまま使用できます。


■ MATLABのバージョンについて

本ベンチマーク問題はMATLAB6.5.1で作成・動作確認しています。
他のバージョンで実行する場合には以下の注意が必要です。

Ver.5.3.1
・LTIモデル非互換：6.5.1で作成したモデルは読み込めない。
  →5.3.1上でHDDBenchを走らせれば問題無し。
・randn の非互換：5.3.1で外乱モデルを生成すると6.5.1と結果が異なる。
  →6.5.1で作成した外乱モデルを読み込ませれば良い。
・Simulinkモデルの非互換：6.5.1で作成したモデルは実行不可
  →5.3.1でSimulinkモデルを作成 (SimTrackFollowing5.mdl)

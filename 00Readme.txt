README for Hard Disk Drive Benchmark Problem
Authors(s): M.Hirata, T.Hara
Ver.1.0, 2005-04-26
Ver.1.1, 2005-05-02
Ver.1.2, 2005-05-10
Ver.1.3, 2005-05-12
Ver.1.4, 2005-05-13
Ver.1.5, 2005-05-16, first release
Ver.1.6, 2005-08-30, add evaluation functions
Ver.3.0, 2006-12-06
Ver.3.1, 2007-08-31
Copyright (c) 2004-2005, MSS benchmark working group
Copyright (c) 2006-, HDD benchmark working group


■ 使用方法

HDDBench.m を実行してください。

Specify the version of parameter file [1 or 2] or just hit return: 

に対して，1 または 2 または何も入力せずに return を押してください。こ
のとき，入力した数字に応じて，該当するバージョンのパラメータファイルが
読み込まれ，制御対象（プラント）モデルの定義，外乱モデルの定義が行われ
ます。そして，プラントモデルと外乱モデルが mat ファイルにセーブされま
す。詳細は以下の通りです。

* パラメータファイルのバージョン（1 or 2）を指定した場合

読み込まれるファイル：

  hdd_plantparam_v#.m
  hdd_distparam_v#.m

保存されるファイル：

  mainPlantDataV#.mat
  mainDistDataV#.m

※）# はバージョンを表す 1 または 2 が入る。

* return のみを入力した場合

読み込まれるファイル：

  hdd_plantparam.m（存在しない場合は hdd_plantparam_v2.m）
  hdd_distparam.m（存在しない場合は hdd_distparam_v2.m）

保存されるファイル：

  mainPlantData.mat
  mainDistData.m

■ 作成される mat ファイルについて

* mainPlantData.mat（プラントモデル）

  PlantData     - フォローイング制御用プラントモデルの構造体
  PlantDataSeek - シーク制御用プラントモデルの構造体

  各プラントは構造体になっており，以下の複数のモデルとパラメータを含みます。

  struct PlantData (一部)
    PlantData.Ts      - PES（位置誤差信号）のサンプリング時間
    PlantData.Ty      - 出力端外乱加算点のサンプリング時間
    PlantData.Tu      - 入力端外乱加算点のサンプリング時間
    PlantData.Td      - 入力むだ時間
    PlantData.Pn      - ノミナルモデル
    PlantData.Pf      - フルオーダーモデル
    PlantData.Pfpert  - 変動モデル（多次元配列）
    PlantData.DeltaKp - ゲイン変動

  制御入力は電流[A]，観測出力はトラック[track]となっています。
  各プラントモデルには入力時間遅れが含まれています。

  ※ 本来は回転系のアクチュエータですが，等価的に並進系とみなして定義し
     ています

* mainDistData.mat（外乱モデル）

  DistParam   - 外乱パラメータ
  ForceDist   - 力外乱
  FlutterDist - フラッタ外乱
  SensorNoise - センサノイズ
  RRO         - RRO（Repeatable Runout: 繰り返し外乱）

  本ベンチマーク問題で取り扱う外乱は以下の4種類です。

  ・力外乱※
  ・フラッタ外乱（サスペンション起因外乱等も含む）
  ・センサノイズ
  ・RRO（時間域のみ）

  ※ 本来は回転系のアクチュエータなのでトルク外乱ですが，等価的に並進
     系とみなして力外乱として定義しています

* 各外乱は下記のような構造体になっています。

  例：力外乱
  struct ForceDist
    ForceDist.Data      - 外乱データ
    ForceDist.Time      - 時間ベクトル
    ForceDist.Ts        - 外乱のサンプリング時間
    ForceDist.DataAtPes - 出力端での外乱データ
    ForceDist.TimeAtPes - 出力端での時間ベクトル
    ForceDist.TsAtPes   - 出力端での外乱のサンプリング時間
    ForceDist.Freq      - 周波数ベクトル
    ForceDist.Spec      - 外乱スペクトル
    ForceDist.SpecAtPes - 出力端での外乱スペクトル

  通常シミュレーションで用いるのは Data, .Time, .Ts だけです。

  力外乱は，制御対象の入力端（単位[A]）および出力端（単位[track]）に換
  算したものの両方を用意しています。入力端のサンプリング時間は
  PES(Position Error Signal)のサンプリング時間の整数倍に設定できます。

  それ以外の外乱はすべて出力端（単位[track]）で定義しています。フラッ
  タ外乱はPESサンプリング時間の整数倍で定義したものと，PESサンプリング
  時間にダウンサンプルしたものの両方を定義しています。

  RROに関しては，位置信号を書き込む際に混入するRROも模擬しており，その
  時系列データをRROSequence.matとして用意しています。このファイル名の
  matファイルがカレントディレクトリまたはサーチパス上に存在するとき，
  自動的に読み込みます。


■ ベンチマーク問題設定と設計例のデモ

  各サブディレクトリを参照しください。

  1. フォローイング：example1
  2. ショートシーク：example2

■ ファイル一覧

・スクリプトファイル

  HDDBench.m     - 制御対象およびノイズデータの表示
  HDDBenchPlot.m - プロット用スクリプト

・モデルパラメータ

  hdd_plantparam_v1.m - HDD Benchmark Model Ver.1.0 のプラントパラメータ
  hdd_distparam_v1.m  - HDD Benchmark Model Ver.1.0 の外乱パラメータ
  hdd_plantparam_v2.m - HDD Benchmark Model Ver.2.0 のプラントパラメータ
  hdd_distparam_v2.m  - HDD Benchmark Model Ver.2.0 の外乱パラメータ

・モデル定義用関数

  SetPlantModel.m   - 制御対象の定義
  SetDistParam.m    - 外乱生成のためのパラメータ定義
  SetFlutterDist.m  - フラッタ外乱データの生成
  SetForceDist.m    - 力外乱データの生成
  SetSensorNoise.m  - センサノイズデータの生成
  SetRRO.m          - RROデータの生成

・補助関数（上記関数から呼び出される）

  make_plant.m - 制御対象の計算
  plot_bode.m  - ボード線図の表示
  figsize.m    - figureのサイズを指定
  psdcal.m     - パワースペクトル密度(PSD)の計算
  whitenoise.m - 単位エネルギーを持つホワイトノイズの生成

・データファイル

  RROSequence.m  -  RROの時刻歴応答。STW時に書き込まれるRROを模擬。

・結果評価用関数

  PESEval.m    - PES評価プロット（時間軸，周波数軸，ヒストグラム）
  PES_FFT.m    - PESのパワースペクトラムを計算（ハニング窓，オーバーラップ50%）
  PES_PlotTD.m - PESの時間応答PLOT（RPEとNRPEを分離してプロット）


■ TODO LIST

* ロングシーク制御系のモデルを作成

■ 注意

この m-file および Simulink ファイルは MATLAB ver 6.5.1 の上で動作確認しています。

■ MATLABのバージョンについて

本ベンチマーク問題は MATLAB6.5.1 で作成・動作確認しています。
他のバージョンで実行する場合には以下の注意が必要です。

Ver.5.3.1
・LTIモデル非互換：6.5.1で作成したモデル（mat file）は読み込めない。
  →5.3.1上でHDDBenchを走らせれば問題無し。
・randn の非互換：5.3.1で外乱モデルを生成すると6.5.1と結果が異なる。
  →6.5.1で作成した外乱モデルを読み込ませれば良い。
・Simulinkモデルの非互換：6.5.1で作成したモデルは実行不可
  →5.3.1でSimulinkモデルを作成

Ver.7以降
・LTIモデル非互換：6.5.1で作成したモデルは読み込み時にWarning
  →無視しても良い。また，Ver.7x 上でHDDBenchを走らせて再作成すれば問題無し。
・Simulinkモデルの非互換：6.5.1で作成したモデルは実行時Warning
  →無視しても良い。

■ 更新履歴
>>Ver.3.1 - 2007-08-31
* Ver.3 正式リリース
* 詳細は Changes.txt 参照

>>Ver.3.0RC2 - 2006-12-06
* 詳細は Changes.txt 参照

>>Ver.2.0 - 2006-06-06
* 暫定リリース
* メカモデルの更新
  実機のHDDをベースにしたメカモデルとした。
* 外乱毎にサンプリング周期が変えられる様にした。
* 各サンプリング周期のデフォルトを以下とした。
  Ts = Tc = Ty = Tu
* 外乱生成コマンドを，外乱別にした。また，外乱のサンプリング周期によっ
  て外乱のパワーが変化しないようにした。
* SetPlantModelのオプションを指定することで，剛体モードが2重積分器とな
  るようにした。（シーク問題への対応）

>> Ver.1.5, 2005-05-16 (委員会内公開版）
* トラックピッチを100kTPIとした
  SetPlantModel.m
* 上記変更に伴う外乱およびループゲインの調整
  SetNoiseParam.m, example1.m
* 共振モードの変動幅を調整した。
  SetPlantModel.m

>> Ver.1.4
* RROの時系列データをmatファイルから読むようにした。
  SetNoiseParam.m, RROSequence.mat
* 共振モードの変動幅を大きくした。
  SetPlantModel.m

>> Ver.1.3
* 制御対象のゲインを調整
  SetPlantModel.m, SetNoiseParam.m
* TDParamを廃止し，すべてのパラメータをSetNoseParam.mの中で定義する事とした。
  SetNoiseParam.m,SetNoiseTimeDom.m
* example1.m の中にノッチフィルターのデータを直接書き込んだ。

>> Ver.1.2
* 外乱の大きさを調整
  SetNoiseParam.m
  SetNoiseFreqDomain.m
* 図の背景色をデフォルトに戻す
  plot_bode.m
* PID制御による設計例を追加
  example1.m
* 変動モデルの定義方法を変更
  SetPlantMode.m, plot_bode.m

>> Ver.1.1
* bug fix
  fftgain.m, SetPlantModel.m, SetNoiseTimeDom.m

* SetPlantModel.m における変動の取り扱いを変更。
   DeltaFn   - Fn に対する乗法的な変動値
   DeltaZeta - Zeta 〃
   DeltaGain - Gain 〃

* SetNoiseParam.m
   RROSequence の追加
   -> ディスク1周分のRROの時系列データ。
      FreqRRO, AmpRRO とは別に，RROを直接時系列データとして与えられる。

>> Ver.1.0, リリース

EOF of readme.txt

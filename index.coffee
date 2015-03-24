'use strict'
gutil = require 'gulp-util'
through = require 'through2'


module.exports = (outputFileName) =>


  # transform関数 ファイルごとに呼びだされる
  transform = (file, eccording, callback) =>

    # ファイルがnullの場合
    if file.isNull()
      # 次のプラグインに処理を渡すためにthis.push(file)しておく
      @push file
      # callback()は必ず実行
      callback()

    # ファイルがstreamの場合 （streamに対応しない）
    if file.isStream()
      # emit('error')を使って、プラグイン呼び出し側に'error'イベントを発生させる
      @emit 'error' new (gutil.PluginError)('myplugin-refactoring', 'Streaming not supported')
      # callback()は必ず実行
      callback()

    # ファイルの内容を取得
    cont = file.contents.toString('utf8')
    # ファイルの内容を（file.contents）をJSONオブジェクトに変換
    # var json = JSON.parse(file.contents.toString('utf8'));

    # replaceの実行
    cont = cont.replace(/: ?0px/, ': 0')
    cont = cont.replace(/ 0px/, ' 0')

    # 出力ファイルを生成（新規ファイル生成にはgulp-utilのFileを利用する）
    output = new (gutil.File)(
      cwd: file.cwd
      base: file.base
      path: file.path # outputFileName
    )

    # ファイルのコンテンツにはnode.jsのBufferを使う
    output.contents = new Buffer(cont)
    # output.contents = new Buffer(JSON.stringfy(json));

    # ファイルを出力ストリームに渡す
    @push output

    # callback()は必ず実行
    callback()

  # flush関数 flush前に呼ばれる
  
  flush = (callback) =>
    # callback()は必ず実行
    callback()

  # through2オブジェクトを生成してreturn
  through.obj transform, flush


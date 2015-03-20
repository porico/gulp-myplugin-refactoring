gulp-myplugin-refactoring
=========================

#はじめに

gulpの自作プラグインをつくってみるためのサンプル（input, outputファイルあり）


#サンプルプラグインの機能

css内で数値0にpxの単位があれば、pxを削除するプラグイン

```
*: 0px;
*:0px;
↓
*: 0;
```

#導入の仕方

```
git clone https://github.com/porico/gulp-myplugin-refactoring.git
```

gulpのプロジェクト配下のnode_modulesフォルダに、myplugin-refactoringをおく
gulpfile.jsに以下を記述する。

```
var mypRefactoring = require('myplugin-refactoring');
```

gulpタスクを設定する。（outフォルダに出力する例）

```
gulp.task('mypRefactoring', function() {
  gulp.src('./htdocs/**/*.css')
    .pipe(mypRefactoring())
    .pipe(gulp.dest(./out/));
});
```
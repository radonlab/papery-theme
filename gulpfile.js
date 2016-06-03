var gulp = require('gulp');
var path = require('path');
var url = require('url');
var del = require('del');
var webpack = require('webpack');
var packer = require('webpack-stream');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

function getConfig(name, prefix, production) {
  var conf = {
    output: {
      filename: name,
      publicPath: prefix
    },
    module: {
      loaders: [{
        test: /\.coffee$/,
        loader: 'coffee'
      },{
        test: /\.less$/,
        loader: 'style!css!less'
      },{
        test: /\.(eot|woff|ttf|svg)(\?v=[a-zA-Z0-9]+)?$/,
        loader: 'file?name=fonts/[name].[ext]'
      }]
    },
    resolve: {
      root: [
        path.resolve('assets')
      ]
    },
    plugins: []
  };
  if (production) {
    conf.plugins.push(new webpack.optimize.UglifyJsPlugin());
  }
  return conf;
}

gulp.task('build-dev', function() {
  var prefix = url.resolve('file://', '/' + __dirname + '/dist/');
  var conf = getConfig('theme.dev.js', prefix);
  return gulp.src('theme.js')
    .pipe(packer(conf))
    .pipe(gulp.dest('dist/'));
});

gulp.task('build', function() {
  var conf = getConfig('js/theme.min.js', '/static/', true);
  return gulp.src('theme.js')
    .pipe(packer(conf))
    .pipe(gulp.dest('dist/'));
});

gulp.task('support', function() {
  return gulp.src('vendor/*.js')
    .pipe(uglify())
    .pipe(rename({
      suffix: '.min'
    }))
    .pipe(gulp.dest('dist/vendor/'));
});

gulp.task('clean', function() {
  return del.sync([
    'dist/*.dev.js',
    'dist/js/'
  ]);
});

gulp.task('rebuild', ['clean', 'build']);

gulp.task('default', ['rebuild', 'support']);

const gulp = require('gulp');
const del = require('del');
const typescript = require('gulp-typescript');
const tscConfig = require('./tsconfig.json');
const htmlmin = require('gulp-htmlmin');
const uglify = require('gulp-uglify');
const preprocess = require('gulp-preprocess');
const cleancss = require('gulp-clean-css');
const concat = require('gulp-concat');
const concatcss = require('gulp-concat-css');
const run = require('run-sequence');
const sass = require('gulp-sass');

// clean the contents of the distribution directory
gulp.task('clean', function(cb) {
  del(['dist/'], cb);
});

gulp.task('buildcss', function() {
  return gulp
    .src('app/**/*.css')
    .pipe(cleancss({
      keepSpecialComments: 0
    }))
    .pipe(gulp.dest('dist/app'));
});

gulp.task('buildscss', function() {
  'use strict';
    return gulp.src('./scss/app.scss')
      .pipe(sass({
        outputStyle: 'compressed'
      }).on('error', sass.logError))
      .pipe(gulp.dest('dist/'));
});

gulp.task('copyElm', function() {
  return gulp
    .src('elm/storewatch/elm-app.js')
    .pipe(gulp.dest('dist/app/vendors'));
});

gulp.task('copyvendor', function() {
  return gulp
    .src([
      'node_modules/es6-shim/es6-shim.min.js',
      'node_modules/systemjs/dist/system-polyfills.js',
      'node_modules/angular2/es6/dev/src/testing/shims_for_IE.js',
      'node_modules/angular2/bundles/angular2-polyfills.js',
      'node_modules/systemjs/dist/system.src.js',
      'node_modules/rxjs/bundles/Rx.js',
      'node_modules/angular2/bundles/angular2.dev.js',
      'node_modules/angular2/bundles/router.dev.js',
      'node_modules/angular2/bundles/http.dev.js',
      'node_modules/lodash/lodash.min.js',
    ])
    .pipe(gulp.dest('dist/app/vendors'));
});

gulp.task('vendorjs', function() {
  return gulp
    .src([
      'node_modules/es6-shim/es6-shim.min.js',
      'node_modules/systemjs/dist/system-polyfills.js',
      'node_modules/angular2/es6/dev/src/testing/shims_for_IE.js',
      'node_modules/angular2/bundles/angular2-polyfills.js',
      'node_modules/systemjs/dist/system.src.js',
      'node_modules/rxjs/bundles/Rx.js',
      'node_modules/angular2/bundles/angular2.dev.js',
      'node_modules/angular2/bundles/router.dev.js',
      'node_modules/angular2/bundles/http.dev.js',
      'node_modules/lodash/lodash.min.js',
    ])
    .pipe(concat('vendor.js'))
    .pipe(uglify({
      compress: {
        drop_console: true
      }
    }))
    .pipe(gulp.dest('dist/app/vendors'));
});

gulp.task('buildhtml', function() {
  return gulp
    .src('app/**/*.html')
    .pipe(preprocess())
    .pipe(gulp.dest('dist/app'));
});

gulp.task('baseindex', function() {
  return gulp
    .src('./index.html')
    .pipe(preprocess())
    .pipe(htmlmin())
    .pipe(gulp.dest('dist/'));
});

gulp.task('base404', function() {
  return gulp
    .src('./404.html')
    .pipe(preprocess())
    .pipe(htmlmin())
    .pipe(gulp.dest('dist/'));
});

gulp.task('basecss', function() {
  return gulp
    .src('./styles.css')
    .pipe(preprocess())
    .pipe(cleancss({
      keepSpecialComments: 0
    }))
    .pipe(gulp.dest('dist/'));
});

// TypeScript compile
gulp.task('compile', function() {
  return gulp
    .src('app/**/*.ts')
    .pipe(typescript(tscConfig.compilerOptions))
    .pipe(gulp.dest('dist/app'));
});

gulp.task('build', function() {
  return run([
    'clean',
    'vendorjs',
    'buildcss',
    'buildhtml',
    'baseindex',
    'base404',
    'basecss',
    'compile'
  ]);
});

gulp.task('default', function() {
  return run([
    'clean',
    'vendorjs',
    'copyvendor',
    'copyElm',
    'buildcss',
    'buildscss',
    'buildhtml',
    'baseindex',
    'base404',
    'basecss',
    'compile'
  ]);
});

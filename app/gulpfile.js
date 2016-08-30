const gulp = require('gulp');
const del = require('del');
const typescript = require('gulp-typescript');
const tscConfig = require('./tsconfig.json');
const tscReleaseConfig = require('./tsconfigRelease.json');
const htmlmin = require('gulp-htmlmin');
const uglify = require('gulp-uglify');
const preprocess = require('gulp-preprocess');
const cleancss = require('gulp-clean-css');
const concat = require('gulp-concat');
const concatcss = require('gulp-concat-css');
const run = require('run-sequence');
const sass = require('gulp-sass');
const pump = require('pump');
const sourcemaps = require('gulp-sourcemaps');

gulp.task('set-node-env', function(cb) {
  process.env.API_URL = 'https://v3q0i4ynpb.execute-api.us-east-1.amazonaws.com/';
  cb();
});

gulp.task('set-dev-node-env', ['set-node-env'], function(cb) {
  process.env.NODE_ENV = 'development';
  process.env.API_SHARD = 'dev';
  cb();
});

gulp.task('set-prod-node-env', ['set-node-env'], function(cb) {
  process.env.NODE_ENV = 'production';
  process.env.API_SHARD = 'prod';
  cb();
});

// clean the contents of the distribution directory
gulp.task('clean', function(cb) {
  return del(['dist/'], cb);
});

gulp.task('buildcss', function(cb) {
  if (process.env.NODE_ENV === 'development') {
    pump([
      gulp
        .src('app/**/*.css'),
      gulp.dest('dist/app')], cb);
  } else {
    pump([
      gulp
        .src('app/**/*.css'),
      cleancss({
        keepSpecialComments: 0
      }),
      gulp.dest('dist/app')], cb);
  }
});

gulp.task('buildscss', function(cb) {
  'use strict';
  if (process.env.NODE_ENV === 'development') {
    pump([
      gulp.src('./scss/app.scss'),
      sourcemaps.init(),
      sass().on('error', sass.logError),
      sourcemaps.write(),
      gulp.dest('dist/')
    ], cb);
  } else {
    pump([
      gulp.src('./scss/app.scss'),
      sass({
        outputStyle: 'compressed'
      }).on('error', sass.logError),
      gulp.dest('dist/')
    ], cb);
  }
});

gulp.task('copyDeploy', function() {
  return gulp
    .src('dist-make')
    .pipe(concat('Makefile'))
    .pipe(gulp.dest('dist/'));
});

gulp.task('copyElm', function(cb) {
  if (process.env.NODE_ENV === 'development') {
    console.log('development');
    pump([
      sourcemaps.init(),
      gulp.src('elm/storewatch/elm-app.js'),
      sourcemaps.write(),
      gulp.dest('dist/app/vendors')
    ], cb);
  } else {
    console.log('production');
    pump([
      gulp.src('elm/storewatch/elm-app.js'),
      uglify({
        compress: {
          drop_console: true
        }
      }),
      gulp.dest('dist/app/vendors')
    ], cb);
  }
});

gulp.task('copyvendor', function(cb) {
  pump([
    gulp
      .src([
        'node_modules/es6-shim/es6-shim.min.js',
        'node_modules/systemjs/dist/system-polyfills.js',
        'node_modules/angular2/es6/dev/src/testing/shims_for_IE.js',
        'node_modules/angular2/bundles/angular2-polyfills.js',
        'node_modules/systemjs/dist/system.src.js',
        'node_modules/rxjs/bundles/Rx.js',
        'node_modules/angular2/bundles/angular2.min.js',
        'node_modules/angular2/bundles/router.min.js',
        'node_modules/angular2/bundles/http.min.js',
        'node_modules/lodash/lodash.min.js',
      ]),
    uglify({
      compress: {
        drop_console: true
      }
    }),
    gulp.dest('dist/app/vendors')
  ], cb);
});

gulp.task('vendor1js', function(cb) {
  pump([
    gulp
      .src([
        'node_modules/angular2/es6/dev/src/testing/shims_for_IE.js',
        'node_modules/angular2/bundles/angular2-polyfills.js',
        'node_modules/systemjs/dist/system.src.js',
        'node_modules/rxjs/bundles/Rx.js',
        'node_modules/angular2/bundles/angular2.min.js',
        'node_modules/angular2/bundles/router.min.js',
        'node_modules/angular2/bundles/http.min.js',
        'node_modules/lodash/lodash.min.js',
      ]),
    concat('vendor-core.js'),
    uglify({
      compress: {
        drop_console: true
      }
    }),
    gulp.dest('dist/app/vendors')], cb);
});

gulp.task('vendorjs', function(cb) {
  pump([
    gulp
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
      ]),
    concat('vendor.js'),
    uglify({
      compress: {
        drop_console: true
      }
    }),
    gulp.dest('dist/app/vendors')], cb);
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
gulp.task('compile', function(cb) {
  if (process.env.NODE_ENV === 'development') {
    return gulp
      .src('app/**/*.ts')
      .pipe(typescript(tscConfig.compilerOptions))
      .pipe(preprocess())
      .pipe(gulp.dest('dist/app'));
  } else {
    return gulp
      .src('app/**/*.ts')
      .pipe(typescript(tscReleaseConfig.compilerOptions))
      .pipe(preprocess())
      .pipe(uglify({
        compress: {
          drop_console: true
        }
      }))
      .pipe(gulp.dest('dist/app'));
  }
});

gulp.task('build', function() {
  return run([
    'clean',
    'vendorjs',
    'vendor1js',
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

gulp.task('release', function() {
  return run([
    'set-prod-node-env',
    'build',
    'copyDeploy'
  ]);
});

gulp.task('default', function() {
  return run([
    'set-dev-node-env',
    'build'
  ]);
});

OPTS=(
  "--language_in=ES6_STRICT"
  "--language_out=ES5"
  "--compilation_level=ADVANCED_OPTIMIZATIONS"
  "--js_output_file=dist/bundle.js"
  "--create_source_map=%outname%.map"
  "--variable_renaming_report=dist/variable_renaming_report"
  "--property_renaming_report=dist/property_renaming_report"

  # Don't include ES6 polyfills
  "--rewrite_polyfills=false"

  # List of path prefixes to be removed from ES6 & CommonJS modules.
  "--js_module_root=node_modules"
  "--js_module_root=vendor"

  # Uncomment for easier debugging
  "--formatting=PRETTY_PRINT"
  "--debug"

  # Include zone.js as externs rather than the source code.
  # Allows us to use --dependency_mode=STRICT below.
  # Otherwise the zone.js file is not imported anywhere and gets dropped.
  # See index.html
  #node_modules/zone.js/dist/zone.js
  "vendor/zone_externs.js"
  "vendor/angular_externs.js"

  $(find vendor/rxjs -name *.js)
  node_modules/@angular/core/index.js
  #$(find node_modules/@angular/{core,common,compiler,platform-browser}/src -name *.js)
  $(find node_modules/@angular/core/src -name *.js)
  #"built/*.js"

  # Trim files not imported (transitively) from bootstrap.js
  #"--entry_point=./built/bootstrap"
  '--entry_point=node_modules/@angular/core/index.js'
  "--dependency_mode=STRICT"
  "--output_manifest=dist/manifest.MF"
)

JVM_ARGS=""
# To attach a remote debugger:
#JVM_ARGS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"

set -ex
java $JVM_ARGS -jar node_modules/google-closure-compiler/compiler.jar $(echo ${OPTS[*]})

# measure the sizes of scripts the user will need to load
for script in dist/bundle.js node_modules/zone.js/dist/zone.min.js; do
  gzip --keep -f $script
  # requires brotli
  # on Mac: brew install brotli
  bro --force --quality 10 --input $script --output $script.brotli
  ls -alH ${script}*
done

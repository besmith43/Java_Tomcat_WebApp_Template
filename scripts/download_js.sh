#!/usr/bin/env bash


program="wget"
css_dir="web/css"
js_dir="web/js"


if [ -z "$(which $program)" ]; then
    echo missing $program
    exit 1
fi

$program https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css || exit 1
mv bootstrap.min.css $css_dir || exit 1

$program https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js || exit 1
mv bootstrap.bundle.min.js $js_dir || exit 1

$program https://cdn.jsdelivr.net/npm/crypto-js@4.2.0/index.min.js || exit 1
mv index.min.js $js_dir/crypto-js.min.js

$program https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js || exit 1
mv jquery.min.js $js_dir || exit 1

$program https://cdn.jsdelivr.net/npm/sweetalert2@11.22.0/dist/sweetalert2.min.css || exit 1
mv sweetalert2.min.css $css_dir || exit 1

$program https://cdn.jsdelivr.net/npm/sweetalert2@11.22.0/dist/sweetalert2.all.min.js || exit 1
mv sweetalert2.all.min.js $js_dir || exit 1

$program https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/css/fontawesome.min.css || exit 1
mv fontawesome.min.css $css_dir || exit 1

# $program https://cdn.jsdelivr.net/npm/alpinejs@3.14.9/dist/cdn.min.js || exit 1
# mv cdn.min.js $js_dir/alpinejs.min.js

# $program https://unpkg.com/htmx.org@2.0.4 -o htmx.min.js || exit 1
# mv htmx.min.js $js_dir



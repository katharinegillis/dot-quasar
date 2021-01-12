#!/usr/bin/env bash

pkg.link() {
    fs.link_files $PKG_PATH/files
}

pkg.install() {
    # Set up quasar
    bash $PKG_PATH/run.sh "$ELLIPSIS_SRC"
}

pkg.pull() {
    # Check for updates on git
    git remote update 2>&1 > /dev/null
    if git.is_behind; then
        # Unlink old files
        hooks.unlink

        # Pull changes from git
        git.pull

        # Link new files
        pkg.link
    fi

    # Set up quasar
    bash $PKG_PATH/run.sh "$ELLIPSIS_SRC"
}

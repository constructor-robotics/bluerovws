# src packages

This directory contains the ROS2 packages as **git submodules** of the bluerovws repository.

## Initial setup (first clone)

```bash
git submodule update --init --recursive
```

or to fetch the latest pinned state of all submodules:

```bash
git submodule update --remote --recursive
```

## Working with a package

- To fetch upstream changes of a package, enter its directory and pull there, then commit the
  new submodule pointer in bluerovws:

  ```bash
  cd src/<package>
  git fetch origin && git checkout origin/main   # or the package's branch
  cd ../..
  git add src/<package>
  git commit -m "update <package> submodule"
  ```

- Pinned commits: bluerov2common* & drivers are on `main`, `px4_msgs` on `uuv_bluerov`
  (fork timzarhansen), `px4-ros2-interface-lib` on tag `1.5.0`.

The packages live in their own repositories and are updated independently — changes inside them
must be committed and pushed to their own remotes first.
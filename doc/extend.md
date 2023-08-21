# Extending the image for new languages

In case you want to add the support for a new language,
please follow this steps:

* Add tests under `tests/test_x.py`.
* Search for a base image that you can use. It should depend on ubuntu 22.04.
* In case you can't find any, use `dariusmurawski/lunarvim_base:latest` as foundation.
* * create a new directory and add the Dockerfile. Add your installation steps.
* Launch the container
* Run `apt-get install -y plocate binutils`
* with `which <executable>`, `locate <executable>` and `ldd <executable>`
to get a feeling for what is loaded / needed for the execution.

# Extracting layer information
When you want to extract the image more granular for multi-stage, use `dive` to see the changes
that where applied to your container. You can find more informations in the
[Dive Repository](https://github.com/wagoodman/dive).


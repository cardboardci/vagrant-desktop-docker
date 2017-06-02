# Vagrant Linux Desktop
[![License][license-badge]][license-link]
[![Image][image-badge]][image-link]
[![Vagrant][vagrant-badge]][vagrant-link]

---

## Summary

Provide a method of reproducible graphical development environments based on Linux.  This repositroy provides a Docker Linux Desktop environment, sandboxed on their local computer.

## Usage

You can use this locally with `vagrant up`, calling as such:

```
vagrant --name=mydesktop up
```

However It is recommended to use the script `create.sh` for the first run to ensure all necessary arguments are provided. The provided arguments enable the creation of a `settings.yaml`.  You can create the environment by calling:

```
sh create.sh -n mydesktop -d lubuntu
```

If you want more information about the script `create.sh`, you can do so by calling:

```
sh start.sh -h
```

### Parameters

The parameters are used in the calling of `vagrant up`, primarily as `vagrant <options> up`.  After provisioning the environment, a settings file (`setting.yaml`) is created, which stores the provided parameters.

| Name | Type | Description |
| ---  | ---  | ---         |
| name | `string` | Name of the provisioned desktop environment |
| desktop | `filename` | The name of the desktop provisioning script.  These scripts are present in [`provision/environments`](src/provision/environments). |

The vagrant environment is based on the `bento/ubuntu` images.  If the timezone is not set, the provision script will attempt to auto-detect the timezone using the [`tzupdate`](https://github.com/cdown/tzupdate).


## Setting up the application 

On first run (`vagrant up`) the base `bento/ubuntu` image will be downloaded, and the environments will be created.  The default user is `vagrant` with password `vagrant`.

### Architecture

The `vagrant-desktop-docker` is meant to be included as a git submodules as part of `.Workspace` projects.  The following is the architecture of a `.Workspace` meta-project:

```
* .Workspace Repository
    * bin
    * lib
    * Repositories
        * MyDockerProject (git repo submodule)
        * MyHomeLab (git repo submodule)
    * vagrant-desktop (git repo submodule)
    * build
        * start-all.sh
    README.md
```

The concept of this architecture is to enable docker experiements that the traditional `Docker Toolbox` might not be the best fit for.  Specfically it is used for experimenting with `homelab` concepts.  This enables purging the docker image cache or completely wiping the users (& filesystem) to ensure consitency with deployment.

### Shared Folders

The `Vagrantfile` makes use of the following shared folders to access files on the host machine.

| Name | Path |  Host Path | Description |
| --- | --- | --- | --- |
| Repository | /srv/local | ../ | The `vagrant-desktop` repository root. |
| Repositories | /home/vagrant/repositories | ../../ | The parent directory of the `vagrant-desktop` repository. See [Architecture](#architecture). |

## Development

The `Vagrantfile` is built to act as a bootstrap for more complex vagrant environments that provision more proper development environment.  As such, it includes lines for script execution that can be leveraged downstream by other projects.  These scripts are expected within the `provision/` directory.

| Script | Purpose |
| --- | --- |
| provision-pre.sh | Acts as a pre-hook to the default provisioning script. |
| provision.sh | provision.sh provisions the development environment. |
| provision-post.sh | Acts as a post-hook to the provisioning. |

### Dependencies 

The following are the dependencies of the vagrant project

* `getoptlong` - The [GetoptLong](http://ruby-doc.org/stdlib-2.1.0/libdoc/getoptlong/rdoc/GetoptLong.html) class allows you to parse command line options similarly to the GNU getopt_long() C library call.
* `yaml` - The [YAML](https://ruby-doc.org/stdlib-1.9.3/libdoc/yaml/rdoc/YAML.html) module provides a Ruby interface for data serialization in YAML format.

[license-badge]: https://img.shields.io/badge/license-MIT-blue.svg?maxAge=2592000
[license-link]: LICENSE

[image-badge]: https://img.shields.io/badge/box-bento/ubuntu-red.svg?maxAge=2592000
[image-link]: https://atlas.hashicorp.com/bento/boxes/ubuntu-16.10

[vagrant-badge]: https://img.shields.io/badge/vagrant.api-2-green.svg?maxAge=2592000
[vagrant-link]: src/Vagrantfile
# OSv Make Report
## OSv Make All
* make all主要是生成操作系统的镜像文件。
* make all的时候，首先生成的是**loader.img**文件，这个镜像文件就是bootloader。bootloader的生成需要用到scripts/imgedit.py脚本。loader.img中包含了loader.elf，而loader.elf包含了drivers下的內容。
* 接着，Makefile中定义了，通过qemu-img创建一个100MB的镜像文件bare.raw，并写入loader.img的内容。调用了scripts/imgedit.py的setpartition。
* 下一步是生成bare.img，将raw格式的bare.raw转成qcow2格式，并改变大小。调用了scripts/mkzfs.py脚本，该脚本通过run.py脚本运行起当前的镜像并将build/release/bootfs.manifest中的文件，通过upload\_manifest.py脚本传到OSv中，完成文件系统有关的操作。
* 最后生成的是usr.img。在bare.img的基础上通过scripts/upload\_manifest.py脚本，把build/release/usr.manifest中的文件也传到OSv中，主要是一些用户相关的内容。


## OSv Make Check
* 在OSv根目录下执行make check可以用制定的测试代码来对OSv的正确性进行测试，测试的代码保存在tests目录下，包括了多种类型的多种测试场景，例如文件系统操作等。
* make check会将tests目录下的测试用例编译到build/release/tests/目录下，编译成.o文件和.so文件。
* 生成相应的目标文件之后，会调用scripts/test.py脚本。该脚本会扫描得到build/release/tests目录下的所有.so文件列表，每个.so文件对应一个特定的测试。脚本会执行每一个测试（当然可以定义黑名单过滤一些不想做的测试）。对于每个测试，实际上是通过scripts/run.py脚本来具体完成的。
* scripts/run.py脚本会根据需要选择特定的hypervisor（xen或者qemu）来运行特定的镜像。
* 最后通过./scripts/run.py -s -e tests/tst-condvar.so这样的形式来运行测试

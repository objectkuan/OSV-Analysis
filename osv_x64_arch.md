# apic
## 数据结构
1. apicreg APIC寄存器
2. apiclvt APIC Local Vector Table，终端向量表相关寄存器
3. msi\_data\_fields MSI中断的相关信息
4. delivery\_mode 投递模式
5. level\_assertion
6. trigger\_mode 中断出发模式（边缘，阶跃）
7. msi\_message MSI消息（地址，数据）

## APIC驱动
> apic\_driver是一个抽象的APIC驱动，在osv中派生出xapic，x2apic等驱动

1. init\_on\_ap -> enable -> 写msr寄存器 + sofrware\_enable ( -> 写寄存器)
2. self\_ipi 设置处理器之间中断
3. ipi，init\_ipi，ipi\_allbutself, nmi\_allbutself, 几个和中断有关的函数
4. eoi 结束中断，end of interrupt
5. read，write，id，读写中断寄存器
6. compose\_msix 封装一个msi消息


# ioapic
> 只有一个初始化ioapic的东西


# arch
1. iqr\_disable，irq\_disable\_notrace，irq\_enable，wait\_for\_interrupt，等中断相关
2. irq\_flag等一系列和中断标识符有关的结构体和操作
3. tls相关的


# arch-cpu
1. init\_stack，初始化使用的一个栈
2. 然后是一个enum，不知道做什么用的
3. 后面定义了arch\_cpu和arch\_thread。其中arch\_cpu是x64的CPU结构，主要包括初始化函数，以及中断和异常处理相关函数。而arch\_thread只有interrupt\_stack和exception\_stack两个栈。
4. 而后定义的是fpu相关的结构体


# arch-mmu
1. 首先定义的是pt\_element类，描述了页表一项，以及相关的操作和函数。
2. hw_ptep是给pt\_element进行了包装，根据注释，应该是为xen用的。
3. make\_empty\_pte，返回一个页表项。
4. make\_pte，根据地址和权限，返回一个页表项。
5. make\_normal\_pte，根据地址和权限，返回一个非large的页表项。
6. make\_large\_pte，根据地址和权限，返回一个large的页表项。


# arch-setup
1. arch\_setup\_free\_memory，初始化内存


# arch-switch
1. 第一个大函数是switch\_to，接着是switch\_to\_first，使用来做线程切换的，但分辨不出两者的区别。
3. 然后是init_stack，用来初始化一个线程的栈，并把线程的状态rbp/rip/rsp设置好。
4. 下一个是setup\_tcb，和free\_tcb，用来初始化和释放tcb的。
5. 最后是thread\_main\_c，执行线程main。


# bitops
> 位运算函数


# cpuid
> 获取cpu的feature


# dump
> 用来打印exception frame中寄存器的信息


# exception
1. exception\_frame 异常帧，各种寄存器
2. interrupt\_descriptor\_table 中断描述表
  1. load\_on\_cpu 加载idt
  2. register\_handler，register\_level\_triggered\_handler，register\_interrupt\_handler，注册eoi中断处理函数，插入一个handler到256长度的handlers列表中
  3. unregister\_handler，注销eoi中断处理函数，将handlers列表中对应的项目清空
  4. invoke\_interrupt触发中断，依次调用handlers列表中对应项目的pre\_eoi，eoi，post\_eoi
  5. idt\_entry，idt的一项。\_idt，整个idt列表的内容
  6. add\_entry，给idt的某一个项目赋值
  7. handler，和\_handlers，eoi中断处理函数的结构
3. idt，外层包装的中断描述符列表


# msr
> 读写MSR寄存器用的函数和常量


# memcpy-decode
> memcpy\_decoder？


# safe-ptr
> 有可能坏掉的指针数据的读写


# arch-thread-state
> 保存着线程的状态，包括rsp，rbp，rip


# processor
1. cr0，cr4的各位 
2. cpuid 调用cpuid指令
3. read/write\_cr0/2/3/4/8，读写控制寄存器
4. desc\_ptr 描述符指针
5. lgdt，sgdt，lidt，sidt，加载/取出gdt，idt
6. 接着都是一系列的指令的C封装
7. task\_state\_segment


# processor-flags
> cr0 cr4寄存器的各位


# smp
1. smp\_launch，启动smp支持
2. smp\_initial\_find\_current\_cpu，获得启动的时候的cpu
3. crash\_other\_processors，关闭其他处理器


# 总结
0. 命令的封装
1. 中断，异常相关的结构和函数
2. 位运算
3. 处理器的结构定义
4. 线程的部分有关定义
5. 页表的部分有关定义

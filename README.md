# ch32f205_gcc_demo

![debuging](/docs/Kooha-2024-05-13-10-38-07.gif)

Demo project

**Note:** Does not work with J-Link.

## Openocd and WCH-LinkE

As far as I know, the main openocd does not support ch32f2x at the moment. But I [found a fork](https://github.com/mengfanyuc/openocd) with support for it.

But it's not all that simple😁. I'm getting an error when trying to build it. So I fixed it with the code below:

```c
// switch (cortex_m_get_partno_safe(target)) NOTE: replace to
switch (cortex_m_get_impl_part(target))
```

![alt text](/docs/Screenshot_20240513_105353.png)

Next I'm replaced binary openocd from [openocd-xpack](https://github.com/xpack-dev-tools/openocd-xpack) to mine.

Added some scripts for Wch-Link to project.

Checkout scripts for vscode in folder .vscode.

![flashing](/docs/Kooha-2024-05-13-11-13-30.gif)

## Additional links

* Custom openocd with ch32f2x support: https://github.com/mengfanyuc/openocd
* List of svd files: https://github.com/ch32-rs/ch32-rs/tree/ce9d179930ba5b8a7ac53addcc2c3255a6034d0e/svd/vendor
* Wch-Link instruction: https://github.com/Mcublog/wch-link-instruction

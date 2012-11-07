From: Stefan Koch <stefan.koch10@gmail.com>
Date: Wed, 07 Nov 2012 20:33:53 +0000
Subject: Re: i.MX 257 ARM-CPU: framebuffer error "division by zero"
Message-Id: <509AC5B1.5040301@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <509A6964.5090305@gmail.com>
In-Reply-To: <509A6964.5090305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The error snipped in first post is not from the beginning it's from the end.
This is from the beginning.
And there is named "imxfb", too.

For this error "video=imxfb:SVGA-16@60" is set in kernel command line:

The full messages are here: http://paste.debian.net/hidden/3d16ba27/

[<80246f78>] (register_framebuffer+0x17c/0x230) from [<80586ab8>] 
(imxfb_probe+0x3c8/0x5a8)
[<80586ab8>] (imxfb_probe+0x3c8/0x5a8) from [<80286ba8>] 
(platform_drv_probe+0x14/0x18)
[<80286ba8>] (platform_drv_probe+0x14/0x18) from [<802858b0>] 
(driver_probe_device+0x80/0x20c)
[<802858b0>] (driver_probe_device+0x80/0x20c) from [<80285ac8>] 
(__driver_attach+0x8c/0x90)
[<80285ac8>] (__driver_attach+0x8c/0x90) from [<80284230>] 
(bus_for_each_dev+0x64/0x8c)
[<80284230>] (bus_for_each_dev+0x64/0x8c) from [<802849b0>] 
(bus_add_driver+0xa4/0x230)
[<802849b0>] (bus_add_driver+0xa4/0x230) from [<80286098>] 
(driver_register+0x78/0x140)
[<80286098>] (driver_register+0x78/0x140) from [<80286ef4>] 
(platform_driver_probe+0x18/0x9c)
[<80286ef4>] (platform_driver_probe+0x18/0x9c) from [<805866d8>] 
(imxfb_init+0x88/0xa0)
[<805866d8>] (imxfb_init+0x88/0xa0) from [<800087e4>] 
(do_one_initcall+0x30/0x178)
[<800087e4>] (do_one_initcall+0x30/0x178) from [<80576310>] 
(kernel_init+0xe4/0x1b0)
[<80576310>] (kernel_init+0xe4/0x1b0) from [<80015268>] 
(kernel_thread_exit+0x0/0x8)
Division by zero in kernel.
[<80019ba4>] (unwind_backtrace+0x0/0xf4) from [<8022accc>] (Ldiv0+0x8/0x10)
[<8022accc>] (Ldiv0+0x8/0x10) from [<8022ac9c>] (__aeabi_uidivmod+0x8/0x18)
[<8022ac9c>] (__aeabi_uidivmod+0x8/0x18) from [<80254198>] 
(cfb_imageblit+0x1fc/0x4b0)
[<80254198>] (cfb_imageblit+0x1fc/0x4b0) from [<80251964>] 
(bit_putcs+0x2e4/0x420)
[<80251964>] (bit_putcs+0x2e4/0x420) from [<8024bde0>] 
(fbcon_putcs+0xec/0x128)
[<8024bde0>] (fbcon_putcs+0xec/0x128) from [<802741f8>] 
(do_update_region+0x108/0x18c)
[<802741f8>] (do_update_region+0x108/0x18c) from [<80275970>] 
(update_region+0x70/0x88)
[<80275970>] (update_region+0x70/0x88) from [<8024dd08>] 
(fbcon_switch+0x468/0x4bc)
[<8024dd08>] (fbcon_switch+0x468/0x4bc) from [<80276c84>] 
(redraw_screen+0x15c/0x278)
[<80276c84>] (redraw_screen+0x15c/0x278) from [<80279e90>] 
(take_over_console+0x2cc/0x37c)
[<80279e90>] (take_over_console+0x2cc/0x37c) from [<8024cacc>] 
(fbcon_takeover+0x70/0xd4)
[<8024cacc>] (fbcon_takeover+0x70/0xd4) from [<8042541c>] 
(notifier_call_chain+0x44/0x84)
[<8042541c>] (notifier_call_chain+0x44/0x84) from [<8004a2a0>] 
(__blocking_notifier_call_chain+0x4c/0x64)
[<8004a2a0>] (__blocking_notifier_call_chain+0x4c/0x64) from 
[<8004a2d0>] (blocking_notifier_call_chain+0x18/0x20)
[<8004a2d0>] (blocking_notifier_call_chain+0x18/0x20) from [<80246f78>] 
(register_framebuffer+0x17c/0x230)
[<80246f78>] (register_framebuffer+0x17c/0x230) from [<80586ab8>] 
(imxfb_probe+0x3c8/0x5a8)
[<80586ab8>] (imxfb_probe+0x3c8/0x5a8) from [<80286ba8>] 
(platform_drv_probe+0x14/0x18)
[<80286ba8>] (platform_drv_probe+0x14/0x18) from [<802858b0>] 
(driver_probe_device+0x80/0x20c)
[<802858b0>] (driver_probe_device+0x80/0x20c) from [<80285ac8>] 
(__driver_attach+0x8c/0x90)
[<80285ac8>] (__driver_attach+0x8c/0x90) from [<80284230>] 
(bus_for_each_dev+0x64/0x8c)
[<80284230>] (bus_for_each_dev+0x64/0x8c) from [<802849b0>] 
(bus_add_driver+0xa4/0x230)
[<802849b0>] (bus_add_driver+0xa4/0x230) from [<80286098>] 
(driver_register+0x78/0x140)
[<80286098>] (driver_register+0x78/0x140) from [<80286ef4>] 
(platform_driver_probe+0x18/0x9c)
[<80286ef4>] (platform_driver_probe+0x18/0x9c) from [<805866d8>] 
(imxfb_init+0x88/0xa0)
[<805866d8>] (imxfb_init+0x88/0xa0) from [<800087e4>] 
(do_one_initcall+0x30/0x178)
[<800087e4>] (do_one_initcall+0x30/0x178) from [<80576310>] 
(kernel_init+0xe4/0x1b0)
[<80576310>] (kernel_init+0xe4/0x1b0) from [<80015268>] 
(kernel_thread_exit+0x0/0x8)


Without this setting the CPU does stop working (for JTAG debugger it has 
the same effect as board is in power off state):

177772 bytes written at address 0x811ffc00
downloaded 177772 bytes in 19.548666s (8.881 KiB/s)
WARNING: unknown debug reason: 0xf
ThumbEE -- incomplete support
target state: halted
target halted in ThumbEE state due to debug-request, current mode: System
cpsr: 0xffffffff pc: 0xfffffff9
MMU: enabled, D-Cache: enabled, I-Cache: enabled




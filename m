From: Stefan Koch <stefan.koch10@gmail.com>
Date: Wed, 07 Nov 2012 14:00:04 +0000
Subject: i.MX 257 ARM-CPU: framebuffer error "division by zero"
Message-Id: <509A6964.5090305@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

I'm porting Linux 3.6.2 to a board with Freescale IMX 257 ARMv5-CPU.

Linux works mostly, kernel can run, and Debian can run with kernel, too.

So I can get access via UART to Debian's Linux console and install 
packages via apt-get and so on.

The next step is to enable the graphics support.

This does the line "imx25_add_imx_fb(&mx25cevipro_fb_pdata);" that 
enables the fb.

Linux kernel works fine when this line is commented out, but when it's 
active the kernel stops working before print out the first kernel 
message on serial line.

So openocd prints with general U-Boot kernel boot (with enabled fb):
WARNING: unknown debug reason: 0xf
ThumbEE -- incomplete support
target state: halted
target halted in ThumbEE state due to debug-request, current mode: System
cpsr: 0xffffffff pc: 0xfffffff9
MMU: enabled, D-Cache: enabled, I-Cache: enabled

If I use gdb for loading and step through the source beginning from 
add_imx_fb(...) line then I will get these output from openocd:
Unable to set 32 bit software breakpoint at address 8057c7e0 - check 
that memory is read/writable
Unable to set 32 bit software breakpoint at address 8057c7e0 - check 
that memory is read/writable
breakpoint not set
 > poll
background polling: on
TAP: imx25.cpu (enabled)
target state: halted
target halted in ARM state due to breakpoint, current mode: Supervisor
cpsr: 0x40000013 pc: 0x8057c7e0
MMU: enabled, D-Cache: enabled, I-Cache: enabled

pc doesn't change anymore (so there are no code steps possible after 
this moment).

The board bsp (with the add_imx_fb(...) line) is this one: 
http://paste.debian.net/hidden/10d828f8/
And this is based on bsp from Freescale MX25 3DS board: 
http://paste.debian.net/hidden/50ada4ee/ or 
arch/arm/mach-imx/mach-mx25_3ds.c in kernel tree

There a two screenshots from ddd-Debugger attached.
The on is code view, and the other the backtrace.

What could be the problem?
Could be a kernel bug?

Could be this a problem?:
"imx-sdma imx35-sdma: firmware not found" appears when booting the 
kernel without enabled fb.

In FB enabled kernel's the last debugable function is 
imx_add_platform_device_dmamask()

Both have "dma" in the string...

But for loading a firmware from filesystem, the kernel crashes to early, 
I think.

(The display is connected via LVDS).

-------------------------

If I add "video=imxfb:SVGA-16@60" to kernel command line, then there are 
new messages when init fb within BSP file:

Division by zero in kernel.
[<80019ba4>] (unwind_backtrace+0x0/0xf4) from [<8022accc>] (Ldiv0+0x8/0x10)
[<8022accc>] (Ldiv0+0x8/0x10) from [<8022ac9c>] (__aeabi_uidivmod+0x8/0x18)
[<8022ac9c>] (__aeabi_uidivmod+0x8/0x18) from [<80254198>] 
(cfb_imageblit+0x1fc/0x4b0)
[<80254198>] (cfb_imageblit+0x1fc/0x4b0) from [<80251c94>] 
(soft_cursor+0x158/0x1bc)
[<80251c94>] (soft_cursor+0x158/0x1bc) from [<80251664>] 
(bit_cursor+0x4ac/0x4c8)
[<80251664>] (bit_cursor+0x4ac/0x4c8) from [<8024bcd8>] 
(fb_flashcursor+0x108/0x124)
[<8024bcd8>] (fb_flashcursor+0x108/0x124) from [<8003cc00>] 
(process_one_work+0x188/0x4fc)
[<8003cc00>] (process_one_work+0x188/0x4fc) from [<8003d458>] 
(worker_thread+0x130/0x598)
[<8003d458>] (worker_thread+0x130/0x598) from [<80043ef0>] 
(kthread+0x8c/0x98)
[<80043ef0>] (kthread+0x8c/0x98) from [<80015268>] 
(kernel_thread_exit+0x0/0x8)
Division by zero in kernel.

Without this command line parameter the "cpsr: 0xffffffff pc: 
0xfffffff9" error still occurs.

Is this a bug in the driver?

Thank you

Stefan Koch

From: Timur Tabi <timur@freescale.com>
Date: Fri, 11 Mar 2011 22:50:37 +0000
Subject: framebuffer works with console, but not tty
Message-Id: <4D7AA73D.5090705@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I have a framebuffer driver (drivers/video/fsl_diu_fb.c) that works fine as a
console.  However, I cannot get any tty output to appear on my video device.
tty output appears on the serial port, as does the login prompt.

I'm pretty sure this is a problem with my root file system configuration, but I
can't find any information on how to get it to work.  I've checked the fbdev
documentation, done numerous Google searches, and searched the archives of this
mailing list, but I can't even find any threads discussing the issue, let alone
answering it.

So what am I missing?  What do I need to do in my rootfs to get tty output and
the login prompt to appear on my video device, and not the serial port?

Here's my kernel command line:

root=/dev/ram rw console=ttyS0,115200 console=tty0
video=fslfb:1280x1024-32@60,monitor=dvi panic=1 ramdisk_size1000 debug=1


-- 
Timur Tabi
Linux kernel developer at Freescale


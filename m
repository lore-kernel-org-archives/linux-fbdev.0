From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Virtual Framebuffer on UM
Date: Sat, 10 Jul 2004 17:05:34 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0407101646170.10242@waterleaf.sonytel.be>
References: <1089438322.3195.126.camel@localhost>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BjJQ5-0002L5-GQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jul 2004 08:05:41 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BjJQ4-0003OL-DU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jul 2004 08:05:41 -0700
In-Reply-To: <1089438322.3195.126.camel@localhost>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Clunis <orospakr@orospakr.is-a-geek.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 10 Jul 2004, Andrew Clunis wrote:
> I've been hacking on the UM kernel to reenable framebuffer support, in
> preparation for writing a driver using SDL (http://libsdl.org).  The
> only things I have modified (at least with this tree, heh heh) so far
> were to add 'source drivers/video/Kconfig' to arch/um's Kconfig, and
> patch fbmem.c to disable caching on the UM arch.  This is in the fb_mmap
> function, in all those messy #ifdefs around the arch specific calls to
> disable caching on the video memory.
>
> I have a 2.6.6 UM kernel with the aforementioned patches that has been
> booted with video=vfb:, and displays:
>   fb0: Virtual frame buffer device, using 1024K of video memory
> in the kernel messages.
>
> I've ensured /dev/fb0 device node has major 29 and minor 0.
>
> However, when I do 'cp /dev/fb0 /root/blob', I get a file of size 0.  I
> was expecting a 1 meg file.
>
> Is this normal behavior?

What does `fbset -i' say about the length of the frame buffer?

> p.s. Geert, where can the source for your old GDK UM driver be found,
> the one that had the -lpthread trouble?  I have a design that will
> (hopefully) not have those issues, but I'm curious as to how you tackled
> the rest of it.  (SDL itself has a -lpthread dependency, but I can get
> around this. The graphical component of SDL does not require pthreads,
> so as long as I don't init the audio or threading components, I should
> be OK)

I never finished it. I started using SKAS mode (in that case UML is dynamically
linked instead of statically, and libX11 doesn't need libpthread) and managed
to get something to work. IIRC at one moment of time even fbtest worked a bit.

However, when trying to get the logo and a real frame buffer console, I got
stuck in the conflicts between the standard virtual console subsystem and the
UML virtual consoles. With Gerd Knorr's recent patches for a special stderr
console, you can probably solve (a few of) these conflicts.

What I had in mind:
  - Split gdkfb in a kernel (gdkfb_kern) part that talks fbdev, and a user
    (gdkfb_user) part that takes care of X/GDK/GTK,
  - Use a ring buffer for transfering drawing commands (from fbcon) between the
    two parts [not yet implemented],
  - Use a separate thread to periodically update the screen contents if the
    user has mmap()ed the virtual frame buffer [not yet implemented].

Anyway, here's the patch for my current work. Note that it includes 2 versions
of gdkfb and that you have to append `gdkfb' or `gdkfb2' to the kernel command
line to make it initialize gdkfb or gdkfb2.

Good luck!

--- linux-uml-2.6.4-1/Makefile	2004-04-28 15:48:59.000000000 +0200
+++ linux-uml-2.6.4-geert/Makefile	2004-07-10 16:51:37.000000000 +0200
@@ -149,7 +149,7 @@
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile

-ARCH		?= $(SUBARCH)
+ARCH		?= um
 CROSS_COMPILE	?=

 # Architecture as present in compile.h
--- linux-uml-2.6.4-1/arch/um/Kconfig	2004-04-30 16:16:22.000000000 +0200
+++ linux-uml-2.6.4-geert/arch/um/Kconfig	2004-06-27 14:37:57.000000000 +0200
@@ -225,6 +225,8 @@

 source "drivers/base/Kconfig"

+source "drivers/input/Kconfig"
+
 source "arch/um/Kconfig_char"

 source "arch/um/Kconfig_block"
@@ -239,6 +241,8 @@

 source "fs/Kconfig"

+source "drivers/video/Kconfig"
+
 source "security/Kconfig"

 source "crypto/Kconfig"
--- linux-uml-2.6.4-1/arch/um/Kconfig_char	2004-04-27 20:32:58.000000000 +0200
+++ linux-uml-2.6.4-geert/arch/um/Kconfig_char	2004-06-27 14:37:16.000000000 +0200
@@ -2,8 +2,9 @@
 menu "Character Devices"

 config STDIO_CONSOLE
-	bool
-	default y
+	bool "Stdio console"
+	help
+	Conflicts with FRAMEBUFFER_CONSOLE?

 config SSL
 	bool "Virtual serial line"
@@ -16,6 +17,7 @@
         information and command line examples of how to use this facility.

         Unless you have a specific reason for disabling this, say Y.
+	Conflicts with FRAMEBUFFER_CONSOLE?

 config FD_CHAN
 	bool "file descriptor channel support"
@@ -106,6 +108,64 @@
         this if you expect the UML that you build to be run in environments
         which don't have a set of /dev/pty* devices.

+config VT
+	bool "Virtual terminal" if EMBEDDED || USERMODE
+	select INPUT
+	default y
+	---help---
+	  If you say Y here, you will get support for terminal devices with
+	  display and keyboard devices. These are called "virtual" because you
+	  can run several virtual terminals (also called virtual consoles) on
+	  one physical terminal. This is rather useful, for example one
+	  virtual terminal can collect system messages and warnings, another
+	  one can be used for a text-mode user session, and a third could run
+	  an X session, all in parallel. Switching between virtual terminals
+	  is done with certain key combinations, usually Alt-<function key>.
+
+	  The setterm command ("man setterm") can be used to change the
+	  properties (such as colors or beeping) of a virtual terminal. The
+	  man page console_codes(4) ("man console_codes") contains the special
+	  character sequences that can be used to change those properties
+	  directly. The fonts used on virtual terminals can be changed with
+	  the setfont ("man setfont") command and the key bindings are defined
+	  with the loadkeys ("man loadkeys") command.
+
+	  You need at least one virtual terminal device in order to make use
+	  of your keyboard and monitor. Therefore, only people configuring an
+	  embedded system would want to say N here in order to save some
+	  memory; the only way to log into such a system is then via a serial
+	  or network connection.
+
+	  If unsure, say Y, or else you won't be able to do much with your new
+	  shiny Linux system :-)
+
+config VT_CONSOLE
+	bool "Support for console on virtual terminal" if EMBEDDED || USERMODE
+	depends on VT
+	default y
+	---help---
+	  The system console is the device which receives all kernel messages
+	  and warnings and which allows logins in single user mode. If you
+	  answer Y here, a virtual terminal (the device used to interact with
+	  a physical terminal) can be used as system console. This is the most
+	  common mode of operations, so you should say Y here unless you want
+	  the kernel messages be output only to a serial port (in which case
+	  you should say Y to "Console on serial port", below).
+
+	  If you do say Y here, by default the currently visible virtual
+	  terminal (/dev/tty0) will be used as system console. You can change
+	  that with a kernel command line option such as "console=tty3" which
+	  would use the third virtual terminal as system console. (Try "man
+	  bootparam" or see the documentation of your boot loader (lilo or
+	  loadlin) about how to pass options to the kernel at boot time.)
+
+	  If unsure, say Y.
+
+config HW_CONSOLE
+	bool
+	depends on VT && !S390
+	default y
+
 config UNIX98_PTYS
 	bool "Unix98 PTY support"

--- linux-uml-2.6.4-1/arch/um/Makefile	2004-04-30 16:16:22.000000000 +0200
+++ linux-uml-2.6.4-geert/arch/um/Makefile	2004-07-10 16:51:55.000000000 +0200
@@ -42,11 +42,11 @@
 MAKEFILE-$(CONFIG_MODE_SKAS) += Makefile-skas

 ifneq ($(MAKEFILE-y),)
-  include $(addprefix $(ARCH_DIR)/,$(MAKEFILE-y))
+  include $(addprefix $(srctree)/$(ARCH_DIR)/,$(MAKEFILE-y))
 endif

-include $(ARCH_DIR)/Makefile-$(SUBARCH)
-include $(ARCH_DIR)/Makefile-os-$(OS)
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)

 EXTRAVERSION := $(EXTRAVERSION)-1um

@@ -84,6 +84,8 @@

 LDFLAGS_vmlinux = -r

+all: linux
+
 vmlinux: $(ARCH_DIR)/main.o

 # These aren't in Makefile-tt because they are needed in the !CONFIG_MODE_TT +
@@ -123,9 +125,53 @@
 #$(LD_SCRIPT-y) : $(LD_SCRIPT-y:.s=.S) scripts FORCE
 #	$(call if_changed_dep,as_s_S)

+LINK_LIBS = -L/usr/lib -lutil
+ifeq ($(CONFIG_FB_GDK), y)
+#LINK_LIBS += -L/usr/X11R6/lib -lgtk -lgdk -lX11 -lXi -lXext -lglib -lgmodule -ldl -lm -lgthread
+LINK_LIBS += -L/usr/X11R6/lib -lgtk -lgdk -lX11 -lXi -lXext -lglib -lgmodule -ldl -lm
+endif
+
+# Start FIXME Geert
+CFLAGS += -D_REENTRANT
+
+#LINK_WRAPS += -Wl,--wrap,sigaction
+#LINK_WRAPS += -Wl,--wrap,sigwait
+#LINK_WRAPS += -Wl,--wrap,raise
+#LINK_WRAPS += -Wl,--wrap,__flockfile
+#LINK_WRAPS += -Wl,--wrap,__funlockfile
+#LINK_WRAPS += -Wl,--wrap,__ftrylockfile
+#LINK_WRAPS += -Wl,--wrap,__fork
+#LINK_WRAPS += -Wl,--wrap,__libc_current_sigrtmin
+#LINK_WRAPS += -Wl,--wrap,siglongjmp
+#LINK_WRAPS += -Wl,--wrap,longjmp
+#LINK_WRAPS += -Wl,--wrap,sem_open
+#LINK_WRAPS += -Wl,--wrap,sem_close
+#LINK_WRAPS += -Wl,--wrap,sem_unlink
+#LINK_WRAPS += -Wl,--wrap,sem_timedwait
+#LINK_WRAPS += -Wl,--wrap,close
+#LINK_WRAPS += -Wl,--wrap,fcntl
+#LINK_WRAPS += -Wl,--wrap,nanosleep
+#LINK_WRAPS += -Wl,--wrap,open
+#LINK_WRAPS += -Wl,--wrap,pause
+#LINK_WRAPS += -Wl,--wrap,pread
+#LINK_WRAPS += -Wl,--wrap,read
+#LINK_WRAPS += -Wl,--wrap,waitpid
+#LINK_WRAPS += -Wl,--wrap,write
+#LINK_WRAPS += -Wl,--wrap,accept
+#LINK_WRAPS += -Wl,--wrap,connect
+#LINK_WRAPS += -Wl,--wrap,recv
+#LINK_WRAPS += -Wl,--wrap,recvfrom
+#LINK_WRAPS += -Wl,--wrap,recvmsg
+#LINK_WRAPS += -Wl,--wrap,send
+#LINK_WRAPS += -Wl,--wrap,sendmsg
+#LINK_WRAPS += -Wl,--wrap,sendto
+
+#LINK_LIBS += -lpthread
+#LINK_LIBS += /export/home2/geert/glibc-2.3.2/i386-linux/obj/linuxthreads/libpthread.a
+# End FIXME Geert
+
 linux: vmlinux $(LD_SCRIPT-y)
-	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) $(LINK_WRAPS) \
-		-o linux $(ARCH_DIR)/main.o vmlinux -L/usr/lib -lutil
+	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) $(LINK_WRAPS) -o linux $(ARCH_DIR)/main.o vmlinux $(LINK_LIBS)

 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -Derrno=kernel_errno,,$(USER_CFLAGS))
--- linux-uml-2.6.4-1/arch/um/drivers/Makefile	2004-04-30 16:16:22.000000000 +0200
+++ linux-uml-2.6.4-geert/arch/um/drivers/Makefile	2004-06-27 14:37:57.000000000 +0200
@@ -19,6 +19,8 @@
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
+gdkfb-objs := gdkfb_kern.o gdkfb_user.o
+gdkfb2-objs := gdkfb2_kern.o gdkfb2_user.o

 obj-y =
 obj-$(CONFIG_SSL) += ssl.o
@@ -41,8 +43,10 @@
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW) += cow_kern.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
+obj-$(CONFIG_FB_GDK) += gdkfb.o gdkfb2.o

-obj-y += stdio_console.o $(CHAN_OBJS)
+obj-$(CONFIG_STDIO_CONSOLE) += stdio_console.o
+obj-y += $(CHAN_OBJS)

 USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))

@@ -50,5 +54,8 @@
 	null.o pty.o tty.o xterm.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

+CFLAGS_gdkfb_user.o += $(shell gtk-config --cflags)
+CFLAGS_gdkfb2_user.o += $(shell gtk-config --cflags)
+
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
--- linux-uml-2.6.4-1/arch/um/drivers/gdkfb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-uml-2.6.4-geert/arch/um/drivers/gdkfb.h	2004-06-27 14:37:16.000000000 +0200
@@ -0,0 +1,23 @@
+/*
+ *  linux/drivers/video/gdkfb.c -- GDK/GTK based frame buffer device
+ *
+ *	Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/fb.h>
+#include <linux/init.h>
+
+struct gdkfb_user;
+
+extern int __init gdkfb_user_init(void);
+extern int __init gdkfb_user_init_one(struct gdkfb_user **gdkfb,
+				      struct fb_fix_screeninfo *fix,
+				      struct fb_var_screeninfo *var);
+extern void gdkfb_user_update(int x, int y, int width, int height,
+			      struct gdkfb_user *gdkfb);
+extern void gdkfb_user_setcolreg(unsigned int regno, unsigned int rgb,
+				 struct gdkfb_user *gdkfb);
--- linux-uml-2.6.4-1/arch/um/drivers/gdkfb2.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-uml-2.6.4-geert/arch/um/drivers/gdkfb2.h	2004-06-27 14:37:16.000000000 +0200
@@ -0,0 +1,23 @@
+/*
+ *  linux/drivers/video/gdkfb2.c -- GDK/GTK based frame buffer device
+ *
+ *	Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/fb.h>
+#include <linux/init.h>
+
+struct gdkfb2_user;
+
+extern int __init gdkfb2_user_init(void);
+extern int __init gdkfb2_user_init_one(struct gdkfb2_user **gdkfb2,
+				      struct fb_fix_screeninfo *fix,
+				      struct fb_var_screeninfo *var);
+extern void gdkfb2_user_update(int x, int y, int width, int height,
+			      struct gdkfb2_user *gdkfb2);
+extern void gdkfb2_user_setcolreg(unsigned int regno, unsigned int rgb,
+				 struct gdkfb2_user *gdkfb2);
--- linux-uml-2.6.4-1/arch/um/drivers/gdkfb2_kern.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-uml-2.6.4-geert/arch/um/drivers/gdkfb2_kern.c	2004-06-27 14:37:16.000000000 +0200
@@ -0,0 +1,308 @@
+/*
+ *  linux/drivers/video/gdkfb2.c -- GDK/GTK based frame buffer device
+ *
+ *	Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include <linux/delay.h>	// FIXME
+
+#include <asm/uaccess.h>
+
+#include "gdkfb2.h"
+
+#include "init.h"
+
+#define VRAM_SIZE	4*1024*1024
+
+#define FB_WIDTH	640
+#define FB_HEIGHT	480
+
+
+int gdkfb2_enabled = 0;
+
+struct gdkfb2_kern {
+    struct fb_info info;
+    struct gdkfb2_user *user;
+};
+
+static u8 gdkfb2_vram[VRAM_SIZE] __attribute__ ((aligned(PAGE_SIZE)));
+
+
+/* ------------------------------------------------------------------------- */
+
+
+static ssize_t gdkfb2_write(struct file *file, const char *buf, size_t count,
+			    loff_t *ppos)
+{
+    unsigned long p = *ppos;
+    struct inode *inode = file->f_dentry->d_inode;
+    int fbidx = iminor(inode);
+    struct fb_info *info = registered_fb[fbidx];
+    struct gdkfb2_kern *gdkfb2 = (struct gdkfb2_kern *)info;
+    int err;
+
+    if (p > info->fix.smem_len)
+	return -ENOSPC;
+    if (count >= info->fix.smem_len)
+	count = info->fix.smem_len;
+    err = 0;
+    if (count + p > info->fix.smem_len) {
+	count = info->fix.smem_len - p;
+	err = -ENOSPC;
+    }
+    if (count) {
+	char *base_addr;
+	base_addr = info->screen_base;
+	count -= copy_from_user(base_addr+p, buf, count);
+	*ppos += count;
+	err = -EFAULT;
+	// FIXME
+	//gdkfb2_user_update(0, 0, info->var.xres, info->var.yres, gdkfb2->user);
+    }
+    if (count)
+	return count;
+    return err;
+}
+
+
+    /*
+     *  Set a single color register. The values supplied are already rounded
+     *  down to the hardware's capabilities (according to the entries in the
+     *  var structure). Return != 0 for invalid regno.
+     */
+
+static int gdkfb2_setcolreg(unsigned int regno, unsigned int red,
+			   unsigned int green, unsigned int blue,
+			   unsigned int transp, struct fb_info *info)
+{
+    struct gdkfb2_kern *gdkfb2 = (struct gdkfb2_kern *)info;
+
+//printk("> gdkfb2_setcolreg\n");
+    if (regno >= info->cmap.len) {
+//printk("< gdkfb2_setcolreg\n");
+	return 1;
+    }
+
+    red >>= 8;
+    green >>= 8;
+    blue >>= 8;
+    gdkfb2_user_setcolreg(regno, red << 16 | green << 8 | blue, gdkfb2->user);
+//printk("< gdkfb2_setcolreg\n");
+    return 0;
+}
+
+
+    /*
+     *  Draw a rectangle
+     */
+
+static void gdkfb2_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect)
+{
+    struct gdkfb2_kern *gdkfb2 = (struct gdkfb2_kern *)info;
+
+//printk("> gdkfb2_fillrect\n");
+    cfb_fillrect(info, rect);
+    gdkfb2_user_update(rect->dx, rect->dy, rect->width, rect->height,
+		       gdkfb2->user);
+//printk("< gdkfb2_fillrect\n");
+}
+
+
+    /*
+     *  Copy data from one area to another
+     */
+
+static void gdkfb2_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *region)
+{
+    struct gdkfb2_kern *gdkfb2 = (struct gdkfb2_kern *)info;
+
+//printk("> gdkfb2_copyarea\n");
+    cfb_copyarea(info, region);
+    gdkfb2_user_update(region->dx, region->dy, region->width, region->height,
+		       gdkfb2->user);
+//printk("< gdkfb2_copyarea\n");
+}
+
+
+    /*
+     *  Draw an image to the display
+     */
+
+static void gdkfb2_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+    struct gdkfb2_kern *gdkfb2 = (struct gdkfb2_kern *)info;
+
+//printk("> gdkfb2_imageblit\n");
+    cfb_imageblit(info, image);
+    gdkfb2_user_update(image->dx, image->dy, image->width, image->height,
+		       gdkfb2->user);
+//printk("< gdkfb2_imageblit\n");
+}
+
+
+    /*
+     *  gdkfb2 operations
+     */
+
+static struct fb_ops gdkfb2_ops = {
+    .owner		= THIS_MODULE,
+    .fb_write		= gdkfb2_write,
+    .fb_setcolreg	= gdkfb2_setcolreg,
+    .fb_fillrect	= gdkfb2_fillrect,
+    .fb_copyarea	= gdkfb2_copyarea,
+    .fb_imageblit	= gdkfb2_imageblit,
+    .fb_cursor		= soft_cursor,
+};
+
+
+    /*
+     *  Initialisation
+     */
+
+static struct gdkfb2_kern gdkfb2_kern;	// FIXME
+static u16 gdkfb2_red[256];		// FIXME
+static u16 gdkfb2_green[256];		// FIXME
+static u16 gdkfb2_blue[256];		// FIXME
+
+int __init gdkfb2_init(void)
+{
+    struct fb_info *info;
+
+    if (!gdkfb2_enabled) {
+printk("gdkfb2_init: gdkfb2 is disabled\n");
+	return 0;
+    }
+
+printk("gdkfb2_init\n");
+    info = &gdkfb2_kern.info;
+
+printk("F\n");
+    if (register_framebuffer(info) < 0) {
+printk("G\n");
+	    return -EINVAL;
+    }
+
+printk("H\n");
+    printk(KERN_INFO "fb%d: GDK/GTK frame buffer device\n", info->node);
+
+printk("info = %p\n", info);
+    return 0;
+}
+
+int __init gdkfb2_setup(char *args)
+{
+    return 0;
+}
+
+MODULE_LICENSE("GPL");
+
+
+static int __init _gdkfb2_setup(char *line, int *add)
+{
+    struct gdkfb2_kern *gdkfb2;
+    struct fb_info *info;
+    struct fb_fix_screeninfo *fix;
+    struct fb_var_screeninfo *var;
+    int error;
+
+    *add = 0;
+    gdkfb2_enabled = 1;
+
+printk("_gdkfb2_setup\n");
+    error = gdkfb2_user_init();
+    if (error)
+	return error;
+
+    gdkfb2 = &gdkfb2_kern;
+printk("A\n");
+    if (!gdkfb2)
+	return -ENOMEM;
+    memset(gdkfb2, 0, sizeof(struct gdkfb2_kern));
+printk("B\n");
+
+    info = &gdkfb2->info;
+    fix = &info->fix;
+    var = &info->var;
+
+printk("C\n");
+    strcpy(fix->id, "gdkfb2");
+    fix->smem_start = (unsigned long)gdkfb2_vram;
+    fix->smem_len = sizeof(gdkfb2_vram);
+    fix->type = FB_TYPE_PACKED_PIXELS;
+    fix->visual = FB_VISUAL_PSEUDOCOLOR;
+    fix->line_length = FB_WIDTH;
+
+    var->xres = var->xres_virtual = FB_WIDTH;
+    var->yres = var->yres_virtual = FB_HEIGHT;
+    var->bits_per_pixel = 8;
+    var->red.length = 8;
+    var->green.length = 8;
+    var->blue.length = 8;
+    var->height = var->width = -1;
+
+    var->pixclock = 39721;
+    var->left_margin = 40;
+    var->right_margin = 24;
+    var->upper_margin = 32;
+    var->lower_margin = 11;
+    var->hsync_len = 96;
+    var->vsync_len = 2;
+    var->vmode = FB_VMODE_NONINTERLACED;
+
+    info->fbops = &gdkfb2_ops;
+    info->screen_base = gdkfb2_vram;
+    info->flags = FBINFO_FLAG_DEFAULT;
+
+printk("D\n");
+    //fb_alloc_cmap(&info->cmap, 256, 0);
+    info->cmap.red = gdkfb2_red;
+    info->cmap.green = gdkfb2_green;
+    info->cmap.blue = gdkfb2_blue;
+    info->cmap.transp = NULL;
+    info->cmap.start = 0;
+    info->cmap.len = 256;
+    fb_copy_cmap(fb_default_cmap(256), &info->cmap, 0);
+
+printk("E\n");
+    error = gdkfb2_user_init_one(&gdkfb2->user, fix, var);
+    if (error) {
+	printk("Woops, GUI failed error %d\n", error);
+	/* FIXME clean up */
+    }
+
+#if 1
+printk("info = %p\n", info);
+{
+    int x, y, i;
+    u8 *fb = (u8 *)info->fix.smem_start;
+printk("fb = %p\n", fb);
+
+    for (i = 0; i < 256; i++) {
+	u16 r = (i & 0xc0) << 8;
+	u16 g = (i & 0x38) << 10;
+	u16 b = (i & 0x07) << 13;
+	gdkfb2_setcolreg(i, r, g, b, 0, info);
+    }
+    for (y = 0; y < FB_HEIGHT; y++)
+	for (x = 0; x < FB_WIDTH; x++)
+	    fb[y*FB_WIDTH+x] = 16*(15*y/FB_HEIGHT)+(15*x/FB_WIDTH);
+}
+#endif
+printk("J\n");
+    return 0;
+    return 0;
+}
+
+__uml_setup("gdkfb2", _gdkfb2_setup, "No comments");
--- linux-uml-2.6.4-1/arch/um/drivers/gdkfb2_user.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-uml-2.6.4-geert/arch/um/drivers/gdkfb2_user.c	2004-06-27 14:37:16.000000000 +0200
@@ -0,0 +1,323 @@
+/*
+ *  linux/drivers/video/gdkfb2.c -- GDK/GTK based frame buffer device
+ *
+ *	Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <sched.h>
+#include <errno.h>
+#include <signal.h>
+
+#include <gtk/gtk.h>
+
+#include <linux/fb.h>
+#include <linux/init.h>
+
+#include "gdkfb2.h"
+#include "kern_util.h"
+#include "user.h"
+
+#include <pthread.h>
+#include <stdio.h>
+
+struct gdkfb2_user {
+    struct fb_fix_screeninfo *fix;
+    struct fb_var_screeninfo *var;
+    GdkRgbCmap cmap;
+    GtkWidget *fb_widget;
+};
+
+#undef ENABLE_KEYBOARD
+#undef ENABLE_MOUSE
+
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Event handlers
+     *  Note: the gdk lock is already held!
+     */
+
+static void gdkfb2_refresh(int x, int y, int width, int height,
+			  struct gdkfb2_user *gdkfb2)
+{
+    GtkWidget *widget = gdkfb2->fb_widget;
+    struct fb_fix_screeninfo *fix = gdkfb2->fix;
+
+printf("  > gdkfb2_refresh(%d, %d, %d, %d)\n", x, y, width, height);
+    gdk_draw_indexed_image(widget->window,
+			   widget->style->fg_gc[GTK_STATE_NORMAL], x, y, width,
+			   height, GDK_RGB_DITHER_MAX,
+			   (guchar *)fix->smem_start+y*fix->line_length+x,
+			   fix->line_length, &gdkfb2->cmap);
+printf("  < gdkfb2_refresh\n");
+}
+
+
+static void gdkfb2_window_destroy_handler(GtkWidget *widget, gpointer data)
+{
+    //struct gdkfb2_user *gdkfb2 = (struct gdkfb2_user *)data;
+printf("gdkfb2_window_destroy_handler(%p, %p)\n", widget, data);
+    gtk_main_quit();
+}
+
+static void gdkfb2_button_callback(GtkWidget *widget, gpointer data)
+{
+    //struct gdkfb2_user *gdkfb2 = (struct gdkfb2_user *)data;
+    printf("gdkfb2_button_callback(%p, %p)\n", widget, data);
+
+#if 0
+    /* Frame buffer has focus by default */
+    gtk_widget_grab_focus(gdkfb2->fb_widget);
+#endif
+}
+
+static gboolean gdkfb2_expose_handler(GtkWidget *widget, GdkEventExpose *event,
+				     gpointer data)
+{
+    struct gdkfb2_user *gdkfb2 = (struct gdkfb2_user *)data;
+printf("> gdkfb2_expose_handler(%p, %p)\n", widget, data);
+    gdkfb2_refresh(event->area.x, event->area.y, event->area.width,
+		  event->area.height, gdkfb2);
+printf("< gdkfb2_expose_handler\n");
+    return TRUE;
+}
+
+#ifdef ENABLE_KEYBOARD
+static void gdkfb2_key_handler(GtkWidget *widget, GdkEvent *event,
+			      gpointer callback_data)
+{
+    struct gdkfb2_user *gdkfb2 = (struct gdkfb2_user *)data;
+    GdkEventKey *key = (GdkEventKey *)event;
+
+    printf("gdkfb2_key_handler %d %s\n", key->keyval & 0x1ff,
+	   key->type == GDK_KEY_PRESS ? "down" : "up");
+}
+#endif /* ENABLE_KEYBOARD */
+
+
+#ifdef ENABLE_MOUSE
+static void gdkfb2_mouse_motion_handler(GtkWidget *widget, GdkEvent *event,
+				       gpointer callback_data)
+{
+    struct gdkfb2_user *gdkfb2 = (struct gdkfb2_user *)data;
+    GdkEventMotion *motion = (GdkEventMotion *)event;
+    gint x, y;
+    GdkModifierType state;
+
+    if (motion->is_hint)
+	gdk_window_get_pointer(motion->window, &x, &y, &state);
+    else {
+      x = (gint)motion->x;
+      y = (gint)motion->y;
+      state = (GdkModifierType)motion->state;
+    }
+    printf("gdkfb2_mouse_motion_handler %d %d\n", x, y);
+}
+
+static void gdkfb2_mouse_button_handler(GtkWidget *widget, GdkEvent *event,
+				       gpointer callback_data)
+{
+    struct gdkfb2_user *gdkfb2 = (struct gdkfb2_user *)data;
+    GdkEventButton *button = (GdkEventButton *)event;
+
+    printf("gdk_mouse_button_handler %d %s\n", button->button,
+	   button->type == GDK_BUTTON_PRESS ? "down" : "up");
+}
+#endif /* ENABLE_MOUSE */
+
+
+/* ------------------------------------------------------------------------- */
+
+static int gdkfb2_widget_thread(void *args)
+{
+printf("> gdkfb2_widget_thread\n");
+    gdk_threads_enter();
+printf("  > gtk_main\n");
+    gtk_main();
+printf("  < gtk_main\n");
+    gdk_threads_leave();
+printf("< gdkfb2_widget_thread\n");
+    printf("*BANG* GUI finished\n");
+    return 0;
+}
+
+
+/* ------------------------------------------------------------------------- */
+
+
+    /*
+     *  Update a rectangular area of the screen
+     */
+
+void gdkfb2_user_update(int x, int y, int width, int height,
+		       struct gdkfb2_user *gdkfb2)
+{
+printf("> gdkfb2_user_update(%d, %d, %d, %d, %p)\n", x, y, width, height, gdkfb2);
+    gdk_threads_enter();
+printf("  [\n");
+    gtk_widget_queue_draw_area(gdkfb2->fb_widget, x, y, width, height);
+printf("  ]\n");
+    gdk_threads_leave();
+printf("< gdkfb2_user_update\n");
+}
+
+
+void gdkfb2_user_setcolreg(unsigned int regno, unsigned int rgb,
+			  struct gdkfb2_user *gdkfb2)
+{
+    gdkfb2->cmap.colors[regno] = rgb;
+    /* FIXME wait a bit to let multiple calls accumulate */
+    gdkfb2_user_update(0, 0, gdkfb2->var->xres, gdkfb2->var->yres, gdkfb2);
+}
+
+
+    /*
+     *  Initialisation
+     */
+
+int __init gdkfb2_user_init(void)
+{
+    int argc = 1;
+    char *title[1] = { "gdkfb2 alpha" };
+    char **argv = title;
+
+printf("gdkfb2_user_init\n");
+    if (!gtk_init_check(&argc, &argv)) {
+printf("GTK initialization failed\n");
+	return -ENODEV;
+    }
+//return 0;	/* FIXME */
+
+printf("c\n");
+    gdk_rgb_init();
+printf("d\n");
+
+    return 0;
+}
+
+static struct gdkfb2_user gdkfb2_user;		// FIXME
+static unsigned long gdkfb2_stack[8192];	// FIXME
+
+int __init gdkfb2_user_init_one(struct gdkfb2_user **gdkfb2_p,
+			       struct fb_fix_screeninfo *fix,
+			       struct fb_var_screeninfo *var)
+{
+    struct gdkfb2_user *gdkfb2;
+    GtkWidget *window, *button, *box1, *box2, *fb;
+    int tid;
+    unsigned long stack;
+
+printf("gdkfb2_user_init_one\n");
+    gdkfb2 = &gdkfb2_user;
+    if (!gdkfb2) {
+	printf("No memory for struct gdkfb2_user\n");
+	return -ENOMEM;
+    }
+
+    *gdkfb2_p = gdkfb2;
+    gdkfb2->fix = fix;
+    gdkfb2->var = var;
+
+    /* Window */
+    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
+    gtk_signal_connect(GTK_OBJECT(window), "destroy",
+		       GTK_SIGNAL_FUNC(gdkfb2_window_destroy_handler), gdkfb2);
+    gtk_container_set_border_width(GTK_CONTAINER(window), 4);
+#if 1
+#ifdef ENABLE_KEYBOARD
+    gtk_signal_connect(GTK_OBJECT(window), "key_press_event",
+		       GTK_SIGNAL_FUNC(gdkfb2_key_handler), gdkfb2);
+    gtk_signal_connect(GTK_OBJECT(window), "key_release_event",
+		       GTK_SIGNAL_FUNC(gdkfb2_key_handler), gdkfb2);
+    gtk_widget_add_events(window, GDK_KEY_PRESS_MASK | GDK_KEY_RELEASE_MASK);
+#endif /* ENABLE_KEYBOARD */
+#endif
+
+    /* Button */
+    button = gtk_check_button_new_with_label("Auto-update");
+    gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), TRUE);
+    gtk_signal_connect(GTK_OBJECT(button), "clicked",
+		       GTK_SIGNAL_FUNC(gdkfb2_button_callback), gdkfb2);
+    gtk_widget_show(button);
+
+    /* Horizontal box */
+    box1 = gtk_hbox_new(FALSE, 10);
+    gtk_box_pack_start(GTK_BOX(box1), button, FALSE, FALSE, 0);
+
+    /* Frame buffer */
+    gdkfb2->fb_widget = fb = gtk_drawing_area_new();
+    gtk_drawing_area_size(GTK_DRAWING_AREA(fb), gdkfb2->var->xres,
+			  gdkfb2->var->yres);
+    gtk_signal_connect(GTK_OBJECT(fb), "expose-event",
+		       GTK_SIGNAL_FUNC(gdkfb2_expose_handler), gdkfb2);
+#ifdef ENABLE_MOUSE
+    gtk_signal_connect(GTK_OBJECT(fb), "motion_notify_event",
+		       GTK_SIGNAL_FUNC(gdkfb2_mouse_motion_handler), gdkfb2);
+    gtk_signal_connect(GTK_OBJECT(fb), "button_press_event",
+		       GTK_SIGNAL_FUNC(gdkfb2_mouse_button_handler), gdkfb2);
+    gtk_signal_connect(GTK_OBJECT(fb), "button_release_event",
+		       GTK_SIGNAL_FUNC(gdkfb2_mouse_button_handler), gdkfb2);
+    gtk_widget_add_events(fb,
+			  GDK_BUTTON_PRESS_MASK | GDK_BUTTON_RELEASE_MASK |
+			  GDK_BUTTON_MOTION_MASK | GDK_POINTER_MOTION_MASK |
+			  GDK_POINTER_MOTION_HINT_MASK);
+#endif /* ENABLE_MOUSE */
+#if 0
+#ifdef ENABLE_KEYBOARD
+    gtk_signal_connect(GTK_OBJECT(fb), "key_press_event",
+		       GTK_SIGNAL_FUNC(gdkfb2_key_handler), gdkfb2);
+    gtk_signal_connect(GTK_OBJECT(fb), "key_release_event",
+		       GTK_SIGNAL_FUNC(gdkfb2_key_handler), gdkfb2);
+    GTK_WIDGET_SET_FLAGS(fb, GTK_CAN_FOCUS);
+    gtk_widget_add_events(fb, GDK_KEY_PRESS_MASK | GDK_KEY_RELEASE_MASK);
+#endif /* ENABLE_KEYBOARD */
+#endif
+
+    /* Vertical box */
+    box2 = gtk_vbox_new(FALSE, 4);
+    gtk_box_pack_start(GTK_BOX(box2), box1, FALSE, FALSE, 0);
+    gtk_box_pack_start(GTK_BOX(box2), fb, FALSE, FALSE, 0);
+    gtk_widget_show(box2);
+
+    /* Put everything in the window */
+    gtk_container_add(GTK_CONTAINER(window), box2);
+    gtk_widget_show_all(window);
+
+#if 0
+    /* Frame buffer has focus by default */
+    gtk_widget_grab_focus(fb);
+#endif
+
+    /* Launch the widget thread */
+
+#if 1
+    stack = (unsigned long)gdkfb2_stack;
+    if (!stack) {
+	printf("gdkfb2_gui_init: no memory for stack\n");
+	return -ENOMEM;
+
+    }
+//return 0;
+
+    tid = clone(gdkfb2_widget_thread,
+		(void *)(stack+sizeof(gdkfb2_stack)-sizeof(void *)),
+		CLONE_FILES | CLONE_VM | SIGCHLD, NULL);
+    if (tid < 0) {
+	printf("gdkfb2_gui_init: clone failed, errno = %d\n", errno);
+	return -ECHILD;
+    }
+#else
+    {
+	pthread_t tid;
+	pthread_create(&tid, 0, gdkfb2_widget_thread, 0);
+    }
+#endif
+
+    return 0;
+}
+
--- linux-uml-2.6.4-1/arch/um/drivers/gdkfb_kern.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-uml-2.6.4-geert/arch/um/drivers/gdkfb_kern.c	2004-06-27 14:37:16.000000000 +0200
@@ -0,0 +1,265 @@
+/*
+ *  linux/drivers/video/gdkfb.c -- GDK/GTK based frame buffer device
+ *
+ *	Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include <linux/delay.h>	// FIXME
+
+#include "gdkfb.h"
+
+#include "init.h"
+
+#define VRAM_SIZE	4*1024*1024
+
+#define FB_WIDTH	640
+#define FB_HEIGHT	480
+
+
+int gdkfb_enabled = 0;
+
+struct gdkfb_kern {
+    struct fb_info info;
+    struct gdkfb_user *user;
+};
+
+static u8 gdkfb_vram[VRAM_SIZE] __attribute__ ((aligned(PAGE_SIZE)));
+
+
+/* ------------------------------------------------------------------------- */
+
+
+    /*
+     *  Set a single color register. The values supplied are already rounded
+     *  down to the hardware's capabilities (according to the entries in the
+     *  var structure). Return != 0 for invalid regno.
+     */
+
+static int gdkfb_setcolreg(unsigned int regno, unsigned int red,
+			   unsigned int green, unsigned int blue,
+			   unsigned int transp, struct fb_info *info)
+{
+    struct gdkfb_kern *gdkfb = (struct gdkfb_kern *)info;
+
+//printk("> gdkfb_setcolreg\n");
+    if (regno >= info->cmap.len) {
+//printk("< gdkfb_setcolreg\n");
+	return 1;
+    }
+
+    red >>= 8;
+    green >>= 8;
+    blue >>= 8;
+    gdkfb_user_setcolreg(regno, red << 16 | green << 8 | blue, gdkfb->user);
+//printk("< gdkfb_setcolreg\n");
+    return 0;
+}
+
+
+    /*
+     *  Draw a rectangle
+     */
+
+static void gdkfb_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect)
+{
+    struct gdkfb_kern *gdkfb = (struct gdkfb_kern *)info;
+
+//printk("> gdkfb_fillrect\n");
+    cfb_fillrect(info, rect);
+    gdkfb_user_update(rect->dx, rect->dy, rect->width, rect->height, gdkfb->user);
+//printk("< gdkfb_fillrect\n");
+}
+
+
+    /*
+     *  Copy data from one area to another
+     */
+
+static void gdkfb_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *region)
+{
+    struct gdkfb_kern *gdkfb = (struct gdkfb_kern *)info;
+
+//printk("> gdkfb_copyarea\n");
+    cfb_copyarea(info, region);
+    gdkfb_user_update(region->dx, region->dy, region->width, region->height, gdkfb->user);
+//printk("< gdkfb_copyarea\n");
+}
+
+
+    /*
+     *  Draw an image to the display
+     */
+
+static void gdkfb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+    struct gdkfb_kern *gdkfb = (struct gdkfb_kern *)info;
+
+//printk("> gdkfb_imageblit\n");
+    cfb_imageblit(info, image);
+    gdkfb_user_update(image->dx, image->dy, image->width, image->height, gdkfb->user);
+//printk("< gdkfb_imageblit\n");
+}
+
+
+    /*
+     *  Gdkfb operations
+     */
+
+static struct fb_ops gdkfb_ops = {
+    .owner		= THIS_MODULE,
+    .fb_setcolreg	= gdkfb_setcolreg,
+    .fb_fillrect	= gdkfb_fillrect,
+    .fb_copyarea	= gdkfb_copyarea,
+    .fb_imageblit	= gdkfb_imageblit,
+    .fb_cursor		= soft_cursor,
+};
+
+
+    /*
+     *  Initialisation
+     */
+
+int __init gdkfb_init(void)
+{
+    struct gdkfb_kern *gdkfb;
+    struct fb_info *info;
+    struct fb_fix_screeninfo *fix;
+    struct fb_var_screeninfo *var;
+    int error;
+
+    if (!gdkfb_enabled) {
+printk("gdkfb_init: gdkfb is disabled\n");
+	return 0;
+    }
+
+printk("gdkfb_init\n");
+error = 0;
+    error = gdkfb_user_init();
+    if (error)
+	return error;
+
+    gdkfb = kmalloc(sizeof(struct gdkfb_kern), GFP_ATOMIC);
+printk("A\n");
+    if (!gdkfb)
+	return -ENOMEM;
+    memset(gdkfb, 0, sizeof(struct gdkfb_kern));
+printk("B\n");
+
+    info = &gdkfb->info;
+    fix = &info->fix;
+    var = &info->var;
+
+printk("C\n");
+    strcpy(fix->id, "gdkfb");
+    fix->smem_start = (unsigned long)gdkfb_vram;
+    fix->smem_len = sizeof(gdkfb_vram);
+    fix->type = FB_TYPE_PACKED_PIXELS;
+    fix->visual = FB_VISUAL_PSEUDOCOLOR;
+    fix->line_length = FB_WIDTH;
+
+    var->xres = var->xres_virtual = FB_WIDTH;
+    var->yres = var->yres_virtual = FB_HEIGHT;
+    var->bits_per_pixel = 8;
+    var->red.length = 8;
+    var->green.length = 8;
+    var->blue.length = 8;
+    var->height = var->width = -1;
+
+    var->pixclock = 39721;
+    var->left_margin = 40;
+    var->right_margin = 24;
+    var->upper_margin = 32;
+    var->lower_margin = 11;
+    var->hsync_len = 96;
+    var->vsync_len = 2;
+    var->vmode = FB_VMODE_NONINTERLACED;
+
+    info->fbops = &gdkfb_ops;
+    info->screen_base = gdkfb_vram;
+    info->flags = FBINFO_FLAG_DEFAULT;
+
+printk("D\n");
+    fb_alloc_cmap(&info->cmap, 256, 0);
+
+printk("E\n");
+//return 0;
+    error = gdkfb_user_init_one(&gdkfb->user, fix, var);
+    if (error) {
+	printk("Woops, GUI failed error %d\n", error);
+	/* FIXME clean up */
+    }
+
+printk("F\n");
+    if (register_framebuffer(info) < 0) {
+printk("G\n");
+	    kfree(gdkfb);
+	    return -EINVAL;
+    }
+
+printk("H\n");
+    printk(KERN_INFO "fb%d: GDK/GTK frame buffer device\n", info->node);
+
+printk("I\n");
+{
+    int i;
+
+    for (i = 0; i < 1000; i++)
+	mdelay(1);
+}
+#if 1
+printk("info = %p\n", info);
+{
+    int x, y, i;
+    u8 *fb = (u8 *)info->fix.smem_start;
+printk("fb = %p\n", fb);
+
+    for (i = 0; i < 256; i++) {
+	u16 r = (i & 0xc0) << 8;
+	u16 g = (i & 0x38) << 10;
+	u16 b = (i & 0x07) << 13;
+	gdkfb_setcolreg(i, r, g, b, 0, info);
+    }
+    for (y = 0; y < FB_HEIGHT; y++)
+	for (x = 0; x < FB_WIDTH; x++)
+	    fb[y*FB_WIDTH+x] = 16*(15*y/FB_HEIGHT)+(15*x/FB_WIDTH);
+}
+#endif
+printk("J\n");
+    return 0;
+}
+
+int __init gdkfb_setup(char *args)
+{
+    return 0;
+}
+
+MODULE_LICENSE("GPL");
+
+
+static int __init _gdkfb_setup(char *line, int *add)
+{
+    static int argc = 1;
+    static char *title[1] = { "Gdkfb alpha" };
+    static char **argv = title;
+    extern int gtk_init_check(int *, char ***);
+
+    gtk_init_check(&argc, &argv);
+    *add = 0;
+
+    //gdkfb_enabled = 1;
+    return 0;
+}
+
+__uml_setup("gdkfb", _gdkfb_setup, "No comments");
--- linux-uml-2.6.4-1/arch/um/drivers/gdkfb_user.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-uml-2.6.4-geert/arch/um/drivers/gdkfb_user.c	2004-06-27 14:37:16.000000000 +0200
@@ -0,0 +1,316 @@
+/*
+ *  linux/drivers/video/gdkfb.c -- GDK/GTK based frame buffer device
+ *
+ *	Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <sched.h>
+#include <errno.h>
+#include <signal.h>
+
+#include <gtk/gtk.h>
+
+#include <linux/fb.h>
+#include <linux/init.h>
+
+#include "gdkfb.h"
+#include "kern_util.h"
+#include "user.h"
+
+struct gdkfb_user {
+    struct fb_fix_screeninfo *fix;
+    struct fb_var_screeninfo *var;
+    GdkRgbCmap cmap;
+    GtkWidget *fb_widget;
+};
+
+#undef ENABLE_KEYBOARD
+#undef ENABLE_MOUSE
+
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Event handlers
+     *  Note: the gdk lock is already held!
+     */
+
+static void gdkfb_refresh(int x, int y, int width, int height,
+			  struct gdkfb_user *gdkfb)
+{
+    GtkWidget *widget = gdkfb->fb_widget;
+    struct fb_fix_screeninfo *fix = gdkfb->fix;
+
+printk("  > gdkfb_refresh(%d, %d, %d, %d)\n", x, y, width, height);
+    gdk_draw_indexed_image(widget->window,
+			   widget->style->fg_gc[GTK_STATE_NORMAL], x, y, width,
+			   height, GDK_RGB_DITHER_MAX,
+			   (guchar *)fix->smem_start+y*fix->line_length+x,
+			   fix->line_length, &gdkfb->cmap);
+printk("  < gdkfb_refresh\n");
+}
+
+
+static void gdkfb_window_destroy_handler(GtkWidget *widget, gpointer data)
+{
+    //struct gdkfb_user *gdkfb = (struct gdkfb_user *)data;
+printk("gdkfb_window_destroy_handler(%p, %p)\n", widget, data);
+    gtk_main_quit();
+}
+
+static void gdkfb_button_callback(GtkWidget *widget, gpointer data)
+{
+    //struct gdkfb_user *gdkfb = (struct gdkfb_user *)data;
+    printk("gdkfb_button_callback(%p, %p)\n", widget, data);
+
+#if 0
+    /* Frame buffer has focus by default */
+    gtk_widget_grab_focus(gdkfb->fb_widget);
+#endif
+}
+
+static gboolean gdkfb_expose_handler(GtkWidget *widget, GdkEventExpose *event,
+				     gpointer data)
+{
+    struct gdkfb_user *gdkfb = (struct gdkfb_user *)data;
+printk("> gdkfb_expose_handler(%p, %p)\n", widget, data);
+    gdkfb_refresh(event->area.x, event->area.y, event->area.width,
+		  event->area.height, gdkfb);
+printk("< gdkfb_expose_handler\n");
+    return TRUE;
+}
+
+#ifdef ENABLE_KEYBOARD
+static void gdkfb_key_handler(GtkWidget *widget, GdkEvent *event,
+			      gpointer callback_data)
+{
+    struct gdkfb_user *gdkfb = (struct gdkfb_user *)data;
+    GdkEventKey *key = (GdkEventKey *)event;
+
+    printk("gdkfb_key_handler %d %s\n", key->keyval & 0x1ff,
+	   key->type == GDK_KEY_PRESS ? "down" : "up");
+}
+#endif /* ENABLE_KEYBOARD */
+
+
+#ifdef ENABLE_MOUSE
+static void gdkfb_mouse_motion_handler(GtkWidget *widget, GdkEvent *event,
+				       gpointer callback_data)
+{
+    struct gdkfb_user *gdkfb = (struct gdkfb_user *)data;
+    GdkEventMotion *motion = (GdkEventMotion *)event;
+    gint x, y;
+    GdkModifierType state;
+
+    if (motion->is_hint)
+	gdk_window_get_pointer(motion->window, &x, &y, &state);
+    else {
+      x = (gint)motion->x;
+      y = (gint)motion->y;
+      state = (GdkModifierType)motion->state;
+    }
+    printk("gdkfb_mouse_motion_handler %d %d\n", x, y);
+}
+
+static void gdkfb_mouse_button_handler(GtkWidget *widget, GdkEvent *event,
+				       gpointer callback_data)
+{
+    struct gdkfb_user *gdkfb = (struct gdkfb_user *)data;
+    GdkEventButton *button = (GdkEventButton *)event;
+
+    printk("gdk_mouse_button_handler %d %s\n", button->button,
+	   button->type == GDK_BUTTON_PRESS ? "down" : "up");
+}
+#endif /* ENABLE_MOUSE */
+
+
+/* ------------------------------------------------------------------------- */
+
+static int gdkfb_widget_thread(void *args)
+{
+printk("> gdkfb_widget_thread\n");
+    gdk_threads_enter();
+printk("  > gtk_main\n");
+
+#if 1
+    gtk_main();
+#else
+    /* computation going on */
+    ...
+    while (gtk_events_pending())
+      gtk_main_iteration();
+    ...
+    /* computation continued */
+#endif
+
+printk("  < gtk_main\n");
+    gdk_threads_leave();
+printk("< gdkfb_widget_thread\n");
+    printk("*BANG* GUI finished\n");
+    return 0;
+}
+
+
+/* ------------------------------------------------------------------------- */
+
+
+    /*
+     *  Update a rectangular area of the screen
+     */
+
+void gdkfb_user_update(int x, int y, int width, int height,
+		       struct gdkfb_user *gdkfb)
+{
+    gdk_threads_enter();
+    gtk_widget_queue_draw_area(gdkfb->fb_widget, x, y, width, height);
+    gdk_threads_leave();
+}
+
+
+void gdkfb_user_setcolreg(unsigned int regno, unsigned int rgb,
+			  struct gdkfb_user *gdkfb)
+{
+    gdkfb->cmap.colors[regno] = rgb;
+    /* FIXME wait a bit to let multiple calls accumulate */
+    gdkfb_user_update(0, 0, gdkfb->var->xres, gdkfb->var->yres, gdkfb);
+}
+
+
+    /*
+     *  Initialisation
+     */
+
+int __init gdkfb_user_init(void)
+{
+    int argc = 1;
+    char *title[1] = { "Gdkfb alpha" };
+    char **argv = title;
+
+printk("gdkfb_user_init\n");
+    if (!gtk_init_check(&argc, &argv)) {
+printk("GTK initialization failed\n");
+	return -ENODEV;
+    }
+//return 0;	/* FIXME */
+
+printk("c\n");
+    gdk_rgb_init();
+printk("d\n");
+
+    return 0;
+}
+
+int __init gdkfb_user_init_one(struct gdkfb_user **gdkfb_p,
+			       struct fb_fix_screeninfo *fix,
+			       struct fb_var_screeninfo *var)
+{
+    struct gdkfb_user *gdkfb;
+    GtkWidget *window, *button, *box1, *box2, *fb;
+    int tid;
+    unsigned long stack;
+
+printk("gdkfb_user_init_one\n");
+    gdkfb = um_kmalloc_atomic(sizeof(struct gdkfb_user));
+    if (!gdkfb) {
+	printk("No memory for struct gdkfb_user\n");
+	return -ENOMEM;
+    }
+
+    *gdkfb_p = gdkfb;
+    gdkfb->fix = fix;
+    gdkfb->var = var;
+
+    /* Window */
+    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
+    gtk_signal_connect(GTK_OBJECT(window), "destroy",
+		       GTK_SIGNAL_FUNC(gdkfb_window_destroy_handler), gdkfb);
+    gtk_container_set_border_width(GTK_CONTAINER(window), 4);
+#if 1
+#ifdef ENABLE_KEYBOARD
+    gtk_signal_connect(GTK_OBJECT(window), "key_press_event",
+		       GTK_SIGNAL_FUNC(gdkfb_key_handler), gdkfb);
+    gtk_signal_connect(GTK_OBJECT(window), "key_release_event",
+		       GTK_SIGNAL_FUNC(gdkfb_key_handler), gdkfb);
+    gtk_widget_add_events(window, GDK_KEY_PRESS_MASK | GDK_KEY_RELEASE_MASK);
+#endif /* ENABLE_KEYBOARD */
+#endif
+
+    /* Button */
+    button = gtk_check_button_new_with_label("Auto-update");
+    gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), TRUE);
+    gtk_signal_connect(GTK_OBJECT(button), "clicked",
+		       GTK_SIGNAL_FUNC(gdkfb_button_callback), gdkfb);
+    gtk_widget_show(button);
+
+    /* Horizontal box */
+    box1 = gtk_hbox_new(FALSE, 10);
+    gtk_box_pack_start(GTK_BOX(box1), button, FALSE, FALSE, 0);
+
+    /* Frame buffer */
+    gdkfb->fb_widget = fb = gtk_drawing_area_new();
+    gtk_drawing_area_size(GTK_DRAWING_AREA(fb), gdkfb->var->xres,
+			  gdkfb->var->yres);
+    gtk_signal_connect(GTK_OBJECT(fb), "expose-event",
+		       GTK_SIGNAL_FUNC(gdkfb_expose_handler), gdkfb);
+#ifdef ENABLE_MOUSE
+    gtk_signal_connect(GTK_OBJECT(fb), "motion_notify_event",
+		       GTK_SIGNAL_FUNC(gdkfb_mouse_motion_handler), gdkfb);
+    gtk_signal_connect(GTK_OBJECT(fb), "button_press_event",
+		       GTK_SIGNAL_FUNC(gdkfb_mouse_button_handler), gdkfb);
+    gtk_signal_connect(GTK_OBJECT(fb), "button_release_event",
+		       GTK_SIGNAL_FUNC(gdkfb_mouse_button_handler), gdkfb);
+    gtk_widget_add_events(fb,
+			  GDK_BUTTON_PRESS_MASK | GDK_BUTTON_RELEASE_MASK |
+			  GDK_BUTTON_MOTION_MASK | GDK_POINTER_MOTION_MASK |
+			  GDK_POINTER_MOTION_HINT_MASK);
+#endif /* ENABLE_MOUSE */
+#if 0
+#ifdef ENABLE_KEYBOARD
+    gtk_signal_connect(GTK_OBJECT(fb), "key_press_event",
+		       GTK_SIGNAL_FUNC(gdkfb_key_handler), gdkfb);
+    gtk_signal_connect(GTK_OBJECT(fb), "key_release_event",
+		       GTK_SIGNAL_FUNC(gdkfb_key_handler), gdkfb);
+    GTK_WIDGET_SET_FLAGS(fb, GTK_CAN_FOCUS);
+    gtk_widget_add_events(fb, GDK_KEY_PRESS_MASK | GDK_KEY_RELEASE_MASK);
+#endif /* ENABLE_KEYBOARD */
+#endif
+
+    /* Vertical box */
+    box2 = gtk_vbox_new(FALSE, 4);
+    gtk_box_pack_start(GTK_BOX(box2), box1, FALSE, FALSE, 0);
+    gtk_box_pack_start(GTK_BOX(box2), fb, FALSE, FALSE, 0);
+    gtk_widget_show(box2);
+
+    /* Put everything in the window */
+    gtk_container_add(GTK_CONTAINER(window), box2);
+    gtk_widget_show_all(window);
+
+#if 0
+    /* Frame buffer has focus by default */
+    gtk_widget_grab_focus(fb);
+#endif
+
+    /* Launch the widget thread */
+
+    stack = alloc_stack(0, 0);
+    if (!stack) {
+	printk("gdkfb_gui_init: no memory for stack\n");
+	return -ENOMEM;
+
+    }
+//return 0;
+
+    tid = clone(gdkfb_widget_thread, (void *)stack_sp(stack),
+		CLONE_FILES | CLONE_VM | SIGCHLD, NULL);
+    if (tid < 0) {
+	printk("gdkfb_gui_init: clone failed, errno = %d\n", errno);
+	return -ECHILD;
+    }
+
+    return 0;
+}
+
--- linux-uml-2.6.4-1/arch/um/kernel/trap_kern.c	2004-04-30 16:16:22.000000000 +0200
+++ linux-uml-2.6.4-geert/arch/um/kernel/trap_kern.c	2004-06-27 14:37:58.000000000 +0200
@@ -147,8 +147,11 @@
         }
 	else if(check_remapped_addr(address & PAGE_MASK, is_write))
 		return(0);
-	else if(current->mm == NULL)
+	else if(current->mm == NULL) {
+printk("address = %lx, ip = %lx, is_write = %c, is_user = %c, sc = %p\n",
+       address, ip, is_write ? 'W' : 'R', is_user ? 'U' : 'K', sc);
 		panic("Segfault with no mm");
+	}
 	err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);

 	catcher = current->thread.fault_catcher;
--- linux-uml-2.6.4-1/arch/um/kernel/um_arch.c	2004-04-30 16:16:22.000000000 +0200
+++ linux-uml-2.6.4-geert/arch/um/kernel/um_arch.c	2004-06-27 14:37:58.000000000 +0200
@@ -17,6 +17,7 @@
 #include "linux/sysrq.h"
 #include "linux/seq_file.h"
 #include "linux/delay.h"
+#include "linux/console.h"
 #include "asm/page.h"
 #include "asm/pgtable.h"
 #include "asm/ptrace.h"
@@ -412,6 +413,9 @@
  	strcpy(command_line, saved_command_line);
  	*cmdline_p = command_line;
 	setup_hostinfo();
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
 }

 void __init check_bugs(void)
--- linux-uml-2.6.4-1/arch/um/sys-i386/bugs.c	2004-04-30 16:16:22.000000000 +0200
+++ linux-uml-2.6.4-geert/arch/um/sys-i386/bugs.c	2004-06-27 14:37:59.000000000 +0200
@@ -146,7 +146,7 @@
        */
 static void disable_lcall(void)
 {
-	struct modify_ldt_ldt_s ldt;
+	struct user_desc ldt;
 	int err;

 	bzero(&ldt, sizeof(ldt));
--- linux-uml-2.6.4-1/drivers/char/Kconfig	2004-04-28 15:49:01.000000000 +0200
+++ linux-uml-2.6.4-geert/drivers/char/Kconfig	2004-06-27 14:38:03.000000000 +0200
@@ -59,7 +59,7 @@

 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UM
+	depends on VT && !S390
 	default y

 config SERIAL_NONSTANDARD
--- linux-uml-2.6.4-1/drivers/char/tty_io.c	2004-04-28 15:49:01.000000000 +0200
+++ linux-uml-2.6.4-geert/drivers/char/tty_io.c	2004-06-27 14:38:04.000000000 +0200
@@ -1359,7 +1359,7 @@
 		/* noctty = 1; */
 		goto got_driver;
 	}
-#ifdef CONFIG_VT
+#ifdef CONFIG_VT_CONSOLE
 	if (device == MKDEV(TTY_MAJOR,0)) {
 		extern int fg_console;
 		extern struct tty_driver *console_driver;
--- linux-uml-2.6.4-1/drivers/char/vt.c	2004-04-28 15:49:01.000000000 +0200
+++ linux-uml-2.6.4-geert/drivers/char/vt.c	2004-06-27 14:38:04.000000000 +0200
@@ -660,6 +660,7 @@

 static void visual_init(int currcons, int init)
 {
+printk("visual_init\n");
     /* ++Geert: sw->con_init determines console size */
     sw = conswitchp;
 #ifndef VT_SINGLE_DRIVER
@@ -751,6 +752,7 @@
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
 	unsigned short *newscreen;

+printk("vc_resize\n");
 	WARN_CONSOLE_UNLOCKED();

 	if (!vc_cons_allocated(currcons))
@@ -2501,6 +2503,7 @@
 {
 	int j, k ;

+printk("vc_init\n");
 	video_num_columns = cols;
 	video_num_lines = rows;
 	video_size_row = cols<<1;
@@ -2602,6 +2605,7 @@

 int __init vty_init(void)
 {
+#ifdef CONFIG_VT_CONSOLE
 	console_driver = alloc_tty_driver(MAX_NR_CONSOLES);
 	if (!console_driver)
 		panic("Couldn't allocate console driver\n");
@@ -2617,6 +2621,7 @@
 	tty_set_operations(console_driver, &con_ops);
 	if (tty_register_driver(console_driver))
 		panic("Couldn't register console driver\n");
+#endif /* CONFIG_VT_CONSOLE */

 	kbd_init();
 	console_map_init();
--- linux-uml-2.6.4-1/drivers/video/Kconfig	2004-04-28 15:49:02.000000000 +0200
+++ linux-uml-2.6.4-geert/drivers/video/Kconfig	2004-06-27 14:38:28.000000000 +0200
@@ -884,6 +884,12 @@
 	  Say Y here if you want to support the built-in frame buffer of
 	  the Motorola 68328 CPU family.

+config FB_GDK
+	tristate "GDK/GTK support"
+	depends on FB && USERMODE
+	---help---
+	  This is a virtual frame buffer device on top of GDK/GTK.
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
--- linux-uml-2.6.4-1/drivers/video/Makefile	2004-04-28 15:49:02.000000000 +0200
+++ linux-uml-2.6.4-geert/drivers/video/Makefile	2004-06-27 14:38:28.000000000 +0200
@@ -89,3 +89,4 @@
 obj-$(CONFIG_FB_LEO)               += leo.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
 				      cfbfillrect.o

+obj-$(CONFIG_FB_GDK)		  += cfbfillrect.o cfbcopyarea.o cfbimgblt.o
--- linux-uml-2.6.4-1/drivers/video/fbmem.c	2004-04-28 15:49:02.000000000 +0200
+++ linux-uml-2.6.4-geert/drivers/video/fbmem.c	2004-06-27 14:38:28.000000000 +0200
@@ -164,6 +164,10 @@
 extern int leo_setup(char*);
 extern int kyrofb_init(void);
 extern int kyrofb_setup(char*);
+extern int gdkfb_init(void);
+extern int gdkfb_setup(char*);
+extern int gdkfb2_init(void);
+extern int gdkfb2_setup(char*);

 static struct {
 	const char *name;
@@ -385,6 +389,11 @@
 	{ "resolverfb", NULL, resolver_video_setup },
 #endif

+#ifdef CONFIG_FB_GDK
+	{ "gdkfb", gdkfb_init, gdkfb_setup },
+	{ "gdkfb2", gdkfb2_init, gdkfb2_setup },
+#endif
+
 #ifdef CONFIG_FB_VIRTUAL
 	/*
 	 * Vfb must be last to avoid that it becomes your primary display if
@@ -1190,9 +1199,15 @@
 #else
 #warning What do we have to do here??
 #endif
+#ifndef CONFIG_USERMODE
 	if (io_remap_page_range(vma, vma->vm_start, off,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
+#else
+	if (remap_page_range(vma, vma->vm_start, off,
+			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+#endif
 #endif /* !__sparc_v9__ */
 	return 0;
 #endif /* !sparc32 */


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

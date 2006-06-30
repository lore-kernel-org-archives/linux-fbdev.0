From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/3] tty: Remove include of
	screen_info.h from tty.h
Date: Fri, 30 Jun 2006 19:54:35 +0800
Message-ID: <44A510FB.7090603@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwHgJ-0005JQ-Jt for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 05:01:07 -0700
Received: from wr-out-0506.google.com ([64.233.184.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FwHgI-0007S2-Gv
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 05:01:07 -0700
Received: by wr-out-0506.google.com with SMTP id i5so269660wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 Jun 2006 05:01:06 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>

From: Jon Smirl <jonsmir@gmail.com>

screen_info.h doesn't have anything to do with the tty layer and
shouldn't be included by tty.h. This patches removes the include and
modifies all users to directly include screen_info.h. struct
screen_info is mainly used to communicate with the console drivers in
drivers/video/console. Note that this patch touches every arch and I
have no way of testing it. If there is a mistake the worst thing that
will happen is a compile error.

Signed-off-by: Jon Smirl <jonsmir@gmail.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/alpha/kernel/setup.c                 |    2 +-
 arch/alpha/kernel/sys_sio.c               |    2 +-
 arch/arm/kernel/setup.c                   |    2 +-
 arch/arm26/kernel/setup.c                 |    2 +-
 arch/cris/kernel/setup.c                  |    2 +-
 arch/i386/kernel/setup.c                  |    2 +-
 arch/ia64/dig/setup.c                     |    2 +-
 arch/ia64/kernel/setup.c                  |    2 +-
 arch/ia64/sn/kernel/setup.c               |    2 +-
 arch/m32r/kernel/setup.c                  |    2 +-
 arch/mips/kernel/setup.c                  |    2 +-
 arch/mips/mips-boards/malta/malta_setup.c |    2 +-
 arch/mips/sibyte/swarm/setup.c            |    2 +-
 arch/mips/sni/setup.c                     |    2 +-
 arch/powerpc/kernel/ppc_ksyms.c           |    2 +-
 arch/powerpc/kernel/setup-common.c        |    2 +-
 arch/ppc/kernel/ppc_ksyms.c               |    2 +-
 arch/ppc/kernel/setup.c                   |    2 +-
 arch/ppc/platforms/prep_setup.c           |    2 +-
 arch/sh/kernel/setup.c                    |    2 +-
 arch/sh64/kernel/setup.c                  |    2 +-
 arch/sh64/kernel/sh_ksyms.c               |    2 +-
 arch/sparc/kernel/setup.c                 |    2 +-
 arch/sparc64/kernel/setup.c               |    2 +-
 arch/x86_64/kernel/early_printk.c         |    2 +-
 arch/x86_64/kernel/setup.c                |    2 +-
 arch/xtensa/kernel/setup.c                |    2 +-
 drivers/video/console/vgacon.c            |    1 +
 drivers/video/sis/sis_main.c              |    2 +-
 include/linux/tty.h                       |    1 -
 30 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 254c507..2cb9c43 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -19,7 +19,7 @@ #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/delay.h>
 #include <linux/config.h>	/* CONFIG_ALPHA_LCA etc */
 #include <linux/mc146818rtc.h>
diff --git a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
index 131a2d9..bfe8650 100644
--- a/arch/alpha/kernel/sys_sio.c
+++ b/arch/alpha/kernel/sys_sio.c
@@ -17,7 +17,7 @@ #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 
 #include <asm/compiler.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index b24d126..1892c11 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -18,7 +18,7 @@ #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
diff --git a/arch/arm26/kernel/setup.c b/arch/arm26/kernel/setup.c
index 8e6a441..b01d7ea 100644
--- a/arch/arm26/kernel/setup.c
+++ b/arch/arm26/kernel/setup.c
@@ -18,7 +18,7 @@ #include <linux/blkdev.h>
 #include <linux/console.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/root_dev.h>
 
diff --git a/arch/cris/kernel/setup.c b/arch/cris/kernel/setup.c
index 1974c01..72d0991 100644
--- a/arch/cris/kernel/setup.c
+++ b/arch/cris/kernel/setup.c
@@ -16,7 +16,7 @@ #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <asm/pgtable.h>
 #include <linux/seq_file.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/utsname.h>
 #include <linux/pfn.h>
 
diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 6483fdd..838df98 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -27,7 +27,7 @@ #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/ioport.h>
 #include <linux/acpi.h>
 #include <linux/apm_bios.h>
diff --git a/arch/ia64/dig/setup.c b/arch/ia64/dig/setup.c
index 38aa9c1..c4933de 100644
--- a/arch/ia64/dig/setup.c
+++ b/arch/ia64/dig/setup.c
@@ -15,7 +15,7 @@ #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
 #include <linux/string.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/console.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index e23d5e3..f31a2de 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -36,7 +36,7 @@ #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/threads.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/dmi.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index c7b40ab..b622fbc 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -13,7 +13,7 @@ #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
 #include <linux/string.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/console.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
diff --git a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
index 1ff483c..90e4d42 100644
--- a/arch/m32r/kernel/setup.c
+++ b/arch/m32r/kernel/setup.c
@@ -22,7 +22,7 @@ #include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/seq_file.h>
 #include <linux/timex.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/cpu.h>
 #include <linux/nodemask.h>
 #include <linux/pfn.h>
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bfcec8d..0437b9a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -25,7 +25,7 @@ #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/utsname.h>
 #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/bootmem.h>
 #include <linux/initrd.h>
 #include <linux/major.h>
diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 0766e43..024bb05 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -20,7 +20,7 @@ #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 
 #ifdef CONFIG_MTD
 #include <linux/mtd/partitions.h>
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index f9e6949..79d925b 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -28,7 +28,7 @@ #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/initrd.h>
 
 #include <asm/irq.h>
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index a050bb6..d21e8a8 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -19,7 +19,7 @@ #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/console.h>
 #include <linux/fb.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 
 #ifdef CONFIG_ARC
 #include <asm/arc/types.h>
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 4b052ae..755b69a 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -6,7 +6,7 @@ #include <linux/sched.h>
 #include <linux/elfcore.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/vt_kern.h>
 #include <linux/nvram.h>
 #include <linux/console.h>
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bd32812..5a17d80 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -27,7 +27,7 @@ #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
 #include <linux/utsname.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/root_dev.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index b250b1b..64cf348 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -6,7 +6,7 @@ #include <linux/sched.h>
 #include <linux/elfcore.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/vt_kern.h>
 #include <linux/nvram.h>
 #include <linux/console.h>
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
index 4b4607d..c323b0f 100644
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -12,7 +12,7 @@ #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/ide.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
diff --git a/arch/ppc/platforms/prep_setup.c b/arch/ppc/platforms/prep_setup.c
index e86f615..d810790 100644
--- a/arch/ppc/platforms/prep_setup.c
+++ b/arch/ppc/platforms/prep_setup.c
@@ -24,7 +24,7 @@ #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/major.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index b703057..d5425b5 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -10,7 +10,7 @@
  * This file handles the architecture-dependent parts of initialization
  */
 
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
diff --git a/arch/sh64/kernel/setup.c b/arch/sh64/kernel/setup.c
index da98d8d..65c8dd0 100644
--- a/arch/sh64/kernel/setup.c
+++ b/arch/sh64/kernel/setup.c
@@ -36,7 +36,7 @@ #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/config.h>
diff --git a/arch/sh64/kernel/sh_ksyms.c b/arch/sh64/kernel/sh_ksyms.c
index 6f3a1c9..b9d8468 100644
--- a/arch/sh64/kernel/sh_ksyms.c
+++ b/arch/sh64/kernel/sh_ksyms.c
@@ -19,7 +19,7 @@ #include <linux/sched.h>
 #include <linux/in6.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 
 #include <asm/semaphore.h>
 #include <asm/processor.h>
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index 11e69e4..6fe61f7 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -17,7 +17,7 @@ #include <linux/initrd.h>
 #include <asm/smp.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/delay.h>
 #include <linux/config.h>
 #include <linux/fs.h>
diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index 66d1e68..4b9e3db 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -16,7 +16,7 @@ #include <linux/slab.h>
 #include <asm/smp.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/delay.h>
 #include <linux/config.h>
 #include <linux/fs.h>
diff --git a/arch/x86_64/kernel/early_printk.c b/arch/x86_64/kernel/early_printk.c
index b93ef5b..140051e 100644
--- a/arch/x86_64/kernel/early_printk.c
+++ b/arch/x86_64/kernel/early_printk.c
@@ -2,7 +2,7 @@ #include <linux/console.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/fcntl.h>
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 91be618..72341f0 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -21,7 +21,7 @@ #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/config.h>
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 513ed8d..ef7e920 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -18,7 +18,7 @@ #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <linux/bootmem.h>
 #include <linux/kernel.h>
 
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 3c54777..068fad5 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -48,6 +48,7 @@ #include <linux/selection.h>
 #include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/screen_info.h>
 #include <linux/smp_lock.h>
 #include <video/vga.h>
 #include <asm/io.h>
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index d5916e6..f0a9581 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -46,7 +46,7 @@ #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,17)
 #include <linux/tty.h>
 #else
 #include <linux/screen_info.h>
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 37937c8..e421d5e 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -12,7 +12,6 @@ #include <linux/termios.h>
 #include <linux/workqueue.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
-#include <linux/screen_info.h>
 #include <linux/mutex.h>
 
 #include <asm/system.h>


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

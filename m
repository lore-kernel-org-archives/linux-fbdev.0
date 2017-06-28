From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 28 Jun 2017 10:36:35 +0000
Subject: [PATCH] fbcon: Make fbcon a built-time depency for fbdev
Message-Id: <20170628103635.24651-1-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

There's a bunch of folks who're trying to make printk less
contended and faster, but there's a problem: printk uses the
console_lock, and the console lock has become the BKL for all things
fbdev/fbcon, which in turn pulled in half the drm subsystem under that
lock. That's awkward.

There reasons for that is probably just a historical accident:

- fbcon is a runtime option of fbdev, i.e. at runtime you can pick
  whether your fbdev driver instances are used as kernel consoles.
  Unfortunately this wasn't implemented with some module option, but
  through some module loading magic: As long as you don't load
  fbcon.ko, there's no fbdev console support, but loading it (in any
  order wrt fbdev drivers) will create console instances for all fbdev
  drivers.

- This was implemented through a notifier chain. fbcon.ko enumerates
  all fbdev instances at load time and also registers itself as
  listener in the fbdev notifier. The fbdev core tries to register new
  fbdev instances with fbcon using the notifier.

- On top of that the modifier chain is also used at runtime by the
  fbdev subsystem to e.g. control backlights for panels.

- The problem is that the notifier puts a mutex locking context
  between fbdev and fbcon, which mixes up the locking contexts for
  both the runtime usage and the register time usage to notify fbcon.
  And at runtime fbcon (through the fbdev core) might call into the
  notifier from a printk critical section while console_lock is held.

- This means console_lock must be an outer lock for the entire fbdev
  subsystem, which also means it must be acquired when registering a
  new framebuffer driver as the outermost lock since we might call
  into fbcon (through the notifier) which would result in a locking
  inversion if fbcon would acquire the console_lock from its notifier
  callback (which it needs to register the console).

- console_lock can be held anywhere, since printk can be called
  anywhere, and through the above story, plus drm/kms being an fbdev
  driver, we pull in a shocking amount of locking hiercharchy
  underneath the console_lock. Which makes cleaning up printk really
  hard (not even splitting console_lock into an rwsem is all that
  useful due to this).

There's various ways to address this, but the cleanest would be to
make fbcon a compile-time option, where fbdev directly calls the fbcon
register functions from register_framebuffer, or dummy static inline
versions if fbcon is disabled. Maybe augmented with a runtime knob to
disable fbcon, if that's needed (for debugging perhaps).

But this could break some users who rely on the magic "loading
fbcon.ko enables/disables fbdev framebuffers at runtime" thing, even
if that's unlikely. Hence we must be careful:

1. Create a compile-time dependency between fbcon and fbdev in the
least minimal way. This is what this patch does.

2. Wait at least 1 year to give possible users time to scream about
how we broke their setup. Unlikely, since all distros make fbcon
compile-in, and embedded platforms only compile stuff they know they
need anyway. But still.

3. Convert the notifier to direct functions calls, with dummy static
inlines if fbcon is disabled. We'll still need the fb notifier for the
other uses (like backlights), but we can probably move it into the fb
core (atm it must be built-into vmlinux).

4. Push console_lock down the call-chain, until it is down in
console_register again.

5. Finally start to clean up and rework the printk/console locking.

For context of this saga see

commit 50e244cc793d511b86adea24972f3a7264cae114
Author: Alan Cox <alan@linux.intel.com>
Date:   Fri Jan 25 10:28:15 2013 +1000

    fb: rework locking to fix lock ordering on takeover

plus the pile of commits on top that tried to make this all work
without terminally upsetting lockdep. We've uncovered all this when
console_lock lockdep annotations where added in

commit daee779718a319ff9f83e1ba3339334ac650bb22
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sat Sep 22 19:52:11 2012 +0200

    console: implement lockdep support for console_lock

On the patch itself:
- Add fbcon.h for the dummy symbol to force the module load ordering
  between fbcon.ko and fb.ko. In step 3 that's hopefully going to be
  the place for the fbcon register/unregister functions.

- Switch CONFIG_FRAMEBUFFER_CONSOLE to be a boolean, using the overall
  CONFIG_FB tristate to decided whether it should be a module or
  built-in.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/video/console/Kconfig    | 2 +-
 drivers/video/console/Makefile   | 8 +++++---
 drivers/video/console/fbcon.c    | 8 ++++++++
 drivers/video/fbdev/core/fbmem.c | 4 ++++
 include/linux/fbcon.h            | 6 ++++++
 5 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/fbcon.h

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 2111d06f8c81..7f1f1fbcef9e 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -117,7 +117,7 @@ config DUMMY_CONSOLE_ROWS
           Select 25 if you use a 640x480 resolution by default.
 
 config FRAMEBUFFER_CONSOLE
-	tristate "Framebuffer Console support"
+	bool "Framebuffer Console support"
 	depends on FB && !UML
 	select VT_HW_CONSOLE_BINDING
 	select CRC32
diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
index 43bfa485db96..8db6f712585b 100644
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -7,13 +7,15 @@ obj-$(CONFIG_SGI_NEWPORT_CONSOLE) += newport_con.o
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
-obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o bitblit.o softcursor.o
+ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE),y)
+obj-$(CONFIG_FB) += fbcon.o bitblit.o softcursor.o
 ifeq ($(CONFIG_FB_TILEBLITTING),y)
-obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += tileblit.o
+obj-$(CONFIG_FB)     += tileblit.o
 endif
 ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
-obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
+obj-$(CONFIG_FB)     += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
                                          fbcon_ccw.o
 endif
+endif
 
 obj-$(CONFIG_FB_STI)              += sticore.o
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 12ded23f1aaf..f97277299b7c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -68,6 +68,7 @@
 #include <linux/kd.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
+#include <linux/fbcon.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/font.h>
@@ -3631,6 +3632,13 @@ static int __init fb_console_init(void)
 	return 0;
 }
 
+/*
+ * Dummy export to force a hard depency between fbcon and fbdev core if fbcon is
+ * enabled.
+ */
+int fbcon_is_available = 1;
+EXPORT_SYMBOL(fbcon_is_available);
+
 fs_initcall(fb_console_init);
 
 #ifdef MODULE
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 069fe7960df1..e5556726bc1c 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -32,6 +32,7 @@
 #include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/fb.h>
+#include <linux/fbcon.h>
 
 #include <asm/fb.h>
 
@@ -1796,6 +1797,9 @@ int
 register_framebuffer(struct fb_info *fb_info)
 {
 	int ret;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE
+	WARN_ON(!fbcon_is_available);
+#endif
 
 	mutex_lock(&registration_lock);
 	ret = do_register_framebuffer(fb_info);
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
new file mode 100644
index 000000000000..b23d011214c0
--- /dev/null
+++ b/include/linux/fbcon.h
@@ -0,0 +1,6 @@
+#ifndef _LINUX_FBCON_H
+#define _LINUX_FBCON_H
+
+extern int fbcon_is_available;
+
+#endif /* _LINUX_FBCON_H */
-- 
2.11.0


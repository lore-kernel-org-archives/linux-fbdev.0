From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 12 Jul 2018 13:29:38 +0000
Subject: [PATCH v2] console: Replace #if 1 with a bool to ignore
Message-Id: <20180712092938.22e33641@gandalf.local.home>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

There's been discussion on the fb list about the addition of
WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
the fb module is loaded with lockless_register_fb the console lock is
not taken for debugging reasons. With the addition of
WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
fill up with warnings when trying to debug the fb driver.

There's also a #if 1 that enables the warning which was added before
git history, and we look down on constant #if's in the kernel nowadays
anyway.

Remove the #if 1 and add a ignore_console_lock_warning boolean that can
be set by drivers to ignore the warning in order to do debugging.

Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since V1:
 - Added comment to describe ignore_console_unlock_waring variable
 - Abide by 80 character limit

Index: linux-trace.git/include/linux/console.h
=================================--- linux-trace.git.orig/include/linux/console.h
+++ linux-trace.git/include/linux/console.h
@@ -200,11 +200,14 @@ void vcs_make_sysfs(int index);
 void vcs_remove_sysfs(int index);
 
 /* Some debug stub to catch some of the obvious races in the VT code */
-#if 1
-#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
-#else
-#define WARN_CONSOLE_UNLOCKED()
-#endif
+#define WARN_CONSOLE_UNLOCKED()						\
+	WARN_ON(!ignore_console_lock_warning &&				\
+		!is_console_locked() && !oops_in_progress)
+/*
+ * Set ignore_console_lock_warning to true if you need to quiet
+ * WARN_CONSOLE_UNLOCKED() for debugging purposes.
+ */
+extern bool ignore_console_lock_warning;
 
 /* VESA Blanking Levels */
 #define VESA_NO_BLANKING        0
Index: linux-trace.git/kernel/printk/printk.c
=================================--- linux-trace.git.orig/kernel/printk/printk.c
+++ linux-trace.git/kernel/printk/printk.c
@@ -66,6 +66,9 @@ int console_printk[4] = {
 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
 };
 
+bool ignore_console_lock_warning __read_mostly;
+EXPORT_SYMBOL(ignore_console_lock_warning);
+
 /*
  * Low level drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.

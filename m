From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 11 Jul 2018 15:41:24 +0000
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <20180711114124.3eb23fca@gandalf.local.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
        <20180628090351.15581-3-hdegoede@redhat.com>
        <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
        <20180711105255.32803a3c@gandalf.local.home>
        <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
        <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
        <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
        <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
In-Reply-To: <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Petr Mladek <pmladek@suse.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On Wed, 11 Jul 2018 17:35:10 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> OK, so if we don't remove it, we should probably make it so that it
> can be used without triggering any WARN_ONs, which would require changing
> the existing WARN_CONSOLE_UNLOCKED() so that the calls from drivers/tty/vt/vt.c
> also do not trigger it ?
> 
> I guess one can just ignore the oopses when debugging, but debugging surely
> would be easier if there are just no oopses ?

What about adding this patch (untested, not even compiled), and then
set it from the fb module.

-- Steve

diff --git a/include/linux/console.h b/include/linux/console.h
index dfd6b0e97855..11cd4956a57f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -200,8 +200,10 @@ void vcs_make_sysfs(int index);
 void vcs_remove_sysfs(int index);
 
 /* Some debug stub to catch some of the obvious races in the VT code */
+extern bool ignore_console_lock_warning;
 #if 1
-#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
+#define WARN_CONSOLE_UNLOCKED()						\
+	WARN_ON(!ignore_console_lock_warning && !is_console_locked() && !oops_in_progress)
 #else
 #define WARN_CONSOLE_UNLOCKED()
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..fa15d7ddf0c4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -66,6 +66,9 @@ int console_printk[4] = {
 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
 };
 
+bool ignore_console_lock_warning;
+EXPORT_SYMBOL(ignore_console_lock_warning);
+
 /*
  * Low level drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.

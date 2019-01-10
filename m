From: Prarit Bhargava <prarit@redhat.com>
Date: Thu, 10 Jan 2019 19:03:25 +0000
Subject: [PATCH v4 2/2] printk: Export console_printk
Message-Id: <20190110190325.15241-3-prarit@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181030154419.2889-1-prarit@redhat.com>
 <20190110190325.15241-1-prarit@redhat.com>
In-Reply-To: <20190110190325.15241-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Petr Mladek <pmladek@suse.com>, Kees Cook <keescook@chromium.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Yisheng Xie <ysxie@foxmail.com>, Thierry Reding <treding@nvidia.com>

The fbcon code can be built as a module and requires console_printk.

Export console_printk.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Marko Myllynen <myllynen@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: dri-devel@lists.freedesktop.org
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d170374ceb..8201019d1fff 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -65,6 +65,7 @@ int console_printk[4] = {
 	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
 };
+EXPORT_SYMBOL_GPL(console_printk);
 
 atomic_t ignore_console_lock_warning __read_mostly = ATOMIC_INIT(0);
 EXPORT_SYMBOL(ignore_console_lock_warning);
-- 
2.17.2

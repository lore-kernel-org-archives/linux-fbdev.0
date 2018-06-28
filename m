From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 28 Jun 2018 09:03:49 +0000
Subject: [PATCH v5 1/3] printk: Export is_console_locked
Message-Id: <20180628090351.15581-2-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
In-Reply-To: <20180628090351.15581-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org

This is a preparation patch for adding a number of WARN_CONSOLE_UNLOCKED()
calls to the fbcon code, which may be built as a module (event though
usually it is not).

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-New patch in v3 of this patchset
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..3f041e7cbfc9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2243,6 +2243,7 @@ int is_console_locked(void)
 {
 	return console_locked;
 }
+EXPORT_SYMBOL(is_console_locked);
 
 /*
  * Check if we have any console that is capable of printing while cpu is
-- 
2.17.1


From: Prarit Bhargava <prarit@redhat.com>
Date: Tue, 29 Jan 2019 13:43:49 +0000
Subject: [PATCH v5 1/2] printk: Export console_printk
Message-Id: <20190129134350.24049-2-prarit@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The fbcon can be built as a module and requires console_printk.

Export console_printk.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
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

From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Thu, 23 Apr 2020 14:26:27 +0000
Subject: [PATCH v2] console: console: Complete exception handling in newport_probe()
Message-Id: <20200423142627.1820-1-zhengdejin5@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: gregkh@linuxfoundation.org, tglx@linutronix.de, FlorianSchandinat@gmx.de, b.zolnierkie@samsung.com, ralf@linux-mips.org, tsbogend@alpha.franken.de, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org

A call of the function ¡°do_take_over_console¡± can fail here.
The corresponding system resources were not released then.
Thus add a call of the function ¡°iounmap¡± together with the check
of a failure predicate.

Fixes: e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")
CC: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v1 -> v2:
	- modify the commit comments by Markus'suggestion.

 drivers/video/console/newport_con.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 00dddf6e08b0..6bfc8e3ffd4a 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -720,6 +720,9 @@ static int newport_probe(struct gio_device *dev,
 	console_lock();
 	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
 	console_unlock();
+
+	if (err)
+		iounmap((void *)npregs);
 	return err;
 }
 
-- 
2.25.0

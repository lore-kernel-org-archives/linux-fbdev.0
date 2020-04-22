From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Wed, 22 Apr 2020 15:53:28 +0000
Subject: [PATCH v1] console: fix an issue about ioremap leak.
Message-Id: <20200422155328.27473-1-zhengdejin5@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tglx@linutronix.de, gregkh@linuxfoundation.org, tsbogend@alpha.franken.de, FlorianSchandinat@gmx.de, ralf@linux-mips.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org

if do_take_over_console() return an error in the newport_probe(),
due to the io virtual address is not released, it will cause a leak.

Fixes: e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")
CC: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
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

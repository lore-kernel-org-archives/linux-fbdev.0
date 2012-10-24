From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Oct 2012 09:28:54 +0000
Subject: [PATCH 03/20] OMAPDSS: remove dispc_irq_handler declaration
Message-Id: <1351070951-18616-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss.h contains dispc_irq_handler declaration, even if the function is
dispc.c internal. Remove the declaration.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index fb89165..00e0a36 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -398,7 +398,6 @@ void dpi_uninit_platform_driver(void) __exit;
 int dispc_init_platform_driver(void) __init;
 void dispc_uninit_platform_driver(void) __exit;
 void dispc_dump_clocks(struct seq_file *s);
-void dispc_irq_handler(void);
 
 int dispc_runtime_get(void);
 void dispc_runtime_put(void);
-- 
1.7.9.5


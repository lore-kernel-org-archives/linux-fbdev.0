From: hvaibhav@ti.com
Date: Thu, 17 Dec 2009 15:30:25 +0000
Subject: [PATCH 1/5] dss2-core:Warning Fix: core_dump_clocks enclosed under DEBUG_FS
Message-Id: <1261063105-19874-1-git-send-email-hvaibhav@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <hvaibhav@ti.com>
In-Reply-To: <hvaibhav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/video/omap2/dss/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 29497a0..2fabaf2 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -124,6 +124,7 @@ static void restore_all_ctx(void)
 	dss_clk_disable_all_no_ctx();
 }
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 /* CLOCKS */
 static void core_dump_clocks(struct seq_file *s)
 {
@@ -149,6 +150,7 @@ static void core_dump_clocks(struct seq_file *s)
 				clocks[i]->usecount);
 	}
 }
+#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) */
 
 static int dss_get_clock(struct clk **clock, const char *clk_name)
 {
-- 
1.6.2.4


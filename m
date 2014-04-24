From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:17:15 +0000
Subject: [PATCH 19/23] OMAPDSS: HDMI: support larger register offsets for OMAP5 HDMI core
Message-Id: <1398334639-14172-20-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Archit Taneja <archit@ti.com>

The HDMI core IP on OMAP5 has a wider address range for registers. The offsets
for the later registers can't fit into the u16 type currently used for hdmi
register read and write functions. Use u32 for offsets instead.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index d784b2cced9d..0e5979ef933c 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -361,13 +361,13 @@ struct hdmi_core_data {
 	struct hdmi_core_infoframe_avi avi_cfg;
 };
 
-static inline void hdmi_write_reg(void __iomem *base_addr, const u16 idx,
+static inline void hdmi_write_reg(void __iomem *base_addr, const u32 idx,
 		u32 val)
 {
 	__raw_writel(val, base_addr + idx);
 }
 
-static inline u32 hdmi_read_reg(void __iomem *base_addr, const u16 idx)
+static inline u32 hdmi_read_reg(void __iomem *base_addr, const u32 idx)
 {
 	return __raw_readl(base_addr + idx);
 }
-- 
1.9.1


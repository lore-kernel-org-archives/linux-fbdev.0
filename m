From: Archit Taneja <archit@ti.com>
Date: Thu, 17 Oct 2013 11:38:37 +0000
Subject: [PATCH 1/6] omapdss: hdmi: support larger register offsets for OMAP5 HDMI core
Message-Id: <1382009202-18984-2-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382009202-18984-1-git-send-email-archit@ti.com>
In-Reply-To: <1382009202-18984-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The HDMI core IP on OMAP5 has a wider register address range. The offsets for
these registers can't fit into the u16 type currently used for hdmi register
read and write functions. Use u32 for offsets instead.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index b049376..b410b14 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -360,13 +360,13 @@ struct hdmi_core_data {
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
1.8.1.2


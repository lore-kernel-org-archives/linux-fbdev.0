From: Archit Taneja <archit@ti.com>
Date: Fri, 13 Sep 2013 10:41:35 +0000
Subject: [PATCH 4/7] OMAPDSS: HDMI: OMAP4: Complete dumping of DPLL registers
Message-Id: <1379068178-17312-5-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379068178-17312-1-git-send-email-archit@ti.com>
In-Reply-To: <1379068178-17312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>, Archit Taneja <archit@ti.com>

From: Ricardo Neri <ricardo.neri@ti.com>

Add the spread spectrum clock configuration registers to the DPLL dump.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index ecadd7a..46af726 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -886,6 +886,8 @@ void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 	DUMPPLL(PLLCTRL_CFG1);
 	DUMPPLL(PLLCTRL_CFG2);
 	DUMPPLL(PLLCTRL_CFG3);
+	DUMPPLL(PLLCTRL_SSC_CFG1);
+	DUMPPLL(PLLCTRL_SSC_CFG2);
 	DUMPPLL(PLLCTRL_CFG4);
 }
 
-- 
1.8.1.2


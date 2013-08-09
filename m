From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 09 Aug 2013 23:03:13 +0000
Subject: [PATCH/RFC v3 14/19] ARM: shmobile: r8a7790: Add DU clocks for DT
Message-Id: <1376089398-13322-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376089398-13322-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1376089398-13322-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index d99b87b..7229f96 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -257,10 +257,15 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP */
 	CLKDEV_ICK_ID("lvds.0", "rcar-du-r8a7790", &mstp_clks[MSTP726]),
+	CLKDEV_ICK_ID("lvds.0", "feb00000.display", &mstp_clks[MSTP726]),
 	CLKDEV_ICK_ID("lvds.1", "rcar-du-r8a7790", &mstp_clks[MSTP725]),
+	CLKDEV_ICK_ID("lvds.1", "feb00000.display", &mstp_clks[MSTP725]),
 	CLKDEV_ICK_ID("du.0", "rcar-du-r8a7790", &mstp_clks[MSTP724]),
+	CLKDEV_ICK_ID("du.0", "feb00000.display", &mstp_clks[MSTP724]),
 	CLKDEV_ICK_ID("du.1", "rcar-du-r8a7790", &mstp_clks[MSTP723]),
+	CLKDEV_ICK_ID("du.1", "feb00000.display", &mstp_clks[MSTP723]),
 	CLKDEV_ICK_ID("du.2", "rcar-du-r8a7790", &mstp_clks[MSTP722]),
+	CLKDEV_ICK_ID("du.2", "feb00000.display", &mstp_clks[MSTP722]),
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]),
-- 
1.8.1.5


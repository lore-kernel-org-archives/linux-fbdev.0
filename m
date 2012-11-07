From: Archit Taneja <archit@ti.com>
Date: Wed, 07 Nov 2012 14:56:28 +0000
Subject: [RFC 10/11] ARCH: ARM: OMAP: Create a platform device for writeback
Message-Id: <1352299469-17609-11-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

writeback is a like DPI in the sense that it's completelty a part of DISPC.
Hence it doesn't have it's own resource, or a hwmod entity tied to it.

Create a simple platfrom device for writeback in omap_display_init. Set the
parent to the omapdss_dss platform device like done for other DSS submodules.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/display.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 282c814e..2e01b61 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -414,6 +414,15 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		}
 	}
 
+	if (cpu_is_omap44xx()) {
+		pdev = create_simple_dss_pdev("omapdss_writeback", -1,
+				NULL, 0, dss_pdev);
+		if (IS_ERR(pdev)) {
+			pr_err("Could not build platform_device for omapdss_writeback\n");
+			return PTR_ERR(pdev);
+		}
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5


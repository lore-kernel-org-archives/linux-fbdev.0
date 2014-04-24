From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:17:03 +0000
Subject: [PATCH 07/23] ARM: OMAP: add detection of omap5-dss
Message-Id: <1398334639-14172-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add detection of omap5-dss nodes so that the related devices get
initialized.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 974461441fc3..74869326dadc 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -665,6 +665,10 @@ struct device_node * __init omapdss_find_dss_of_node(void)
 	if (node)
 		return node;
 
+	node = of_find_compatible_node(NULL, NULL, "ti,omap5-dss");
+	if (node)
+		return node;
+
 	return NULL;
 }
 
-- 
1.9.1


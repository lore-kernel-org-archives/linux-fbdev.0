From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 17:59:37 +0000
Subject: [PATCH] video: fbdev: omap2: dss: sdi.c:  Cleaning up removal variable thet is never used
Message-Id: <1404669577-15942-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404577396-25151-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404577396-25151-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Archit Taneja <archit@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Removal of struct member variable thet is never used

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/omap2/dss/sdi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/sdi.c b/drivers/video/fbdev/omap2/dss/sdi.c
index 911dcc9..c6491ac 100644
--- a/drivers/video/fbdev/omap2/dss/sdi.c
+++ b/drivers/video/fbdev/omap2/dss/sdi.c
@@ -34,7 +34,6 @@
 static struct {
 	struct platform_device *pdev;
 
-	bool update_enabled;
 	struct regulator *vdds_sdi_reg;
 
 	struct dss_lcd_mgr_config mgr_config;
-- 
1.7.10.4


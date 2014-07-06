From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:44:32 +0000
Subject: [PATCH] video: fbdev: mxsfb.c:  Cleaning up variable that is never used
Message-Id: <1404672272-19231-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404563630-20521-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404563630-20521-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Jingoo Han <jg1.han@samsung.com>, Fabio Estevam <fabio.estevam@freescale.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Marek Vasut <marex@denx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/mxsfb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index accf48a2..d0a55c6 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -594,7 +594,6 @@ static int mxsfb_restore_mode(struct mxsfb_info *host,
 			struct fb_videomode *vmode)
 {
 	struct fb_info *fb_info = &host->fb_info;
-	unsigned line_count;
 	unsigned period;
 	unsigned long pa, fbsize;
 	int bits_per_pixel, ofs;
@@ -672,7 +671,6 @@ static int mxsfb_restore_mode(struct mxsfb_info *host,
 		writel(fb_info->fix.smem_start, host->base + host->devdata->next_buf);
 	}
 
-	line_count = fb_info->fix.smem_len / fb_info->fix.line_length;
 	fb_info->fix.ypanstep = 1;
 
 	clk_prepare_enable(host->clk);
-- 
1.7.10.4


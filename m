From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:33:50 +0000
Subject: [PATCH] video: fbdev: mxsfb.c:  Cleaning up variable that is never used
Message-Id: <1404563630-20521-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Rickard Strandqvist <rickard.strandqvist-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

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


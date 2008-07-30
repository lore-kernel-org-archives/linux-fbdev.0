From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] atyfb_base.c: fix warning
Date: Thu, 31 Jul 2008 01:03:52 +0400
Message-ID: <20080730210352.GA29355@orion>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756302AbYG3VEU@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: syrjala@sci.fi, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>

atyfb_base.c: fix warning

drivers/video/aty/atyfb_base.c:2663: warning: 'aty_resume_chip' defined
but not used

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
Cc: Ville Syrjala <syrjala@sci.fi>
Cc: Antonino A. Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 620ba81..9e5dfb1 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -244,7 +244,9 @@ static int atyfb_sync(struct fb_info *info);
      */
 
 static int aty_init(struct fb_info *info);
+#if defined(CONFIG_PM) && defined(CONFIG_PCI)
 static void aty_resume_chip(struct fb_info *info);
+#endif
 #ifdef CONFIG_ATARI
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
@@ -2659,6 +2661,7 @@ aty_init_exit:
 	return ret;
 }
 
+#if defined(CONFIG_PM) && defined(CONFIG_PCI)
 static void aty_resume_chip(struct fb_info *info)
 {
 	struct atyfb_par *par = info->par;
@@ -2671,6 +2674,7 @@ static void aty_resume_chip(struct fb_info *info)
 	if (par->aux_start)
 		aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, par) | BUS_APER_REG_DIS, par);
 }
+#endif /* defined(CONFIG_PM) && defined(CONFIG_PCI) */
 
 #ifdef CONFIG_ATARI
 static int __devinit store_video_par(char *video_str, unsigned char m64_num)

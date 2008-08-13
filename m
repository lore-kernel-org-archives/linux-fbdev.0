From: York Sun <yorksun@freescale.com>
Subject: [PATCH 1/2] Added virtual resolution and
	panning support.
Date: Wed, 13 Aug 2008 15:55:03 -0500
Message-ID: <12186609063047-git-send-email-yorksun@freescale.com>
References: <12186609042933-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KTNNg-0004IO-J0 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 13:55:44 -0700
Received: from az33egw01.freescale.net ([192.88.158.102])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KTNNf-0001pF-2A
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 13:55:44 -0700
In-Reply-To: <12186609042933-git-send-email-yorksun@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, galak@kernel.crashing.org

Application can now have the virtual resoltuion and use FBIOPAN_DISPLAY ioctl to pan.

Signed-off-by: York Sun <yorksun@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 9cd36c2..d67e79b 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -778,6 +778,22 @@ static void unmap_video_memory(struct fb_info *info)
 }
 
 /*
+ * Using the fb_var_screeninfo in fb_info we set the aoi of this
+ * particular framebuffer. It is a light version of fsl_diu_set_par.
+ */
+static int fsl_diu_set_aoi(struct fb_info *info)
+{
+	struct fb_var_screeninfo *var = &info->var;
+	struct mfb_info *mfbi = info->par;
+	struct diu_ad *ad = mfbi->ad;
+
+	/* AOI should not be greater than display size */
+	ad->offset_xyi = cpu_to_le32((var->yoffset << 16) | var->xoffset);
+	ad->offset_xyd = cpu_to_le32((mfbi->y_aoi_d << 16) | mfbi->x_aoi_d);
+	return 0;
+}
+
+/*
  * Using the fb_var_screeninfo in fb_info we set the resolution of this
  * particular framebuffer. This function alters the fb_fix_screeninfo stored
  * in fb_info. It does not alter var in fb_info since we are using that
@@ -817,11 +833,11 @@ static int fsl_diu_set_par(struct fb_info *info)
 		diu_ops.get_pixel_format(var->bits_per_pixel,
 					 machine_data->monitor_port);
 	ad->addr    = cpu_to_le32(info->fix.smem_start);
-	ad->src_size_g_alpha = cpu_to_le32((var->yres << 12) |
-				var->xres) | mfbi->g_alpha;
-	/* fix me. AOI should not be greater than display size */
+	ad->src_size_g_alpha = cpu_to_le32((var->yres_virtual << 12) |
+				var->xres_virtual) | mfbi->g_alpha;
+	/* AOI should not be greater than display size */
 	ad->aoi_size 	= cpu_to_le32((var->yres << 16) | var->xres);
-	ad->offset_xyi = 0;
+	ad->offset_xyi = cpu_to_le32((var->yoffset << 16) | var->xoffset);
 	ad->offset_xyd = cpu_to_le32((mfbi->y_aoi_d << 16) | mfbi->x_aoi_d);
 
 	/* Disable chroma keying function */
@@ -921,6 +937,8 @@ static int fsl_diu_pan_display(struct fb_var_screeninfo *var,
 	else
 		info->var.vmode &= ~FB_VMODE_YWRAP;
 
+	fsl_diu_set_aoi(info);
+
 	return 0;
 }
 
@@ -989,7 +1007,7 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		pr_debug("set AOI display offset of index %d to (%d,%d)\n",
 				 mfbi->index, aoi_d.x_aoi_d, aoi_d.y_aoi_d);
 		fsl_diu_check_var(&info->var, info);
-		fsl_diu_set_par(info);
+		fsl_diu_set_aoi(info);
 		break;
 	case MFB_GET_AOID:
 		aoi_d.x_aoi_d = mfbi->x_aoi_d;
-- 
1.5.2.2


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

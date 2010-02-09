From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 09 Feb 2010 14:32:37 +0000
Subject: [PATCH 2/3] viafb: video address setting revisited
Message-Id: <1265725958-4641-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1265725958-4641-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1265725958-4641-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: video address setting revisited

Set always the correct video address. Especially do panning right on
multiple IGAs.
This should have no effect on single monitor mode (no SAMM, no dual fb).
For SAMM without dual fb this might break something as I really cannot
image what we are supposed to do for different resolutions with a single
framebuffer as we can't get data out of nowhere (no, they are not set
up in something one would call "expanded"). Previously I got for that
funny colored pictures as the second IGA pointed to video memory that
was never written to. After the patch it'll work as cloning if the first
and second mode are identical (this was working already without SAMM).
Finally for dual fb this should push us a step in the right direction.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c       |    2 --
 drivers/video/via/viafbdev.c |   23 +++++++++++++++--------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 1aa3bb2..400373f 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2206,8 +2206,6 @@ int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 		outb(VPIT.SR[i - 1], VIASR + 1);
 	}
 
-	viafb_set_primary_address(0);
-	viafb_set_secondary_address(viafb_SAMM_ON ? viafb_second_offset : 0);
 	viafb_set_iga_path();
 
 	/* Write CRTC */
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 4d955ca..b417259 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -50,6 +50,8 @@ static void apply_second_mode_setting(struct fb_var_screeninfo
 	*sec_var);
 static void retrieve_device_setting(struct viafb_ioctl_setting
 	*setting_info);
+static int viafb_pan_display(struct fb_var_screeninfo *var,
+	struct fb_info *info);
 
 static struct fb_ops viafb_ops;
 
@@ -182,6 +184,7 @@ static int viafb_set_par(struct fb_info *info)
 			info->flags |= FBINFO_HWACCEL_DISABLED;
 		viafb_setmode(vmode_entry, info->var.bits_per_pixel,
 			vmode_entry1, viafb_bpp1);
+		viafb_pan_display(&info->var, info);
 	}
 
 	return 0;
@@ -410,15 +413,19 @@ static int viafb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 static int viafb_pan_display(struct fb_var_screeninfo *var,
 	struct fb_info *info)
 {
-	unsigned int offset;
-
-	DEBUG_MSG(KERN_INFO "viafb_pan_display!\n");
-
-	offset = (var->xoffset + (var->yoffset * var->xres_virtual)) *
-	    var->bits_per_pixel / 16;
+	struct viafb_par *viapar = info->par;
+	u32 vram_addr = (var->yoffset * var->xres_virtual + var->xoffset)
+		* (var->bits_per_pixel / 8) + viapar->vram_addr;
+
+	DEBUG_MSG(KERN_DEBUG "viafb_pan_display, address = %d\n", vram_addr);
+	if (!viafb_dual_fb) {
+		viafb_set_primary_address(vram_addr);
+		viafb_set_secondary_address(vram_addr);
+	} else if (viapar->iga_path = IGA1)
+		viafb_set_primary_address(vram_addr);
+	else
+		viafb_set_secondary_address(vram_addr);
 
-	DEBUG_MSG(KERN_INFO "\nviafb_pan_display,offset =%d ", offset);
-	viafb_set_primary_address(offset);
 	return 0;
 }
 
-- 
1.6.3.2


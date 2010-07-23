From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Jul 2010 15:39:23 +0000
Subject: [PATCH 08/11] viafb: update fix before calculating depth
Message-Id: <1279899566-4359-9-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: update fix before calculating depth

As the depth calculation depends on information in fix it is saner to
do the update first.
No runtime change expected as the value visual in fix used never
changes to MONO.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/viafbdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 1082541..ab39552 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -234,6 +234,7 @@ static int viafb_set_par(struct fb_info *info)
 	struct VideoModeTable *vmode_entry, *vmode_entry1 = NULL;
 	DEBUG_MSG(KERN_INFO "viafb_set_par!\n");
 
+	viafb_update_fix(info);
 	viapar->depth = fb_get_color_depth(&info->var, &info->fix);
 	viafb_update_device_setting(viafbinfo->var.xres, viafbinfo->var.yres,
 		viafbinfo->var.bits_per_pixel, viafb_refresh, 0);
@@ -257,7 +258,6 @@ static int viafb_set_par(struct fb_info *info)
 	}
 
 	if (vmode_entry) {
-		viafb_update_fix(info);
 		if (viafb_dual_fb && viapar->iga_path = IGA2)
 			viafb_bpp1 = info->var.bits_per_pixel;
 		else
-- 
1.6.3.2


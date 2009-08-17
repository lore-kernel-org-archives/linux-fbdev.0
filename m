From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: [PATCH 3/4] viafb: cleanup duoview
Date: Mon, 17 Aug 2009 11:58:09 +0000
Message-ID: <1250510290-3327-3-git-send-email-FlorianSchandinat@gmx.de>
References: <1250510290-3327-1-git-send-email-FlorianSchandinat@gmx.de>
 <1250510290-3327-2-git-send-email-FlorianSchandinat@gmx.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932579AbZHQLz5@vger.kernel.org>
In-Reply-To: <1250510290-3327-2-git-send-email-FlorianSchandinat@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: cleanup duoview

This patch cleans the duoview handling up by replacing the varible with
the funtion in the only place where it is used.
This is a code cleanup only, no runtime change expected.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 viafbdev.c |   18 ++----------------
 viafbdev.h |    1 -
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 7eff26e..e48e493 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1009,7 +1009,8 @@ static int viafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 		return -ENODEV;
 
 	/* When duoview and using lcd , use soft cursor */
-	if (viafb_LCD_ON || ((struct viafb_par *)(info->par))->duoview)
+	if (viafb_LCD_ON || (!viafb_SAMM_ON &&
+		viafb_LCD2_ON + viafb_DVI_ON + viafb_CRT_ON == 2))
 		return -ENODEV;
 
 	viafb_show_hw_cursor(info, HW_Cursor_OFF);
@@ -1376,18 +1377,6 @@ static int get_primary_device(void)
 	return primary_device;
 }
 
-static u8 is_duoview(void)
-{
-	if (0 == viafb_SAMM_ON) {
-		if (viafb_LCD_ON + viafb_LCD2_ON +
-			viafb_DVI_ON + viafb_CRT_ON == 2)
-			return true;
-		return false;
-	} else {
-		return false;
-	}
-}
-
 static void apply_second_mode_setting(struct fb_var_screeninfo
 	*sec_var)
 {
@@ -1496,8 +1485,6 @@ static int apply_device_setting(struct viafb_ioctl_setting setting_info,
 		need_set_mode = 1;
 	}
 
-	viaparinfo->duoview = is_duoview();
-
 	if (!need_set_mode) {
 		;
 	} else {
@@ -1618,7 +1605,6 @@ static void parse_active_dev(void)
 		viafb_CRT_ON = STATE_ON;
 		viafb_SAMM_ON = STATE_OFF;
 	}
-	viaparinfo->duoview = is_duoview();
 }
 
 static void parse_video_dev(void)
diff --git a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
index cd3dff7..9231877 100644
--- a/drivers/video/via/viafbdev.h
+++ b/drivers/video/via/viafbdev.h
@@ -52,7 +52,6 @@ struct viafb_par {
 	u32 VQ_end;		/* Virtual Queue End Address */
 	u32 iga_path;
 	struct proc_dir_entry *proc_entry;	/*viafb proc entry */
-	u8 duoview;		/*Is working in duoview mode? */
 
 	/* I2C stuff */
 	struct via_i2c_stuff i2c_stuff;
-- 
1.6.3.2

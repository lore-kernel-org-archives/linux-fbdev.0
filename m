From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 17 Apr 2010 19:44:52 +0000
Subject: [PATCH 2/7] viafb: unify modesetting functions
Message-Id: <1271533498-3376-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271533498-3376-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1271533498-3376-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, corbet@lwn.net, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: unify modesetting functions

This patch unifies some cleaned up modesetting functions to prepare for
moving them to an extra file. This includes make them use via_io and
changing there names to reflect that they do not depend on anything
framebuffer specific.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c       |   66 +++++++++++++++++++++---------------------
 drivers/video/via/hw.h       |    8 ++--
 drivers/video/via/viafbdev.c |   17 ++++++-----
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 32742dd..6c6c140 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -624,50 +624,50 @@ void viafb_set_iga_path(void)
 	}
 }
 
-void viafb_set_primary_address(u32 addr)
+void via_set_primary_address(u32 addr)
 {
-	DEBUG_MSG(KERN_DEBUG "viafb_set_primary_address(0x%08X)\n", addr);
-	viafb_write_reg(CR0D, VIACR, addr & 0xFF);
-	viafb_write_reg(CR0C, VIACR, (addr >> 8) & 0xFF);
-	viafb_write_reg(CR34, VIACR, (addr >> 16) & 0xFF);
-	viafb_write_reg_mask(CR48, VIACR, (addr >> 24) & 0x1F, 0x1F);
+	DEBUG_MSG(KERN_DEBUG "via_set_primary_address(0x%08X)\n", addr);
+	via_write_reg(VIACR, 0x0D, addr & 0xFF);
+	via_write_reg(VIACR, 0x0C, (addr >> 8) & 0xFF);
+	via_write_reg(VIACR, 0x34, (addr >> 16) & 0xFF);
+	via_write_reg_mask(VIACR, 0x48, (addr >> 24) & 0x1F, 0x1F);
 }
 
-void viafb_set_secondary_address(u32 addr)
+void via_set_secondary_address(u32 addr)
 {
-	DEBUG_MSG(KERN_DEBUG "viafb_set_secondary_address(0x%08X)\n", addr);
+	DEBUG_MSG(KERN_DEBUG "via_set_secondary_address(0x%08X)\n", addr);
 	/* secondary display supports only quadword aligned memory */
-	viafb_write_reg_mask(CR62, VIACR, (addr >> 2) & 0xFE, 0xFE);
-	viafb_write_reg(CR63, VIACR, (addr >> 10) & 0xFF);
-	viafb_write_reg(CR64, VIACR, (addr >> 18) & 0xFF);
-	viafb_write_reg_mask(CRA3, VIACR, (addr >> 26) & 0x07, 0x07);
+	via_write_reg_mask(VIACR, 0x62, (addr >> 2) & 0xFE, 0xFE);
+	via_write_reg(VIACR, 0x63, (addr >> 10) & 0xFF);
+	via_write_reg(VIACR, 0x64, (addr >> 18) & 0xFF);
+	via_write_reg_mask(VIACR, 0xA3, (addr >> 26) & 0x07, 0x07);
 }
 
-void viafb_set_primary_pitch(u32 pitch)
+void via_set_primary_pitch(u32 pitch)
 {
-	DEBUG_MSG(KERN_DEBUG "viafb_set_primary_pitch(0x%08X)\n", pitch);
+	DEBUG_MSG(KERN_DEBUG "via_set_primary_pitch(0x%08X)\n", pitch);
 	/* spec does not say that first adapter skips 3 bits but old
 	 * code did it and seems to be reasonable in analogy to 2nd adapter
 	 */
 	pitch = pitch >> 3;
-	viafb_write_reg(0x13, VIACR, pitch & 0xFF);
-	viafb_write_reg_mask(0x35, VIACR, (pitch >> (8 - 5)) & 0xE0, 0xE0);
+	via_write_reg(VIACR, 0x13, pitch & 0xFF);
+	via_write_reg_mask(VIACR, 0x35, (pitch >> (8 - 5)) & 0xE0, 0xE0);
 }
 
-void viafb_set_secondary_pitch(u32 pitch)
+void via_set_secondary_pitch(u32 pitch)
 {
-	DEBUG_MSG(KERN_DEBUG "viafb_set_secondary_pitch(0x%08X)\n", pitch);
+	DEBUG_MSG(KERN_DEBUG "via_set_secondary_pitch(0x%08X)\n", pitch);
 	pitch = pitch >> 3;
-	viafb_write_reg(0x66, VIACR, pitch & 0xFF);
-	viafb_write_reg_mask(0x67, VIACR, (pitch >> 8) & 0x03, 0x03);
-	viafb_write_reg_mask(0x71, VIACR, (pitch >> (10 - 7)) & 0x80, 0x80);
+	via_write_reg(VIACR, 0x66, pitch & 0xFF);
+	via_write_reg_mask(VIACR, 0x67, (pitch >> 8) & 0x03, 0x03);
+	via_write_reg_mask(VIACR, 0x71, (pitch >> (10 - 7)) & 0x80, 0x80);
 }
 
-void viafb_set_primary_color_depth(u8 depth)
+void via_set_primary_color_depth(u8 depth)
 {
 	u8 value;
 
-	DEBUG_MSG(KERN_DEBUG "viafb_set_primary_color_depth(%d)\n", depth);
+	DEBUG_MSG(KERN_DEBUG "via_set_primary_color_depth(%d)\n", depth);
 	switch (depth) {
 	case 8:
 		value = 0x00;
@@ -685,19 +685,19 @@ void viafb_set_primary_color_depth(u8 depth)
 		value = 0x08;
 		break;
 	default:
-		printk(KERN_WARNING "viafb_set_primary_color_depth: "
+		printk(KERN_WARNING "via_set_primary_color_depth: "
 			"Unsupported depth: %d\n", depth);
 		return;
 	}
 
-	viafb_write_reg_mask(0x15, VIASR, value, 0x1C);
+	via_write_reg_mask(VIASR, 0x15, value, 0x1C);
 }
 
-void viafb_set_secondary_color_depth(u8 depth)
+void via_set_secondary_color_depth(u8 depth)
 {
 	u8 value;
 
-	DEBUG_MSG(KERN_DEBUG "viafb_set_secondary_color_depth(%d)\n", depth);
+	DEBUG_MSG(KERN_DEBUG "via_set_secondary_color_depth(%d)\n", depth);
 	switch (depth) {
 	case 8:
 		value = 0x00;
@@ -712,12 +712,12 @@ void viafb_set_secondary_color_depth(u8 depth)
 		value = 0x80;
 		break;
 	default:
-		printk(KERN_WARNING "viafb_set_secondary_color_depth: "
+		printk(KERN_WARNING "via_set_secondary_color_depth: "
 			"Unsupported depth: %d\n", depth);
 		return;
 	}
 
-	viafb_write_reg_mask(0x67, VIACR, value, 0xC0);
+	via_write_reg_mask(VIACR, 0x67, value, 0xC0);
 }
 
 static void set_color_register(u8 index, u8 red, u8 green, u8 blue)
@@ -2255,11 +2255,11 @@ int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 		}
 	}
 
-	viafb_set_primary_pitch(viafbinfo->fix.line_length);
-	viafb_set_secondary_pitch(viafb_dual_fb ? viafbinfo1->fix.line_length
+	via_set_primary_pitch(viafbinfo->fix.line_length);
+	via_set_secondary_pitch(viafb_dual_fb ? viafbinfo1->fix.line_length
 		: viafbinfo->fix.line_length);
-	viafb_set_primary_color_depth(viaparinfo->depth);
-	viafb_set_secondary_color_depth(viafb_dual_fb ? viaparinfo1->depth
+	via_set_primary_color_depth(viaparinfo->depth);
+	via_set_secondary_color_depth(viafb_dual_fb ? viaparinfo1->depth
 		: viaparinfo->depth);
 	/* Update Refresh Rate Setting */
 
diff --git a/drivers/video/via/hw.h b/drivers/video/via/hw.h
index f0c202d..cb63f22 100644
--- a/drivers/video/via/hw.h
+++ b/drivers/video/via/hw.h
@@ -912,10 +912,10 @@ void viafb_update_device_setting(int hres, int vres, int bpp,
 
 int viafb_get_fb_size_from_pci(void);
 void viafb_set_iga_path(void);
-void viafb_set_primary_address(u32 addr);
-void viafb_set_secondary_address(u32 addr);
-void viafb_set_primary_pitch(u32 pitch);
-void viafb_set_secondary_pitch(u32 pitch);
+void via_set_primary_address(u32 addr);
+void via_set_secondary_address(u32 addr);
+void via_set_primary_pitch(u32 pitch);
+void via_set_secondary_pitch(u32 pitch);
 void viafb_set_primary_color_register(u8 index, u8 red, u8 green, u8 blue);
 void viafb_set_secondary_color_register(u8 index, u8 red, u8 green, u8 blue);
 void viafb_get_fb_info(unsigned int *fb_base, unsigned int *fb_len);
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 777b38a..c6c01ef 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -317,12 +317,12 @@ static int viafb_pan_display(struct fb_var_screeninfo *var,
 
 	DEBUG_MSG(KERN_DEBUG "viafb_pan_display, address = %d\n", vram_addr);
 	if (!viafb_dual_fb) {
-		viafb_set_primary_address(vram_addr);
-		viafb_set_secondary_address(vram_addr);
+		via_set_primary_address(vram_addr);
+		via_set_secondary_address(vram_addr);
 	} else if (viapar->iga_path = IGA1)
-		viafb_set_primary_address(vram_addr);
+		via_set_primary_address(vram_addr);
 	else
-		viafb_set_secondary_address(vram_addr);
+		via_set_secondary_address(vram_addr);
 
 	return 0;
 }
@@ -1018,8 +1018,8 @@ static void viafb_set_device(struct device_t active_dev)
 		viafb_SAMM_ON = active_dev.samm;
 	viafb_primary_dev = active_dev.primary_dev;
 
-	viafb_set_primary_address(0);
-	viafb_set_secondary_address(viafb_SAMM_ON ? viafb_second_offset : 0);
+	via_set_primary_address(0);
+	via_set_secondary_address(viafb_SAMM_ON ? viafb_second_offset : 0);
 	viafb_set_iga_path();
 }
 
@@ -1165,8 +1165,9 @@ static int apply_device_setting(struct viafb_ioctl_setting setting_info,
 			if (viafb_SAMM_ON)
 				viafb_primary_dev = setting_info.primary_device;
 
-			viafb_set_primary_address(0);
-			viafb_set_secondary_address(viafb_SAMM_ON ? viafb_second_offset : 0);
+			via_set_primary_address(0);
+			via_set_secondary_address(viafb_SAMM_ON ?
+				viafb_second_offset : 0);
 			viafb_set_iga_path();
 		}
 		need_set_mode = 1;
-- 
1.6.3.2


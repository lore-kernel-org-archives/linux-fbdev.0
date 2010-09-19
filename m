From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 19 Sep 2010 07:33:50 +0000
Subject: [PATCH 09/12] viafb: set sync polarity for all output devices
Message-Id: <b056421d5a9d9b35ef5f77d343f2b3d6b8cfc561.1284879533.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
In-Reply-To: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: set sync polarity for all output devices

This patch sets the sync polarity for all output devices, not only CRT.
This may give some people a working screen but only if lcd scaling and
centering are not used as it is currently too dificult to propagate a
different resolution (from what the application thinks) to the correct
output device. Hopefully this does not introduce regressions as the
polarity of non-CRT devices was completly ignored before.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/hw.c |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index d6bbb0a..00fecb5 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2014,7 +2014,6 @@ void viafb_fill_crtc_timing(struct crt_mode_table *crt_table,
 	int index = 0;
 	int h_addr, v_addr;
 	u32 pll_D_N;
-	u8 polarity = 0;
 
 	for (i = 0; i < video_mode->mode_array; i++) {
 		index = i;
@@ -2041,14 +2040,6 @@ void viafb_fill_crtc_timing(struct crt_mode_table *crt_table,
 
 	h_addr = crt_reg.hor_addr;
 	v_addr = crt_reg.ver_addr;
-
-	/* update polarity for CRT timing */
-	if (crt_table[index].h_sync_polarity = NEGATIVE)
-		polarity |= VIA_HSYNC_NEGATIVE;
-	if (crt_table[index].v_sync_polarity = NEGATIVE)
-		polarity |= VIA_VSYNC_NEGATIVE;
-	via_set_sync_polarity(VIA_CRT, polarity);
-
 	if (set_iga = IGA1) {
 		viafb_unlock_crt();
 		viafb_write_reg(CR09, VIACR, 0x00);	/*initial CR09=0 */
@@ -2352,6 +2343,17 @@ static void set_display_channel(void)
 	}
 }
 
+static u8 get_sync(struct fb_info *info)
+{
+	u8 polarity = 0;
+
+	if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
+		polarity |= VIA_HSYNC_NEGATIVE;
+	if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
+		polarity |= VIA_VSYNC_NEGATIVE;
+	return polarity;
+}
+
 int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 	struct VideoModeTable *vmode_tbl1, int video_bpp1)
 {
@@ -2566,6 +2568,15 @@ int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 			viafb_DeviceStatus = CRT_Device;
 	}
 	device_on();
+	if (!viafb_dual_fb)
+		via_set_sync_polarity(devices, get_sync(viafbinfo));
+	else {
+		via_set_sync_polarity(viaparinfo->shared->iga1_devices,
+			get_sync(viafbinfo));
+		via_set_sync_polarity(viaparinfo->shared->iga2_devices,
+			get_sync(viafbinfo1));
+	}
+
 	via_set_state(devices, VIA_STATE_ON);
 	device_screen_on();
 	return 1;
@@ -2719,4 +2730,9 @@ void viafb_fill_var_timing_info(struct fb_var_screeninfo *var, int refresh,
 	    crt_reg.ver_total - (crt_reg.ver_sync_start + crt_reg.ver_sync_end);
 	var->lower_margin = crt_reg.ver_sync_start - crt_reg.ver_addr;
 	var->vsync_len = crt_reg.ver_sync_end;
+	var->sync = 0;
+	if (crt_timing[index].h_sync_polarity = POSITIVE)
+		var->sync |= FB_SYNC_HOR_HIGH_ACT;
+	if (crt_timing[index].v_sync_polarity = POSITIVE)
+		var->sync |= FB_SYNC_VERT_HIGH_ACT;
 }
-- 
1.6.3.2


From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 19 Sep 2010 07:33:49 +0000
Subject: [PATCH 08/12] viafb: add function to change sync polarity per device
Message-Id: <00ad35ddf5af3070a8c4cd031bc93d560259ee00.1284879532.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
In-Reply-To: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: add function to change sync polarity per device

At the moment only the sync polarity for CRT is handled but there are
also bits for controlling the sync polarity for other output devices.
Add a function to change those similar to the other output device
functions.
There is no runtime change yet as the code still handles only CRT.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/hw.c |   24 +++++++++++++++++++++---
 drivers/video/via/hw.h |    5 +++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 132d811..d6bbb0a 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -1151,6 +1151,24 @@ void via_set_state(u32 devices, u8 state)
 		set_lvds2_state(state);
 }
 
+void via_set_sync_polarity(u32 devices, u8 polarity)
+{
+	if (polarity & ~(VIA_HSYNC_NEGATIVE | VIA_VSYNC_NEGATIVE)) {
+		printk(KERN_WARNING "viafb: Unsupported polarity: %d\n",
+			polarity);
+		return;
+	}
+
+	if (devices & VIA_CRT)
+		via_write_misc_reg_mask(polarity << 6, 0xC0);
+	if (devices & VIA_DVP1)
+		via_write_reg_mask(VIACR, 0x9B, polarity << 5, 0x60);
+	if (devices & VIA_LVDS1)
+		via_write_reg_mask(VIACR, 0x99, polarity << 5, 0x60);
+	if (devices & VIA_LVDS2)
+		via_write_reg_mask(VIACR, 0x97, polarity << 5, 0x60);
+}
+
 u32 via_parse_odev(char *input, char **end)
 {
 	char *ptr = input;
@@ -2026,10 +2044,10 @@ void viafb_fill_crtc_timing(struct crt_mode_table *crt_table,
 
 	/* update polarity for CRT timing */
 	if (crt_table[index].h_sync_polarity = NEGATIVE)
-		polarity |= BIT6;
+		polarity |= VIA_HSYNC_NEGATIVE;
 	if (crt_table[index].v_sync_polarity = NEGATIVE)
-		polarity |= BIT7;
-	via_write_misc_reg_mask(polarity, BIT6 | BIT7);
+		polarity |= VIA_VSYNC_NEGATIVE;
+	via_set_sync_polarity(VIA_CRT, polarity);
 
 	if (set_iga = IGA1) {
 		viafb_unlock_crt();
diff --git a/drivers/video/via/hw.h b/drivers/video/via/hw.h
index b067cbb..ad6f9b1 100644
--- a/drivers/video/via/hw.h
+++ b/drivers/video/via/hw.h
@@ -47,6 +47,10 @@
 #define VIA_STATE_SUSPEND	2
 #define VIA_STATE_OFF		3
 
+/* VIA output device sync polarity */
+#define VIA_HSYNC_NEGATIVE	0x01
+#define VIA_VSYNC_NEGATIVE	0x02
+
 /***************************************************
 * Definition IGA1 Design Method of CRTC Registers *
 ****************************************************/
@@ -912,6 +916,7 @@ void viafb_load_reg(int timing_value, int viafb_load_reg_num,
 	      int io_type);
 void via_set_source(u32 devices, u8 iga);
 void via_set_state(u32 devices, u8 state);
+void via_set_sync_polarity(u32 devices, u8 polarity);
 u32 via_parse_odev(char *input, char **end);
 void via_odev_to_seq(struct seq_file *m, u32 odev);
 void init_ad9389(void);
-- 
1.6.3.2


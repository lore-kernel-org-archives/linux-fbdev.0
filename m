From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 23 Mar 2011 21:49:17 +0000
Subject: [PATCH 1/4] viafb: move initialization code
Message-Id: <1300917792-3880-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300917792-3880-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1300917792-3880-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This moves some mode independend initialization code to the function
where the other parts of the initialization are.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index dc4c778..a982718 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -1162,6 +1162,8 @@ void via_odev_to_seq(struct seq_file *m, u32 odev)
 
 static void load_fix_bit_crtc_reg(void)
 {
+	viafb_unlock_crt();
+
 	/* always set to 1 */
 	viafb_write_reg_mask(CR03, VIACR, 0x80, BIT7);
 	/* line compare should set all bits = 1 (extend modes) */
@@ -1169,8 +1171,6 @@ static void load_fix_bit_crtc_reg(void)
 	/* line compare should set all bits = 1 (extend modes) */
 	viafb_write_reg_mask(CR07, VIACR, 0x10, BIT4);
 	/* line compare should set all bits = 1 (extend modes) */
-	viafb_write_reg_mask(CR09, VIACR, 0x40, BIT6);
-	/* line compare should set all bits = 1 (extend modes) */
 	viafb_write_reg_mask(CR35, VIACR, 0x10, BIT4);
 	/* line compare should set all bits = 1 (extend modes) */
 	viafb_write_reg_mask(CR33, VIACR, 0x06, BIT0 + BIT1 + BIT2);
@@ -1181,6 +1181,10 @@ static void load_fix_bit_crtc_reg(void)
 	viafb_write_reg(CR08, VIACR, 0x00);
 	/* extend mode always set to 0h */
 	viafb_write_reg(CR14, VIACR, 0x00);
+	viafb_write_reg_mask(CR09, VIACR, 0x40, 0xDF);
+	viafb_write_reg_mask(CR11, VIACR, 0x00, BIT4 + BIT5 + BIT6);
+
+	viafb_lock_crt();
 
 	/* If K8M800, enable Prefetch Mode. */
 	if ((viaparinfo->chip_info->gfx_chip_name = UNICHROME_K800)
@@ -2033,8 +2037,6 @@ void viafb_fill_crtc_timing(struct crt_mode_table *crt_table,
 	v_addr = crt_reg.ver_addr;
 	if (set_iga = IGA1) {
 		viafb_unlock_crt();
-		viafb_write_reg(CR09, VIACR, 0x00);	/*initial CR09=0 */
-		viafb_write_reg_mask(CR11, VIACR, 0x00, BIT4 + BIT5 + BIT6);
 		viafb_write_reg_mask(CR17, VIACR, 0x00, BIT7);
 	}
 
@@ -2047,7 +2049,6 @@ void viafb_fill_crtc_timing(struct crt_mode_table *crt_table,
 		break;
 	}
 
-	load_fix_bit_crtc_reg();
 	viafb_lock_crt();
 	viafb_write_reg_mask(CR17, VIACR, 0x80, BIT7);
 	viafb_load_fetch_count_reg(h_addr, bpp_byte, set_iga);
@@ -2432,6 +2433,7 @@ int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 		}
 	}
 
+	load_fix_bit_crtc_reg();
 	via_set_primary_pitch(viafbinfo->fix.line_length);
 	via_set_secondary_pitch(viafb_dual_fb ? viafbinfo1->fix.line_length
 		: viafbinfo->fix.line_length);
-- 
1.6.3.2


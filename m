From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 28 Apr 2010 22:17:28 +0000
Subject: [PATCH 27/30] viafb: replace inb/outb
Message-Id: <1272493051-25380-28-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: replace inb/outb

This patch replaces occurences of inb/outb with via_write_reg and
via_write_reg_mask where this is possible to improve code
readability.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index d474fbe..b2bb24e 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -1008,16 +1008,12 @@ void viafb_load_reg(int timing_value, int viafb_load_reg_num,
 void viafb_write_regx(struct io_reg RegTable[], int ItemNum)
 {
 	int i;
-	unsigned char RegTemp;
 
 	/*DEBUG_MSG(KERN_INFO "Table Size : %x!!\n",ItemNum ); */
 
-	for (i = 0; i < ItemNum; i++) {
-		outb(RegTable[i].index, RegTable[i].port);
-		RegTemp = inb(RegTable[i].port + 1);
-		RegTemp = (RegTemp & (~RegTable[i].mask)) | RegTable[i].value;
-		outb(RegTemp, RegTable[i].port + 1);
-	}
+	for (i = 0; i < ItemNum; i++)
+		via_write_reg_mask(RegTable[i].port, RegTable[i].index,
+			RegTable[i].value, RegTable[i].mask);
 }
 
 void viafb_load_fetch_count_reg(int h_addr, int bpp_byte, int set_iga)
@@ -2130,10 +2126,8 @@ int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 	outb(VPIT.Misc, VIAWMisc);
 
 	/* Write Sequencer */
-	for (i = 1; i <= StdSR; i++) {
-		outb(i, VIASR);
-		outb(VPIT.SR[i - 1], VIASR + 1);
-	}
+	for (i = 1; i <= StdSR; i++)
+		via_write_reg(VIASR, i, VPIT.SR[i - 1]);
 
 	viafb_write_reg_mask(0x15, VIASR, 0xA2, 0xA2);
 	viafb_set_iga_path();
@@ -2142,10 +2136,8 @@ int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 	viafb_fill_crtc_timing(crt_timing, vmode_tbl, video_bpp / 8, IGA1);
 
 	/* Write Graphic Controller */
-	for (i = 0; i < StdGR; i++) {
-		outb(i, VIAGR);
-		outb(VPIT.GR[i], VIAGR + 1);
-	}
+	for (i = 0; i < StdGR; i++)
+		via_write_reg(VIAGR, i, VPIT.GR[i]);
 
 	/* Write Attribute Controller */
 	for (i = 0; i < StdAR; i++) {
-- 
1.7.0.1


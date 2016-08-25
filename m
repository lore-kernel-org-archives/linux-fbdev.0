From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 25 Aug 2016 17:56:12 +0000
Subject: [PATCH] matroxfb: fix size of memcpy
Message-Id: <1472147052-26921-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

hw->DACreg has a size of 80 bytes and MGADACbpp32 has 21. So when
memcpy copies MGADACbpp32 to hw->DACreg it copies 80 bytes but
only 21 bytes are valid.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/video/fbdev/matrox/matroxfb_Ti3026.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
index 195ad7c..68fa037 100644
--- a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
+++ b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
@@ -372,7 +372,7 @@ static int Ti3026_init(struct matrox_fb_info *minfo, struct my_timming *m)
 
 	DBG(__func__)
 
-	memcpy(hw->DACreg, MGADACbpp32, sizeof(hw->DACreg));
+	memcpy(hw->DACreg, MGADACbpp32, sizeof(MGADACbpp32));
 	switch (minfo->fbcon.var.bits_per_pixel) {
 		case 4:	hw->DACreg[POS3026_XLATCHCTRL] = TVP3026_XLATCHCTRL_16_1;	/* or _8_1, they are same */
 			hw->DACreg[POS3026_XTRUECOLORCTRL] = TVP3026_XTRUECOLORCTRL_PSEUDOCOLOR;
-- 
1.9.1


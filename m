From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 13 Feb 2011 22:11:26 +0000
Subject: [PATCH 4/6] sisfb: add RAM type detection for XGI Z9
Message-Id: <1297635088-13224-5-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297635088-13224-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1297635088-13224-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Winischhofer <thomas@winischhofer.net>

Detect the XGI Z9 RAM type as "documented" by the XGI's xgifb driver.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/sis_main.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index f0c48e8..de03567 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -4955,7 +4955,13 @@ sisfb_post_xgi_ramtype(struct sis_video_info *ivideo)
 		v1 = bios[0x1d2];
 	}
 	if (!(ramtype & 0x80)) {
-		if (ivideo->chip = XGI_20) {
+		if (sisfb_xgi_is21(ivideo)) {
+			SiS_SetRegAND(SISCR, 0xb4, 0xfd); /* GPIO control */
+			SiS_SetRegOR(SISCR, 0x4a, 0x80);  /* GPIOH EN */
+			reg = SiS_GetReg(SISCR, 0x48);
+			SiS_SetRegOR(SISCR, 0xb4, 0x02);
+			ramtype = reg & 0x01;		  /* GPIOH */
+		} else if (ivideo->chip = XGI_20) {
 			SiS_SetReg(SISCR, 0x97, v1);
 			reg = SiS_GetReg(SISCR, 0x97);
 			if (reg & 0x10) {
-- 
1.5.6.5


From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 23 Mar 2011 21:48:56 +0000
Subject: [PATCH 2/4] viafb: no need to write CRTC values twice
Message-Id: <1300917792-3880-3-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300917792-3880-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1300917792-3880-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Later the correct values will be written so there is no need to
write early some values which might be wrong.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index a982718..c4d2136 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2401,9 +2401,6 @@ int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 
 	viafb_write_reg_mask(0x15, VIASR, 0xA2, 0xA2);
 
-	/* Write CRTC */
-	viafb_fill_crtc_timing(crt_timing, vmode_tbl, video_bpp / 8, IGA1);
-
 	/* Write Graphic Controller */
 	for (i = 0; i < StdGR; i++)
 		via_write_reg(VIAGR, i, VPIT.GR[i]);
-- 
1.6.3.2


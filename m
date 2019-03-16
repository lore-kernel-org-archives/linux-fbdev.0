From: Yifeng Li <tomli@tomli.me>
Date: Sat, 16 Mar 2019 22:25:02 +0000
Subject: [PATCH 6/8] fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting.
Message-Id: <20190316222504.27170-7-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>, stable@vger.kernel.org

On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), blanking the display
or starting the X server will crash and freeze the system, or garble the
display.

Experiments showed this problem can mostly be solved by adjusting the
order of register writes. Also, sm712fb failed to consider the difference
of clock frequency when unblanking the display, and programs the clock for
SM712 to SM720.

Fix them by adjusting the order of register writes, and adding an
additional check for SM720 for programming the clock frequency.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 64 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 52234c57be02..a40d0ae7cb66 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -827,67 +827,79 @@ static inline unsigned int chan_to_field(unsigned int chan,
 
 static int smtc_blank(int blank_mode, struct fb_info *info)
 {
+	struct smtcfb_info *sfb = info->par;
+
 	/* clear DPMS setting */
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		/* Screen On: HSync: On, VSync : On */
+
+		switch (sfb->chip_id) {
+		case 0x710:
+		case 0x712:
+			smtc_seqw(0x6a, 0x16);
+			smtc_seqw(0x6b, 0x02);
+		case 0x720:
+			smtc_seqw(0x6a, 0x0d);
+			smtc_seqw(0x6b, 0x02);
+			break;
+		}
+
+		smtc_seqw(0x23, (smtc_seqr(0x23) & (~0xc0)));
 		smtc_seqw(0x01, (smtc_seqr(0x01) & (~0x20)));
-		smtc_seqw(0x6a, 0x16);
-		smtc_seqw(0x6b, 0x02);
 		smtc_seqw(0x21, (smtc_seqr(0x21) & 0x77));
 		smtc_seqw(0x22, (smtc_seqr(0x22) & (~0x30)));
-		smtc_seqw(0x23, (smtc_seqr(0x23) & (~0xc0)));
-		smtc_seqw(0x24, (smtc_seqr(0x24) | 0x01));
 		smtc_seqw(0x31, (smtc_seqr(0x31) | 0x03));
+		smtc_seqw(0x24, (smtc_seqr(0x24) | 0x01));
 		break;
 	case FB_BLANK_NORMAL:
 		/* Screen Off: HSync: On, VSync : On   Soft blank */
+		smtc_seqw(0x24, (smtc_seqr(0x24) | 0x01));
+		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
+		smtc_seqw(0x23, (smtc_seqr(0x23) & (~0xc0)));
 		smtc_seqw(0x01, (smtc_seqr(0x01) & (~0x20)));
+		smtc_seqw(0x22, (smtc_seqr(0x22) & (~0x30)));
 		smtc_seqw(0x6a, 0x16);
 		smtc_seqw(0x6b, 0x02);
-		smtc_seqw(0x22, (smtc_seqr(0x22) & (~0x30)));
-		smtc_seqw(0x23, (smtc_seqr(0x23) & (~0xc0)));
-		smtc_seqw(0x24, (smtc_seqr(0x24) | 0x01));
-		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 		/* Screen On: HSync: On, VSync : Off */
+		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
+		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
+		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0x20));
 		smtc_seqw(0x01, (smtc_seqr(0x01) | 0x20));
-		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
-		smtc_seqw(0x6a, 0x0c);
-		smtc_seqw(0x6b, 0x02);
 		smtc_seqw(0x21, (smtc_seqr(0x21) | 0x88));
+		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
 		smtc_seqw(0x22, ((smtc_seqr(0x22) & (~0x30)) | 0x20));
-		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0x20));
-		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
-		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
 		smtc_seqw(0x34, (smtc_seqr(0x34) | 0x80));
+		smtc_seqw(0x6a, 0x0c);
+		smtc_seqw(0x6b, 0x02);
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		/* Screen On: HSync: Off, VSync : On */
+		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
+		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
+		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0xD8));
 		smtc_seqw(0x01, (smtc_seqr(0x01) | 0x20));
-		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
-		smtc_seqw(0x6a, 0x0c);
-		smtc_seqw(0x6b, 0x02);
 		smtc_seqw(0x21, (smtc_seqr(0x21) | 0x88));
+		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
 		smtc_seqw(0x22, ((smtc_seqr(0x22) & (~0x30)) | 0x10));
-		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0xD8));
-		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
-		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
 		smtc_seqw(0x34, (smtc_seqr(0x34) | 0x80));
+		smtc_seqw(0x6a, 0x0c);
+		smtc_seqw(0x6b, 0x02);
 		break;
 	case FB_BLANK_POWERDOWN:
 		/* Screen On: HSync: Off, VSync : Off */
+		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
+		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
+		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0xD8));
 		smtc_seqw(0x01, (smtc_seqr(0x01) | 0x20));
-		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
-		smtc_seqw(0x6a, 0x0c);
-		smtc_seqw(0x6b, 0x02);
 		smtc_seqw(0x21, (smtc_seqr(0x21) | 0x88));
+		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
 		smtc_seqw(0x22, ((smtc_seqr(0x22) & (~0x30)) | 0x30));
-		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0xD8));
-		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
-		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
 		smtc_seqw(0x34, (smtc_seqr(0x34) | 0x80));
+		smtc_seqw(0x6a, 0x0c);
+		smtc_seqw(0x6b, 0x02);
 		break;
 	default:
 		return -EINVAL;
-- 
2.20.1

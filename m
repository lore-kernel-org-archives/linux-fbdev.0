From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 18 Aug 2012 13:30:21 +0000
Subject: [PATCH] fbdev/amifb: Remove write-only variable amifb_inverse
Message-Id: <1345296621-15367-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 887df9d..7fa1bf8 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -949,7 +949,6 @@ static int round_down_bpp = 1;	/* for mode probing */
 
 
 static int amifb_ilbm = 0;	/* interleaved or normal bitplanes */
-static int amifb_inverse = 0;
 
 static u32 amifb_hfmin __initdata;	/* monitor hfreq lower limit (Hz) */
 static u32 amifb_hfmax __initdata;	/* monitor hfreq upper limit (Hz) */
@@ -2355,7 +2354,6 @@ static int __init amifb_setup(char *options)
 		if (!*this_opt)
 			continue;
 		if (!strcmp(this_opt, "inverse")) {
-			amifb_inverse = 1;
 			fb_invert_cmaps();
 		} else if (!strcmp(this_opt, "ilbm"))
 			amifb_ilbm = 1;
-- 
1.7.0.4


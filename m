From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Nov 2011 20:53:57 +0000
Subject: [PATCH 6/8] fbdev/amifb: Store monitor limits in separate __initdata variables
Message-Id: <1321908839-11419-6-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321908839-11419-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1321908839-11419-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

The static fb_info will go away soon.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 421c1f9..13e7a17 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -961,6 +961,11 @@ static int round_down_bpp = 1;	/* for mode probing */
 static int amifb_ilbm = 0;	/* interleaved or normal bitplanes */
 static int amifb_inverse = 0;
 
+static u32 amifb_hfmin __initdata;	/* monitor hfreq lower limit (Hz) */
+static u32 amifb_hfmax __initdata;	/* monitor hfreq upper limit (Hz) */
+static u16 amifb_vfmin __initdata;	/* monitor vfreq lower limit (Hz) */
+static u16 amifb_vfmax __initdata;	/* monitor vfreq upper limit (Hz) */
+
 
 	/*
 	 * Macros for the conversion from real world values to hardware register
@@ -2357,10 +2362,10 @@ static void __init amifb_setup_mcap(char *spec)
 	if (hmax <= 0 || hmax <= hmin)
 		return;
 
-	fb_info.monspecs.vfmin = vmin;
-	fb_info.monspecs.vfmax = vmax;
-	fb_info.monspecs.hfmin = hmin;
-	fb_info.monspecs.hfmax = hmax;
+	amifb_hfmin = hmin;
+	amifb_hfmax = hmax;
+	amifb_vfmin = vmin;
+	amifb_vfmax = vmax;
 }
 
 static int __init amifb_setup(char *options)
@@ -3666,10 +3671,15 @@ default_chipset:
 		}
 	}
 
-	/*
-	 *  These monitor specs are for a typical Amiga monitor (e.g. A1960)
-	 */
-	if (fb_info.monspecs.hfmin = 0) {
+	if (amifb_hfmin) {
+		fb_info.monspecs.hfmin = amifb_hfmin;
+		fb_info.monspecs.hfmax = amifb_hfmax;
+		fb_info.monspecs.vfmin = amifb_vfmin;
+		fb_info.monspecs.vfmax = amifb_vfmax;
+	} else {
+		/*
+		 *  These are for a typical Amiga monitor (e.g. A1960)
+		 */
 		fb_info.monspecs.hfmin = 15000;
 		fb_info.monspecs.hfmax = 38000;
 		fb_info.monspecs.vfmin = 49;
-- 
1.7.0.4


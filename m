From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 05 Jul 2018 13:52:17 +0000
Subject: [PATCH] fbdev: fix modedb docs in fb_find_mode
Message-Id: <20180705135217.12561-1-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Fix up the indenting that confused sphinx. To make sure we
don't have to make the examples unreadable with escaping just
put them in as block quotes, that seems the simplest solution.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/core/modedb.c | 62 ++++++++++++++++---------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 2510fa728d77..5ab8af271286 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -628,45 +628,47 @@ static int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
 }
 
 /**
- *     fb_find_mode - finds a valid video mode
- *     @var: frame buffer user defined part of display
- *     @info: frame buffer info structure
- *     @mode_option: string video mode to find
- *     @db: video mode database
- *     @dbsize: size of @db
- *     @default_mode: default video mode to fall back to
- *     @default_bpp: default color depth in bits per pixel
+ * fb_find_mode - finds a valid video mode
+ * @var: frame buffer user defined part of display
+ * @info: frame buffer info structure
+ * @mode_option: string video mode to find
+ * @db: video mode database
+ * @dbsize: size of @db
+ * @default_mode: default video mode to fall back to
+ * @default_bpp: default color depth in bits per pixel
  *
- *     Finds a suitable video mode, starting with the specified mode
- *     in @mode_option with fallback to @default_mode.  If
- *     @default_mode fails, all modes in the video mode database will
- *     be tried.
+ * Finds a suitable video mode, starting with the specified mode
+ * in @mode_option with fallback to @default_mode.  If
+ * @default_mode fails, all modes in the video mode database will
+ * be tried.
  *
- *     Valid mode specifiers for @mode_option:
+ * Valid mode specifiers for @mode_option::
  *
- *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m] or
- *     <name>[-<bpp>][@<refresh>]
+ *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m]
+ *
+ * or ::
  *
- *     with <xres>, <yres>, <bpp> and <refresh> decimal numbers and
- *     <name> a string.
+ *     <name>[-<bpp>][@<refresh>]
  *
- *      If 'M' is present after yres (and before refresh/bpp if present),
- *      the function will compute the timings using VESA(tm) Coordinated
- *      Video Timings (CVT).  If 'R' is present after 'M', will compute with
- *      reduced blanking (for flatpanels).  If 'i' is present, compute
- *      interlaced mode.  If 'm' is present, add margins equal to 1.8%
- *      of xres rounded down to 8 pixels, and 1.8% of yres. The char
- *      'i' and 'm' must be after 'M' and 'R'. Example:
+ * with <xres>, <yres>, <bpp> and <refresh> decimal numbers and
+ * <name> a string.
  *
- *      1024x768MR-8@60m - Reduced blank with margins at 60Hz.
+ * If 'M' is present after yres (and before refresh/bpp if present),
+ * the function will compute the timings using VESA(tm) Coordinated
+ * Video Timings (CVT).  If 'R' is present after 'M', will compute with
+ * reduced blanking (for flatpanels).  If 'i' is present, compute
+ * interlaced mode.  If 'm' is present, add margins equal to 1.8%
+ * of xres rounded down to 8 pixels, and 1.8% of yres. The char
+ * 'i' and 'm' must be after 'M' and 'R'. Example::
  *
- *     NOTE: The passed struct @var is _not_ cleared!  This allows you
- *     to supply values for e.g. the grayscale and accel_flags fields.
+ *     1024x768MR-8@60m - Reduced blank with margins at 60Hz.
  *
- *     Returns zero for failure, 1 if using specified @mode_option,
- *     2 if using specified @mode_option with an ignored refresh rate,
- *     3 if default mode is used, 4 if fall back to any valid mode.
+ * NOTE: The passed struct @var is _not_ cleared!  This allows you
+ * to supply values for e.g. the grayscale and accel_flags fields.
  *
+ * Returns zero for failure, 1 if using specified @mode_option,
+ * 2 if using specified @mode_option with an ignored refresh rate,
+ * 3 if default mode is used, 4 if fall back to any valid mode.
  */
 
 int fb_find_mode(struct fb_var_screeninfo *var,
-- 
2.18.0


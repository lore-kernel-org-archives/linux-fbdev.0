From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Mon, 07 May 2018 09:35:50 +0000
Subject: [PATCH 14/18] fbdev: modedb.c: fix a kernel-doc markup
Message-Id: <a712d724d034cedeab76335071f916808db77e7a.1525684985.git.mchehab+samsung@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Use code blocks to avoid those warnings and make it look nicer.

	./drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
	./drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
	./drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
	./drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/video/fbdev/core/modedb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 2510fa728d77..7284324fbd77 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -642,23 +642,23 @@ static int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
  *     @default_mode fails, all modes in the video mode database will
  *     be tried.
  *
- *     Valid mode specifiers for @mode_option:
+ *     Valid mode specifiers for @mode_option::
  *
- *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m] or
- *     <name>[-<bpp>][@<refresh>]
+ *       <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m] or
+ *       <name>[-<bpp>][@<refresh>]
  *
  *     with <xres>, <yres>, <bpp> and <refresh> decimal numbers and
  *     <name> a string.
  *
- *      If 'M' is present after yres (and before refresh/bpp if present),
- *      the function will compute the timings using VESA(tm) Coordinated
- *      Video Timings (CVT).  If 'R' is present after 'M', will compute with
- *      reduced blanking (for flatpanels).  If 'i' is present, compute
- *      interlaced mode.  If 'm' is present, add margins equal to 1.8%
- *      of xres rounded down to 8 pixels, and 1.8% of yres. The char
- *      'i' and 'm' must be after 'M' and 'R'. Example:
+ *     If 'M' is present after yres (and before refresh/bpp if present),
+ *     the function will compute the timings using VESA(tm) Coordinated
+ *     Video Timings (CVT).  If 'R' is present after 'M', will compute with
+ *     reduced blanking (for flatpanels).  If 'i' is present, compute
+ *     interlaced mode.  If 'm' is present, add margins equal to 1.8%
+ *     of xres rounded down to 8 pixels, and 1.8% of yres. The char
+ *     'i' and 'm' must be after 'M' and 'R'. Example::
  *
- *      1024x768MR-8@60m - Reduced blank with margins at 60Hz.
+ *       1024x768MR-8@60m - Reduced blank with margins at 60Hz.
  *
  *     NOTE: The passed struct @var is _not_ cleared!  This allows you
  *     to supply values for e.g. the grayscale and accel_flags fields.
-- 
2.17.0


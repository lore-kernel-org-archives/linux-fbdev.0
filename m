From: Hector Palacios <hector.palacios@digi.com>
Date: Fri, 07 Jun 2013 08:10:39 +0000
Subject: [PATCH] video: mxsfb: fix color settings for 18bit data bus and 32bpp
Message-Id: <51B1957F.40104@digi.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <519E03B0.1080006@digi.com> <519F4435.5010703@digi.com>
 <201305241300.25461.jbe@pengutronix.de>
 <201305241533.19941.jbe@pengutronix.de> <20130607072103.GF14209@lukather>
 <51B18BA0.50506@digi.com> <20130607074200.GG14209@lukather>
In-Reply-To: <20130607074200.GG14209@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

For a combination of 18bit LCD data bus width and a color
mode of 32bpp, the driver was setting the color mapping to
rgb666, which is wrong, as the color in memory realy has an
rgb888 layout.

This patch also removes the setting of flag CTRL_DF24 that
makes the driver dimiss the upper 2 bits when handling 32/24bpp
colors in a diplay with 18bit data bus width. This flag made
true color images display wrong in such configurations.

Finally, the color mapping rgb666 has also been removed as nobody
is using it and high level applications like Qt5 cannot work
with it either.

Reference: https://lkml.org/lkml/2013/5/23/220
Signed-off-by: Hector Palacios <hector.palacios@digi.com>
Acked-by: Juergen Beisert <jbe@pengutronix.de>
---
  drivers/video/mxsfb.c | 26 --------------------------
  1 file changed, 26 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 21223d4..d2c5105 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -239,24 +239,6 @@ static const struct fb_bitfield def_rgb565[] = {
  	}
  };

-static const struct fb_bitfield def_rgb666[] = {
-	[RED] = {
-		.offset = 16,
-		.length = 6,
-	},
-	[GREEN] = {
-		.offset = 8,
-		.length = 6,
-	},
-	[BLUE] = {
-		.offset = 0,
-		.length = 6,
-	},
-	[TRANSP] = {	/* no support for transparency */
-		.length = 0,
-	}
-};
-
  static const struct fb_bitfield def_rgb888[] = {
  	[RED] = {
  		.offset = 16,
@@ -309,9 +291,6 @@ static int mxsfb_check_var(struct fb_var_screeninfo *var,
  			break;
  		case STMLCDIF_16BIT:
  		case STMLCDIF_18BIT:
-			/* 24 bit to 18 bit mapping */
-			rgb = def_rgb666;
-			break;
  		case STMLCDIF_24BIT:
  			/* real 24 bit */
  			rgb = def_rgb888;
@@ -453,11 +432,6 @@ static int mxsfb_set_par(struct fb_info *fb_info)
  			return -EINVAL;
  		case STMLCDIF_16BIT:
  		case STMLCDIF_18BIT:
-			/* 24 bit to 18 bit mapping */
-			ctrl |= CTRL_DF24; /* ignore the upper 2 bits in
-					    *  each colour component
-					    */
-			break;
  		case STMLCDIF_24BIT:
  			/* real 24 bit */
  			break;
--
1.8.3



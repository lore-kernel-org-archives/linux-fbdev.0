From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 18 Jul 2018 03:03:27 +0000
Subject: [PATCH 6/6] vt: support bright backgrounds for \e[48m if unblinking
Message-Id: <20180718030327.579-6-kilobyte@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>

This improves schemes used by fancy new programs.  For example, it lets
bright powerline segments match, and fixes images shown by catimg being
striped to the point of unreadability.

Handling of 8-color backgrounds uses stripped 16-color value instead of a
dedicated formula; this works worse for dark and better for bright inputs.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c777f4c91df0..7fcb0ff2dccf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1555,7 +1555,7 @@ static void rgb_from_256(int i, struct rgb *c)
 		c->r = c->g = c->b = i * 10 - 2312;
 }
 
-static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
+static u8 rgb_to_16(const struct rgb *c)
 {
 	u8 hue = 0, max = max3(c->r, c->g, c->b);
 
@@ -1566,22 +1566,12 @@ static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
 	if (c->b > max / 2 + 32)
 		hue |= 1;
 
-	if (hue = 7 && max <= 0x70) {
-		hue = 0;
-		vc->vc_intensity = 2;
-	} else if (max > 0xc0)
-		vc->vc_intensity = 2;
+	if (hue = 7 && max <= 0x70)
+		return 8;
+	if (max > 0xc0)
+		return hue | 8;
 	else
-		vc->vc_intensity = 1;
-
-	vc->vc_color = (vc->vc_color & 0xf0) | hue;
-}
-
-static void rgb_background(struct vc_data *vc, const struct rgb *c)
-{
-	/* For backgrounds, err on the dark side. */
-	vc->vc_color = (vc->vc_color & 0x0f)
-		| (c->r&0x80) >> 1 | (c->g&0x80) >> 2 | (c->b&0x80) >> 3;
+		return hue;
 }
 
 /*
@@ -1593,10 +1583,10 @@ static void rgb_background(struct vc_data *vc, const struct rgb *c)
  * Subcommands 3 (CMY) and 4 (CMYK) are so insane there's no point in
  * supporting them.
  */
-static int vc_t416_color(struct vc_data *vc, int i,
-		void(*set_color)(struct vc_data *vc, const struct rgb *c))
+static int vc_t416_color(struct vc_data *vc, int i, int bgshift)
 {
 	struct rgb c;
+	u8 v;
 
 	i++;
 	if (i > vc->vc_npar)
@@ -1615,7 +1605,13 @@ static int vc_t416_color(struct vc_data *vc, int i,
 	} else
 		return i;
 
-	set_color(vc, &c);
+	v = rgb_to_16(&c);
+
+	vc->vc_color = (vc->vc_color & (0xf0 >> bgshift)) | v << bgshift;
+	if (!bgshift)
+		vc->vc_intensity = (v & 8 >> 4) + 1;
+	else if (vc->vc_unblinking)
+		vc->vc_blink = v & 8 >> 4;
 
 	return i;
 }
@@ -1695,10 +1691,10 @@ static void csi_m(struct vc_data *vc)
 			vc->vc_reverse = 0;
 			break;
 		case 38:
-			i = vc_t416_color(vc, i, rgb_foreground);
+			i = vc_t416_color(vc, i, 0);
 			break;
 		case 48:
-			i = vc_t416_color(vc, i, rgb_background);
+			i = vc_t416_color(vc, i, 4);
 			break;
 		case 39:
 			vc->vc_color = (vc->vc_def_color & 0x0f) |
-- 
2.18.0


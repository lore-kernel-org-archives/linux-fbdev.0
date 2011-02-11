From: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
Date: Fri, 11 Feb 2011 15:19:44 +0000
Subject: [PATCH 2/2] atmel_lcdfb: add fb_blank function
Message-Id: <1297437584-14048-2-git-send-email-biessmann@corscience.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297437584-14048-1-git-send-email-biessmann@corscience.de>
In-Reply-To: <1297437584-14048-1-git-send-email-biessmann@corscience.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: kernel@avr32linux.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>, "open list:ATMEL LCDFB DRIVER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Signed-off-by: Andreas Bie=C3=9Fmann <biessmann@corscience.de>
---
These are some older patches which are used in some of our systems. Heavy
merging pointed out these functionality was missed to push upstream.

 drivers/video/atmel_lcdfb.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 16da8af..59654e2 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -714,11 +714,35 @@ static int atmel_lcdfb_pan_display(struct fb_var_scre=
eninfo *var,
 	return 0;
 }
=20
+static int atmel_lcdfb_blank(int blank_mode, struct fb_info *info)
+{
+	struct atmel_lcdfb_info *sinfo =3D info->par;
+
+	switch (blank_mode) {
+	case FB_BLANK_UNBLANK:
+	case FB_BLANK_NORMAL:
+		atmel_lcdfb_start(sinfo);
+		break;
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+		break;
+	case FB_BLANK_POWERDOWN:
+		atmel_lcdfb_stop(sinfo);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* let fbcon do a soft blank for us */
+	return ((blank_mode =3D FB_BLANK_NORMAL) ? 1 : 0);
+}
+
 static struct fb_ops atmel_lcdfb_ops =3D {
 	.owner		=3D THIS_MODULE,
 	.fb_check_var	=3D atmel_lcdfb_check_var,
 	.fb_set_par	=3D atmel_lcdfb_set_par,
 	.fb_setcolreg	=3D atmel_lcdfb_setcolreg,
+	.fb_blank	=3D atmel_lcdfb_blank,
 	.fb_pan_display	=3D atmel_lcdfb_pan_display,
 	.fb_fillrect	=3D cfb_fillrect,
 	.fb_copyarea	=3D cfb_copyarea,
--=20
1.7.2.3


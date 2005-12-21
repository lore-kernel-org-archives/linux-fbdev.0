From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1: 2.6.15-rc5-mm3] Fix cyblafb: fillrect bugs and white
 space
Date: Wed, 21 Dec 2005 09:56:42 +0100
Message-ID: <43A918CA.9050409@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EozmK-00071P-Nk
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 00:56:56 -0800
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EozmJ-0002Gc-9g
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 00:56:56 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Cyblafb silently assumes that there is no drawing operation with
width > 4096 and height > 4096. This is ok for almost all cases as
monitors of such dimensions are uncommon ... I don=B4t know of such a
beast. But bit_clear_margins() tries to fill the entire right margin with
one call to the drivers fillrect function. In that case height > 4096 is
often true. This problem and also the basestride calculation is fixed
with this patch.

Some whitespace fixes are included, too.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxori=
g/drivers/video/cyblafb.c linux/drivers/video/cyblafb.c
--- linuxorig/drivers/video/cyblafb.c	2005-12-15 10:35:14.000000000 +0100
+++ linux/drivers/video/cyblafb.c	2005-12-21 09:14:45.000000000 +0100
@@ -23,7 +23,7 @@
 #include <asm/types.h>
 #include <video/cyblafb.h>
=20
-#define VERSION "0.60"
+#define VERSION "0.61"
=20
 struct cyblafb_par {
 	u32 pseudo_pal[16];
@@ -301,7 +301,7 @@ static void cyblafb_fillrect(struct fb_i
 			     const struct fb_fillrect *fr)
 {
 	int bpp =3D info->var.bits_per_pixel;
-	int col;
+	u32 col, height, desty;
=20
 	switch (bpp) {
 		default:
@@ -316,14 +316,24 @@ static void cyblafb_fillrect(struct fb_i
 			 break;
 	}
=20
-	out32(GEB8,basestride |
-		   (((fr->dy >> 3) * info->var.xres_virtual * bpp) >> 3));
-	out32(GE60,col);
-	out32(GE48,fr->rop ? 0x66:ROP_S);
-	out32(GE44,0x20000000|1<<19|1<<4|2<<2);
-	out32(GE08,point(fr->dx,0));
-	out32(GE0C,point(fr->dx+fr->width-1,(fr->dy % 8) + fr->height-1));
-
+	height =3D fr->height;
+	desty =3D fr->dy;
+	while(height) {
+		out32(GEB8,basestride | ((desty * info->var.xres_virtual *
+					bpp) >> 6));
+		out32(GE60,col);
+		out32(GE48,fr->rop ? 0x66:ROP_S);
+		out32(GE44,0x20000000|1<<19|1<<4|2<<2);
+		out32(GE08,point(fr->dx,0));
+		if (height > 4096) {
+			out32(GE0C,point(fr->dx+fr->width-1,4095));
+			height -=3D 4096;
+			desty +=3D 4096;
+		} else {
+			out32(GE0C,point(fr->dx+fr->width-1,height-1));
+			return;
+		}
+	}
 }
=20
 //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
@@ -357,7 +367,6 @@ static void cyblafb_copyarea(struct fb_i
 	out32(GE04,direction?s1:s2);
 	out32(GE08,direction?d2:d1);
 	out32(GE0C,direction?d1:d2);
-
 }
=20
 //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -421,8 +430,8 @@ static void cyblafb_imageblit(struct fb_
 			 break;
 	}
=20
-	out32(GEB8,basestride |
-		   ((image->dy * info->var.xres_virtual * bpp) >> 6));
+	out32(GEB8,basestride | ((image->dy * info->var.xres_virtual *
+				bpp) >> 6));
 	out32(GE60,fgcol);
 	out32(GE64,bgcol);
 	out32(GE44,0xa0000000 | 1<<20 | 1<<19);
@@ -462,7 +471,6 @@ static void cyblafb_imageblit(struct fb_
 static int cyblafb_check_var(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
-
 	int bpp =3D var->bits_per_pixel;
=20
 	//
@@ -555,7 +563,6 @@ static int cyblafb_check_var(struct fb_v
 	}
=20
 	return 0;
-
 }
=20
 //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -1001,14 +1008,14 @@ static int cyblafb_blank(int blank_mode,
 	if (displaytype =3D=3D DISPLAY_FP)
 		return 0;
=20
-	out8(0x83C8,0x04); 		// DPMS Control
+	out8(0x83C8,0x04);		// DPMS Control
 	PMCont =3D in8(0x83C6) & 0xFC;
=20
 	DPMSCont =3D read3CE(GR23) & 0xFC;
=20
 	switch (blank_mode)
 	{
-	case FB_BLANK_UNBLANK:       // Screen: On, HSync: On, VSync: On
+	case FB_BLANK_UNBLANK:	     // Screen: On, HSync: On, VSync: On
 	case FB_BLANK_NORMAL:	     // Screen: Off, HSync: On, VSync: On
 		PMCont |=3D 0x03;
 		DPMSCont |=3D 0x00;
@@ -1081,9 +1088,9 @@ static int __devinit getstartupmode(stru
 		int left_margin; int right_margin; int upper_margin;
 		int lower_margin; int hsync_len; int vsync_len;
 	}  modedb[5] =3D {
-		{   0, 2048,    0, 4096, 0, 0,   0,  0,  0, 0,   0,  0},
+		{   0, 2048,	0, 4096, 0, 0,	 0,  0,  0, 0,	 0,  0},
 		{ 640, 2048,  480, 4096, 0, 0, -40, 24, 17, 0, 216,  3},
-		{ 800, 2048,  600, 4096, 0, 0,  96, 24, 14, 0, 136, 11},
+		{ 800, 2048,  600, 4096, 0, 0,	96, 24, 14, 0, 136, 11},
 		{1024, 2048,  768, 4096, 0, 0, 144, 24, 29, 0, 120,  3},
 		{1280, 2048, 1024, 4096, 0, 0, 232, 16, 39, 0, 160,  3}
 	};
@@ -1224,7 +1231,6 @@ static int __devinit getstartupmode(stru
 	}
=20
 	return 0;
-
 }
=20
 //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick

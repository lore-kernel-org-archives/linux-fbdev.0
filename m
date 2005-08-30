From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1 2.6.13] framebuffer: bit_putcs() optimization for 8x*
 fonts
Date: Tue, 30 Aug 2005 18:15:12 +0200
Message-ID: <43148610.70406@t-online.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932195AbVH3QM2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jochen Hein <jochen@jochen.org>

This trivial patch gives a performance boost to the framebuffer console

Constructing the bitmaps that are given to the bitblit functions of the=
=20
framebuffer
drivers is time consuming. Here we avoide a call to the slow=20
fb_pad_aligned_buffer().
The patch replaces that call with a simple but much more efficient=20
bytewise copy.

The kernel spends a significant time at this place if you use 8x* fonts=
=2E=20
Every
pixel displayed on your screen is prepared here.

Some benchmark results:

Displaying a file of 2000 lines with 160 characters each takes 889 ms=20
system
time using  cyblafb on my system  (I=B4m using a 1280x1024 video mode,
resulting in a 160x64 character console)

Displaying the same file with the enclosed patch applied to 2.6.13 only=
=20
takes
760 ms system time, saving 129 ms or 14.5%.

=46ont widths other than 8 are not affected.

The advantage and correctness of this patch should be obvious.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxo=
rig/drivers/video/console/bitblit.c linux/drivers/video/console/bitblit=
=2Ec
--- linuxorig/drivers/video/console/bitblit.c	2005-08-29 01:41:01.00000=
0000 +0200
+++ linux/drivers/video/console/bitblit.c	2005-08-30 17:19:57.000000000=
 +0200
@@ -114,7 +114,7 @@ static void bit_putcs(struct vc_data *vc
 	unsigned int scan_align =3D info->pixmap.scan_align - 1;
 	unsigned int buf_align =3D info->pixmap.buf_align - 1;
 	unsigned int shift_low =3D 0, mod =3D vc->vc_font.width % 8;
-	unsigned int shift_high =3D 8, pitch, cnt, size, k;
+	unsigned int shift_high =3D 8, pitch, cnt, size, i, k;
 	unsigned int idx =3D vc->vc_font.width >> 3;
 	unsigned int attribute =3D get_attribute(info, scr_readw(s));
 	struct fb_image image;
@@ -175,7 +175,11 @@ static void bit_putcs(struct vc_data *vc
 					src =3D buf;
 				}
=20
-				fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
+				if (idx =3D=3D 1)
+					for(i=3D0; i < image.height; i++)
+						dst[pitch*i] =3D src[i];
+				else
+					fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
 				dst +=3D width;
 			}
 		}

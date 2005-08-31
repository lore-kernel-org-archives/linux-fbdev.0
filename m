From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Wed, 31 Aug 2005 14:46:35 +0200
Message-ID: <4315A6AB.5090108@t-online.de>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home> <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EARwK-0008Lo-P6
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Aug 2005 05:43:40 -0700
Received: from mailout08.sul.t-online.com ([194.25.134.20])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EARwK-0002nn-1H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Aug 2005 05:43:40 -0700
In-Reply-To: <Pine.LNX.4.61.0508310159290.3728@scrub.home>
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
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>, Geert Uytterhoeven <geert@linux-m68k.org>


>Something like below, which has the advantange that there is still only=20
>one implementation of the function
>
True, that=B4s a great advantage.

> and if it's still slower, we really need to check the compiler
> =20
>
Please have a look at the following patch. It takes your idea of=20
inlining but moves
the special cases into the macro, speeding things up for the very likely=20
case of
s_pitch =3D=3D 1 and the less likely case of s_pitch of 2. Treating s_pit=
ch=20
=3D=3D 2 special
gives a still significant performance improvement of more than 10 % for=20
16x30
fonts.

This way also bit_putcs looks better again ...

Andrew, as this way is better than and still as fast as my first=20
approach I think
framebuffer-bit_putcs-optimization-for-8x.patch should be reverted and th=
e
following patch should be applied instead.

Antonino, Roman, Geert, do you agree?


cu,
 knut

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxori=
g/drivers/video/console/bitblit.c linux/drivers/video/console/bitblit.c
--- linuxorig/drivers/video/console/bitblit.c	2005-08-29 01:41:01.0000000=
00 +0200
+++ linux/drivers/video/console/bitblit.c	2005-08-31 10:06:22.000000000 +=
0200
@@ -175,7 +175,7 @@ static void bit_putcs(struct vc_data *vc
 					src =3D buf;
 				}
=20
-				fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
+				__fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
 				dst +=3D width;
 			}
 		}
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxori=
g/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linuxorig/drivers/video/fbmem.c	2005-08-29 01:41:01.000000000 +0200
+++ linux/drivers/video/fbmem.c	2005-08-31 13:36:16.000000000 +0200
@@ -80,15 +80,7 @@ EXPORT_SYMBOL(fb_get_color_depth);
  */
 void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u=
32 height)
 {
-	int i, j;
-
-	for (i =3D height; i--; ) {
-		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
-		for (j =3D 0; j < s_pitch; j++)
-			dst[j] =3D src[j];
-		src +=3D s_pitch;
-		dst +=3D d_pitch;
-	}
+	__fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, height);
 }
 EXPORT_SYMBOL(fb_pad_aligned_buffer);
=20
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxori=
g/include/linux/fb.h linux/include/linux/fb.h
--- linuxorig/include/linux/fb.h	2005-08-29 01:41:01.000000000 +0200
+++ linux/include/linux/fb.h	2005-08-31 12:45:08.000000000 +0200
@@ -824,6 +824,38 @@ extern int fb_get_color_depth(struct fb_
 extern int fb_get_options(char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
=20
+
+/*
+ * Don't change without testing performance of framebuffer
+ * bitblitting. Inlining is necessary for performance reasons.
+ * Although the code might not _look_ fast because of some
+ * multiplications, it really _is_ fast as it is easier for gcc
+ * to optimize well.
+ */
+
+static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src=
,=20
+						u32 s_pitch, u32 height)
+{
+	int i, j;
+
+	if (likely(s_pitch=3D=3D1))
+		for(i=3D0; i < height; i++)
+			dst[d_pitch*i] =3D src[i];
+	else if (s_pitch=3D=3D2)
+		for(i=3D0; i < height; i++) {
+			*(u16 *)dst =3D ((u16 *)src)[i];
+			dst +=3D d_pitch;
+		}
+	else {
+		d_pitch -=3D s_pitch;
+		for (i =3D height; i--; ) {
+			for (j =3D 0; j < s_pitch; j++)
+				*dst++ =3D *src++;
+			dst +=3D d_pitch;
+		}
+	}
+}
+
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
=20






-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

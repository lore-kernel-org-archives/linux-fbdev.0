From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2 more fbcon rotation bugs
Date: Sun, 20 Nov 2005 11:48:08 +0800
Message-ID: <437FF1F8.9020307@gmail.com>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com> <437EFA9B.8090402@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdgCD-0002qS-Vw
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Nov 2005 19:48:53 -0800
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdgCD-0002Zm-GE
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Nov 2005 19:48:54 -0800
Received: by zproxy.gmail.com with SMTP id z3so458147nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Nov 2005 19:48:36 -0800 (PST)
In-Reply-To: <437EFA9B.8090402@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Antonino A. Daplas schrieb:
>=20

> New bug: Vesafb & rotation does show a bug that is not present using
> cyblafb & rotation and the 16x30
> bitstream font: When I start my favourite text editor sedt, the top row
> is coloured and contains some
> status information. Line two is in a different colour. Those areas of
> line 1 drawn with the bitblit
> functions are ok, but those areas drawn with the fillrect function are
> not completely coloured, the last
> (maybe the 2 last, don=B4t know) pixel rows of the area that should be
> coloured are still black.

It seems that cfbfillrect and cfbcopyarea were written in a big-endian
machine (if I'm not mistaken, by Geert on m68k?) as unaligned access in
little endian produces this bug.

Try this patch and let me know if this solves your problem.

Tony

diff --git a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
index cdc7157..dc7e210 100644
--- a/drivers/video/cfbcopyarea.c
+++ b/drivers/video/cfbcopyarea.c
@@ -64,8 +64,8 @@ bitcpy(unsigned long __iomem *dst, int d
 	int const shift =3D dst_idx-src_idx;
 	int left, right;
=20
-	first =3D ~0UL >> dst_idx;
-	last =3D ~(~0UL >> ((dst_idx+n) % bits));
+	first =3D SHIFT_HIGH(~0UL, dst_idx);
+	last =3D ~(SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
=20
 	if (!shift) {
 		// Same alignment for source and dest
@@ -216,8 +216,8 @@ bitcpy_rev(unsigned long __iomem *dst, i
=20
 	shift =3D dst_idx-src_idx;
=20
-	first =3D ~0UL << (bits - 1 - dst_idx);
-	last =3D ~(~0UL << (bits - 1 - ((dst_idx-n) % bits)));
+	first =3D SHIFT_LOW(~0UL, bits - 1 - dst_idx);
+	last =3D ~(SHIFT_LOW(~0UL, bits - 1 - ((dst_idx-n) % bits)));
=20
 	if (!shift) {
 		// Same alignment for source and dest
diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
index 167d931..495cdaf 100644
--- a/drivers/video/cfbfillrect.c
+++ b/drivers/video/cfbfillrect.c
@@ -110,8 +110,8 @@ bitfill_aligned(unsigned long __iomem *d
 	if (!n)
 		return;
=20
-	first =3D ~0UL >> dst_idx;
-	last =3D ~(~0UL >> ((dst_idx+n) % bits));
+	first =3D SHIFT_HIGH(~0UL, dst_idx);
+	last =3D ~(SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
=20
 	if (dst_idx+n <=3D bits) {
 		// Single word
@@ -167,8 +167,8 @@ bitfill_unaligned(unsigned long __iomem=20
 	if (!n)
 		return;
=20
-	first =3D ~0UL >> dst_idx;
-	last =3D ~(~0UL >> ((dst_idx+n) % bits));
+	first =3D SHIFT_HIGH(~0UL, dst_idx);
+	last =3D ~(SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
=20
 	if (dst_idx+n <=3D bits) {
 		// Single word
@@ -221,8 +221,8 @@ bitfill_aligned_rev(unsigned long __iome
 	if (!n)
 		return;
=20
-	first =3D ~0UL >> dst_idx;
-	last =3D ~(~0UL >> ((dst_idx+n) % bits));
+	first =3D SHIFT_HIGH(~0UL, dst_idx);
+	last =3D ~(SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
=20
 	if (dst_idx+n <=3D bits) {
 		// Single word
@@ -290,8 +290,8 @@ bitfill_unaligned_rev(unsigned long __io
 	if (!n)
 		return;
=20
-	first =3D ~0UL >> dst_idx;
-	last =3D ~(~0UL >> ((dst_idx+n) % bits));
+	first =3D SHIFT_HIGH(~0UL, dst_idx);
+	last =3D ~(SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
=20
 	if (dst_idx+n <=3D bits) {
 		// Single word
diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 7a01742..6a78340 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -76,18 +76,6 @@ static u32 cfb_tab32[] =3D {
 #define FB_WRITEL fb_writel
 #define FB_READL  fb_readl
=20
-#if defined (__BIG_ENDIAN)
-#define LEFT_POS(bpp)          (32 - bpp)
-#define SHIFT_HIGH(val, bits)  ((val) >> (bits))
-#define SHIFT_LOW(val, bits)   ((val) << (bits))
-#define BIT_NR(b)              (7 - (b))
-#else
-#define LEFT_POS(bpp)          (0)
-#define SHIFT_HIGH(val, bits)  ((val) << (bits))
-#define SHIFT_LOW(val, bits)   ((val) >> (bits))
-#define BIT_NR(b)              (b)
-#endif
-
 static inline void color_imageblit(const struct fb_image *image,=20
 				   struct fb_info *p, u8 __iomem *dst1,=20
 				   u32 start_index,
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 04a58f3..e44950e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -817,6 +817,18 @@ struct fb_info {
=20
 #endif
=20
+#if defined (__BIG_ENDIAN)
+#define LEFT_POS(bpp)          (32 - bpp)
+#define SHIFT_HIGH(val, bits)  ((val) >> (bits))
+#define SHIFT_LOW(val, bits)   ((val) << (bits))
+#define BIT_NR(b)              (7 - (b))
+#else
+#define LEFT_POS(bpp)          (0)
+#define SHIFT_HIGH(val, bits)  ((val) << (bits))
+#define SHIFT_LOW(val, bits)   ((val) >> (bits))
+#define BIT_NR(b)              (b)
+#endif
+
     /*
      *  `Generic' versions of the frame buffer device operations
      */


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick

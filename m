From: Antonino Daplas <adaplas@pol.net>
Subject: Re: RFC: Optimizing putcs()
Date: 07 Aug 2002 02:11:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1028657448.554.6.camel@daplas>
References: <20020806054957.44715.qmail@web13004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BDO0fV4YrTxKwCvz711f"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17c8kM-0002tD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 11:07:54 -0700
In-Reply-To: <20020806054957.44715.qmail@web13004.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: James Simmons <captain_delete@yahoo.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--=-BDO0fV4YrTxKwCvz711f
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-08-06 at 13:49, James Simmons wrote:

> Ah. Thank you for solving this problem for me. I
> haven't had time to figure it out. Also left to be
> done is 24 bpp support as well as drawing the penguin.
> 
I took a crack at adding support for bpp24 for the cfb_* drawing
functions.  I tried to keep the original code as much as possible, so
the result may not be optimal.  My test shows though that bpp24 should
be as fast as (maybe a tad slower than) bpp32.

As for drawing the logo, will the source be containing indices to the
palette?

Tony



--=-BDO0fV4YrTxKwCvz711f
Content-Disposition: attachment; filename=bpp24.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=bpp24.diff; charset=ISO-8859-1

diff -Naur linux-2.5.27/drivers/video/cfbcopyarea.c linux/drivers/video/cfb=
copyarea.c
--- linux-2.5.27/drivers/video/cfbcopyarea.c	Tue Aug  6 17:55:48 2002
+++ linux/drivers/video/cfbcopyarea.c	Tue Aug  6 17:56:19 2002
@@ -83,7 +83,7 @@
 		lineincr =3D -linesize;
 	}
=20
-	if ((BITS_PER_LONG % p->var.bits_per_pixel) =3D=3D 0) {
+	if ((BITS_PER_LONG % p->var.bits_per_pixel) =3D=3D 0) {=20
 		int ppw =3D BITS_PER_LONG / p->var.bits_per_pixel;
 		int n =3D ((area->width * p->var.bits_per_pixel) >> 3);
=20
@@ -103,7 +103,6 @@
 			n -=3D end_index;
 		}
 		n /=3D bpl;
-
 		if (n <=3D 0) {
 			if (start_mask) {
 				if (end_mask)
@@ -219,4 +218,32 @@
 			}
 		}
 	}
+	else {
+		int n =3D ((area->width * p->var.bits_per_pixel) >> 3);
+		int n16 =3D (n16 >> 4) << 4;
+		int n_fract =3D n - n16;
+		int rows;
+
+		if (area->dy < area->sy
+		    || (area->dy =3D=3D area->sy && area->dx < area->sx)) {
+			for (rows =3D height; rows--; ) {
+				if (n16)
+					fast_memmove(dst1, src1, n16);
+				if (n_fract)
+					fb_memmove(dst1+n16, src1+n16, n_fract);
+				dst1 +=3D linesize;
+				src1 +=3D linesize;
+			}
+		}
+		else {
+			for (rows =3D height; rows--; ) {
+				if (n16)
+					fast_memmove(dst1, src1, n16);
+				if (n_fract)
+					fb_memmove(dst1+n16, src1+n16, n_fract);
+				dst1 -=3D linesize;
+				src1 -=3D linesize;
+			}
+		}
+	}		=09
 }
diff -Naur linux-2.5.27/drivers/video/cfbfillrect.c linux/drivers/video/cfb=
fillrect.c
--- linux-2.5.27/drivers/video/cfbfillrect.c	Tue Aug  6 17:55:54 2002
+++ linux/drivers/video/cfbfillrect.c	Tue Aug  6 17:56:23 2002
@@ -57,7 +57,7 @@
 	else
 		fg =3D fgcolor =3D rect->color;
=20
-	for (i =3D 0; i < ppw - 1; i++) {
+	for (i =3D 0; i < ppw-1; i++) {
 		fg <<=3D p->var.bits_per_pixel;
 		fg |=3D fgcolor;
 	}
@@ -161,45 +161,31 @@
 			break;
 		}
 	} else {
-		/* Odd modes like 24 or 80 bits per pixel */
-		start_mask =3D fg >> (start_index * p->var.bits_per_pixel);
-		end_mask =3D fg << (end_index * p->var.bits_per_pixel);
-		/* start_mask =3D& PFILL24(x1,fg);
-		   end_mask_or =3D end_mask & PFILL24(x1+width-1,fg); */
-
-		n =3D (rect->width - start_index - end_index) / ppw;
+		char *dst2;
+		int bytes =3D (p->var.bits_per_pixel + 7) >> 3;
=20
+		n =3D rect->width;
+		fg =3D fgcolor;
 		switch (rect->rop) {
 		case ROP_COPY:
 			do {
-				dst =3D (unsigned long *) dst1;
-				if (start_mask)
-					*dst |=3D start_mask;
-				if ((start_index + rect->width) > ppw)
-					dst++;
-
+				dst2 =3D dst1;
 				/* XXX: slow */
+				/* YYY: extremely slow */
 				for (i =3D 0; i < n; i++) {
-					*dst++ =3D fg;
+					*(unsigned long *) dst2 =3D fg;
+					dst2 +=3D bytes;
 				}
-				if (end_mask)
-					*dst |=3D end_mask;
 				dst1 +=3D linesize;
 			} while (--height);
 			break;
 		case ROP_XOR:
 			do {
-				dst =3D (unsigned long *) dst1;
-				if (start_mask)
-					*dst ^=3D start_mask;
-				if ((start_mask + rect->width) > ppw)
-					dst++;
-
+				dst2 =3D dst1;
 				for (i =3D 0; i < n; i++) {
-					*dst++ ^=3D fg;	/* PFILL24(fg,x1+i); */
+					*(unsigned long *) dst2 ^=3D fg;	/* PFILL24(fg,x1+i); */
+					dst2 +=3D bytes;
 				}
-				if (end_mask)
-					*dst ^=3D end_mask;
 				dst1 +=3D linesize;
 			} while (--height);
 			break;
diff -Naur linux-2.5.27/drivers/video/cfbimgblt.c linux/drivers/video/cfbim=
gblt.c
--- linux-2.5.27/drivers/video/cfbimgblt.c	Tue Aug  6 17:55:41 2002
+++ linux/drivers/video/cfbimgblt.c	Tue Aug  6 17:56:14 2002
@@ -47,9 +47,8 @@
 	int x2, y2, n, i, j, k, l =3D 7;
 	unsigned long tmp =3D ~0 << (BITS_PER_LONG - p->var.bits_per_pixel);
 	unsigned long fgx, bgx, fgcolor, bgcolor, eorx;=09
-	unsigned long end_mask;
-	unsigned long *dst =3D NULL;
-	u8 *dst1;
+	unsigned long end_mask, bytes =3D 4;
+	u8 *dst =3D NULL, *dst1;
 	u8 *src;
=20
 	/*=20
@@ -64,7 +63,7 @@
 	y2 =3D y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
 	image->width  =3D x2 - image->dx;
 	image->height =3D y2 - image->dy;
- =20
+
 	dst1 =3D p->screen_base + image->dy * p->fix.line_length +=20
 		((image->dx * p->var.bits_per_pixel) >> 3);
  =20
@@ -88,13 +87,26 @@
 			fgx |=3D fgcolor;
 			bgx |=3D bgcolor;
 		}
-		eorx =3D fgx ^ bgx;
+
+		/*
+		 * BPP kludge, should be generalized/optimized later
+		 */
+		if (BITS_PER_LONG % p->var.bits_per_pixel) {
+			bytes =3D (p->var.bits_per_pixel + 7) >> 3;
+			tmp =3D ~0UL >> (BITS_PER_LONG - p->var.bits_per_pixel);
+			fgx =3D fgcolor;
+			bgx =3D bgcolor;
+			ppw =3D 1;
+		}
+
 		n =3D ((image->width + 7) >> 3);
 		pad =3D (n << 3) - image->width;
 		n =3D image->width % ppw;
=20
+		eorx =3D fgx ^ bgx;
+	=09
 		for (i =3D 0; i < image->height; i++) {
-			dst =3D (unsigned long *) dst1;
+			dst =3D dst1;
 	=09
 			for (j =3D image->width/ppw; j > 0; j--) {
 				end_mask =3D 0;
@@ -105,8 +117,8 @@
 					l--;
 					if (l < 0) { l =3D 7; src++; }
 				}
-				fb_writel((end_mask & eorx)^bgx, dst);
-				dst++;
+				fb_writel((end_mask & eorx)^bgx, (unsigned long *) dst);
+				dst +=3D bytes;
 			}
 	=09
 			if (n) {
@@ -117,8 +129,8 @@
 					l--;
 					if (l < 0) { l =3D 7; src++; }
 				}
-				fb_writel((end_mask & eorx)^bgx, dst);
-				dst++;
+				fb_writel((end_mask & eorx)^bgx, (unsigned long *) dst);
+				dst +=3D bytes;
 			}
 			l -=3D pad;	=09
 			dst1 +=3D p->fix.line_length;=09

--=-BDO0fV4YrTxKwCvz711f--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

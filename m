From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] tridentfb: remove misplaced
	enable_mmio()
Date: Fri, 02 May 2008 11:15:27 +0200
Message-ID: <481adbafcaaba@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part481adbafcd1d6"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrrMb-0007rS-PS for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 02:15:33 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JrrMa-0000kQ-B4
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 02:15:33 -0700
Received: from poczta-19.free.wp-sa.pl (HELO localhost) ([10.1.1.98])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 2 May 2008 11:15:27 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

This is a multi-part message in MIME format.

--part481adbafcd1d6
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes redundant enable_mmio() call as
the mmio mode is enabled in the probe function earlier.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

If the patch below is mangled by email client it is also attached.

diff -urp linux-old/drivers/video/tridentfb.c=20
linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-01 11:19:02.000000000=20
+0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-01 18:06:31.000000000 +020=
0
@@ -905,7 +905,6 @@ static int tridentfb_set_par(struct fb_i
 	vblankstart =3D var->yres;
 	vblankend =3D vtotal + 2;
=20
-	enable_mmio();
 	crtc_unlock();
 	write3CE(CyberControl, 8);

----------------------------------------------------
Kociaki prosto z wybieg=F3w mody? =20
Ciu=B3a=B3a lepsze ni=BF Paris!=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fkonkurs.ulubiency.wp.pl&sid=3D335

--part481adbafcd1d6
Content-Type: application/octet-stream; name="tridentfb-remove-mmio.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tridentfb-remove-mmio.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggcmVt
b3ZlcyByZWR1bmRhbnQgZW5hYmxlX21taW8oKSBjYWxsIGFzCnRoZSBtbWlvIG1vZGUgaXMgZW5h
YmxlZCBpbiB0aGUgcHJvYmUgZnVuY3Rpb24gZWFybGllci4KClNpZ25lZC1vZmYtYnk6IEtyenlz
enRvZiBIZWx0IDxrcnp5c3p0b2YuaDFAd3AucGw+CgpkaWZmIC11cnAgbGludXgtb2xkL2RyaXZl
cnMvdmlkZW8vdHJpZGVudGZiLmMgbGludXgtcGMvZHJpdmVycy92aWRlby90cmlkZW50ZmIuYwot
LS0gbGludXgtb2xkL2RyaXZlcnMvdmlkZW8vdHJpZGVudGZiLmMJMjAwOC0wNS0wMSAxMToxOTow
Mi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LXBjL2RyaXZlcnMvdmlkZW8vdHJpZGVudGZiLmMJ
MjAwOC0wNS0wMSAxODowNjozMS4wMDAwMDAwMDAgKzAyMDAKQEAgLTkwNSw3ICs5MDUsNiBAQCBz
dGF0aWMgaW50IHRyaWRlbnRmYl9zZXRfcGFyKHN0cnVjdCBmYl9pCiAJdmJsYW5rc3RhcnQgPSB2
YXItPnlyZXM7CiAJdmJsYW5rZW5kID0gdnRvdGFsICsgMjsKIAotCWVuYWJsZV9tbWlvKCk7CiAJ
Y3J0Y191bmxvY2soKTsKIAl3cml0ZTNDRShDeWJlckNvbnRyb2wsIDgpOwogCg==

--part481adbafcd1d6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--part481adbafcd1d6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part481adbafcd1d6--

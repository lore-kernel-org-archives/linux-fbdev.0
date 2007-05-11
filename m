From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: RDAC_WR barriers clean up
Date: Fri, 11 May 2007 08:47:53 +0200
Message-ID: <464411993b718@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part464411993cd70"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmOuy-0008Er-C9 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 23:48:05 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HmOux-0004aa-HK
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 23:47:56 -0700
Received: from poczta-11.free.wp-sa.pl (HELO localhost) ([10.1.1.31])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	11 May 2007 08:47:53 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part464411993cd70
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes a possible barriers problem in RDAC_WR
functions, then remove redudant ones.

It also removes one unneeded register load from blitter function().

Signed-off-by: Krzysztof.Helt <krzysztof.h1@wp.pl>

---

This patch requires the linux-2.6.11-git11 with the patch "pm2fb:
fb_sync added" already sent to mm tree.

Regards,
Krzysztof

diff -urp linux-2.6.21.orig/drivers/video/pm2fb.c
linux-2.6.21/drivers/video/pm2fb.c
--- linux-2.6.21.orig/drivers/video/pm2fb.c	2007-05-10
21:12:40.474644774 +0200
+++ linux-2.6.21/drivers/video/pm2fb.c	2007-05-10
21:21:07.530491360 +0200
@@ -183,15 +183,17 @@ static inline void pm2_RDAC_WR(struct pm
 		index =3D PM2VR_RD_INDEXED_DATA;
 		break;
 	}=09
-	mb();
+	wmb();
 	pm2_WR(p, index, v);
+	wmb();
 }
=20
 static inline void pm2v_RDAC_WR(struct pm2fb_par* p, s32 idx, u32 v)
 {
 	pm2_WR(p, PM2VR_RD_INDEX_LOW, idx & 0xff);
-	mb();
+	wmb();
 	pm2_WR(p, PM2VR_RD_INDEXED_DATA, v);
+	wmb();
 }
=20
 #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
@@ -466,11 +468,9 @@ static void set_memclock(struct pm2fb_pa
 		WAIT_FIFO(par, 8);
 		pm2_WR(par, PM2VR_RD_INDEX_HIGH, PM2VI_RD_MCLK_CONTROL >> 8);
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_CONTROL, 0);
-		wmb();
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_PRESCALE, m);
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_FEEDBACK, n);
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_POSTSCALE, p);
-		wmb();
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_CONTROL, 1);
 		rmb();
 		for (i =3D 256;
@@ -483,12 +483,9 @@ static void set_memclock(struct pm2fb_pa
 		pm2_mnp(clk, &m, &n, &p);
 		WAIT_FIFO(par, 10);
 		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 6);
-		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_1, m);
 		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_2, n);
-		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 8|p);
-		wmb();
 		pm2_RDAC_RD(par, PM2I_RD_MEMORY_CLOCK_STATUS);
 		rmb();
 		for (i =3D 256;
@@ -509,12 +506,9 @@ static void set_pixclock(struct pm2fb_pa
 		pm2_mnp(clk, &m, &n, &p);
 		WAIT_FIFO(par, 8);
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A3, 0);
-		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A1, m);
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A2, n);
-		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A3, 8|p);
-		wmb();
 		pm2_RDAC_RD(par, PM2I_RD_PIXEL_CLOCK_STATUS);
 		rmb();
 		for (i =3D 256;
@@ -1066,10 +1060,9 @@ static void pm2fb_block_op(struct fb_inf
=20
 	if (!w || !h)
 		return;
-	WAIT_FIFO(par, 6);
+	WAIT_FIFO(par, 5);
 	pm2_WR(par, PM2R_CONFIG, PM2F_CONFIG_FB_WRITE_ENABLE |
 		PM2F_CONFIG_FB_READ_SOURCE_ENABLE);
-	pm2_WR(par, PM2R_FB_PIXEL_OFFSET, 0);
 	if (copy)
 		pm2_WR(par, PM2R_FB_SOURCE_DELTA,
 			((ysrc-y) & 0xfff) << 16 | ((xsrc-x) & 0xfff));


----------------------------------------------------
Bebe Lilly - "M=F3j =B6wiat". Ta p=B3yta rozbawi Twoje dziecko!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fbebe.html&=
sid=3D1135

--part464411993cd70
Content-Type: text/x-patch; name="pm2fb-barriers.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-barriers.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vcG0yZmIuYyBsaW51eC0y
LjYuMjEvZHJpdmVycy92aWRlby9wbTJmYi5jCi0tLSBsaW51eC0yLjYuMjEub3JpZy9kcml2ZXJz
L3ZpZGVvL3BtMmZiLmMJMjAwNy0wNS0xMCAyMToxMjo0MC40NzQ2NDQ3NzQgKzAyMDAKKysrIGxp
bnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVvL3BtMmZiLmMJMjAwNy0wNS0xMCAyMToyMTowNy41MzA0
OTEzNjAgKzAyMDAKQEAgLTE4MywxNSArMTgzLDE3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwbTJf
UkRBQ19XUihzdHJ1Y3QgcG0KIAkJaW5kZXggPSBQTTJWUl9SRF9JTkRFWEVEX0RBVEE7CiAJCWJy
ZWFrOwogCX0JCi0JbWIoKTsKKwl3bWIoKTsKIAlwbTJfV1IocCwgaW5kZXgsIHYpOworCXdtYigp
OwogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgcG0ydl9SREFDX1dSKHN0cnVjdCBwbTJmYl9wYXIq
IHAsIHMzMiBpZHgsIHUzMiB2KQogewogCXBtMl9XUihwLCBQTTJWUl9SRF9JTkRFWF9MT1csIGlk
eCAmIDB4ZmYpOwotCW1iKCk7CisJd21iKCk7CiAJcG0yX1dSKHAsIFBNMlZSX1JEX0lOREVYRURf
REFUQSwgdik7CisJd21iKCk7CiB9CiAKICNpZmRlZiBDT05GSUdfRkJfUE0yX0ZJRk9fRElTQ09O
TkVDVApAQCAtNDY2LDExICs0NjgsOSBAQCBzdGF0aWMgdm9pZCBzZXRfbWVtY2xvY2soc3RydWN0
IHBtMmZiX3BhCiAJCVdBSVRfRklGTyhwYXIsIDgpOwogCQlwbTJfV1IocGFyLCBQTTJWUl9SRF9J
TkRFWF9ISUdILCBQTTJWSV9SRF9NQ0xLX0NPTlRST0wgPj4gOCk7CiAJCXBtMnZfUkRBQ19XUihw
YXIsIFBNMlZJX1JEX01DTEtfQ09OVFJPTCwgMCk7Ci0JCXdtYigpOwogCQlwbTJ2X1JEQUNfV1Io
cGFyLCBQTTJWSV9SRF9NQ0xLX1BSRVNDQUxFLCBtKTsKIAkJcG0ydl9SREFDX1dSKHBhciwgUE0y
VklfUkRfTUNMS19GRUVEQkFDSywgbik7CiAJCXBtMnZfUkRBQ19XUihwYXIsIFBNMlZJX1JEX01D
TEtfUE9TVFNDQUxFLCBwKTsKLQkJd21iKCk7CiAJCXBtMnZfUkRBQ19XUihwYXIsIFBNMlZJX1JE
X01DTEtfQ09OVFJPTCwgMSk7CiAJCXJtYigpOwogCQlmb3IgKGkgPSAyNTY7CkBAIC00ODMsMTIg
KzQ4Myw5IEBAIHN0YXRpYyB2b2lkIHNldF9tZW1jbG9jayhzdHJ1Y3QgcG0yZmJfcGEKIAkJcG0y
X21ucChjbGssICZtLCAmbiwgJnApOwogCQlXQUlUX0ZJRk8ocGFyLCAxMCk7CiAJCXBtMl9SREFD
X1dSKHBhciwgUE0ySV9SRF9NRU1PUllfQ0xPQ0tfMywgNik7Ci0JCXdtYigpOwogCQlwbTJfUkRB
Q19XUihwYXIsIFBNMklfUkRfTUVNT1JZX0NMT0NLXzEsIG0pOwogCQlwbTJfUkRBQ19XUihwYXIs
IFBNMklfUkRfTUVNT1JZX0NMT0NLXzIsIG4pOwotCQl3bWIoKTsKIAkJcG0yX1JEQUNfV1IocGFy
LCBQTTJJX1JEX01FTU9SWV9DTE9DS18zLCA4fHApOwotCQl3bWIoKTsKIAkJcG0yX1JEQUNfUkQo
cGFyLCBQTTJJX1JEX01FTU9SWV9DTE9DS19TVEFUVVMpOwogCQlybWIoKTsKIAkJZm9yIChpID0g
MjU2OwpAQCAtNTA5LDEyICs1MDYsOSBAQCBzdGF0aWMgdm9pZCBzZXRfcGl4Y2xvY2soc3RydWN0
IHBtMmZiX3BhCiAJCXBtMl9tbnAoY2xrLCAmbSwgJm4sICZwKTsKIAkJV0FJVF9GSUZPKHBhciwg
OCk7CiAJCXBtMl9SREFDX1dSKHBhciwgUE0ySV9SRF9QSVhFTF9DTE9DS19BMywgMCk7Ci0JCXdt
YigpOwogCQlwbTJfUkRBQ19XUihwYXIsIFBNMklfUkRfUElYRUxfQ0xPQ0tfQTEsIG0pOwogCQlw
bTJfUkRBQ19XUihwYXIsIFBNMklfUkRfUElYRUxfQ0xPQ0tfQTIsIG4pOwotCQl3bWIoKTsKIAkJ
cG0yX1JEQUNfV1IocGFyLCBQTTJJX1JEX1BJWEVMX0NMT0NLX0EzLCA4fHApOwotCQl3bWIoKTsK
IAkJcG0yX1JEQUNfUkQocGFyLCBQTTJJX1JEX1BJWEVMX0NMT0NLX1NUQVRVUyk7CiAJCXJtYigp
OwogCQlmb3IgKGkgPSAyNTY7CkBAIC0xMDY2LDEwICsxMDYwLDkgQEAgc3RhdGljIHZvaWQgcG0y
ZmJfYmxvY2tfb3Aoc3RydWN0IGZiX2luZgogCiAJaWYgKCF3IHx8ICFoKQogCQlyZXR1cm47Ci0J
V0FJVF9GSUZPKHBhciwgNik7CisJV0FJVF9GSUZPKHBhciwgNSk7CiAJcG0yX1dSKHBhciwgUE0y
Ul9DT05GSUcsIFBNMkZfQ09ORklHX0ZCX1dSSVRFX0VOQUJMRSB8CiAJCVBNMkZfQ09ORklHX0ZC
X1JFQURfU09VUkNFX0VOQUJMRSk7Ci0JcG0yX1dSKHBhciwgUE0yUl9GQl9QSVhFTF9PRkZTRVQs
IDApOwogCWlmIChjb3B5KQogCQlwbTJfV1IocGFyLCBQTTJSX0ZCX1NPVVJDRV9ERUxUQSwKIAkJ
CSgoeXNyYy15KSAmIDB4ZmZmKSA8PCAxNiB8ICgoeHNyYy14KSAmIDB4ZmZmKSk7Cg==

--part464411993cd70
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part464411993cd70
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part464411993cd70--

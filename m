From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] s3c2410fb: fix missing registers offset
Date: Sun, 12 Aug 2007 14:29:33 +0200
Message-ID: <46befd2d3f4e5@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46befd2d41bfa"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKCZg-0003zZ-Dj for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 12 Aug 2007 05:29:40 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IKCZd-0005Wt-Lc
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 12 Aug 2007 05:29:40 -0700
Received: from poczta-11.free.wp-sa.pl (HELO localhost) ([10.1.1.31])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	12 Aug 2007 14:29:33 +0200
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
Cc: ben-linux@fluff.org

This is a multi-part message in MIME format.

--part46befd2d41bfa
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds missing virtual register offsets where=20
appropriate. This fixes crashes in the driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires all s3c2410fb patches sent to this list=20
(including set of patches which replaces register values with=20
more descriptive ones).

diff -urp linux-2.6.23.old/drivers/video/s3c2410fb.c linux-2.6.
23/drivers/video/s3c2410fb.c
--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-12 07:
56:49.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-12 13:56:
34.000000000 +0200
@@ -123,6 +123,8 @@ static void s3c2410fb_set_lcdaddr(struct
 {
 	unsigned long saddr1, saddr2, saddr3;
 	int line_length =3D info->var.xres * info->var.
bits_per_pixel;
+	struct s3c2410fb_info *fbi =3D info->par;
+	void __iomem *regs =3D fbi->io;
=20
 	saddr1  =3D info->fix.smem_start >> 1;
 	saddr2  =3D info->fix.smem_start;
@@ -136,9 +138,9 @@ static void s3c2410fb_set_lcdaddr(struct
 	dprintk("LCDSADDR2 =3D 0x%08lx\n", saddr2);
 	dprintk("LCDSADDR3 =3D 0x%08lx\n", saddr3);
=20
-	writel(saddr1, S3C2410_LCDSADDR1);
-	writel(saddr2, S3C2410_LCDSADDR2);
-	writel(saddr3, S3C2410_LCDSADDR3);
+	writel(saddr1, regs + S3C2410_LCDSADDR1);
+	writel(saddr2, regs + S3C2410_LCDSADDR2);
+	writel(saddr3, regs + S3C2410_LCDSADDR3);
 }
=20
 /* s3c2410fb_calc_pixclk()
@@ -409,6 +411,7 @@ static void s3c2410fb_calculate_tft_lcd_
 static void s3c2410fb_activate_var(struct fb_info *info)
 {
 	struct s3c2410fb_info *fbi =3D info->par;
+	void __iomem *regs =3D fbi->io;
 	struct fb_var_screeninfo *var =3D &info->var;
 	struct s3c2410fb_mach_info *mach_info =3D fbi->mach_info;
 	struct s3c2410fb_display *display =3D mach_info->displays +
@@ -449,16 +452,17 @@ static void s3c2410fb_activate_var(struc
 	dprintk("lcdcon[4] =3D 0x%08lx\n", fbi->regs.lcdcon4);
 	dprintk("lcdcon[5] =3D 0x%08lx\n", fbi->regs.lcdcon5);
=20
-	writel(fbi->regs.lcdcon1 & ~S3C2410_LCDCON1_ENVID,=20
S3C2410_LCDCON1);
-	writel(fbi->regs.lcdcon2, S3C2410_LCDCON2);
-	writel(fbi->regs.lcdcon3, S3C2410_LCDCON3);
-	writel(fbi->regs.lcdcon4, S3C2410_LCDCON4);
-	writel(fbi->regs.lcdcon5, S3C2410_LCDCON5);
+	writel(fbi->regs.lcdcon1 & ~S3C2410_LCDCON1_ENVID,
+		regs + S3C2410_LCDCON1);
+	writel(fbi->regs.lcdcon2, regs + S3C2410_LCDCON2);
+	writel(fbi->regs.lcdcon3, regs + S3C2410_LCDCON3);
+	writel(fbi->regs.lcdcon4, regs + S3C2410_LCDCON4);
+	writel(fbi->regs.lcdcon5, regs + S3C2410_LCDCON5);
=20
 	/* set lcd address pointers */
 	s3c2410fb_set_lcdaddr(info);
=20
-	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
+	writel(fbi->regs.lcdcon1, regs + S3C2410_LCDCON1);
 }
=20
 /*
@@ -527,6 +531,7 @@ static int s3c2410fb_setcolreg(unsigned=20
 			       unsigned transp, struct fb_info *info)
 {
 	struct s3c2410fb_info *fbi =3D info->par;
+	void __iomem *regs =3D fbi->io;
 	unsigned int val;
=20
 	/* dprintk("setcol: regno=3D%d, rgb=3D%d,%d,%d\n",
@@ -555,7 +560,7 @@ static int s3c2410fb_setcolreg(unsigned=20
 			val |=3D ((green >>  5) & 0x07e0);
 			val |=3D ((blue  >> 11) & 0x001f);
=20
-			writel(val, S3C2410_TFTPAL(regno));
+			writel(val, regs + S3C2410_TFTPAL(regno));
 			schedule_palette_update(fbi, regno, val);
 		}
=20
@@ -586,16 +591,19 @@ static int s3c2410fb_setcolreg(unsigned=20
  */
 static int s3c2410fb_blank(int blank_mode, struct fb_info *info)
 {
+	struct s3c2410fb_info *fbi =3D info->par;
+	void __iomem *regs =3D fbi->io;
+
 	dprintk("blank(mode=3D%d, info=3D%p)\n", blank_mode, info);
=20
 	if (mach_info =3D=3D NULL)
 		return -EINVAL;
=20
 	if (blank_mode =3D=3D FB_BLANK_UNBLANK)
-		writel(0x0, S3C2410_TPAL);
+		writel(0x0, regs + S3C2410_TPAL);
 	else {
 		dprintk("setting TPAL to output 0x000000\n");
-		writel(S3C2410_TPAL_EN, S3C2410_TPAL);
+		writel(S3C2410_TPAL_EN, regs + S3C2410_TPAL);
 	}
=20
 	return 0;


----------------------------------------------------
DOROTA GORJAINOW dla niej teatr to pasja.=20
=A6ci=B1gnij ZA DARMO i pos=B3uchaj MP3!=20
Kliknij: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd=
orotagorjainow.html&sid=3D1253

--part46befd2d41bfa
Content-Type: application/octet-stream; name="s3c2410fb-missing-offsets.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="s3c2410fb-missing-offsets.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYyBsaW51
eC0yLjYuMjMvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9k
cml2ZXJzL3ZpZGVvL3MzYzI0MTBmYi5jCTIwMDctMDgtMTIgMDc6NTY6NDkuMDAwMDAwMDAwICsw
MjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYwkyMDA3LTA4LTEy
IDEzOjU2OjM0LjAwMDAwMDAwMCArMDIwMApAQCAtMTIzLDYgKzEyMyw4IEBAIHN0YXRpYyB2b2lk
IHMzYzI0MTBmYl9zZXRfbGNkYWRkcihzdHJ1Y3QKIHsKIAl1bnNpZ25lZCBsb25nIHNhZGRyMSwg
c2FkZHIyLCBzYWRkcjM7CiAJaW50IGxpbmVfbGVuZ3RoID0gaW5mby0+dmFyLnhyZXMgKiBpbmZv
LT52YXIuYml0c19wZXJfcGl4ZWw7CisJc3RydWN0IHMzYzI0MTBmYl9pbmZvICpmYmkgPSBpbmZv
LT5wYXI7CisJdm9pZCBfX2lvbWVtICpyZWdzID0gZmJpLT5pbzsKIAogCXNhZGRyMSAgPSBpbmZv
LT5maXguc21lbV9zdGFydCA+PiAxOwogCXNhZGRyMiAgPSBpbmZvLT5maXguc21lbV9zdGFydDsK
QEAgLTEzNiw5ICsxMzgsOSBAQCBzdGF0aWMgdm9pZCBzM2MyNDEwZmJfc2V0X2xjZGFkZHIoc3Ry
dWN0CiAJZHByaW50aygiTENEU0FERFIyID0gMHglMDhseFxuIiwgc2FkZHIyKTsKIAlkcHJpbnRr
KCJMQ0RTQUREUjMgPSAweCUwOGx4XG4iLCBzYWRkcjMpOwogCi0Jd3JpdGVsKHNhZGRyMSwgUzND
MjQxMF9MQ0RTQUREUjEpOwotCXdyaXRlbChzYWRkcjIsIFMzQzI0MTBfTENEU0FERFIyKTsKLQl3
cml0ZWwoc2FkZHIzLCBTM0MyNDEwX0xDRFNBRERSMyk7CisJd3JpdGVsKHNhZGRyMSwgcmVncyAr
IFMzQzI0MTBfTENEU0FERFIxKTsKKwl3cml0ZWwoc2FkZHIyLCByZWdzICsgUzNDMjQxMF9MQ0RT
QUREUjIpOworCXdyaXRlbChzYWRkcjMsIHJlZ3MgKyBTM0MyNDEwX0xDRFNBRERSMyk7CiB9CiAK
IC8qIHMzYzI0MTBmYl9jYWxjX3BpeGNsaygpCkBAIC00MDksNiArNDExLDcgQEAgc3RhdGljIHZv
aWQgczNjMjQxMGZiX2NhbGN1bGF0ZV90ZnRfbGNkXwogc3RhdGljIHZvaWQgczNjMjQxMGZiX2Fj
dGl2YXRlX3ZhcihzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKIAlzdHJ1Y3QgczNjMjQxMGZiX2lu
Zm8gKmZiaSA9IGluZm8tPnBhcjsKKwl2b2lkIF9faW9tZW0gKnJlZ3MgPSBmYmktPmlvOwogCXN0
cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyID0gJmluZm8tPnZhcjsKIAlzdHJ1Y3QgczNjMjQx
MGZiX21hY2hfaW5mbyAqbWFjaF9pbmZvID0gZmJpLT5tYWNoX2luZm87CiAJc3RydWN0IHMzYzI0
MTBmYl9kaXNwbGF5ICpkaXNwbGF5ID0gbWFjaF9pbmZvLT5kaXNwbGF5cyArCkBAIC00NDksMTYg
KzQ1MiwxNyBAQCBzdGF0aWMgdm9pZCBzM2MyNDEwZmJfYWN0aXZhdGVfdmFyKHN0cnVjCiAJZHBy
aW50aygibGNkY29uWzRdID0gMHglMDhseFxuIiwgZmJpLT5yZWdzLmxjZGNvbjQpOwogCWRwcmlu
dGsoImxjZGNvbls1XSA9IDB4JTA4bHhcbiIsIGZiaS0+cmVncy5sY2Rjb241KTsKIAotCXdyaXRl
bChmYmktPnJlZ3MubGNkY29uMSAmIH5TM0MyNDEwX0xDRENPTjFfRU5WSUQsIFMzQzI0MTBfTENE
Q09OMSk7Ci0Jd3JpdGVsKGZiaS0+cmVncy5sY2Rjb24yLCBTM0MyNDEwX0xDRENPTjIpOwotCXdy
aXRlbChmYmktPnJlZ3MubGNkY29uMywgUzNDMjQxMF9MQ0RDT04zKTsKLQl3cml0ZWwoZmJpLT5y
ZWdzLmxjZGNvbjQsIFMzQzI0MTBfTENEQ09ONCk7Ci0Jd3JpdGVsKGZiaS0+cmVncy5sY2Rjb241
LCBTM0MyNDEwX0xDRENPTjUpOworCXdyaXRlbChmYmktPnJlZ3MubGNkY29uMSAmIH5TM0MyNDEw
X0xDRENPTjFfRU5WSUQsCisJCXJlZ3MgKyBTM0MyNDEwX0xDRENPTjEpOworCXdyaXRlbChmYmkt
PnJlZ3MubGNkY29uMiwgcmVncyArIFMzQzI0MTBfTENEQ09OMik7CisJd3JpdGVsKGZiaS0+cmVn
cy5sY2Rjb24zLCByZWdzICsgUzNDMjQxMF9MQ0RDT04zKTsKKwl3cml0ZWwoZmJpLT5yZWdzLmxj
ZGNvbjQsIHJlZ3MgKyBTM0MyNDEwX0xDRENPTjQpOworCXdyaXRlbChmYmktPnJlZ3MubGNkY29u
NSwgcmVncyArIFMzQzI0MTBfTENEQ09ONSk7CiAKIAkvKiBzZXQgbGNkIGFkZHJlc3MgcG9pbnRl
cnMgKi8KIAlzM2MyNDEwZmJfc2V0X2xjZGFkZHIoaW5mbyk7CiAKLQl3cml0ZWwoZmJpLT5yZWdz
LmxjZGNvbjEsIFMzQzI0MTBfTENEQ09OMSk7CisJd3JpdGVsKGZiaS0+cmVncy5sY2Rjb24xLCBy
ZWdzICsgUzNDMjQxMF9MQ0RDT04xKTsKIH0KIAogLyoKQEAgLTUyNyw2ICs1MzEsNyBAQCBzdGF0
aWMgaW50IHMzYzI0MTBmYl9zZXRjb2xyZWcodW5zaWduZWQgCiAJCQkgICAgICAgdW5zaWduZWQg
dHJhbnNwLCBzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKIAlzdHJ1Y3QgczNjMjQxMGZiX2luZm8g
KmZiaSA9IGluZm8tPnBhcjsKKwl2b2lkIF9faW9tZW0gKnJlZ3MgPSBmYmktPmlvOwogCXVuc2ln
bmVkIGludCB2YWw7CiAKIAkvKiBkcHJpbnRrKCJzZXRjb2w6IHJlZ25vPSVkLCByZ2I9JWQsJWQs
JWRcbiIsCkBAIC01NTUsNyArNTYwLDcgQEAgc3RhdGljIGludCBzM2MyNDEwZmJfc2V0Y29scmVn
KHVuc2lnbmVkIAogCQkJdmFsIHw9ICgoZ3JlZW4gPj4gIDUpICYgMHgwN2UwKTsKIAkJCXZhbCB8
PSAoKGJsdWUgID4+IDExKSAmIDB4MDAxZik7CiAKLQkJCXdyaXRlbCh2YWwsIFMzQzI0MTBfVEZU
UEFMKHJlZ25vKSk7CisJCQl3cml0ZWwodmFsLCByZWdzICsgUzNDMjQxMF9URlRQQUwocmVnbm8p
KTsKIAkJCXNjaGVkdWxlX3BhbGV0dGVfdXBkYXRlKGZiaSwgcmVnbm8sIHZhbCk7CiAJCX0KIApA
QCAtNTg2LDE2ICs1OTEsMTkgQEAgc3RhdGljIGludCBzM2MyNDEwZmJfc2V0Y29scmVnKHVuc2ln
bmVkIAogICovCiBzdGF0aWMgaW50IHMzYzI0MTBmYl9ibGFuayhpbnQgYmxhbmtfbW9kZSwgc3Ry
dWN0IGZiX2luZm8gKmluZm8pCiB7CisJc3RydWN0IHMzYzI0MTBmYl9pbmZvICpmYmkgPSBpbmZv
LT5wYXI7CisJdm9pZCBfX2lvbWVtICpyZWdzID0gZmJpLT5pbzsKKwogCWRwcmludGsoImJsYW5r
KG1vZGU9JWQsIGluZm89JXApXG4iLCBibGFua19tb2RlLCBpbmZvKTsKIAogCWlmIChtYWNoX2lu
Zm8gPT0gTlVMTCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlpZiAoYmxhbmtfbW9kZSA9PSBGQl9C
TEFOS19VTkJMQU5LKQotCQl3cml0ZWwoMHgwLCBTM0MyNDEwX1RQQUwpOworCQl3cml0ZWwoMHgw
LCByZWdzICsgUzNDMjQxMF9UUEFMKTsKIAllbHNlIHsKIAkJZHByaW50aygic2V0dGluZyBUUEFM
IHRvIG91dHB1dCAweDAwMDAwMFxuIik7Ci0JCXdyaXRlbChTM0MyNDEwX1RQQUxfRU4sIFMzQzI0
MTBfVFBBTCk7CisJCXdyaXRlbChTM0MyNDEwX1RQQUxfRU4sIHJlZ3MgKyBTM0MyNDEwX1RQQUwp
OwogCX0KIAogCXJldHVybiAwOwo=

--part46befd2d41bfa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46befd2d41bfa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46befd2d41bfa--

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] ffb: source cleanup
Date: Sat, 04 Aug 2007 13:55:06 +0200
Message-ID: <46b4691ae9d22@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46b4691aec41d"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IHIDv-0003xX-UV for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Aug 2007 04:55:14 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IHIDu-0006tD-Ti
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Aug 2007 04:55:11 -0700
Received: from poczta-10.free.wp-sa.pl (HELO localhost) ([10.1.1.28])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 4 Aug 2007 13:55:06 +0200
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
Cc: David Miller <davem@davemloft.net>

This is a multi-part message in MIME format.

--part46b4691aec41d
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch cleans up the driver a bit. It contains
coding style fixes (pointed by Lindent and checkpatch)
and white space clean ups.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

It makes driver file little shorter.

--- linux-2.6.23.old/drivers/video/ffb.c	2007-08-02=20
10:21:10.000000000 +0200
+++ linux-2.6.23/drivers/video/ffb.c	2007-08-03=20
19:42:54.000000000 +0200
@@ -171,17 +171,17 @@ static struct fb_ops ffb_ops =3D {
 #define FFB_PPC_CS_VAR		0x000002
 #define FFB_PPC_CS_CONST	0x000003
=20
-#define FFB_ROP_NEW                  0x83
-#define FFB_ROP_OLD                  0x85
-#define FFB_ROP_NEW_XOR_OLD          0x86
-
-#define FFB_UCSR_FIFO_MASK     0x00000fff
-#define FFB_UCSR_FB_BUSY       0x01000000
-#define FFB_UCSR_RP_BUSY       0x02000000
-#define FFB_UCSR_ALL_BUSY      (FFB_UCSR_RP_BUSY|
FFB_UCSR_FB_BUSY)
-#define FFB_UCSR_READ_ERR      0x40000000
-#define FFB_UCSR_FIFO_OVFL     0x80000000
-#define FFB_UCSR_ALL_ERRORS    (FFB_UCSR_READ_ERR|
FFB_UCSR_FIFO_OVFL)
+#define FFB_ROP_NEW		0x83
+#define FFB_ROP_OLD		0x85
+#define FFB_ROP_NEW_XOR_OLD	0x86
+
+#define FFB_UCSR_FIFO_MASK	0x00000fff
+#define FFB_UCSR_FB_BUSY	0x01000000
+#define FFB_UCSR_RP_BUSY	0x02000000
+#define FFB_UCSR_ALL_BUSY	(FFB_UCSR_RP_BUSY|
FFB_UCSR_FB_BUSY)
+#define FFB_UCSR_READ_ERR	0x40000000
+#define FFB_UCSR_FIFO_OVFL	0x80000000
+#define FFB_UCSR_ALL_ERRORS	(FFB_UCSR_READ_ERR|
FFB_UCSR_FIFO_OVFL)
=20
 struct ffb_fbc {
 	/* Next vertex registers */
@@ -197,7 +197,7 @@ struct ffb_fbc {
 	u32	ryf;
 	u32	rxf;
 	u32	xxx3[2];
-=09
+
 	u32	dmyf;
 	u32	dmxf;
 	u32	xxx4[2];
@@ -211,13 +211,13 @@ struct ffb_fbc {
 	u32	bh;
 	u32	bw;
 	u32	xxx6[2];
-=09
+
 	u32	xxx7[32];
-=09
+
 	/* Setup unit vertex state register */
 	u32	suvtx;
 	u32	xxx8[63];
-=09
+
 	/* Control registers */
 	u32	ppc;
 	u32	wid;
@@ -235,7 +235,7 @@ struct ffb_fbc {
 	u32	dcsb;
 	u32	dczf;
 	u32	dczb;
-=09
+
 	u32	xxx9;
 	u32	blendc;
 	u32	blendc1;
@@ -252,7 +252,7 @@ struct ffb_fbc {
 	u32	fbcfg1;
 	u32	fbcfg2;
 	u32	fbcfg3;
-=09
+
 	u32	ppcfg;
 	u32	pick;
 	u32	fillmode;
@@ -269,7 +269,7 @@ struct ffb_fbc {
 	u32	clip2max;
 	u32	clip3min;
 	u32	clip3max;
-=09
+
 	/* New 3dRAM III support regs */
 	u32	rawblend2;
 	u32	rawpreblend;
@@ -287,7 +287,7 @@ struct ffb_fbc {
 	u32	rawcmp;
 	u32	rawwac;
 	u32	fbramid;
-=09
+
 	u32	drawop;
 	u32	xxx10[2];
 	u32	fontlpat;
@@ -302,7 +302,7 @@ struct ffb_fbc {
 	u32	stencil;
 	u32	stencilctl;
=20
-	u32	xxx13[4];=09
+	u32	xxx13[4];
 	u32	dcss1;
 	u32	dcss2;
 	u32	dcss3;
@@ -315,17 +315,17 @@ struct ffb_fbc {
 	u32	dcd3;
 	u32	dcd4;
 	u32	xxx15;
-=09
+
 	u32	pattern[32];
-=09
+
 	u32	xxx16[256];
-=09
+
 	u32	devid;
 	u32	xxx17[63];
-=09
+
 	u32	ucsr;
 	u32	xxx18[31];
-=09
+
 	u32	mer;
 };
=20
@@ -336,20 +336,20 @@ struct ffb_dac {
 	u32	value2;
 };
=20
-#define FFB_DAC_UCTRL	0x1001 /* User Control */
-#define  FFB_DAC_UCTRL_MANREV	0x00000f00 /* 4-bit=20
Manufacturing Revision */
-#define  FFB_DAC_UCTRL_MANREV_SHIFT 8
-#define FFB_DAC_TGEN	0x6000 /* Timing Generator */
-#define  FFB_DAC_TGEN_VIDE	0x00000001 /* Video Enable */
-#define FFB_DAC_DID	0x8000 /* Device Identification */
-#define  FFB_DAC_DID_PNUM	0x0ffff000 /* Device Part Number=20
*/
-#define  FFB_DAC_DID_PNUM_SHIFT 12
-#define  FFB_DAC_DID_REV	0xf0000000 /* Device Revision */
-#define  FFB_DAC_DID_REV_SHIFT 28
+#define FFB_DAC_UCTRL		0x1001 /* User Control */
+#define FFB_DAC_UCTRL_MANREV	0x00000f00 /* 4-bit=20
Manufacturing Revision */
+#define FFB_DAC_UCTRL_MANREV_SHIFT 8
+#define FFB_DAC_TGEN		0x6000 /* Timing Generator */
+#define FFB_DAC_TGEN_VIDE	0x00000001 /* Video Enable */
+#define FFB_DAC_DID		0x8000 /* Device Identification=20
*/
+#define FFB_DAC_DID_PNUM	0x0ffff000 /* Device Part Number=20
*/
+#define FFB_DAC_DID_PNUM_SHIFT	12
+#define FFB_DAC_DID_REV		0xf0000000 /* Device=20
Revision */
+#define FFB_DAC_DID_REV_SHIFT	28
=20
 #define FFB_DAC_CUR_CTRL	0x100
-#define  FFB_DAC_CUR_CTRL_P0	0x00000001
-#define  FFB_DAC_CUR_CTRL_P1	0x00000002
+#define FFB_DAC_CUR_CTRL_P0	0x00000001
+#define FFB_DAC_CUR_CTRL_P1	0x00000002
=20
 struct ffb_par {
 	spinlock_t		lock;
@@ -382,7 +382,9 @@ static void FFBFifo(struct ffb_par *par,
=20
 	if (cache - n < 0) {
 		fbc =3D par->fbc;
-		do {	cache =3D (upa_readl(&fbc->ucsr) &=20
FFB_UCSR_FIFO_MASK) - 8;
+		do {
+			cache =3D (upa_readl(&fbc->ucsr) &=20
FFB_UCSR_FIFO_MASK);
+			cache -=3D 8;
 		} while (cache - n < 0);
 	}
 	par->fifo_cache =3D cache - n;
@@ -401,12 +403,12 @@ static void FFBWait(struct ffb_par *par)
 			upa_writel(FFB_UCSR_ALL_ERRORS, &fbc-
>ucsr);
 		}
 		udelay(10);
-	} while(--limit > 0);
+	} while (--limit > 0);
 }
=20
 static int ffb_sync(struct fb_info *p)
 {
-	struct ffb_par *par =3D (struct ffb_par *) p->par;
+	struct ffb_par *par =3D (struct ffb_par *)p->par;
=20
 	FFBWait(par);
 	return 0;
@@ -431,8 +433,8 @@ static void ffb_switch_from_graph(struct
 	FFBWait(par);
 	par->fifo_cache =3D 0;
 	FFBFifo(par, 7);
-	upa_writel(FFB_PPC_VCE_DISABLE|FFB_PPC_TBE_OPAQUE|
-		   FFB_PPC_APE_DISABLE|FFB_PPC_CS_CONST,
+	upa_writel(FFB_PPC_VCE_DISABLE | FFB_PPC_TBE_OPAQUE |
+		   FFB_PPC_APE_DISABLE | FFB_PPC_CS_CONST,
 		   &fbc->ppc);
 	upa_writel(0x2000707f, &fbc->fbc);
 	upa_writel(par->rop_cache, &fbc->rop);
@@ -455,7 +457,7 @@ static void ffb_switch_from_graph(struct
=20
 static int ffb_pan_display(struct fb_var_screeninfo *var,=20
struct fb_info *info)
 {
-	struct ffb_par *par =3D (struct ffb_par *) info->par;
+	struct ffb_par *par =3D (struct ffb_par *)info->par;
=20
 	/* We just use this to catch switches out of
 	 * graphics mode.
@@ -468,16 +470,14 @@ static int ffb_pan_display(struct fb_var
 }
=20
 /**
- *      ffb_fillrect - REQUIRED function. Can use generic=20
routines if=20
- *                     non acclerated hardware and packed pixel=20
based.
- *                     Draws a rectangle on the=20
screen.              =20
+ *	ffb_fillrect - Draws a rectangle on the screen.
  *
- *      @info: frame buffer structure that represents a single=20
frame buffer
- *      @rect: structure defining the rectagle and operation.
+ *	@info: frame buffer structure that represents a single=20
frame buffer
+ *	@rect: structure defining the rectagle and operation.
  */
 static void ffb_fillrect(struct fb_info *info, const struct=20
fb_fillrect *rect)
 {
-	struct ffb_par *par =3D (struct ffb_par *) info->par;
+	struct ffb_par *par =3D (struct ffb_par *)info->par;
 	struct ffb_fbc __iomem *fbc =3D par->fbc;
 	unsigned long flags;
 	u32 fg;
@@ -494,9 +494,9 @@ static void ffb_fillrect(struct fb_info=20
 		par->fg_cache =3D fg;
 	}
=20
-	ffb_rop(par, (rect->rop =3D=3D ROP_COPY ?
-		      FFB_ROP_NEW :
-		      FFB_ROP_NEW_XOR_OLD));
+	ffb_rop(par, rect->rop =3D=3D ROP_COPY ?
+		     FFB_ROP_NEW :
+		     FFB_ROP_NEW_XOR_OLD);
=20
 	FFBFifo(par, 5);
 	upa_writel(FFB_DRAWOP_RECTANGLE, &fbc->drawop);
@@ -509,18 +509,15 @@ static void ffb_fillrect(struct fb_info=20
 }
=20
 /**
- *      ffb_copyarea - REQUIRED function. Can use generic=20
routines if
- *                     non acclerated hardware and packed pixel=20
based.
- *                     Copies on area of the screen to another=20
area.
+ *	ffb_copyarea - Copies on area of the screen to another=20
area.
  *
- *      @info: frame buffer structure that represents a single=20
frame buffer
- *      @area: structure defining the source and destination.
+ *	@info: frame buffer structure that represents a single=20
frame buffer
+ *	@area: structure defining the source and destination.
  */
=20
-static void
-ffb_copyarea(struct fb_info *info, const struct fb_copyarea=20
*area)=20
+static void ffb_copyarea(struct fb_info *info, const struct=20
fb_copyarea *area)
 {
-	struct ffb_par *par =3D (struct ffb_par *) info->par;
+	struct ffb_par *par =3D (struct ffb_par *)info->par;
 	struct ffb_fbc __iomem *fbc =3D par->fbc;
 	unsigned long flags;
=20
@@ -547,16 +544,14 @@ ffb_copyarea(struct fb_info *info, const
 }
=20
 /**
- *      ffb_imageblit - REQUIRED function. Can use generic=20
routines if
- *                      non acclerated hardware and packed=20
pixel based.
- *                      Copies a image from system memory to=20
the screen.=20
+ *	ffb_imageblit - Copies a image from system memory to the=20
screen.
  *
- *      @info: frame buffer structure that represents a single=20
frame buffer
- *      @image: structure defining the image.
+ *	@info: frame buffer structure that represents a single=20
frame buffer
+ *	@image: structure defining the image.
  */
 static void ffb_imageblit(struct fb_info *info, const struct=20
fb_image *image)
 {
-	struct ffb_par *par =3D (struct ffb_par *) info->par;
+	struct ffb_par *par =3D (struct ffb_par *)info->par;
 	struct ffb_fbc __iomem *fbc =3D par->fbc;
 	const u8 *data =3D image->data;
 	unsigned long flags;
@@ -644,13 +639,14 @@ static void ffb_fixup_var_rgb(struct fb_
 }
=20
 /**
- *      ffb_setcolreg - Optional function. Sets a color=20
register.
- *      @regno: boolean, 0 copy local, 1 get_user() function
- *      @red: frame buffer colormap structure
- *      @green: The green value which can be up to 16 bits wide
- *      @blue:  The blue value which can be up to 16 bits wide.
- *      @transp: If supported the alpha value which can be up=20
to 16 bits wide.
- *      @info: frame buffer info structure
+ *	ffb_setcolreg - Sets a color register.
+ *
+ *	@regno: boolean, 0 copy local, 1 get_user() function
+ *	@red: frame buffer colormap structure
+ *	@green: The green value which can be up to 16 bits wide
+ *	@blue:  The blue value which can be up to 16 bits wide.
+ *	@transp: If supported the alpha value which can be up to=20
16 bits wide.
+ *	@info: frame buffer info structure
  */
 static int ffb_setcolreg(unsigned regno,
 			 unsigned red, unsigned green, unsigned=20
blue,
@@ -672,14 +668,13 @@ static int ffb_setcolreg(unsigned regno,
 }
=20
 /**
- *      ffb_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
- *      @info: frame buffer structure that represents a single=20
frame buffer
+ *	ffb_blank - Optional function.  Blanks the display.
+ *	@blank_mode: the blank mode we want.
+ *	@info: frame buffer structure that represents a single=20
frame buffer
  */
-static int
-ffb_blank(int blank, struct fb_info *info)
+static int ffb_blank(int blank, struct fb_info *info)
 {
-	struct ffb_par *par =3D (struct ffb_par *) info->par;
+	struct ffb_par *par =3D (struct ffb_par *)info->par;
 	struct ffb_dac __iomem *dac =3D par->dac;
 	unsigned long flags;
 	u32 val;
@@ -867,7 +862,7 @@ static int ffb_mmap(struct fb_info *info
=20
 static int ffb_ioctl(struct fb_info *info, unsigned int cmd,=20
unsigned long arg)
 {
-	struct ffb_par *par =3D (struct ffb_par *) info->par;
+	struct ffb_par *par =3D (struct ffb_par *)info->par;
=20
 	return sbusfb_ioctl_helper(cmd, arg, info,
 				   FBTYPE_CREATOR, 24, par-
>fbsize);
@@ -877,8 +872,7 @@ static int ffb_ioctl(struct fb_info *inf
  *  Initialisation
  */
=20
-static void
-ffb_init_fix(struct fb_info *info)
+static void ffb_init_fix(struct fb_info *info)
 {
 	struct ffb_par *par =3D (struct ffb_par *)info->par;
 	const char *ffb_type_name;
@@ -902,7 +896,8 @@ ffb_init_fix(struct fb_info *info)
 	info->fix.accel =3D FB_ACCEL_SUN_CREATOR;
 }
=20
-static int __devinit ffb_probe(struct of_device *op, const=20
struct of_device_id *match)
+static int __devinit ffb_probe(struct of_device *op,
+			       const struct of_device_id *match)
 {
 	struct device_node *dp =3D op->node;
 	struct ffb_fbc __iomem *fbc;


----------------------------------------------------
Czy na wakacje warto zabra=E6 laptopa?
Zobacz gdzie dzia=B3aj=B1 strefy darmowego, bezprzewodowego Internetu!
Kliknij: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd=
128.html&sid=3D1243

--part46b4691aec41d
Content-Type: application/octet-stream; name="ffb-cleanup.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ffb-cleanup.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggY2xl
YW5zIHVwIHRoZSBkcml2ZXIgYSBiaXQuIEl0IGNvbnRhaW5zCmNvZGluZyBzdHlsZSBmaXhlcyAo
cG9pbnRlZCBieSBMaW5kZW50IGFuZCBjaGVja3BhdGNoKQphbmQgd2hpdGUgc3BhY2UgY2xlYW4g
dXBzLgoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4K
Ci0tLQoKLS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9mZmIuYwkyMDA3LTA4LTAy
IDEwOjIxOjEwLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8v
ZmZiLmMJMjAwNy0wOC0wMyAxOTo0Mjo1NC4wMDAwMDAwMDAgKzAyMDAKQEAgLTE3MSwxNyArMTcx
LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgZmJfb3BzIGZmYl9vcHMgPSB7CiAjZGVmaW5lIEZGQl9QUENf
Q1NfVkFSCQkweDAwMDAwMgogI2RlZmluZSBGRkJfUFBDX0NTX0NPTlNUCTB4MDAwMDAzCiAKLSNk
ZWZpbmUgRkZCX1JPUF9ORVcgICAgICAgICAgICAgICAgICAweDgzCi0jZGVmaW5lIEZGQl9ST1Bf
T0xEICAgICAgICAgICAgICAgICAgMHg4NQotI2RlZmluZSBGRkJfUk9QX05FV19YT1JfT0xEICAg
ICAgICAgIDB4ODYKLQotI2RlZmluZSBGRkJfVUNTUl9GSUZPX01BU0sgICAgIDB4MDAwMDBmZmYK
LSNkZWZpbmUgRkZCX1VDU1JfRkJfQlVTWSAgICAgICAweDAxMDAwMDAwCi0jZGVmaW5lIEZGQl9V
Q1NSX1JQX0JVU1kgICAgICAgMHgwMjAwMDAwMAotI2RlZmluZSBGRkJfVUNTUl9BTExfQlVTWSAg
ICAgIChGRkJfVUNTUl9SUF9CVVNZfEZGQl9VQ1NSX0ZCX0JVU1kpCi0jZGVmaW5lIEZGQl9VQ1NS
X1JFQURfRVJSICAgICAgMHg0MDAwMDAwMAotI2RlZmluZSBGRkJfVUNTUl9GSUZPX09WRkwgICAg
IDB4ODAwMDAwMDAKLSNkZWZpbmUgRkZCX1VDU1JfQUxMX0VSUk9SUyAgICAoRkZCX1VDU1JfUkVB
RF9FUlJ8RkZCX1VDU1JfRklGT19PVkZMKQorI2RlZmluZSBGRkJfUk9QX05FVwkJMHg4MworI2Rl
ZmluZSBGRkJfUk9QX09MRAkJMHg4NQorI2RlZmluZSBGRkJfUk9QX05FV19YT1JfT0xECTB4ODYK
KworI2RlZmluZSBGRkJfVUNTUl9GSUZPX01BU0sJMHgwMDAwMGZmZgorI2RlZmluZSBGRkJfVUNT
Ul9GQl9CVVNZCTB4MDEwMDAwMDAKKyNkZWZpbmUgRkZCX1VDU1JfUlBfQlVTWQkweDAyMDAwMDAw
CisjZGVmaW5lIEZGQl9VQ1NSX0FMTF9CVVNZCShGRkJfVUNTUl9SUF9CVVNZfEZGQl9VQ1NSX0ZC
X0JVU1kpCisjZGVmaW5lIEZGQl9VQ1NSX1JFQURfRVJSCTB4NDAwMDAwMDAKKyNkZWZpbmUgRkZC
X1VDU1JfRklGT19PVkZMCTB4ODAwMDAwMDAKKyNkZWZpbmUgRkZCX1VDU1JfQUxMX0VSUk9SUwko
RkZCX1VDU1JfUkVBRF9FUlJ8RkZCX1VDU1JfRklGT19PVkZMKQogCiBzdHJ1Y3QgZmZiX2ZiYyB7
CiAJLyogTmV4dCB2ZXJ0ZXggcmVnaXN0ZXJzICovCkBAIC0xOTcsNyArMTk3LDcgQEAgc3RydWN0
IGZmYl9mYmMgewogCXUzMglyeWY7CiAJdTMyCXJ4ZjsKIAl1MzIJeHh4M1syXTsKLQkKKwogCXUz
MglkbXlmOwogCXUzMglkbXhmOwogCXUzMgl4eHg0WzJdOwpAQCAtMjExLDEzICsyMTEsMTMgQEAg
c3RydWN0IGZmYl9mYmMgewogCXUzMgliaDsKIAl1MzIJYnc7CiAJdTMyCXh4eDZbMl07Ci0JCisK
IAl1MzIJeHh4N1szMl07Ci0JCisKIAkvKiBTZXR1cCB1bml0IHZlcnRleCBzdGF0ZSByZWdpc3Rl
ciAqLwogCXUzMglzdXZ0eDsKIAl1MzIJeHh4OFs2M107Ci0JCisKIAkvKiBDb250cm9sIHJlZ2lz
dGVycyAqLwogCXUzMglwcGM7CiAJdTMyCXdpZDsKQEAgLTIzNSw3ICsyMzUsNyBAQCBzdHJ1Y3Qg
ZmZiX2ZiYyB7CiAJdTMyCWRjc2I7CiAJdTMyCWRjemY7CiAJdTMyCWRjemI7Ci0JCisKIAl1MzIJ
eHh4OTsKIAl1MzIJYmxlbmRjOwogCXUzMglibGVuZGMxOwpAQCAtMjUyLDcgKzI1Miw3IEBAIHN0
cnVjdCBmZmJfZmJjIHsKIAl1MzIJZmJjZmcxOwogCXUzMglmYmNmZzI7CiAJdTMyCWZiY2ZnMzsK
LQkKKwogCXUzMglwcGNmZzsKIAl1MzIJcGljazsKIAl1MzIJZmlsbG1vZGU7CkBAIC0yNjksNyAr
MjY5LDcgQEAgc3RydWN0IGZmYl9mYmMgewogCXUzMgljbGlwMm1heDsKIAl1MzIJY2xpcDNtaW47
CiAJdTMyCWNsaXAzbWF4OwotCQorCiAJLyogTmV3IDNkUkFNIElJSSBzdXBwb3J0IHJlZ3MgKi8K
IAl1MzIJcmF3YmxlbmQyOwogCXUzMglyYXdwcmVibGVuZDsKQEAgLTI4Nyw3ICsyODcsNyBAQCBz
dHJ1Y3QgZmZiX2ZiYyB7CiAJdTMyCXJhd2NtcDsKIAl1MzIJcmF3d2FjOwogCXUzMglmYnJhbWlk
OwotCQorCiAJdTMyCWRyYXdvcDsKIAl1MzIJeHh4MTBbMl07CiAJdTMyCWZvbnRscGF0OwpAQCAt
MzAyLDcgKzMwMiw3IEBAIHN0cnVjdCBmZmJfZmJjIHsKIAl1MzIJc3RlbmNpbDsKIAl1MzIJc3Rl
bmNpbGN0bDsKIAotCXUzMgl4eHgxM1s0XTsJCisJdTMyCXh4eDEzWzRdOwogCXUzMglkY3NzMTsK
IAl1MzIJZGNzczI7CiAJdTMyCWRjc3MzOwpAQCAtMzE1LDE3ICszMTUsMTcgQEAgc3RydWN0IGZm
Yl9mYmMgewogCXUzMglkY2QzOwogCXUzMglkY2Q0OwogCXUzMgl4eHgxNTsKLQkKKwogCXUzMglw
YXR0ZXJuWzMyXTsKLQkKKwogCXUzMgl4eHgxNlsyNTZdOwotCQorCiAJdTMyCWRldmlkOwogCXUz
Mgl4eHgxN1s2M107Ci0JCisKIAl1MzIJdWNzcjsKIAl1MzIJeHh4MThbMzFdOwotCQorCiAJdTMy
CW1lcjsKIH07CiAKQEAgLTMzNiwyMCArMzM2LDIwIEBAIHN0cnVjdCBmZmJfZGFjIHsKIAl1MzIJ
dmFsdWUyOwogfTsKIAotI2RlZmluZSBGRkJfREFDX1VDVFJMCTB4MTAwMSAvKiBVc2VyIENvbnRy
b2wgKi8KLSNkZWZpbmUgIEZGQl9EQUNfVUNUUkxfTUFOUkVWCTB4MDAwMDBmMDAgLyogNC1iaXQg
TWFudWZhY3R1cmluZyBSZXZpc2lvbiAqLwotI2RlZmluZSAgRkZCX0RBQ19VQ1RSTF9NQU5SRVZf
U0hJRlQgOAotI2RlZmluZSBGRkJfREFDX1RHRU4JMHg2MDAwIC8qIFRpbWluZyBHZW5lcmF0b3Ig
Ki8KLSNkZWZpbmUgIEZGQl9EQUNfVEdFTl9WSURFCTB4MDAwMDAwMDEgLyogVmlkZW8gRW5hYmxl
ICovCi0jZGVmaW5lIEZGQl9EQUNfRElECTB4ODAwMCAvKiBEZXZpY2UgSWRlbnRpZmljYXRpb24g
Ki8KLSNkZWZpbmUgIEZGQl9EQUNfRElEX1BOVU0JMHgwZmZmZjAwMCAvKiBEZXZpY2UgUGFydCBO
dW1iZXIgKi8KLSNkZWZpbmUgIEZGQl9EQUNfRElEX1BOVU1fU0hJRlQgMTIKLSNkZWZpbmUgIEZG
Ql9EQUNfRElEX1JFVgkweGYwMDAwMDAwIC8qIERldmljZSBSZXZpc2lvbiAqLwotI2RlZmluZSAg
RkZCX0RBQ19ESURfUkVWX1NISUZUIDI4CisjZGVmaW5lIEZGQl9EQUNfVUNUUkwJCTB4MTAwMSAv
KiBVc2VyIENvbnRyb2wgKi8KKyNkZWZpbmUgRkZCX0RBQ19VQ1RSTF9NQU5SRVYJMHgwMDAwMGYw
MCAvKiA0LWJpdCBNYW51ZmFjdHVyaW5nIFJldmlzaW9uICovCisjZGVmaW5lIEZGQl9EQUNfVUNU
UkxfTUFOUkVWX1NISUZUIDgKKyNkZWZpbmUgRkZCX0RBQ19UR0VOCQkweDYwMDAgLyogVGltaW5n
IEdlbmVyYXRvciAqLworI2RlZmluZSBGRkJfREFDX1RHRU5fVklERQkweDAwMDAwMDAxIC8qIFZp
ZGVvIEVuYWJsZSAqLworI2RlZmluZSBGRkJfREFDX0RJRAkJMHg4MDAwIC8qIERldmljZSBJZGVu
dGlmaWNhdGlvbiAqLworI2RlZmluZSBGRkJfREFDX0RJRF9QTlVNCTB4MGZmZmYwMDAgLyogRGV2
aWNlIFBhcnQgTnVtYmVyICovCisjZGVmaW5lIEZGQl9EQUNfRElEX1BOVU1fU0hJRlQJMTIKKyNk
ZWZpbmUgRkZCX0RBQ19ESURfUkVWCQkweGYwMDAwMDAwIC8qIERldmljZSBSZXZpc2lvbiAqLwor
I2RlZmluZSBGRkJfREFDX0RJRF9SRVZfU0hJRlQJMjgKIAogI2RlZmluZSBGRkJfREFDX0NVUl9D
VFJMCTB4MTAwCi0jZGVmaW5lICBGRkJfREFDX0NVUl9DVFJMX1AwCTB4MDAwMDAwMDEKLSNkZWZp
bmUgIEZGQl9EQUNfQ1VSX0NUUkxfUDEJMHgwMDAwMDAwMgorI2RlZmluZSBGRkJfREFDX0NVUl9D
VFJMX1AwCTB4MDAwMDAwMDEKKyNkZWZpbmUgRkZCX0RBQ19DVVJfQ1RSTF9QMQkweDAwMDAwMDAy
CiAKIHN0cnVjdCBmZmJfcGFyIHsKIAlzcGlubG9ja190CQlsb2NrOwpAQCAtMzgyLDcgKzM4Miw5
IEBAIHN0YXRpYyB2b2lkIEZGQkZpZm8oc3RydWN0IGZmYl9wYXIgKnBhciwKIAogCWlmIChjYWNo
ZSAtIG4gPCAwKSB7CiAJCWZiYyA9IHBhci0+ZmJjOwotCQlkbyB7CWNhY2hlID0gKHVwYV9yZWFk
bCgmZmJjLT51Y3NyKSAmIEZGQl9VQ1NSX0ZJRk9fTUFTSykgLSA4OworCQlkbyB7CisJCQljYWNo
ZSA9ICh1cGFfcmVhZGwoJmZiYy0+dWNzcikgJiBGRkJfVUNTUl9GSUZPX01BU0spOworCQkJY2Fj
aGUgLT0gODsKIAkJfSB3aGlsZSAoY2FjaGUgLSBuIDwgMCk7CiAJfQogCXBhci0+Zmlmb19jYWNo
ZSA9IGNhY2hlIC0gbjsKQEAgLTQwMSwxMiArNDAzLDEyIEBAIHN0YXRpYyB2b2lkIEZGQldhaXQo
c3RydWN0IGZmYl9wYXIgKnBhcikKIAkJCXVwYV93cml0ZWwoRkZCX1VDU1JfQUxMX0VSUk9SUywg
JmZiYy0+dWNzcik7CiAJCX0KIAkJdWRlbGF5KDEwKTsKLQl9IHdoaWxlKC0tbGltaXQgPiAwKTsK
Kwl9IHdoaWxlICgtLWxpbWl0ID4gMCk7CiB9CiAKIHN0YXRpYyBpbnQgZmZiX3N5bmMoc3RydWN0
IGZiX2luZm8gKnApCiB7Ci0Jc3RydWN0IGZmYl9wYXIgKnBhciA9IChzdHJ1Y3QgZmZiX3BhciAq
KSBwLT5wYXI7CisJc3RydWN0IGZmYl9wYXIgKnBhciA9IChzdHJ1Y3QgZmZiX3BhciAqKXAtPnBh
cjsKIAogCUZGQldhaXQocGFyKTsKIAlyZXR1cm4gMDsKQEAgLTQzMSw4ICs0MzMsOCBAQCBzdGF0
aWMgdm9pZCBmZmJfc3dpdGNoX2Zyb21fZ3JhcGgoc3RydWN0CiAJRkZCV2FpdChwYXIpOwogCXBh
ci0+Zmlmb19jYWNoZSA9IDA7CiAJRkZCRmlmbyhwYXIsIDcpOwotCXVwYV93cml0ZWwoRkZCX1BQ
Q19WQ0VfRElTQUJMRXxGRkJfUFBDX1RCRV9PUEFRVUV8Ci0JCSAgIEZGQl9QUENfQVBFX0RJU0FC
TEV8RkZCX1BQQ19DU19DT05TVCwKKwl1cGFfd3JpdGVsKEZGQl9QUENfVkNFX0RJU0FCTEUgfCBG
RkJfUFBDX1RCRV9PUEFRVUUgfAorCQkgICBGRkJfUFBDX0FQRV9ESVNBQkxFIHwgRkZCX1BQQ19D
U19DT05TVCwKIAkJICAgJmZiYy0+cHBjKTsKIAl1cGFfd3JpdGVsKDB4MjAwMDcwN2YsICZmYmMt
PmZiYyk7CiAJdXBhX3dyaXRlbChwYXItPnJvcF9jYWNoZSwgJmZiYy0+cm9wKTsKQEAgLTQ1NSw3
ICs0NTcsNyBAQCBzdGF0aWMgdm9pZCBmZmJfc3dpdGNoX2Zyb21fZ3JhcGgoc3RydWN0CiAKIHN0
YXRpYyBpbnQgZmZiX3Bhbl9kaXNwbGF5KHN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyLCBz
dHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKLQlzdHJ1Y3QgZmZiX3BhciAqcGFyID0gKHN0cnVjdCBm
ZmJfcGFyICopIGluZm8tPnBhcjsKKwlzdHJ1Y3QgZmZiX3BhciAqcGFyID0gKHN0cnVjdCBmZmJf
cGFyICopaW5mby0+cGFyOwogCiAJLyogV2UganVzdCB1c2UgdGhpcyB0byBjYXRjaCBzd2l0Y2hl
cyBvdXQgb2YKIAkgKiBncmFwaGljcyBtb2RlLgpAQCAtNDY4LDE2ICs0NzAsMTQgQEAgc3RhdGlj
IGludCBmZmJfcGFuX2Rpc3BsYXkoc3RydWN0IGZiX3ZhcgogfQogCiAvKioKLSAqICAgICAgZmZi
X2ZpbGxyZWN0IC0gUkVRVUlSRUQgZnVuY3Rpb24uIENhbiB1c2UgZ2VuZXJpYyByb3V0aW5lcyBp
ZiAKLSAqICAgICAgICAgICAgICAgICAgICAgbm9uIGFjY2xlcmF0ZWQgaGFyZHdhcmUgYW5kIHBh
Y2tlZCBwaXhlbCBiYXNlZC4KLSAqICAgICAgICAgICAgICAgICAgICAgRHJhd3MgYSByZWN0YW5n
bGUgb24gdGhlIHNjcmVlbi4gICAgICAgICAgICAgICAKKyAqCWZmYl9maWxscmVjdCAtIERyYXdz
IGEgcmVjdGFuZ2xlIG9uIHRoZSBzY3JlZW4uCiAgKgotICogICAgICBAaW5mbzogZnJhbWUgYnVm
ZmVyIHN0cnVjdHVyZSB0aGF0IHJlcHJlc2VudHMgYSBzaW5nbGUgZnJhbWUgYnVmZmVyCi0gKiAg
ICAgIEByZWN0OiBzdHJ1Y3R1cmUgZGVmaW5pbmcgdGhlIHJlY3RhZ2xlIGFuZCBvcGVyYXRpb24u
CisgKglAaW5mbzogZnJhbWUgYnVmZmVyIHN0cnVjdHVyZSB0aGF0IHJlcHJlc2VudHMgYSBzaW5n
bGUgZnJhbWUgYnVmZmVyCisgKglAcmVjdDogc3RydWN0dXJlIGRlZmluaW5nIHRoZSByZWN0YWds
ZSBhbmQgb3BlcmF0aW9uLgogICovCiBzdGF0aWMgdm9pZCBmZmJfZmlsbHJlY3Qoc3RydWN0IGZi
X2luZm8gKmluZm8sIGNvbnN0IHN0cnVjdCBmYl9maWxscmVjdCAqcmVjdCkKIHsKLQlzdHJ1Y3Qg
ZmZiX3BhciAqcGFyID0gKHN0cnVjdCBmZmJfcGFyICopIGluZm8tPnBhcjsKKwlzdHJ1Y3QgZmZi
X3BhciAqcGFyID0gKHN0cnVjdCBmZmJfcGFyICopaW5mby0+cGFyOwogCXN0cnVjdCBmZmJfZmJj
IF9faW9tZW0gKmZiYyA9IHBhci0+ZmJjOwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJdTMyIGZn
OwpAQCAtNDk0LDkgKzQ5NCw5IEBAIHN0YXRpYyB2b2lkIGZmYl9maWxscmVjdChzdHJ1Y3QgZmJf
aW5mbyAKIAkJcGFyLT5mZ19jYWNoZSA9IGZnOwogCX0KIAotCWZmYl9yb3AocGFyLCAocmVjdC0+
cm9wID09IFJPUF9DT1BZID8KLQkJICAgICAgRkZCX1JPUF9ORVcgOgotCQkgICAgICBGRkJfUk9Q
X05FV19YT1JfT0xEKSk7CisJZmZiX3JvcChwYXIsIHJlY3QtPnJvcCA9PSBST1BfQ09QWSA/CisJ
CSAgICAgRkZCX1JPUF9ORVcgOgorCQkgICAgIEZGQl9ST1BfTkVXX1hPUl9PTEQpOwogCiAJRkZC
RmlmbyhwYXIsIDUpOwogCXVwYV93cml0ZWwoRkZCX0RSQVdPUF9SRUNUQU5HTEUsICZmYmMtPmRy
YXdvcCk7CkBAIC01MDksMTggKzUwOSwxNSBAQCBzdGF0aWMgdm9pZCBmZmJfZmlsbHJlY3Qoc3Ry
dWN0IGZiX2luZm8gCiB9CiAKIC8qKgotICogICAgICBmZmJfY29weWFyZWEgLSBSRVFVSVJFRCBm
dW5jdGlvbi4gQ2FuIHVzZSBnZW5lcmljIHJvdXRpbmVzIGlmCi0gKiAgICAgICAgICAgICAgICAg
ICAgIG5vbiBhY2NsZXJhdGVkIGhhcmR3YXJlIGFuZCBwYWNrZWQgcGl4ZWwgYmFzZWQuCi0gKiAg
ICAgICAgICAgICAgICAgICAgIENvcGllcyBvbiBhcmVhIG9mIHRoZSBzY3JlZW4gdG8gYW5vdGhl
ciBhcmVhLgorICoJZmZiX2NvcHlhcmVhIC0gQ29waWVzIG9uIGFyZWEgb2YgdGhlIHNjcmVlbiB0
byBhbm90aGVyIGFyZWEuCiAgKgotICogICAgICBAaW5mbzogZnJhbWUgYnVmZmVyIHN0cnVjdHVy
ZSB0aGF0IHJlcHJlc2VudHMgYSBzaW5nbGUgZnJhbWUgYnVmZmVyCi0gKiAgICAgIEBhcmVhOiBz
dHJ1Y3R1cmUgZGVmaW5pbmcgdGhlIHNvdXJjZSBhbmQgZGVzdGluYXRpb24uCisgKglAaW5mbzog
ZnJhbWUgYnVmZmVyIHN0cnVjdHVyZSB0aGF0IHJlcHJlc2VudHMgYSBzaW5nbGUgZnJhbWUgYnVm
ZmVyCisgKglAYXJlYTogc3RydWN0dXJlIGRlZmluaW5nIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0
aW9uLgogICovCiAKLXN0YXRpYyB2b2lkCi1mZmJfY29weWFyZWEoc3RydWN0IGZiX2luZm8gKmlu
Zm8sIGNvbnN0IHN0cnVjdCBmYl9jb3B5YXJlYSAqYXJlYSkgCitzdGF0aWMgdm9pZCBmZmJfY29w
eWFyZWEoc3RydWN0IGZiX2luZm8gKmluZm8sIGNvbnN0IHN0cnVjdCBmYl9jb3B5YXJlYSAqYXJl
YSkKIHsKLQlzdHJ1Y3QgZmZiX3BhciAqcGFyID0gKHN0cnVjdCBmZmJfcGFyICopIGluZm8tPnBh
cjsKKwlzdHJ1Y3QgZmZiX3BhciAqcGFyID0gKHN0cnVjdCBmZmJfcGFyICopaW5mby0+cGFyOwog
CXN0cnVjdCBmZmJfZmJjIF9faW9tZW0gKmZiYyA9IHBhci0+ZmJjOwogCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7CiAKQEAgLTU0NywxNiArNTQ0LDE0IEBAIGZmYl9jb3B5YXJlYShzdHJ1Y3QgZmJfaW5m
byAqaW5mbywgY29uc3QKIH0KIAogLyoqCi0gKiAgICAgIGZmYl9pbWFnZWJsaXQgLSBSRVFVSVJF
RCBmdW5jdGlvbi4gQ2FuIHVzZSBnZW5lcmljIHJvdXRpbmVzIGlmCi0gKiAgICAgICAgICAgICAg
ICAgICAgICBub24gYWNjbGVyYXRlZCBoYXJkd2FyZSBhbmQgcGFja2VkIHBpeGVsIGJhc2VkLgot
ICogICAgICAgICAgICAgICAgICAgICAgQ29waWVzIGEgaW1hZ2UgZnJvbSBzeXN0ZW0gbWVtb3J5
IHRvIHRoZSBzY3JlZW4uIAorICoJZmZiX2ltYWdlYmxpdCAtIENvcGllcyBhIGltYWdlIGZyb20g
c3lzdGVtIG1lbW9yeSB0byB0aGUgc2NyZWVuLgogICoKLSAqICAgICAgQGluZm86IGZyYW1lIGJ1
ZmZlciBzdHJ1Y3R1cmUgdGhhdCByZXByZXNlbnRzIGEgc2luZ2xlIGZyYW1lIGJ1ZmZlcgotICog
ICAgICBAaW1hZ2U6IHN0cnVjdHVyZSBkZWZpbmluZyB0aGUgaW1hZ2UuCisgKglAaW5mbzogZnJh
bWUgYnVmZmVyIHN0cnVjdHVyZSB0aGF0IHJlcHJlc2VudHMgYSBzaW5nbGUgZnJhbWUgYnVmZmVy
CisgKglAaW1hZ2U6IHN0cnVjdHVyZSBkZWZpbmluZyB0aGUgaW1hZ2UuCiAgKi8KIHN0YXRpYyB2
b2lkIGZmYl9pbWFnZWJsaXQoc3RydWN0IGZiX2luZm8gKmluZm8sIGNvbnN0IHN0cnVjdCBmYl9p
bWFnZSAqaW1hZ2UpCiB7Ci0Jc3RydWN0IGZmYl9wYXIgKnBhciA9IChzdHJ1Y3QgZmZiX3BhciAq
KSBpbmZvLT5wYXI7CisJc3RydWN0IGZmYl9wYXIgKnBhciA9IChzdHJ1Y3QgZmZiX3BhciAqKWlu
Zm8tPnBhcjsKIAlzdHJ1Y3QgZmZiX2ZiYyBfX2lvbWVtICpmYmMgPSBwYXItPmZiYzsKIAljb25z
dCB1OCAqZGF0YSA9IGltYWdlLT5kYXRhOwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CkBAIC02NDQs
MTMgKzYzOSwxNCBAQCBzdGF0aWMgdm9pZCBmZmJfZml4dXBfdmFyX3JnYihzdHJ1Y3QgZmJfCiB9
CiAKIC8qKgotICogICAgICBmZmJfc2V0Y29scmVnIC0gT3B0aW9uYWwgZnVuY3Rpb24uIFNldHMg
YSBjb2xvciByZWdpc3Rlci4KLSAqICAgICAgQHJlZ25vOiBib29sZWFuLCAwIGNvcHkgbG9jYWws
IDEgZ2V0X3VzZXIoKSBmdW5jdGlvbgotICogICAgICBAcmVkOiBmcmFtZSBidWZmZXIgY29sb3Jt
YXAgc3RydWN0dXJlCi0gKiAgICAgIEBncmVlbjogVGhlIGdyZWVuIHZhbHVlIHdoaWNoIGNhbiBi
ZSB1cCB0byAxNiBiaXRzIHdpZGUKLSAqICAgICAgQGJsdWU6ICBUaGUgYmx1ZSB2YWx1ZSB3aGlj
aCBjYW4gYmUgdXAgdG8gMTYgYml0cyB3aWRlLgotICogICAgICBAdHJhbnNwOiBJZiBzdXBwb3J0
ZWQgdGhlIGFscGhhIHZhbHVlIHdoaWNoIGNhbiBiZSB1cCB0byAxNiBiaXRzIHdpZGUuCi0gKiAg
ICAgIEBpbmZvOiBmcmFtZSBidWZmZXIgaW5mbyBzdHJ1Y3R1cmUKKyAqCWZmYl9zZXRjb2xyZWcg
LSBTZXRzIGEgY29sb3IgcmVnaXN0ZXIuCisgKgorICoJQHJlZ25vOiBib29sZWFuLCAwIGNvcHkg
bG9jYWwsIDEgZ2V0X3VzZXIoKSBmdW5jdGlvbgorICoJQHJlZDogZnJhbWUgYnVmZmVyIGNvbG9y
bWFwIHN0cnVjdHVyZQorICoJQGdyZWVuOiBUaGUgZ3JlZW4gdmFsdWUgd2hpY2ggY2FuIGJlIHVw
IHRvIDE2IGJpdHMgd2lkZQorICoJQGJsdWU6ICBUaGUgYmx1ZSB2YWx1ZSB3aGljaCBjYW4gYmUg
dXAgdG8gMTYgYml0cyB3aWRlLgorICoJQHRyYW5zcDogSWYgc3VwcG9ydGVkIHRoZSBhbHBoYSB2
YWx1ZSB3aGljaCBjYW4gYmUgdXAgdG8gMTYgYml0cyB3aWRlLgorICoJQGluZm86IGZyYW1lIGJ1
ZmZlciBpbmZvIHN0cnVjdHVyZQogICovCiBzdGF0aWMgaW50IGZmYl9zZXRjb2xyZWcodW5zaWdu
ZWQgcmVnbm8sCiAJCQkgdW5zaWduZWQgcmVkLCB1bnNpZ25lZCBncmVlbiwgdW5zaWduZWQgYmx1
ZSwKQEAgLTY3MiwxNCArNjY4LDEzIEBAIHN0YXRpYyBpbnQgZmZiX3NldGNvbHJlZyh1bnNpZ25l
ZCByZWdubywKIH0KIAogLyoqCi0gKiAgICAgIGZmYl9ibGFuayAtIE9wdGlvbmFsIGZ1bmN0aW9u
LiAgQmxhbmtzIHRoZSBkaXNwbGF5LgotICogICAgICBAYmxhbmtfbW9kZTogdGhlIGJsYW5rIG1v
ZGUgd2Ugd2FudC4KLSAqICAgICAgQGluZm86IGZyYW1lIGJ1ZmZlciBzdHJ1Y3R1cmUgdGhhdCBy
ZXByZXNlbnRzIGEgc2luZ2xlIGZyYW1lIGJ1ZmZlcgorICoJZmZiX2JsYW5rIC0gT3B0aW9uYWwg
ZnVuY3Rpb24uICBCbGFua3MgdGhlIGRpc3BsYXkuCisgKglAYmxhbmtfbW9kZTogdGhlIGJsYW5r
IG1vZGUgd2Ugd2FudC4KKyAqCUBpbmZvOiBmcmFtZSBidWZmZXIgc3RydWN0dXJlIHRoYXQgcmVw
cmVzZW50cyBhIHNpbmdsZSBmcmFtZSBidWZmZXIKICAqLwotc3RhdGljIGludAotZmZiX2JsYW5r
KGludCBibGFuaywgc3RydWN0IGZiX2luZm8gKmluZm8pCitzdGF0aWMgaW50IGZmYl9ibGFuayhp
bnQgYmxhbmssIHN0cnVjdCBmYl9pbmZvICppbmZvKQogewotCXN0cnVjdCBmZmJfcGFyICpwYXIg
PSAoc3RydWN0IGZmYl9wYXIgKikgaW5mby0+cGFyOworCXN0cnVjdCBmZmJfcGFyICpwYXIgPSAo
c3RydWN0IGZmYl9wYXIgKilpbmZvLT5wYXI7CiAJc3RydWN0IGZmYl9kYWMgX19pb21lbSAqZGFj
ID0gcGFyLT5kYWM7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAl1MzIgdmFsOwpAQCAtODY3LDcg
Kzg2Miw3IEBAIHN0YXRpYyBpbnQgZmZiX21tYXAoc3RydWN0IGZiX2luZm8gKmluZm8KIAogc3Rh
dGljIGludCBmZmJfaW9jdGwoc3RydWN0IGZiX2luZm8gKmluZm8sIHVuc2lnbmVkIGludCBjbWQs
IHVuc2lnbmVkIGxvbmcgYXJnKQogewotCXN0cnVjdCBmZmJfcGFyICpwYXIgPSAoc3RydWN0IGZm
Yl9wYXIgKikgaW5mby0+cGFyOworCXN0cnVjdCBmZmJfcGFyICpwYXIgPSAoc3RydWN0IGZmYl9w
YXIgKilpbmZvLT5wYXI7CiAKIAlyZXR1cm4gc2J1c2ZiX2lvY3RsX2hlbHBlcihjbWQsIGFyZywg
aW5mbywKIAkJCQkgICBGQlRZUEVfQ1JFQVRPUiwgMjQsIHBhci0+ZmJzaXplKTsKQEAgLTg3Nyw4
ICs4NzIsNyBAQCBzdGF0aWMgaW50IGZmYl9pb2N0bChzdHJ1Y3QgZmJfaW5mbyAqaW5mCiAgKiAg
SW5pdGlhbGlzYXRpb24KICAqLwogCi1zdGF0aWMgdm9pZAotZmZiX2luaXRfZml4KHN0cnVjdCBm
Yl9pbmZvICppbmZvKQorc3RhdGljIHZvaWQgZmZiX2luaXRfZml4KHN0cnVjdCBmYl9pbmZvICpp
bmZvKQogewogCXN0cnVjdCBmZmJfcGFyICpwYXIgPSAoc3RydWN0IGZmYl9wYXIgKilpbmZvLT5w
YXI7CiAJY29uc3QgY2hhciAqZmZiX3R5cGVfbmFtZTsKQEAgLTkwMiw3ICs4OTYsOCBAQCBmZmJf
aW5pdF9maXgoc3RydWN0IGZiX2luZm8gKmluZm8pCiAJaW5mby0+Zml4LmFjY2VsID0gRkJfQUND
RUxfU1VOX0NSRUFUT1I7CiB9CiAKLXN0YXRpYyBpbnQgX19kZXZpbml0IGZmYl9wcm9iZShzdHJ1
Y3Qgb2ZfZGV2aWNlICpvcCwgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2gpCitzdGF0
aWMgaW50IF9fZGV2aW5pdCBmZmJfcHJvYmUoc3RydWN0IG9mX2RldmljZSAqb3AsCisJCQkgICAg
ICAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2gpCiB7CiAJc3RydWN0IGRldmljZV9u
b2RlICpkcCA9IG9wLT5ub2RlOwogCXN0cnVjdCBmZmJfZmJjIF9faW9tZW0gKmZiYzsK

--part46b4691aec41d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46b4691aec41d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46b4691aec41d--

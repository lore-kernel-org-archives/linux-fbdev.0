From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] s3c2410fb: remove fb_info pointer from
	s3c2410fb_info
Date: Sat, 04 Aug 2007 13:46:44 +0200
Message-ID: <46b4672403046@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46b4672405741"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IHI5t-00036D-9D for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Aug 2007 04:46:53 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IHI5p-0006Cq-HH
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Aug 2007 04:46:53 -0700
Received: from poczta-10.free.wp-sa.pl (HELO localhost) ([10.1.1.28])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 4 Aug 2007 13:46:44 +0200
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
Cc: Ben Dooks <ben-linux@fluff.org>, Arnaud Patard <arnaud.patard@rtp-net.org>

This is a multi-part message in MIME format.

--part46b4672405741
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes redundant fb field from
the s3c2410fb_info structure. This breaks circular
reference fb_info -> s3c2410fb_info -> fb_info again.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires s3c2410fb-cleanup patch I posted earlier.

diff -urp linux-2.6.23.old/drivers/video/s3c2410fb.c linux-
2.6.23/drivers/video/s3c2410fb.c
--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-03=20
07:30:31.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-03=20
07:27:48.000000000 +0200
@@ -119,15 +119,14 @@ static int debug	=3D 0;
  *
  * initialise lcd controller address pointers
  */
-static void s3c2410fb_set_lcdaddr(struct s3c2410fb_info *fbi)
+static void s3c2410fb_set_lcdaddr(struct fb_info *info)
 {
-	struct fb_var_screeninfo *var =3D &fbi->fb->var;
 	unsigned long saddr1, saddr2, saddr3;
-	int line_length =3D var->xres * var->bits_per_pixel;
+	int line_length =3D info->var.xres * info-
>var.bits_per_pixel;
=20
-	saddr1  =3D fbi->fb->fix.smem_start >> 1;
-	saddr2  =3D fbi->fb->fix.smem_start;
-	saddr2 +=3D (line_length * var->yres) / 8;
+	saddr1  =3D info->fix.smem_start >> 1;
+	saddr2  =3D info->fix.smem_start;
+	saddr2 +=3D (line_length * info->var.yres) / 8;
 	saddr2 >>=3D 1;
=20
 	saddr3 =3D S3C2410_OFFSIZE(0) |
@@ -275,9 +274,10 @@ static int s3c2410fb_check_var(struct fb
  * activate (set) the controller from the given framebuffer
  * information
  */
-static void s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
+static void s3c2410fb_activate_var(struct fb_info *info,
 				   struct fb_var_screeninfo *var)
 {
+	struct s3c2410fb_info *fbi =3D info->par;
 	int hs;
=20
 	fbi->regs.lcdcon1 &=3D ~S3C2410_LCDCON1_MODEMASK;
@@ -418,7 +418,7 @@ static void s3c2410fb_activate_var(struc
 	writel(fbi->regs.lcdcon5, S3C2410_LCDCON5);
=20
 	/* set lcd address pointers */
-	s3c2410fb_set_lcdaddr(fbi);
+	s3c2410fb_set_lcdaddr(info);
=20
 	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
 }
@@ -430,7 +430,6 @@ static void s3c2410fb_activate_var(struc
  */
 static int s3c2410fb_set_par(struct fb_info *info)
 {
-	struct s3c2410fb_info *fbi =3D info->par;
 	struct fb_var_screeninfo *var =3D &info->var;
=20
 	switch (var->bits_per_pixel) {
@@ -449,7 +448,7 @@ static int s3c2410fb_set_par(struct fb_i
=20
 	/* activate this new configuration */
=20
-	s3c2410fb_activate_var(fbi, var);
+	s3c2410fb_activate_var(info, var);
 	return 0;
 }
=20
@@ -615,15 +614,17 @@ static struct fb_ops s3c2410fb_ops =3D {
  *	cache.  Once this area is remapped, all virtual memory
  *	access to the video memory should occur at the new=20
region.
  */
-static int __init s3c2410fb_map_video_memory(struct=20
s3c2410fb_info *fbi)
+static int __init s3c2410fb_map_video_memory(struct fb_info=20
*info)
 {
+	struct s3c2410fb_info *fbi =3D info->par;
+
 	dprintk("map_video_memory(fbi=3D%p)\n", fbi);
=20
-	fbi->map_size =3D PAGE_ALIGN(fbi->fb->fix.smem_len +=20
PAGE_SIZE);
+	fbi->map_size =3D PAGE_ALIGN(info->fix.smem_len +=20
PAGE_SIZE);
 	fbi->map_cpu  =3D dma_alloc_writecombine(fbi->dev, fbi-
>map_size,
 					       &fbi->map_dma,=20
GFP_KERNEL);
=20
-	fbi->map_size =3D fbi->fb->fix.smem_len;
+	fbi->map_size =3D info->fix.smem_len;
=20
 	if (fbi->map_cpu) {
 		/* prevent initial garbage on screen */
@@ -632,11 +633,11 @@ static int __init s3c2410fb_map_video_me
 		memset(fbi->map_cpu, 0xf0, fbi->map_size);
=20
 		fbi->screen_dma		=3D fbi->map_dma;
-		fbi->fb->screen_base	=3D fbi->map_cpu;
-		fbi->fb->fix.smem_start  =3D fbi->screen_dma;
+		info->screen_base	=3D fbi->map_cpu;
+		info->fix.smem_start	=3D fbi->screen_dma;
=20
 		dprintk("map_video_memory: dma=3D%08x cpu=3D%p=20
size=3D%08x\n",
-			fbi->map_dma, fbi->map_cpu, fbi->fb-
>fix.smem_len);
+			fbi->map_dma, fbi->map_cpu, info-
>fix.smem_len);
 	}
=20
 	return fbi->map_cpu ? 0 : -ENOMEM;
@@ -660,8 +661,9 @@ static inline void modify_gpio(void __io
 /*
  * s3c2410fb_init_registers - Initialise all LCD-related=20
registers
  */
-static int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
+static int s3c2410fb_init_registers(struct fb_info *info)
 {
+	struct s3c2410fb_info *fbi =3D info->par;
 	unsigned long flags;
 	void __iomem *regs =3D fbi->io;
=20
@@ -684,7 +686,7 @@ static int s3c2410fb_init_registers(stru
 	writel(fbi->regs.lcdcon4, regs + S3C2410_LCDCON4);
 	writel(fbi->regs.lcdcon5, regs + S3C2410_LCDCON5);
=20
-	s3c2410fb_set_lcdaddr(fbi);
+	s3c2410fb_set_lcdaddr(info);
=20
 	dprintk("LPCSEL    =3D 0x%08lx\n", mach_info->lpcsel);
 	writel(mach_info->lpcsel, regs + S3C2410_LPCSEL);
@@ -777,7 +779,6 @@ static int __init s3c2410fb_probe(struct
 		return -ENOMEM;
=20
 	info =3D fbinfo->par;
-	info->fb =3D fbinfo;
 	info->dev =3D &pdev->dev;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -890,7 +891,7 @@ static int __init s3c2410fb_probe(struct
 	msleep(1);
=20
 	/* Initialize video memory */
-	ret =3D s3c2410fb_map_video_memory(info);
+	ret =3D s3c2410fb_map_video_memory(fbinfo);
 	if (ret) {
 		printk(KERN_ERR "Failed to allocate video RAM:
 %d\n", ret);
 		ret =3D -ENOMEM;
@@ -899,7 +900,7 @@ static int __init s3c2410fb_probe(struct
=20
 	dprintk("got video memory\n");
=20
-	s3c2410fb_init_registers(info);
+	s3c2410fb_init_registers(fbinfo);
=20
 	s3c2410fb_check_var(&fbinfo->var, fbinfo);
=20
diff -urp linux-2.6.23.old/drivers/video/s3c2410fb.h linux-
2.6.23/drivers/video/s3c2410fb.h
--- linux-2.6.23.old/drivers/video/s3c2410fb.h	2007-08-02=20
10:21:08.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.h	2007-08-03=20
07:16:50.000000000 +0200
@@ -26,7 +26,6 @@
 #define __S3C2410FB_H
=20
 struct s3c2410fb_info {
-	struct fb_info		*fb;
 	struct device		*dev;
 	struct clk		*clk;
=20


----------------------------------------------------
Jedni przybyli na Ziemi=EA, by nas zniszczy=E6. Inni - by nas chroni=E6.
"Transformers" - pe=B3en akcji film Stevena Spielberga
i Michaela Baya w kinach od 17 sierpnia.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Ftransforme=
rs.html&sid=3D1247

--part46b4672405741
Content-Type: application/octet-stream; name="s3c2410fb-remove-fb-field.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="s3c2410fb-remove-fb-field.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggcmVt
b3ZlcyByZWR1bmRhbnQgZmIgZmllbGQgZnJvbQp0aGUgczNjMjQxMGZiX2luZm8gc3RydWN0dXJl
LiBUaGlzIGJyZWFrcyBjaXJjdWxhcgpyZWZlcmVuY2UgZmJfaW5mbyAtPiBzM2MyNDEwZmJfaW5m
byAtPiBmYl9pbmZvIGFnYWluLgoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEhlbHQgPGtyenlz
enRvZi5oMUB3cC5wbD4KCi0tLQoKVGhpcyBwYXRjaCByZXF1aXJlcyBzM2MyNDEwZmItY2xlYW51
cCBwYXRjaCBJIHBvc3RlZCBlYXJsaWVyLgoKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJp
dmVycy92aWRlby9zM2MyNDEwZmIuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9zM2MyNDEw
ZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3MzYzI0MTBmYi5jCTIwMDct
MDgtMDMgMDc6MzA6MzEuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92
aWRlby9zM2MyNDEwZmIuYwkyMDA3LTA4LTAzIDA3OjI3OjQ4LjAwMDAwMDAwMCArMDIwMApAQCAt
MTE5LDE1ICsxMTksMTQgQEAgc3RhdGljIGludCBkZWJ1Zwk9IDA7CiAgKgogICogaW5pdGlhbGlz
ZSBsY2QgY29udHJvbGxlciBhZGRyZXNzIHBvaW50ZXJzCiAgKi8KLXN0YXRpYyB2b2lkIHMzYzI0
MTBmYl9zZXRfbGNkYWRkcihzdHJ1Y3QgczNjMjQxMGZiX2luZm8gKmZiaSkKK3N0YXRpYyB2b2lk
IHMzYzI0MTBmYl9zZXRfbGNkYWRkcihzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKLQlzdHJ1Y3Qg
ZmJfdmFyX3NjcmVlbmluZm8gKnZhciA9ICZmYmktPmZiLT52YXI7CiAJdW5zaWduZWQgbG9uZyBz
YWRkcjEsIHNhZGRyMiwgc2FkZHIzOwotCWludCBsaW5lX2xlbmd0aCA9IHZhci0+eHJlcyAqIHZh
ci0+Yml0c19wZXJfcGl4ZWw7CisJaW50IGxpbmVfbGVuZ3RoID0gaW5mby0+dmFyLnhyZXMgKiBp
bmZvLT52YXIuYml0c19wZXJfcGl4ZWw7CiAKLQlzYWRkcjEgID0gZmJpLT5mYi0+Zml4LnNtZW1f
c3RhcnQgPj4gMTsKLQlzYWRkcjIgID0gZmJpLT5mYi0+Zml4LnNtZW1fc3RhcnQ7Ci0Jc2FkZHIy
ICs9IChsaW5lX2xlbmd0aCAqIHZhci0+eXJlcykgLyA4OworCXNhZGRyMSAgPSBpbmZvLT5maXgu
c21lbV9zdGFydCA+PiAxOworCXNhZGRyMiAgPSBpbmZvLT5maXguc21lbV9zdGFydDsKKwlzYWRk
cjIgKz0gKGxpbmVfbGVuZ3RoICogaW5mby0+dmFyLnlyZXMpIC8gODsKIAlzYWRkcjIgPj49IDE7
CiAKIAlzYWRkcjMgPSBTM0MyNDEwX09GRlNJWkUoMCkgfApAQCAtMjc1LDkgKzI3NCwxMCBAQCBz
dGF0aWMgaW50IHMzYzI0MTBmYl9jaGVja192YXIoc3RydWN0IGZiCiAgKiBhY3RpdmF0ZSAoc2V0
KSB0aGUgY29udHJvbGxlciBmcm9tIHRoZSBnaXZlbiBmcmFtZWJ1ZmZlcgogICogaW5mb3JtYXRp
b24KICAqLwotc3RhdGljIHZvaWQgczNjMjQxMGZiX2FjdGl2YXRlX3ZhcihzdHJ1Y3QgczNjMjQx
MGZiX2luZm8gKmZiaSwKK3N0YXRpYyB2b2lkIHMzYzI0MTBmYl9hY3RpdmF0ZV92YXIoc3RydWN0
IGZiX2luZm8gKmluZm8sCiAJCQkJICAgc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIpCiB7
CisJc3RydWN0IHMzYzI0MTBmYl9pbmZvICpmYmkgPSBpbmZvLT5wYXI7CiAJaW50IGhzOwogCiAJ
ZmJpLT5yZWdzLmxjZGNvbjEgJj0gflMzQzI0MTBfTENEQ09OMV9NT0RFTUFTSzsKQEAgLTQxOCw3
ICs0MTgsNyBAQCBzdGF0aWMgdm9pZCBzM2MyNDEwZmJfYWN0aXZhdGVfdmFyKHN0cnVjCiAJd3Jp
dGVsKGZiaS0+cmVncy5sY2Rjb241LCBTM0MyNDEwX0xDRENPTjUpOwogCiAJLyogc2V0IGxjZCBh
ZGRyZXNzIHBvaW50ZXJzICovCi0JczNjMjQxMGZiX3NldF9sY2RhZGRyKGZiaSk7CisJczNjMjQx
MGZiX3NldF9sY2RhZGRyKGluZm8pOwogCiAJd3JpdGVsKGZiaS0+cmVncy5sY2Rjb24xLCBTM0My
NDEwX0xDRENPTjEpOwogfQpAQCAtNDMwLDcgKzQzMCw2IEBAIHN0YXRpYyB2b2lkIHMzYzI0MTBm
Yl9hY3RpdmF0ZV92YXIoc3RydWMKICAqLwogc3RhdGljIGludCBzM2MyNDEwZmJfc2V0X3Bhcihz
dHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKLQlzdHJ1Y3QgczNjMjQxMGZiX2luZm8gKmZiaSA9IGlu
Zm8tPnBhcjsKIAlzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciA9ICZpbmZvLT52YXI7CiAK
IAlzd2l0Y2ggKHZhci0+Yml0c19wZXJfcGl4ZWwpIHsKQEAgLTQ0OSw3ICs0NDgsNyBAQCBzdGF0
aWMgaW50IHMzYzI0MTBmYl9zZXRfcGFyKHN0cnVjdCBmYl9pCiAKIAkvKiBhY3RpdmF0ZSB0aGlz
IG5ldyBjb25maWd1cmF0aW9uICovCiAKLQlzM2MyNDEwZmJfYWN0aXZhdGVfdmFyKGZiaSwgdmFy
KTsKKwlzM2MyNDEwZmJfYWN0aXZhdGVfdmFyKGluZm8sIHZhcik7CiAJcmV0dXJuIDA7CiB9CiAK
QEAgLTYxNSwxNSArNjE0LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgZmJfb3BzIHMzYzI0MTBmYl9vcHMg
PSB7CiAgKgljYWNoZS4gIE9uY2UgdGhpcyBhcmVhIGlzIHJlbWFwcGVkLCBhbGwgdmlydHVhbCBt
ZW1vcnkKICAqCWFjY2VzcyB0byB0aGUgdmlkZW8gbWVtb3J5IHNob3VsZCBvY2N1ciBhdCB0aGUg
bmV3IHJlZ2lvbi4KICAqLwotc3RhdGljIGludCBfX2luaXQgczNjMjQxMGZiX21hcF92aWRlb19t
ZW1vcnkoc3RydWN0IHMzYzI0MTBmYl9pbmZvICpmYmkpCitzdGF0aWMgaW50IF9faW5pdCBzM2My
NDEwZmJfbWFwX3ZpZGVvX21lbW9yeShzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKKwlzdHJ1Y3Qg
czNjMjQxMGZiX2luZm8gKmZiaSA9IGluZm8tPnBhcjsKKwogCWRwcmludGsoIm1hcF92aWRlb19t
ZW1vcnkoZmJpPSVwKVxuIiwgZmJpKTsKIAotCWZiaS0+bWFwX3NpemUgPSBQQUdFX0FMSUdOKGZi
aS0+ZmItPmZpeC5zbWVtX2xlbiArIFBBR0VfU0laRSk7CisJZmJpLT5tYXBfc2l6ZSA9IFBBR0Vf
QUxJR04oaW5mby0+Zml4LnNtZW1fbGVuICsgUEFHRV9TSVpFKTsKIAlmYmktPm1hcF9jcHUgID0g
ZG1hX2FsbG9jX3dyaXRlY29tYmluZShmYmktPmRldiwgZmJpLT5tYXBfc2l6ZSwKIAkJCQkJICAg
ICAgICZmYmktPm1hcF9kbWEsIEdGUF9LRVJORUwpOwogCi0JZmJpLT5tYXBfc2l6ZSA9IGZiaS0+
ZmItPmZpeC5zbWVtX2xlbjsKKwlmYmktPm1hcF9zaXplID0gaW5mby0+Zml4LnNtZW1fbGVuOwog
CiAJaWYgKGZiaS0+bWFwX2NwdSkgewogCQkvKiBwcmV2ZW50IGluaXRpYWwgZ2FyYmFnZSBvbiBz
Y3JlZW4gKi8KQEAgLTYzMiwxMSArNjMzLDExIEBAIHN0YXRpYyBpbnQgX19pbml0IHMzYzI0MTBm
Yl9tYXBfdmlkZW9fbWUKIAkJbWVtc2V0KGZiaS0+bWFwX2NwdSwgMHhmMCwgZmJpLT5tYXBfc2l6
ZSk7CiAKIAkJZmJpLT5zY3JlZW5fZG1hCQk9IGZiaS0+bWFwX2RtYTsKLQkJZmJpLT5mYi0+c2Ny
ZWVuX2Jhc2UJPSBmYmktPm1hcF9jcHU7Ci0JCWZiaS0+ZmItPmZpeC5zbWVtX3N0YXJ0ICA9IGZi
aS0+c2NyZWVuX2RtYTsKKwkJaW5mby0+c2NyZWVuX2Jhc2UJPSBmYmktPm1hcF9jcHU7CisJCWlu
Zm8tPmZpeC5zbWVtX3N0YXJ0CT0gZmJpLT5zY3JlZW5fZG1hOwogCiAJCWRwcmludGsoIm1hcF92
aWRlb19tZW1vcnk6IGRtYT0lMDh4IGNwdT0lcCBzaXplPSUwOHhcbiIsCi0JCQlmYmktPm1hcF9k
bWEsIGZiaS0+bWFwX2NwdSwgZmJpLT5mYi0+Zml4LnNtZW1fbGVuKTsKKwkJCWZiaS0+bWFwX2Rt
YSwgZmJpLT5tYXBfY3B1LCBpbmZvLT5maXguc21lbV9sZW4pOwogCX0KIAogCXJldHVybiBmYmkt
Pm1hcF9jcHUgPyAwIDogLUVOT01FTTsKQEAgLTY2MCw4ICs2NjEsOSBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgbW9kaWZ5X2dwaW8odm9pZCBfX2lvCiAvKgogICogczNjMjQxMGZiX2luaXRfcmVnaXN0
ZXJzIC0gSW5pdGlhbGlzZSBhbGwgTENELXJlbGF0ZWQgcmVnaXN0ZXJzCiAgKi8KLXN0YXRpYyBp
bnQgczNjMjQxMGZiX2luaXRfcmVnaXN0ZXJzKHN0cnVjdCBzM2MyNDEwZmJfaW5mbyAqZmJpKQor
c3RhdGljIGludCBzM2MyNDEwZmJfaW5pdF9yZWdpc3RlcnMoc3RydWN0IGZiX2luZm8gKmluZm8p
CiB7CisJc3RydWN0IHMzYzI0MTBmYl9pbmZvICpmYmkgPSBpbmZvLT5wYXI7CiAJdW5zaWduZWQg
bG9uZyBmbGFnczsKIAl2b2lkIF9faW9tZW0gKnJlZ3MgPSBmYmktPmlvOwogCkBAIC02ODQsNyAr
Njg2LDcgQEAgc3RhdGljIGludCBzM2MyNDEwZmJfaW5pdF9yZWdpc3RlcnMoc3RydQogCXdyaXRl
bChmYmktPnJlZ3MubGNkY29uNCwgcmVncyArIFMzQzI0MTBfTENEQ09ONCk7CiAJd3JpdGVsKGZi
aS0+cmVncy5sY2Rjb241LCByZWdzICsgUzNDMjQxMF9MQ0RDT041KTsKIAotCXMzYzI0MTBmYl9z
ZXRfbGNkYWRkcihmYmkpOworCXMzYzI0MTBmYl9zZXRfbGNkYWRkcihpbmZvKTsKIAogCWRwcmlu
dGsoIkxQQ1NFTCAgICA9IDB4JTA4bHhcbiIsIG1hY2hfaW5mby0+bHBjc2VsKTsKIAl3cml0ZWwo
bWFjaF9pbmZvLT5scGNzZWwsIHJlZ3MgKyBTM0MyNDEwX0xQQ1NFTCk7CkBAIC03NzcsNyArNzc5
LDYgQEAgc3RhdGljIGludCBfX2luaXQgczNjMjQxMGZiX3Byb2JlKHN0cnVjdAogCQlyZXR1cm4g
LUVOT01FTTsKIAogCWluZm8gPSBmYmluZm8tPnBhcjsKLQlpbmZvLT5mYiA9IGZiaW5mbzsKIAlp
bmZvLT5kZXYgPSAmcGRldi0+ZGV2OwogCiAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBk
ZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKQEAgLTg5MCw3ICs4OTEsNyBAQCBzdGF0aWMgaW50IF9f
aW5pdCBzM2MyNDEwZmJfcHJvYmUoc3RydWN0CiAJbXNsZWVwKDEpOwogCiAJLyogSW5pdGlhbGl6
ZSB2aWRlbyBtZW1vcnkgKi8KLQlyZXQgPSBzM2MyNDEwZmJfbWFwX3ZpZGVvX21lbW9yeShpbmZv
KTsKKwlyZXQgPSBzM2MyNDEwZmJfbWFwX3ZpZGVvX21lbW9yeShmYmluZm8pOwogCWlmIChyZXQp
IHsKIAkJcHJpbnRrKEtFUk5fRVJSICJGYWlsZWQgdG8gYWxsb2NhdGUgdmlkZW8gUkFNOiAlZFxu
IiwgcmV0KTsKIAkJcmV0ID0gLUVOT01FTTsKQEAgLTg5OSw3ICs5MDAsNyBAQCBzdGF0aWMgaW50
IF9faW5pdCBzM2MyNDEwZmJfcHJvYmUoc3RydWN0CiAKIAlkcHJpbnRrKCJnb3QgdmlkZW8gbWVt
b3J5XG4iKTsKIAotCXMzYzI0MTBmYl9pbml0X3JlZ2lzdGVycyhpbmZvKTsKKwlzM2MyNDEwZmJf
aW5pdF9yZWdpc3RlcnMoZmJpbmZvKTsKIAogCXMzYzI0MTBmYl9jaGVja192YXIoJmZiaW5mby0+
dmFyLCBmYmluZm8pOwogCmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8v
czNjMjQxMGZiLmggbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vczNjMjQxMGZiLmgKLS0tIGxp
bnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuaAkyMDA3LTA4LTAyIDEwOjIx
OjA4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vczNjMjQx
MGZiLmgJMjAwNy0wOC0wMyAwNzoxNjo1MC4wMDAwMDAwMDAgKzAyMDAKQEAgLTI2LDcgKzI2LDYg
QEAKICNkZWZpbmUgX19TM0MyNDEwRkJfSAogCiBzdHJ1Y3QgczNjMjQxMGZiX2luZm8gewotCXN0
cnVjdCBmYl9pbmZvCQkqZmI7CiAJc3RydWN0IGRldmljZQkJKmRldjsKIAlzdHJ1Y3QgY2xrCQkq
Y2xrOwogCg==

--part46b4672405741
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46b4672405741
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46b4672405741--

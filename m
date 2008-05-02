From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] tridentfb: improve clock setting
	accuracy
Date: Fri, 02 May 2008 11:19:01 +0200
Message-ID: <481adc85b18f4@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part481adc85b40b5"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrrQ2-0008I8-AQ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 02:19:06 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1JrrQ0-0001vo-K6
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 02:19:06 -0700
Received: from poczta-19.free.wp-sa.pl (HELO localhost) ([10.1.1.98])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 2 May 2008 11:19:01 +0200
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

--part481adc85b40b5
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch improves clock calculation precision (to kHz from MHz)
and removes parameter field vclk from the tridentfb_par structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

If the patch below is mangled, another copy is attached.

diff -urp linux-old/drivers/video/tridentfb.c=20
linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-01 11:19:02.000000000=20
+0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-01 14:28:19.000000000 +020=
0
@@ -27,7 +27,6 @@
 #define VERSION		"0.7.8-NEWAPI"
=20
 struct tridentfb_par {
-	int vclk;		/* in MHz */
 	void __iomem *io_virt;	/* iospace virtual memory address */
 };
=20
@@ -669,27 +668,26 @@ static void set_screen_start(int base)
 		 (read3X4(CRTHiOrd) & 0xF8) | ((base & 0xE0000) >> 17));
 }
=20
-/* Use 20.12 fixed-point for NTSC value and frequency calculation */
-#define calc_freq(n, m, k)  ( ((unsigned long)0xE517 * (n + 8) / ((m +=20
2) * (1 << k))) >> 12 )
-
 /* Set dotclock frequency */
-static void set_vclk(int freq)
+static void set_vclk(unsigned long freq)
 {
 	int m, n, k;
-	int f, fi, d, di;
+	unsigned long f, fi, d, di;
 	unsigned char lo =3D 0, hi =3D 0;
=20
-	d =3D 20;
+	d =3D 20000;
 	for (k =3D 2; k >=3D 0; k--)
 		for (m =3D 0; m < 63; m++)
 			for (n =3D 0; n < 128; n++) {
-				fi =3D calc_freq(n, m, k);
+				fi =3D ((14318l * (n + 8)) / (m + 2)) >> k;
 				if ((di =3D abs(fi - freq)) < d) {
 					d =3D di;
 					f =3D fi;
 					lo =3D n;
 					hi =3D (k << 6) | m;
 				}
+				if (fi > freq)
+					break;
 			}
 	if (chip3D) {
 		write3C4(ClockHigh, hi);
@@ -888,6 +886,8 @@ static int tridentfb_set_par(struct fb_i
 	struct fb_var_screeninfo *var =3D &info->var;
 	int bpp =3D var->bits_per_pixel;
 	unsigned char tmp;
+	unsigned long vclk;
+
 	debug("enter\n");
 	hdispend =3D var->xres / 8 - 1;
 	hsyncstart =3D (var->xres + var->right_margin) / 8;
@@ -1015,11 +1015,11 @@ static int tridentfb_set_par(struct fb_i
 	write3X4(Performance, 0x92);
 	write3X4(PCIReg, 0x07);		/* MMIO & PCI read and write burst enable */
=20
-	/* convert from picoseconds to MHz */
-	par->vclk =3D 1000000 / info->var.pixclock;
+	/* convert from picoseconds to kHz */
+	vclk =3D PICOS2KHZ(info->var.pixclock);
 	if (bpp =3D=3D 32)
-		par->vclk *=3D 2;
-	set_vclk(par->vclk);
+		vclk *=3D 2;
+	set_vclk(vclk);
=20
 	write3C4(0, 3);
 	write3C4(1, 1);		/* set char clock 8 dots wide */

----------------------------------------------------
Nigdy nie spojrza=B3y sobie prosto w oczy.
Nigdy nie sp=EAdzi=B3y osobno nawet jednej chwili. Siostry.=20
Wspania=B3a opowie=B6=E6 o byciu naprawd=EA razem! =20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fcorto.www.wp.pl%2Fas%2Fsiostry.html=
&sid=3D336

--part481adc85b40b5
Content-Type: application/octet-stream; name="tridentfb-vclk-khz.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tridentfb-vclk-khz.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggaW1w
cm92ZXMgY2xvY2sgY2FsY3VsYXRpb24gcHJlY2lzaW9uICh0byBrSHogZnJvbSBNSHopCmFuZCBy
ZW1vdmVzIHBhcmFtZXRlciBmaWVsZCB2Y2xrIGZyb20gdGhlIHRyaWRlbnRmYl9wYXIgc3RydWN0
dXJlLgoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4K
CmRpZmYgLXVycCBsaW51eC1vbGQvZHJpdmVycy92aWRlby90cmlkZW50ZmIuYyBsaW51eC1wYy9k
cml2ZXJzL3ZpZGVvL3RyaWRlbnRmYi5jCi0tLSBsaW51eC1vbGQvZHJpdmVycy92aWRlby90cmlk
ZW50ZmIuYwkyMDA4LTA1LTAxIDExOjE5OjAyLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtcGMv
ZHJpdmVycy92aWRlby90cmlkZW50ZmIuYwkyMDA4LTA1LTAxIDE0OjI4OjE5LjAwMDAwMDAwMCAr
MDIwMApAQCAtMjcsNyArMjcsNiBAQAogI2RlZmluZSBWRVJTSU9OCQkiMC43LjgtTkVXQVBJIgog
CiBzdHJ1Y3QgdHJpZGVudGZiX3BhciB7Ci0JaW50IHZjbGs7CQkvKiBpbiBNSHogKi8KIAl2b2lk
IF9faW9tZW0gKmlvX3ZpcnQ7CS8qIGlvc3BhY2UgdmlydHVhbCBtZW1vcnkgYWRkcmVzcyAqLwog
fTsKIApAQCAtNjY5LDI3ICs2NjgsMjYgQEAgc3RhdGljIHZvaWQgc2V0X3NjcmVlbl9zdGFydChp
bnQgYmFzZSkKIAkJIChyZWFkM1g0KENSVEhpT3JkKSAmIDB4RjgpIHwgKChiYXNlICYgMHhFMDAw
MCkgPj4gMTcpKTsKIH0KIAotLyogVXNlIDIwLjEyIGZpeGVkLXBvaW50IGZvciBOVFNDIHZhbHVl
IGFuZCBmcmVxdWVuY3kgY2FsY3VsYXRpb24gKi8KLSNkZWZpbmUgY2FsY19mcmVxKG4sIG0sIGsp
ICAoICgodW5zaWduZWQgbG9uZykweEU1MTcgKiAobiArIDgpIC8gKChtICsgMikgKiAoMSA8PCBr
KSkpID4+IDEyICkKLQogLyogU2V0IGRvdGNsb2NrIGZyZXF1ZW5jeSAqLwotc3RhdGljIHZvaWQg
c2V0X3ZjbGsoaW50IGZyZXEpCitzdGF0aWMgdm9pZCBzZXRfdmNsayh1bnNpZ25lZCBsb25nIGZy
ZXEpCiB7CiAJaW50IG0sIG4sIGs7Ci0JaW50IGYsIGZpLCBkLCBkaTsKKwl1bnNpZ25lZCBsb25n
IGYsIGZpLCBkLCBkaTsKIAl1bnNpZ25lZCBjaGFyIGxvID0gMCwgaGkgPSAwOwogCi0JZCA9IDIw
OworCWQgPSAyMDAwMDsKIAlmb3IgKGsgPSAyOyBrID49IDA7IGstLSkKIAkJZm9yIChtID0gMDsg
bSA8IDYzOyBtKyspCiAJCQlmb3IgKG4gPSAwOyBuIDwgMTI4OyBuKyspIHsKLQkJCQlmaSA9IGNh
bGNfZnJlcShuLCBtLCBrKTsKKwkJCQlmaSA9ICgoMTQzMThsICogKG4gKyA4KSkgLyAobSArIDIp
KSA+PiBrOwogCQkJCWlmICgoZGkgPSBhYnMoZmkgLSBmcmVxKSkgPCBkKSB7CiAJCQkJCWQgPSBk
aTsKIAkJCQkJZiA9IGZpOwogCQkJCQlsbyA9IG47CiAJCQkJCWhpID0gKGsgPDwgNikgfCBtOwog
CQkJCX0KKwkJCQlpZiAoZmkgPiBmcmVxKQorCQkJCQlicmVhazsKIAkJCX0KIAlpZiAoY2hpcDNE
KSB7CiAJCXdyaXRlM0M0KENsb2NrSGlnaCwgaGkpOwpAQCAtODg4LDYgKzg4Niw4IEBAIHN0YXRp
YyBpbnQgdHJpZGVudGZiX3NldF9wYXIoc3RydWN0IGZiX2kKIAlzdHJ1Y3QgZmJfdmFyX3NjcmVl
bmluZm8gKnZhciA9ICZpbmZvLT52YXI7CiAJaW50IGJwcCA9IHZhci0+Yml0c19wZXJfcGl4ZWw7
CiAJdW5zaWduZWQgY2hhciB0bXA7CisJdW5zaWduZWQgbG9uZyB2Y2xrOworCiAJZGVidWcoImVu
dGVyXG4iKTsKIAloZGlzcGVuZCA9IHZhci0+eHJlcyAvIDggLSAxOwogCWhzeW5jc3RhcnQgPSAo
dmFyLT54cmVzICsgdmFyLT5yaWdodF9tYXJnaW4pIC8gODsKQEAgLTEwMTUsMTEgKzEwMTUsMTEg
QEAgc3RhdGljIGludCB0cmlkZW50ZmJfc2V0X3BhcihzdHJ1Y3QgZmJfaQogCXdyaXRlM1g0KFBl
cmZvcm1hbmNlLCAweDkyKTsKIAl3cml0ZTNYNChQQ0lSZWcsIDB4MDcpOwkJLyogTU1JTyAmIFBD
SSByZWFkIGFuZCB3cml0ZSBidXJzdCBlbmFibGUgKi8KIAotCS8qIGNvbnZlcnQgZnJvbSBwaWNv
c2Vjb25kcyB0byBNSHogKi8KLQlwYXItPnZjbGsgPSAxMDAwMDAwIC8gaW5mby0+dmFyLnBpeGNs
b2NrOworCS8qIGNvbnZlcnQgZnJvbSBwaWNvc2Vjb25kcyB0byBrSHogKi8KKwl2Y2xrID0gUElD
T1MyS0haKGluZm8tPnZhci5waXhjbG9jayk7CiAJaWYgKGJwcCA9PSAzMikKLQkJcGFyLT52Y2xr
ICo9IDI7Ci0Jc2V0X3ZjbGsocGFyLT52Y2xrKTsKKwkJdmNsayAqPSAyOworCXNldF92Y2xrKHZj
bGspOwogCiAJd3JpdGUzQzQoMCwgMyk7CiAJd3JpdGUzQzQoMSwgMSk7CQkvKiBzZXQgY2hhciBj
bG9jayA4IGRvdHMgd2lkZSAqLwo=

--part481adc85b40b5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--part481adc85b40b5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part481adc85b40b5--

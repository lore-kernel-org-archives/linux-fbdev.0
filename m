From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH 1/3] cirrusfb: remove typedefs
Date: Sat, 18 Aug 2007 08:20:21 +0200
Message-ID: <46c68fa5b14ae@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c68fa5b247f"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMHfg-00019e-9Y for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 23:20:28 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IMHfe-0004zf-I5
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 23:20:28 -0700
Received: from poczta-16.free.wp-sa.pl (HELO localhost) ([10.1.1.71])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	18 Aug 2007 08:20:21 +0200
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

This is a multi-part message in MIME format.

--part46c68fa5b247f
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces "typedef enum" with "enum type" constructs.
Using the typedef is error for the checkpatch.pl script.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.23.old/drivers/video/cirrusfb.c	2007-08-17 21:
07:43.000000000 +0200
+++ linux-2.6.23/drivers/video/cirrusfb.c	2007-08-18 06:35:
35.000000000 +0200
@@ -110,7 +110,7 @@
  */
=20
 /* board types */
-typedef enum {
+enum cirrus_board {
 	BT_NONE =3D 0,
 	BT_SD64,
 	BT_PICCOLO,
@@ -120,12 +120,12 @@ typedef enum {
 	BT_ALPINE,	/* GD543x/4x */
 	BT_GD5480,
 	BT_LAGUNA,	/* GD546x */
-} cirrusfb_board_t;
+};
=20
 /*
  * per-board-type information, used for enumerating and=20
abstracting
  * chip-specific information
- * NOTE: MUST be in the same order as cirrusfb_board_t in order=20
to
+ * NOTE: MUST be in the same order as enum cirrus_board in order=20
to
  * use direct indexing on this array
  * NOTE: '__initdata' cannot be used as some of this info
  * is required at runtime.  Maybe separate into an init-only and
@@ -361,10 +361,10 @@ struct cirrusfb_regs {
 };
=20
 #ifdef CIRRUSFB_DEBUG
-typedef enum {
+enum cirrusfb_dbg_reg_class {
 	CRT,
 	SEQ
-} cirrusfb_dbg_reg_class_t;
+};
 #endif		/* CIRRUSFB_DEBUG */
=20
 /* info about board */
@@ -375,7 +375,7 @@ struct cirrusfb_info {
 	u8 __iomem *regbase;
 	u8 __iomem *mem;
 	unsigned long size;
-	cirrusfb_board_t btype;
+	enum cirrus_board btype;
 	unsigned char SFR;	/* Shadow of special function=20
register */
=20
 	unsigned long fbmem_phys;
@@ -571,7 +571,7 @@ static void bestclock(long freq, long *b
 static void cirrusfb_dump(void);
 static void cirrusfb_dbg_reg_dump(caddr_t regbase);
 static void cirrusfb_dbg_print_regs(caddr_t regbase,
-				    cirrusfb_dbg_reg_class_t reg_class, ...);
+				    enum cirrusfb_dbg_reg_class reg_class, ...);
 static void cirrusfb_dbg_print_byte(const char *name, unsigned=20
char val);
 #endif /* CIRRUSFB_DEBUG */
=20
@@ -2449,7 +2449,7 @@ static int cirrusfb_register(struct cirr
 {
 	struct fb_info *info;
 	int err;
-	cirrusfb_board_t btype;
+	enum cirrus_board btype;
=20
 	DPRINTK("ENTER\n");
=20
@@ -2517,7 +2517,7 @@ static int cirrusfb_pci_register(struct=20
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
-	cirrusfb_board_t btype;
+	enum cirrus_board btype;
 	unsigned long board_addr, board_size;
 	int ret;
=20
@@ -2537,11 +2537,11 @@ static int cirrusfb_pci_register(struct=20
 	cinfo =3D info->par;
 	cinfo->info =3D info;
 	cinfo->pdev =3D pdev;
-	cinfo->btype =3D btype =3D (cirrusfb_board_t) ent->driver_data;
+	cinfo->btype =3D btype =3D (enum cirrus_board)=20
ent->driver_data;
=20
-	DPRINTK(" Found PCI device, base address 0 is 0x%lx, btype=20
set to %d\n",
+	DPRINTK(" Found PCI device, base address 0 is 0x%x, btype=20
set to %d\n",
 		pdev->resource[0].start, btype);
-	DPRINTK(" base address 1 is 0x%lx\n", pdev->resource[1].
start);
+	DPRINTK(" base address 1 is 0x%x\n", pdev->resource[1].
start);
=20
 	if (isPReP) {
 		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0,=20
0x00000000);
@@ -2647,7 +2647,7 @@ static int cirrusfb_zorro_register(struc
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
-	cirrusfb_board_t btype;
+	enum cirrus_board btype;
 	struct zorro_dev *z2 =3D NULL;
 	unsigned long board_addr, board_size, size;
 	int ret;
@@ -3353,7 +3353,7 @@ void cirrusfb_dbg_print_byte(const char=20
=20
 static
 void cirrusfb_dbg_print_regs(caddr_t regbase,
-			     cirrusfb_dbg_reg_class_t reg_class, ...)
+			     enum cirrusfb_dbg_reg_class reg_class, ...)
 {
 	va_list list;
 	unsigned char val =3D 0;


----------------------------------------------------
Czy na wakacje warto zabra=E6 laptopa?
Zobacz gdzie dzia=B3aj=B1 strefy darmowego, bezprzewodowego Internetu!
Kliknij: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd=
128.html&sid=3D1259

--part46c68fa5b247f
Content-Type: application/octet-stream; name="cirrusfb-remove-typedefs.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cirrusfb-remove-typedefs.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggcmVw
bGFjZXMgInR5cGVkZWYgZW51bSIgd2l0aCAiZW51bSB0eXBlIiBjb25zdHJ1Y3RzLgpVc2luZyB0
aGUgdHlwZWRlZiBpcyBlcnJvciBmb3IgdGhlIGNoZWNrcGF0Y2gucGwgc2NyaXB0LgoKU2lnbmVk
LW9mZi1ieTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KCi0tLQoKLS0tIGxp
bnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9jaXJydXNmYi5jCTIwMDctMDgtMTcgMjE6MDc6
NDMuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9jaXJydXNm
Yi5jCTIwMDctMDgtMTggMDY6MzU6MzUuMDAwMDAwMDAwICswMjAwCkBAIC0xMTAsNyArMTEwLDcg
QEAKICAqLwogCiAvKiBib2FyZCB0eXBlcyAqLwotdHlwZWRlZiBlbnVtIHsKK2VudW0gY2lycnVz
X2JvYXJkIHsKIAlCVF9OT05FID0gMCwKIAlCVF9TRDY0LAogCUJUX1BJQ0NPTE8sCkBAIC0xMjAs
MTIgKzEyMCwxMiBAQCB0eXBlZGVmIGVudW0gewogCUJUX0FMUElORSwJLyogR0Q1NDN4LzR4ICov
CiAJQlRfR0Q1NDgwLAogCUJUX0xBR1VOQSwJLyogR0Q1NDZ4ICovCi19IGNpcnJ1c2ZiX2JvYXJk
X3Q7Cit9OwogCiAvKgogICogcGVyLWJvYXJkLXR5cGUgaW5mb3JtYXRpb24sIHVzZWQgZm9yIGVu
dW1lcmF0aW5nIGFuZCBhYnN0cmFjdGluZwogICogY2hpcC1zcGVjaWZpYyBpbmZvcm1hdGlvbgot
ICogTk9URTogTVVTVCBiZSBpbiB0aGUgc2FtZSBvcmRlciBhcyBjaXJydXNmYl9ib2FyZF90IGlu
IG9yZGVyIHRvCisgKiBOT1RFOiBNVVNUIGJlIGluIHRoZSBzYW1lIG9yZGVyIGFzIGVudW0gY2ly
cnVzX2JvYXJkIGluIG9yZGVyIHRvCiAgKiB1c2UgZGlyZWN0IGluZGV4aW5nIG9uIHRoaXMgYXJy
YXkKICAqIE5PVEU6ICdfX2luaXRkYXRhJyBjYW5ub3QgYmUgdXNlZCBhcyBzb21lIG9mIHRoaXMg
aW5mbwogICogaXMgcmVxdWlyZWQgYXQgcnVudGltZS4gIE1heWJlIHNlcGFyYXRlIGludG8gYW4g
aW5pdC1vbmx5IGFuZApAQCAtMzYxLDEwICszNjEsMTAgQEAgc3RydWN0IGNpcnJ1c2ZiX3JlZ3Mg
ewogfTsKIAogI2lmZGVmIENJUlJVU0ZCX0RFQlVHCi10eXBlZGVmIGVudW0geworZW51bSBjaXJy
dXNmYl9kYmdfcmVnX2NsYXNzIHsKIAlDUlQsCiAJU0VRCi19IGNpcnJ1c2ZiX2RiZ19yZWdfY2xh
c3NfdDsKK307CiAjZW5kaWYJCS8qIENJUlJVU0ZCX0RFQlVHICovCiAKIC8qIGluZm8gYWJvdXQg
Ym9hcmQgKi8KQEAgLTM3NSw3ICszNzUsNyBAQCBzdHJ1Y3QgY2lycnVzZmJfaW5mbyB7CiAJdTgg
X19pb21lbSAqcmVnYmFzZTsKIAl1OCBfX2lvbWVtICptZW07CiAJdW5zaWduZWQgbG9uZyBzaXpl
OwotCWNpcnJ1c2ZiX2JvYXJkX3QgYnR5cGU7CisJZW51bSBjaXJydXNfYm9hcmQgYnR5cGU7CiAJ
dW5zaWduZWQgY2hhciBTRlI7CS8qIFNoYWRvdyBvZiBzcGVjaWFsIGZ1bmN0aW9uIHJlZ2lzdGVy
ICovCiAKIAl1bnNpZ25lZCBsb25nIGZibWVtX3BoeXM7CkBAIC01NzEsNyArNTcxLDcgQEAgc3Rh
dGljIHZvaWQgYmVzdGNsb2NrKGxvbmcgZnJlcSwgbG9uZyAqYgogc3RhdGljIHZvaWQgY2lycnVz
ZmJfZHVtcCh2b2lkKTsKIHN0YXRpYyB2b2lkIGNpcnJ1c2ZiX2RiZ19yZWdfZHVtcChjYWRkcl90
IHJlZ2Jhc2UpOwogc3RhdGljIHZvaWQgY2lycnVzZmJfZGJnX3ByaW50X3JlZ3MoY2FkZHJfdCBy
ZWdiYXNlLAotCQkJCSAgICBjaXJydXNmYl9kYmdfcmVnX2NsYXNzX3QgcmVnX2NsYXNzLCAuLi4p
OworCQkJCSAgICBlbnVtIGNpcnJ1c2ZiX2RiZ19yZWdfY2xhc3MgcmVnX2NsYXNzLCAuLi4pOwog
c3RhdGljIHZvaWQgY2lycnVzZmJfZGJnX3ByaW50X2J5dGUoY29uc3QgY2hhciAqbmFtZSwgdW5z
aWduZWQgY2hhciB2YWwpOwogI2VuZGlmIC8qIENJUlJVU0ZCX0RFQlVHICovCiAKQEAgLTI0NDks
NyArMjQ0OSw3IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfcmVnaXN0ZXIoc3RydWN0IGNpcnIKIHsK
IAlzdHJ1Y3QgZmJfaW5mbyAqaW5mbzsKIAlpbnQgZXJyOwotCWNpcnJ1c2ZiX2JvYXJkX3QgYnR5
cGU7CisJZW51bSBjaXJydXNfYm9hcmQgYnR5cGU7CiAKIAlEUFJJTlRLKCJFTlRFUlxuIik7CiAK
QEAgLTI1MTcsNyArMjUxNyw3IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfcGNpX3JlZ2lzdGVyKHN0
cnVjdCAKIHsKIAlzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm87CiAJc3RydWN0IGZiX2luZm8g
KmluZm87Ci0JY2lycnVzZmJfYm9hcmRfdCBidHlwZTsKKwllbnVtIGNpcnJ1c19ib2FyZCBidHlw
ZTsKIAl1bnNpZ25lZCBsb25nIGJvYXJkX2FkZHIsIGJvYXJkX3NpemU7CiAJaW50IHJldDsKIApA
QCAtMjUzNywxMSArMjUzNywxMSBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3BjaV9yZWdpc3Rlcihz
dHJ1Y3QgCiAJY2luZm8gPSBpbmZvLT5wYXI7CiAJY2luZm8tPmluZm8gPSBpbmZvOwogCWNpbmZv
LT5wZGV2ID0gcGRldjsKLQljaW5mby0+YnR5cGUgPSBidHlwZSA9IChjaXJydXNmYl9ib2FyZF90
KSBlbnQtPmRyaXZlcl9kYXRhOworCWNpbmZvLT5idHlwZSA9IGJ0eXBlID0gKGVudW0gY2lycnVz
X2JvYXJkKSBlbnQtPmRyaXZlcl9kYXRhOwogCi0JRFBSSU5USygiIEZvdW5kIFBDSSBkZXZpY2Us
IGJhc2UgYWRkcmVzcyAwIGlzIDB4JWx4LCBidHlwZSBzZXQgdG8gJWRcbiIsCisJRFBSSU5USygi
IEZvdW5kIFBDSSBkZXZpY2UsIGJhc2UgYWRkcmVzcyAwIGlzIDB4JXgsIGJ0eXBlIHNldCB0byAl
ZFxuIiwKIAkJcGRldi0+cmVzb3VyY2VbMF0uc3RhcnQsIGJ0eXBlKTsKLQlEUFJJTlRLKCIgYmFz
ZSBhZGRyZXNzIDEgaXMgMHglbHhcbiIsIHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0KTsKKwlEUFJJ
TlRLKCIgYmFzZSBhZGRyZXNzIDEgaXMgMHgleFxuIiwgcGRldi0+cmVzb3VyY2VbMV0uc3RhcnQp
OwogCiAJaWYgKGlzUFJlUCkgewogCQlwY2lfd3JpdGVfY29uZmlnX2R3b3JkKHBkZXYsIFBDSV9C
QVNFX0FERFJFU1NfMCwgMHgwMDAwMDAwMCk7CkBAIC0yNjQ3LDcgKzI2NDcsNyBAQCBzdGF0aWMg
aW50IGNpcnJ1c2ZiX3pvcnJvX3JlZ2lzdGVyKHN0cnVjCiB7CiAJc3RydWN0IGNpcnJ1c2ZiX2lu
Zm8gKmNpbmZvOwogCXN0cnVjdCBmYl9pbmZvICppbmZvOwotCWNpcnJ1c2ZiX2JvYXJkX3QgYnR5
cGU7CisJZW51bSBjaXJydXNfYm9hcmQgYnR5cGU7CiAJc3RydWN0IHpvcnJvX2RldiAqejIgPSBO
VUxMOwogCXVuc2lnbmVkIGxvbmcgYm9hcmRfYWRkciwgYm9hcmRfc2l6ZSwgc2l6ZTsKIAlpbnQg
cmV0OwpAQCAtMzM1Myw3ICszMzUzLDcgQEAgdm9pZCBjaXJydXNmYl9kYmdfcHJpbnRfYnl0ZShj
b25zdCBjaGFyIAogCiBzdGF0aWMKIHZvaWQgY2lycnVzZmJfZGJnX3ByaW50X3JlZ3MoY2FkZHJf
dCByZWdiYXNlLAotCQkJICAgICBjaXJydXNmYl9kYmdfcmVnX2NsYXNzX3QgcmVnX2NsYXNzLCAu
Li4pCisJCQkgICAgIGVudW0gY2lycnVzZmJfZGJnX3JlZ19jbGFzcyByZWdfY2xhc3MsIC4uLikK
IHsKIAl2YV9saXN0IGxpc3Q7CiAJdW5zaWduZWQgY2hhciB2YWwgPSAwOwo=

--part46c68fa5b247f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c68fa5b247f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c68fa5b247f--

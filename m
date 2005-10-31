From: syrjala@sci.fi
Subject: [PATCH 3/5] matroxfb: Use CACHEFLUSH on all chips
Date: Tue,  1 Nov 2005 00:12:20 +0200 (EET)
Message-ID: <20051031221220.8B3AE317@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWhtF-0004Rc-CM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:29 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EWhtC-0005as-6B
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:29 -0800
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
MIME-Version: 1.0
Content-Type: text; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

Use the CACHEFLUSH register on all chip types. The register is listed=20
in all other specs except 2064W. However I have verified that the=20
register does work on a 2064W despite being marked reserved in the=20
specs. There were no noticeable side effects after writing to the=20
register.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 matroxfb_DAC1064.c |    2 --
 matroxfb_base.c    |    9 ++-------
 matroxfb_base.h    |    5 -----
 3 files changed, 2 insertions(+), 14 deletions(-)

diff -uprN linux-2.6.14-2/drivers/video/matrox/matroxfb_base.c linux-2.6.14=
-3/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.14-2/drivers/video/matrox/matroxfb_base.c	2005-10-31 17:45:41=
.000000000 +0200
+++ linux-2.6.14-3/drivers/video/matrox/matroxfb_base.c	2005-10-31 19:40:02=
.000000000 +0200
@@ -1283,7 +1283,7 @@ static int matroxfb_getmemory(WPMINFO un
 	vaddr_t vm;
 	unsigned int offs;
 	unsigned int offs2;
-	unsigned char store, orig;
+	unsigned char orig;
 	unsigned char bytes[32];
 	unsigned char* tmp;
=20
@@ -1299,16 +1299,12 @@ static int matroxfb_getmemory(WPMINFO un
 	orig =3D mga_inb(M_EXTVGA_DATA);
 	mga_outb(M_EXTVGA_DATA, orig | 0x80);
=20
-	store =3D mga_readb(vm, 0x1234);
 	tmp =3D bytes;
 	for (offs =3D 0x100000; offs < maxSize; offs +=3D 0x200000)
 		*tmp++ =3D mga_readb(vm, offs);
 	for (offs =3D 0x100000; offs < maxSize; offs +=3D 0x200000)
 		mga_writeb(vm, offs, 0x02);
-	if (ACCESS_FBINFO(features.accel.has_cacheflush))
-		mga_outb(M_CACHEFLUSH, 0x00);
-	else
-		mga_writeb(vm, 0x1234, 0x99);
+	mga_outb(M_CACHEFLUSH, 0x00);
 	for (offs =3D 0x100000; offs < maxSize; offs +=3D 0x200000) {
 		if (mga_readb(vm, offs) !=3D 0x02)
 			break;
@@ -1319,7 +1315,6 @@ static int matroxfb_getmemory(WPMINFO un
 	tmp =3D bytes;
 	for (offs2 =3D 0x100000; offs2 < maxSize; offs2 +=3D 0x200000)
 		mga_writeb(vm, offs2, *tmp++);
-	mga_writeb(vm, 0x1234, store);
=20
 	mga_outb(M_EXTVGA_INDEX, 0x03);
 	mga_outb(M_EXTVGA_DATA, orig);
diff -uprN linux-2.6.14-2/drivers/video/matrox/matroxfb_base.h linux-2.6.14=
-3/drivers/video/matrox/matroxfb_base.h
--- linux-2.6.14-2/drivers/video/matrox/matroxfb_base.h	2005-10-31 17:44:36=
.000000000 +0200
+++ linux-2.6.14-3/drivers/video/matrox/matroxfb_base.h	2005-10-31 19:40:02=
.000000000 +0200
@@ -272,10 +272,6 @@ struct matrox_DAC1064_features {
 	u_int8_t	xmiscctrl;
 };
=20
-struct matrox_accel_features {
-	int		has_cacheflush;
-};
-
 /* current hardware status */
 struct mavenregs {
 	u_int8_t regs[256];
@@ -440,7 +436,6 @@ struct matrox_fb_info {
 	struct {
 		struct matrox_pll_features pll;
 		struct matrox_DAC1064_features DAC1064;
-		struct matrox_accel_features accel;
 			      } features;
 	struct {
 		spinlock_t	DAC;
diff -uprN linux-2.6.14-2/drivers/video/matrox/matroxfb_DAC1064.c linux-2.6=
.14-3/drivers/video/matrox/matroxfb_DAC1064.c
--- linux-2.6.14-2/drivers/video/matrox/matroxfb_DAC1064.c	2005-10-31 17:44=
:36.000000000 +0200
+++ linux-2.6.14-3/drivers/video/matrox/matroxfb_DAC1064.c	2005-10-31 19:40=
:02.000000000 +0200
@@ -657,7 +657,6 @@ static int MGA1064_preinit(WPMINFO2) {
 	/* ACCESS_FBINFO(capable.cfb4) =3D 0; ... preinitialized by 0 */
 	ACCESS_FBINFO(capable.text) =3D 1;
 	ACCESS_FBINFO(capable.vxres) =3D vxres_mystique;
-	ACCESS_FBINFO(features.accel.has_cacheflush) =3D 1;
=20
 	ACCESS_FBINFO(outputs[0]).output =3D &m1064;
 	ACCESS_FBINFO(outputs[0]).src =3D ACCESS_FBINFO(outputs[0]).default_src;
@@ -842,7 +841,6 @@ static int MGAG100_preinit(WPMINFO2) {
 	/* ACCESS_FBINFO(capable.cfb4) =3D 0; ... preinitialized by 0 */
 	ACCESS_FBINFO(capable.text) =3D 1;
 	ACCESS_FBINFO(capable.vxres) =3D vxres_g100;
-	ACCESS_FBINFO(features.accel.has_cacheflush) =3D 1;
 	ACCESS_FBINFO(capable.plnwt) =3D ACCESS_FBINFO(devflags.accelerator) =3D=
=3D FB_ACCEL_MATROX_MGAG100
 			? ACCESS_FBINFO(devflags.sgram) : 1;
=20



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information

From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH 3/5]: rivafb fixes
Date: 16 Feb 2003 14:08:51 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045375693.1823.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aLQ6a/jK15w+7CmXNOao"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kI0Q-0005Zr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Feb 2003 22:10:27 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-aLQ6a/jK15w+7CmXNOao
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch (linux-2.5.61 + James' fbdev.diff) to fix the "green screen" problem on module load, 
and compilation warnings.

Tony




--=-aLQ6a/jK15w+7CmXNOao
Content-Disposition: attachment; filename=rivafb4.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=rivafb4.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61-fbdev/drivers/video/riva/fbdev.c linux-2.5.61-ad/dr=
ivers/video/riva/fbdev.c
--- linux-2.5.61-fbdev/drivers/video/riva/fbdev.c	2003-02-16 00:55:53.00000=
0000 +0000
+++ linux-2.5.61-ad/drivers/video/riva/fbdev.c	2003-02-16 02:52:37.00000000=
0 +0000
@@ -286,7 +286,6 @@
=20
 /* command line data, set in rivafb_setup() */
 static u32 pseudo_palette[17];
-static int noblink =3D 0;
 static int flatpanel __initdata =3D -1; /* Autodetect later */
 static int forceCRTC __initdata =3D -1;
 #ifdef CONFIG_MTRR
@@ -1380,15 +1379,16 @@
  * CALLED FROM:
  * framebuffer hook
  */
-static void rivafb_imageblit(struct fb_info *info, const struct fb_image *=
image)
+static void rivafb_imageblit(struct fb_info *info,=20
+			     const struct fb_image *image)
 {
 	struct riva_par *par =3D (struct riva_par *) info->par;
 	u32 fgx =3D 0, bgx =3D 0, width, mod, tmp;
-	u8 *cdat =3D image->data;
+	u8 *cdat =3D (u8 *) image->data;
 	volatile u32 *d;
 	int i, j, k, size;
=20
-	if (image->depth !=3D 1) {
+	if (image->depth !=3D 0) {
 		wait_for_idle(par);
 		cfb_imageblit(info, image);
 		return;
@@ -1854,8 +1854,8 @@
 		default_par->riva.PCRTC =3D default_par->riva.PCRTC0 =3D default_par->ri=
va.PGRAPH;
 	}
=20
-	rivafb_fix.smem_len =3D default_par->riva.RamAmountKBytes * 1024;
-	default_par->dclk_max =3D default_par->riva.MaxVClockFreqKHz * 1000;
+	rivafb_fix.smem_len =3D riva_get_memlen(default_par) * 1024;
+	default_par->dclk_max =3D riva_get_maxdclk(default_par) * 1000;
=20
 	if (!request_mem_region(rivafb_fix.smem_start,
 				rivafb_fix.smem_len, "rivafb")) {
@@ -1976,8 +1976,6 @@
 	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
 		if (!*this_opt)
 			continue;
-		if (!strncmp(this_opt, "noblink", 7)) {
-			noblink =3D 1;
 #ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr =3D 1;
@@ -2016,7 +2014,10 @@
=20
 int __init rivafb_init(void)
 {
-	return pci_module_init(&rivafb_driver);
+	if (pci_register_driver(&rivafb_driver) > 0)
+		return 0;
+	pci_unregister_driver(&rivafb_driver);
+	return -ENODEV;
 }
=20
=20
@@ -2029,8 +2030,6 @@
 module_init(rivafb_init);
 module_exit(rivafb_exit);
=20
-MODULE_PARM(noblink, "i");
-MODULE_PARM_DESC(noblink, "Disables hardware cursor blinking (0 or 1=3Ddis=
abled) (default=3D0)");
 MODULE_PARM(flatpanel, "i");
 MODULE_PARM_DESC(flatpanel, "Enables experimental flat panel support for s=
ome chipsets. (0 or 1=3Denabled) (default=3D0)");
 MODULE_PARM(forceCRTC, "i");
diff -Naur linux-2.5.61-fbdev/drivers/video/riva/nv_driver.c linux-2.5.61-a=
d/drivers/video/riva/nv_driver.c
--- linux-2.5.61-fbdev/drivers/video/riva/nv_driver.c	2003-02-16 00:48:53.0=
00000000 +0000
+++ linux-2.5.61-ad/drivers/video/riva/nv_driver.c	2003-02-16 02:52:37.0000=
00000 +0000
@@ -35,6 +35,7 @@
 5 20:47:06 mvojkovi Exp $ */
=20
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include "nv_type.h"
 #include "rivafb.h"
@@ -133,6 +134,159 @@
 	riva_override_CRTC(par);
 }
=20
+unsigned long riva_get_memlen(struct riva_par *par)
+{
+	RIVA_HW_INST *chip =3D &par->riva;
+	unsigned long memlen =3D 0;
+	unsigned int chipset =3D par->Chipset;
+	struct pci_dev* dev;
+	int amt;
+
+	switch (chip->Architecture) {
+	case NV_ARCH_03:
+		if (chip->PFB[0x00000000/4] & 0x00000020) {
+			if (((chip->PMC[0x00000000/4] & 0xF0) =3D=3D 0x20)
+			    && ((chip->PMC[0x00000000/4] & 0x0F) >=3D 0x02)) {
+				/*
+				 * SDRAM 128 ZX.
+				 */
+				switch (chip->PFB[0x00000000/4] & 0x03) {
+				case 2:
+					memlen =3D 1024 * 4;
+					break;
+				case 1:
+					memlen =3D 1024 * 2;
+					break;
+				default:
+					memlen =3D 1024 * 8;
+					break;
+				}
+			} else {
+				memlen =3D 1024 * 8;
+			}           =20
+		} else 	{
+			/*
+			 * SGRAM 128.
+			 */
+			switch (chip->PFB[0x00000000/4] & 0x00000003) {
+			case 0:
+				memlen =3D 1024 * 8;
+				break;
+			case 2:
+				memlen =3D 1024 * 4;
+				break;
+			default:
+				memlen =3D 1024 * 2;
+				break;
+			}
+		}       =20
+		break;
+	case NV_ARCH_04:
+		if (chip->PFB[0x00000000/4] & 0x00000100) {
+			memlen =3D ((chip->PFB[0x00000000/4] >> 12) & 0x0F) *=20
+				1024 * 2 + 1024 * 2;
+		} else {
+			switch (chip->PFB[0x00000000/4] & 0x00000003) {
+			case 0:
+				memlen =3D 1024 * 32;
+				break;
+			case 1:
+				memlen =3D 1024 * 4;
+				break;
+			case 2:
+				memlen =3D 1024 * 8;
+				break;
+			case 3:
+			default:
+				memlen =3D 1024 * 16;
+				break;
+			}
+		}
+		break;
+	case NV_ARCH_10:
+	case NV_ARCH_20:
+		if(chipset =3D=3D NV_CHIP_IGEFORCE2) {
+
+			dev =3D pci_find_slot(0, 1);
+			pci_read_config_dword(dev, 0x7C, &amt);
+			memlen =3D (((amt >> 6) & 31) + 1) * 1024;
+		} else if (chipset =3D=3D NV_CHIP_0x01F0) {
+			dev =3D pci_find_slot(0, 1);
+			pci_read_config_dword(dev, 0x84, &amt);
+			memlen =3D (((amt >> 4) & 127) + 1) * 1024;
+		} else {
+			switch ((chip->PFB[0x0000020C/4] >> 20) & 0x000000FF){
+			case 0x02:
+				memlen =3D 1024 * 2;
+				break;
+			case 0x04:
+				memlen =3D 1024 * 4;
+				break;
+			case 0x08:
+				memlen =3D 1024 * 8;
+				break;
+			case 0x10:
+				memlen =3D 1024 * 16;
+				break;
+			case 0x20:
+				memlen =3D 1024 * 32;
+				break;
+			case 0x40:
+				memlen =3D 1024 * 64;
+				break;
+			case 0x80:
+				memlen =3D 1024 * 128;
+				break;
+			default:
+				memlen =3D 1024 * 16;
+				break;
+			}
+		}
+		break;
+	}
+	return memlen;
+}
+
+unsigned long riva_get_maxdclk(struct riva_par *par)
+{
+	RIVA_HW_INST *chip =3D &par->riva;
+	unsigned long dclk =3D 0;
+
+	switch (chip->Architecture) {
+	case NV_ARCH_03:
+		if (chip->PFB[0x00000000/4] & 0x00000020) {
+			if (((chip->PMC[0x00000000/4] & 0xF0) =3D=3D 0x20)
+			    && ((chip->PMC[0x00000000/4] & 0x0F) >=3D 0x02)) {  =20
+				/*
+				 * SDRAM 128 ZX.
+				 */
+				dclk =3D 800000;
+			} else {
+				dclk =3D 1000000;
+			}           =20
+		} else {
+			/*
+			 * SGRAM 128.
+			 */
+			dclk =3D 1000000;
+		}=20
+		break;
+	case NV_ARCH_04:
+	case NV_ARCH_10:
+	case NV_ARCH_20:
+		switch ((chip->PFB[0x00000000/4] >> 3) & 0x00000003) {
+		case 3:
+			dclk =3D 800000;
+			break;
+		default:
+			dclk =3D 1000000;
+			break;
+		}
+		break;
+	}
+	return dclk;
+}
+
 void
 riva_common_setup(struct riva_par *par)
 {
@@ -201,8 +355,6 @@
 		par->riva.PDIO =3D par->riva.PDIO0;
 	}
=20
-	RivaGetConfig(&par->riva, par->Chipset);
-
 	if (par->FlatPanel =3D=3D -1) {
 		/* Fix me, need x86 DDC code */
 		par->FlatPanel =3D 0;
diff -Naur linux-2.5.61-fbdev/drivers/video/riva/rivafb.h linux-2.5.61-ad/d=
rivers/video/riva/rivafb.h
--- linux-2.5.61-fbdev/drivers/video/riva/rivafb.h	2003-02-16 00:48:53.0000=
00000 +0000
+++ linux-2.5.61-ad/drivers/video/riva/rivafb.h	2003-02-16 02:52:39.0000000=
00 +0000
@@ -55,5 +55,7 @@
 };
=20
 void riva_common_setup(struct riva_par *);
+unsigned long riva_get_memlen(struct riva_par *);
+unsigned long riva_get_maxdclk(struct riva_par *);
=20
 #endif /* __RIVAFB_H */

--=-aLQ6a/jK15w+7CmXNOao--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

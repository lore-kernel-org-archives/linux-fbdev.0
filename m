From: "Phil Endecott" <phil_wueww_endecott@chezphil.org>
Subject: [PATCH] intelfb: support 945GME (as used in ASUS Eee 901)
Date: Fri, 29 Aug 2008 12:50:45 +0100
Message-ID: <1220010645384@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757178AbYH2LvA@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; format="fixed"; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: sylvain.meyer@worldonline.fr, linux-fbdev-devel@lists.sourceforge.net

The following patch adds support for Intel's 945GME graphics chip to
the intelfb driver.  I have assumed that the 945GME is identical to the
already-supported 945GM apart from its PCI IDs; this is based on a quick
look at the X driver for these chips which seems to treat them
identically.

Signed-off-by: Phil Endecott <spam_from_intelfb@chezphil.org>

---

The 945GME is used in the ASUS Eee 901, and I coded this in the hope that=20
I'd be able to use it to get a console at the native 1024x600 resolution=20
which is not known to the BIOS.  I realised too late that the intelfb=20
driver does not support mode changing on laptops, so it won't be any=20
use for me.  But rather than throw it away I will post it here as=20
essentially "untested"; maybe someone who knows more about this driver,=20
and with more useful hardware to test on, can pick it up.

diff --git a/Documentation/fb/intelfb.txt b/Documentation/fb/intelfb.txt
index 27a3160..dd9e944 100644
--- a/Documentation/fb/intelfb.txt
+++ b/Documentation/fb/intelfb.txt
@@ -14,6 +14,7 @@ graphics devices.  These would include:
 	Intel 915GM
 	Intel 945G
 	Intel 945GM
+	Intel 945GME
 	Intel 965G
 	Intel 965GM
=20
diff --git a/drivers/video/intelfb/intelfb.h b/drivers/video/intelfb/intelf=
b.h
index 3325fbd..a50bea6 100644
--- a/drivers/video/intelfb/intelfb.h
+++ b/drivers/video/intelfb/intelfb.h
@@ -12,9 +12,9 @@
 #endif
=20
 /*** Version/name ***/
-#define INTELFB_VERSION			"0.9.5"
+#define INTELFB_VERSION			"0.9.6"
 #define INTELFB_MODULE_NAME		"intelfb"
-#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G/915G/915GM/945G/94=
5GM/965G/965GM"
+#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G/915G/915GM/945G/94=
5GM/945GME/965G/965GM"
=20
=20
 /*** Debug/feature defines ***/
@@ -58,6 +58,7 @@
 #define PCI_DEVICE_ID_INTEL_915GM	0x2592
 #define PCI_DEVICE_ID_INTEL_945G	0x2772
 #define PCI_DEVICE_ID_INTEL_945GM	0x27A2
+#define PCI_DEVICE_ID_INTEL_945GME	0x27AE
 #define PCI_DEVICE_ID_INTEL_965G	0x29A2
 #define PCI_DEVICE_ID_INTEL_965GM	0x2A02
=20
@@ -160,6 +161,7 @@ enum intel_chips {
 	INTEL_915GM,
 	INTEL_945G,
 	INTEL_945GM,
+	INTEL_945GME,
 	INTEL_965G,
 	INTEL_965GM,
 };
@@ -363,6 +365,7 @@ struct intelfb_info {
 			((dinfo)->chipset =3D=3D INTEL_915GM) ||	\
 			((dinfo)->chipset =3D=3D INTEL_945G) ||	\
 			((dinfo)->chipset =3D=3D INTEL_945GM) ||	\
+			((dinfo)->chipset =3D=3D INTEL_945GME) ||	\
 			((dinfo)->chipset =3D=3D INTEL_965G) ||	\
 			((dinfo)->chipset =3D=3D INTEL_965GM))
=20
diff --git a/drivers/video/intelfb/intelfb_i2c.c b/drivers/video/intelfb/in=
telfb_i2c.c
index fcf9fad..5d896b8 100644
--- a/drivers/video/intelfb/intelfb_i2c.c
+++ b/drivers/video/intelfb/intelfb_i2c.c
@@ -171,6 +171,7 @@ void intelfb_create_i2c_busses(struct intelfb_info *din=
fo)
 		/* has some LVDS + tv-out */
 	case INTEL_945G:
 	case INTEL_945GM:
+	case INTEL_945GME:
 	case INTEL_965G:
 	case INTEL_965GM:
 		/* SDVO ports have a single control bus - 2 devices */
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/int=
elfbdrv.c
index e44303f..a09e236 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -2,7 +2,7 @@
  * intelfb
  *
  * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/9=
15GM/
- * 945G/945GM/965G/965GM integrated graphics chips.
+ * 945G/945GM/945GME/965G/965GM integrated graphics chips.
  *
  * Copyright =C2=A9 2002, 2003 David Dawes <dawes@xfree86.org>
  *                   2004 Sylvain Meyer
@@ -102,6 +102,9 @@
  *
  *    04/2008 - Version 0.9.5
  *              Add support for 965G/965GM. (Maik Broemme <mbroemme@plusse=
rver.de>)
+ *
+ *    08/2008 - Version 0.9.6
+ *              Add support for 945GME. (Phil Endecott <spam_from_intelfb@=
chezphil.org>)
  */
=20
 #include <linux/module.h>
@@ -183,6 +186,7 @@ static struct pci_device_id intelfb_pci_table[] __devin=
itdata =3D {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915GM, PCI_ANY_ID, PCI_ANY_ID,=
 PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915GM },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_945G, PCI_ANY_ID, PCI_ANY_ID, =
PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945G },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_945GM, PCI_ANY_ID, PCI_ANY_ID,=
 PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945GM },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_945GME, PCI_ANY_ID, PCI_ANY_ID=
, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945GME },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_965G, PCI_ANY_ID, PCI_ANY_ID, =
PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_965G },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_965GM, PCI_ANY_ID, PCI_ANY_ID,=
 PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_965GM },
 	{ 0, }
@@ -555,6 +559,7 @@ static int __devinit intelfb_pci_register(struct pci_de=
v *pdev,
 	    (ent->device =3D=3D PCI_DEVICE_ID_INTEL_915GM) ||
 	    (ent->device =3D=3D PCI_DEVICE_ID_INTEL_945G)  ||
 	    (ent->device =3D=3D PCI_DEVICE_ID_INTEL_945GM) ||
+	    (ent->device =3D=3D PCI_DEVICE_ID_INTEL_945GME) ||
 	    (ent->device =3D=3D PCI_DEVICE_ID_INTEL_965G) ||
 	    (ent->device =3D=3D PCI_DEVICE_ID_INTEL_965GM)) {
=20
diff --git a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/inte=
lfbhw.c
index 8e6d6a4..8b26b27 100644
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -143,6 +143,12 @@ int intelfbhw_get_chipset(struct pci_dev *pdev, struct=
 intelfb_info *dinfo)
 		dinfo->mobile =3D 1;
 		dinfo->pll_index =3D PLLS_I9xx;
 		return 0;
+	case PCI_DEVICE_ID_INTEL_945GME:
+		dinfo->name =3D "Intel(R) 945GME";
+		dinfo->chipset =3D INTEL_945GME;
+		dinfo->mobile =3D 1;
+		dinfo->pll_index =3D PLLS_I9xx;
+		return 0;
 	case PCI_DEVICE_ID_INTEL_965G:
 		dinfo->name =3D "Intel(R) 965G";
 		dinfo->chipset =3D INTEL_965G;
@@ -186,6 +192,7 @@ int intelfbhw_get_memory(struct pci_dev *pdev, int *ape=
rture_size,
 	case PCI_DEVICE_ID_INTEL_915GM:
 	case PCI_DEVICE_ID_INTEL_945G:
 	case PCI_DEVICE_ID_INTEL_945GM:
+	case PCI_DEVICE_ID_INTEL_945GME:
 	case PCI_DEVICE_ID_INTEL_965G:
 	case PCI_DEVICE_ID_INTEL_965GM:
 		/* 915, 945 and 965 chipsets support a 256MB aperture.

From: "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Subject: Re: [patch] intelfb: add (partial) support for
 915G
Date: Mon, 07 Feb 2005 05:10:37 +0100
Message-ID: <4206EA3D.7040502@XLsigned.net>
References: <41FB1AEB.4090206@XLsigned.net> <200502022019.21453.adaplas@hotpop.com> <4201026F.1080309@XLsigned.net> <200502031242.24560.adaplas@swissinfo.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040605000701080304000102"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cy0Ed-0007yg-N3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Feb 2005 20:10:51 -0800
Received: from mail.goracer.de ([62.75.192.134])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cy0Ea-0006u7-HJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Feb 2005 20:10:51 -0800
In-Reply-To: <200502031242.24560.adaplas@swissinfo.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: sylvain.meyer@worldonline.fr, adaplas@pol.net

This is a multi-part message in MIME format.
--------------040605000701080304000102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Antonino A. Daplas wrote:
> On Thursday 03 February 2005 00:40, Buttchereit, Axel (XL) wrote:
> 
>>Antonino A. Daplas wrote:
>>
>>>On Saturday 29 January 2005 13:11, Buttchereit, Axel (XL) wrote:
>>>
>>>>Add (partial) support for 915G
>>>> No HW cursor at the moment
>>>> Screen is blanked but signal/sync is not switched off
>>>>Mostly derived from XFree86/Xorg driver
>>>>Pass "vesa_modes" and VESA_MODEDB_SIZE in call to "fb_find_mode()"
>>>> to allow loading as module. Makes "vesa_modes" also the default
>>>> "modedb" when linking statically into the kernel.
>>>>Change PREFERRED_MODE to more reasonable value "1024x768-32@70"
>>>
>>>Can you resend?  Patch is malformed.
>>
>>Sure!
>>But it would be much easier for me, if I know what's wrong with my patch.
> 
> 
> It's line-wrapped, I think, your mailer probably mangled it.  You can resend
> the patch as a text attachment.
> 
> 
>>I assume that the kernel source version I was using is wrong (outdated),
>>i. e. I have to make my patch base on (at least) version 2.6.11-rc2.
> 
> 
> The source tree is not a problem, you can use any kernel >= 2.6.10.
> 
> Tony

Sorry for my late response, but I was quite busy with "subversioning the kernel",
i. e. I'm now able to (semi-)automatically update my subversion repository
using (downloaded) patches from kernel.org (mirrors).

I have attached the same patch I've send before, though I do not understand
why it was mangled. (I've tested this by sendind myself an email
containing the patch...)

For the patch was build on 2.6.10 with gentoo-patches already applied,
I have verified that my patch works on 2.6.11-rc3 from kernel.org, too.
It works! (The patching, i. e. I've not built a 2.6.11-rc3-kernel yet)

Hope that I'm able to remove the "partial" soon.

Cheers,
Axel

--------------040605000701080304000102
Content-Type: text/x-patch;
 name="intelfb-915G.patch"
Content-Disposition: inline;
 filename="intelfb-915G.patch"
Content-Transfer-Encoding: quoted-printable

Add (partial) support for 915G
  No HW cursor at the moment
  Screen is blanked but signal/sync is not switched off
Mostly derived from XFree86/Xorg driver
Pass "vesa_modes" and VESA_MODEDB_SIZE in call to "fb_find_mode()"
  to allow loading as module. Makes "vesa_modes" also the default
  "modedb" when linking statically into the kernel.
Change PREFERRED_MODE to more reasonable value "1024x768-32@70"

Signed-off-by: Axel Buttchereit <XL@XLsigned.net>


diff -ru linux.orig/drivers/video/intelfb/intelfbdrv.c linux/drivers/vide=
o/intelfb/intelfbdrv.c
--- linux.orig/drivers/video/intelfb/intelfbdrv.c	2005-01-29 05:16:44.372=
522436 +0100
+++ linux/drivers/video/intelfb/intelfbdrv.c	2005-01-29 05:40:29.56654860=
4 +0100
@@ -1,7 +1,7 @@
 /*
  * intelfb
  *
- * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G
+ * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G
  * integrated graphics chips.
  *
  * Copyright =A9 2002, 2003 David Dawes <dawes@xfree86.org>
@@ -153,6 +153,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_845G, PCI_ANY_ID, PCI_ANY_ID=
, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID, PCI_ANY_I=
D, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_865G, PCI_ANY_ID, PCI_ANY_ID=
, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915G, PCI_ANY_ID, PCI_ANY_ID=
, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915G },
 	{ 0, }
 };
=20
@@ -470,6 +471,8 @@
 	struct agp_kern_info gtt_info;
 	int agp_memtype;
 	const char *s;
+	int aperture_bar =3D 0;
+	int mmio_bar =3D 1;
=20
 	DBG_MSG("intelfb_pci_register\n");
=20
@@ -516,13 +519,20 @@
 	}
=20
 	/* Set base addresses. */
-	dinfo->aperture.physical =3D pci_resource_start(pdev, 0);
-	dinfo->aperture.size     =3D pci_resource_len(pdev, 0);
-	dinfo->mmio_base_phys    =3D pci_resource_start(pdev, 1);
-
+	if (ent->device =3D=3D PCI_DEVICE_ID_INTEL_915G) {
+		aperture_bar =3D 2;
+		mmio_bar =3D 0;
+		/* Disable HW cursor on 915G (not implemented yet) */
+		hwcursor =3D 0;
+	}
+	dinfo->aperture.physical =3D pci_resource_start(pdev, aperture_bar);
+	dinfo->aperture.size     =3D pci_resource_len(pdev, aperture_bar);
+	dinfo->mmio_base_phys    =3D pci_resource_start(pdev, mmio_bar);
 	DBG_MSG("fb aperture: 0x%lx/0x%lx, MMIO region: 0x%lx/0x%lx\n",
-		pci_resource_start(pdev, 0), pci_resource_len(pdev, 0),
-		pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
+		pci_resource_start(pdev, aperture_bar),
+		pci_resource_len(pdev, aperture_bar),
+		pci_resource_start(pdev, mmio_bar),
+		pci_resource_len(pdev, mmio_bar));
=20
 	/* Reserve the fb and MMIO regions */
 	if (!request_mem_region(dinfo->aperture.physical, dinfo->aperture.size,
@@ -989,13 +999,15 @@
 	} else {
 		if (mode) {
 			msrc =3D fb_find_mode(var, dinfo->info, mode,
-					    NULL, 0, NULL, 0);
+					    vesa_modes, VESA_MODEDB_SIZE,
+					    NULL, 0);
 			if (msrc)
 				msrc |=3D 8;
 		}
 		if (!msrc) {
 			msrc =3D fb_find_mode(var, dinfo->info, PREFERRED_MODE,
-					    NULL, 0, NULL, 0);
+					    vesa_modes, VESA_MODEDB_SIZE,
+					    NULL, 0);
 		}
 	}
=20
diff -ru linux.orig/drivers/video/intelfb/intelfbdrv.h linux/drivers/vide=
o/intelfb/intelfbdrv.h
--- linux.orig/drivers/video/intelfb/intelfbdrv.h	2005-01-29 05:16:44.373=
522137 +0100
+++ linux/drivers/video/intelfb/intelfbdrv.h	2005-01-29 03:33:52.02172814=
6 +0100
@@ -5,7 +5,7 @@
  ***********************************************************************=
*******
  * intelfb
  *
- * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G
+ * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G
  * integrated graphics chips.
  *
  * Copyright =A9 2004 Sylvain Meyer
diff -ru linux.orig/drivers/video/intelfb/intelfb.h linux/drivers/video/i=
ntelfb/intelfb.h
--- linux.orig/drivers/video/intelfb/intelfb.h	2005-01-29 05:16:44.360526=
028 +0100
+++ linux/drivers/video/intelfb/intelfb.h	2005-01-29 05:22:04.356713430 +=
0100
@@ -10,7 +10,7 @@
 /*** Version/name ***/
 #define INTELFB_VERSION			"0.9.2"
 #define INTELFB_MODULE_NAME		"intelfb"
-#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G"
+#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G/915G"
=20
=20
 /*** Debug/feature defines ***/
@@ -36,7 +36,7 @@
 #endif
=20
 #ifndef PREFERRED_MODE
-#define PREFERRED_MODE			"1024x768-16@60"
+#define PREFERRED_MODE			"1024x768-32@70"
 #endif
=20
 /*** hw-related values ***/
@@ -46,6 +46,7 @@
 #define PCI_DEVICE_ID_INTEL_845G	0x2562
 #define PCI_DEVICE_ID_INTEL_85XGM	0x3582
 #define PCI_DEVICE_ID_INTEL_865G	0x2572
+#define PCI_DEVICE_ID_INTEL_915G	0x2582
=20
 /* Size of MMIO region */
 #define INTEL_REG_SIZE			0x80000
@@ -117,7 +118,8 @@
 	INTEL_852GME,
 	INTEL_855GM,
 	INTEL_855GME,
-	INTEL_865G
+	INTEL_865G,
+	INTEL_915G
 };
=20
 struct intelfb_hwstate {
diff -ru linux.orig/drivers/video/intelfb/intelfbhw.c linux/drivers/video=
/intelfb/intelfbhw.c
--- linux.orig/drivers/video/intelfb/intelfbhw.c	2005-01-29 05:16:44.3815=
19742 +0100
+++ linux/drivers/video/intelfb/intelfbhw.c	2005-01-29 03:40:41.971680927=
 +0100
@@ -98,6 +98,11 @@
 		*chipset =3D INTEL_865G;
 		*mobile =3D 0;
 		return 0;
+	case PCI_DEVICE_ID_INTEL_915G:
+		*name =3D "Intel(R) 915G";
+		*chipset =3D INTEL_915G;
+		*mobile =3D 0;
+		return 0;
 	default:
 		return 1;
 	}
@@ -169,6 +174,12 @@
 		case INTEL_855_GMCH_GMS_STOLEN_32M:
 			*stolen_size =3D MB(32) - KB(132);
 			return 0;
+		case INTEL_915G_GMCH_GMS_STOLEN_48M:
+			*stolen_size =3D MB(48) - KB(132);
+			return 0;
+		case INTEL_915G_GMCH_GMS_STOLEN_64M:
+			*stolen_size =3D MB(64) - KB(132);
+			return 0;
 		case INTEL_855_GMCH_GMS_DISABLED:
 			ERR_MSG("video memory is disabled\n");
 			return 0;
diff -ru linux.orig/drivers/video/intelfb/intelfbhw.h linux/drivers/video=
/intelfb/intelfbhw.h
--- linux.orig/drivers/video/intelfb/intelfbhw.h	2005-01-29 05:16:44.3955=
15551 +0100
+++ linux/drivers/video/intelfb/intelfbhw.h	2005-01-29 03:37:01.004941554=
 +0100
@@ -46,6 +46,9 @@
 #define INTEL_855_GMCH_GMS_STOLEN_16M	(0x4 << 4)
 #define INTEL_855_GMCH_GMS_STOLEN_32M	(0x5 << 4)
=20
+#define INTEL_915G_GMCH_GMS_STOLEN_48M	(0x6 << 4)
+#define INTEL_915G_GMCH_GMS_STOLEN_64M	(0x7 << 4)
+
 /* HW registers */
=20
 /* Fence registers */

--------------040605000701080304000102--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

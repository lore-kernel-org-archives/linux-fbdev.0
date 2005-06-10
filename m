From: "Pfiffer, AndrewX K" <andrewx.k.pfiffer@intel.com>
Subject: [PATCH] intelfb: 854 support (2.6.11.5)
Date: Fri, 10 Jun 2005 11:00:46 -0700
Message-ID: <69F69FD5FD4A9843ACBF7CE9B7830B4A048BA28C@orsmsx408>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgnoO-00085k-2z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 11:00:56 -0700
Received: from fmr20.intel.com ([134.134.136.19] helo=orsfmr005.jf.intel.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DgnoN-0008Tb-C9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 11:00:56 -0700
Content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: sylvain.meyer@worldonline.fr
Cc: linux-fbdev-devel@lists.sourceforge.net, celinux-dev@tree.celinuxforum.org, "Gadiraju, Narm" <narm@intel.com>, "Liu, De YuX" <de.yux.liu@intel.com>

[If this patch has been whitespace mangled, I'd be happy to resend as an
attachment.]
--

This patch:
	- is relative to 2.6.11.5,
	- adds support to intelfb for the Intel 854 PCI ids,
	- a bug fix for 24 bpp @ 1280x1024 resolutions.

Signed-off-by: Andrew Pfiffer <andrewx.k.pfiffer@intel.com>
Signed-off-by: Bill Liu <de.yux.liu@intel.com>

---
diff -urN linux-2.6.11.5-orig/drivers/char/agp/intel-agp.c
linux-2.6.11.5/drivers/char/agp/intel-agp.c
--- linux-2.6.11.5-orig/drivers/char/agp/intel-agp.c    2005-03-18
22:34:57.000000000 -0800
+++ linux-2.6.11.5/drivers/char/agp/intel-agp.c 2005-04-08
11:08:14.346286280 -0700
@@ -1617,6 +1617,14 @@
                bridge->driver =3D &intel_845_driver;
                name =3D "855PM";
                break;
+       case PCI_DEVICE_ID_INTEL_82854_HB:
+               if (find_i830(PCI_DEVICE_ID_INTEL_82854_IG)) {
+                       bridge->driver =3D &intel_830_driver;
+               } else {
+                       bridge->driver =3D &intel_845_driver;
+               }
+               name =3D "854";
+               break;
        case PCI_DEVICE_ID_INTEL_82855GM_HB:
                if (find_i830(PCI_DEVICE_ID_INTEL_82855GM_IG)) {
                        bridge->driver =3D &intel_830_driver;
@@ -1795,6 +1803,7 @@
        ID(PCI_DEVICE_ID_INTEL_7205_0),
        ID(PCI_DEVICE_ID_INTEL_82915G_HB),
        ID(PCI_DEVICE_ID_INTEL_82915GM_HB),
+       ID(PCI_DEVICE_ID_INTEL_82854_HB),
        { }
 };

diff -urN linux-2.6.11.5-orig/drivers/char/drm/drm_pciids.h
linux-2.6.11.5/drivers/char/drm/drm_pciids.h
--- linux-2.6.11.5-orig/drivers/char/drm/drm_pciids.h   2005-03-18
22:34:56.000000000 -0800
+++ linux-2.6.11.5/drivers/char/drm/drm_pciids.h        2005-04-01
18:23:45.000000000 -0800
@@ -178,6 +178,7 @@
        {0x8086, 0x2562, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
        {0x8086, 0x3582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
        {0x8086, 0x2572, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+       {0x8086, 0x358e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
        {0, 0, 0}

 #define gamma_PCI_IDS \
@@ -219,5 +220,6 @@
        {0x8086, 0x2572, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
        {0x8086, 0x2582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
        {0x8086, 0x2982, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+       {0x8086, 0x358e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
        {0, 0, 0}

diff -urN linux-2.6.11.5-orig/drivers/video/intelfb/intelfbdrv.c
linux-2.6.11.5/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.11.5-orig/drivers/video/intelfb/intelfbdrv.c
2005-03-18 22:35:00.000000000 -0800
+++ linux-2.6.11.5/drivers/video/intelfb/intelfbdrv.c   2005-04-01
13:21:27.000000000 -0800
@@ -153,6 +153,7 @@
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_845G, PCI_ANY_ID,
PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G
},
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID,
PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM
},
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_865G, PCI_ANY_ID,
PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G
},
+       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_854, PCI_ANY_ID,
PCI_ANY_ID,
PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_854 },
        { 0, }
 };
@@ -1173,8 +1174,8 @@
                }
                return -EINVAL;
        }
-
-       switch (intelfb_var_to_depth(&v)) {
+
+       switch (v.bits_per_pixel) {
        case 8:
                v.red.offset =3D v.green.offset =3D v.blue.offset =3D 0;
                v.red.length =3D v.green.length =3D v.blue.length =3D 8;
diff -urN linux-2.6.11.5-orig/drivers/video/intelfb/intelfb.h
linux-2.6.11.5/drivers/video/intelfb/intelfb.h
--- linux-2.6.11.5-orig/drivers/video/intelfb/intelfb.h 2005-03-18
22:34:57.000000000 -0800
+++ linux-2.6.11.5/drivers/video/intelfb/intelfb.h      2005-04-01
13:18:15.000000000 -0800
@@ -46,6 +46,7 @@
 #define PCI_DEVICE_ID_INTEL_845G       0x2562
 #define PCI_DEVICE_ID_INTEL_85XGM      0x3582
 #define PCI_DEVICE_ID_INTEL_865G       0x2572
+#define PCI_DEVICE_ID_INTEL_854        0x358E

 /* Size of MMIO region */
 #define INTEL_REG_SIZE                 0x80000
@@ -117,7 +118,8 @@
        INTEL_852GME,
        INTEL_855GM,
        INTEL_855GME,
-       INTEL_865G
+       INTEL_865G,
+       INTEL_854
 };

 struct intelfb_hwstate {
diff -urN linux-2.6.11.5-orig/drivers/video/intelfb/intelfbhw.c
linux-2.6.11.5/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.11.5-orig/drivers/video/intelfb/intelfbhw.c
2005-03-18 22:34:51.000000000 -0800
+++ linux-2.6.11.5/drivers/video/intelfb/intelfbhw.c    2005-04-08
09:45:40.000000000 -0700
@@ -65,6 +65,11 @@
                *chipset =3D INTEL_845G;
                *mobile =3D 0;
                return 0;
+       case PCI_DEVICE_ID_INTEL_854:
+               *mobile =3D 1;
+               *name =3D "Intel(R) 854";
+                *chipset =3D INTEL_854;
+                return 0;
        case PCI_DEVICE_ID_INTEL_85XGM:
                tmp =3D 0;
                *mobile =3D 1;
@@ -1033,12 +1038,12 @@

        *ht =3D (htotal << HTOTAL_SHIFT) | (hactive << HACTIVE_SHIFT);
        *hb =3D (hblank_start << HBLANKSTART_SHIFT) |
-             (hblank_end << HSYNCEND_SHIFT);
+             (hblank_end << HBLANKEND_SHIFT);
        *hs =3D (hsync_start << HSYNCSTART_SHIFT) | (hsync_end <<
HSYNCEND_SHIFT);

        *vt =3D (vtotal << VTOTAL_SHIFT) | (vactive << VACTIVE_SHIFT);
        *vb =3D (vblank_start << VBLANKSTART_SHIFT) |
-             (vblank_end << VSYNCEND_SHIFT);
+             (vblank_end << VBLANKEND_SHIFT);
        *vs =3D (vsync_start << VSYNCSTART_SHIFT) | (vsync_end <<
VSYNCEND_SHIFT);
        *ss =3D (hactive << SRC_SIZE_HORIZ_SHIFT) |
              (vactive << SRC_SIZE_VERT_SHIFT);
@@ -1168,7 +1173,7 @@

        /* turn off PLL */
        tmp =3D INREG(dpll_reg);
-       dpll_reg &=3D ~DPLL_VCO_ENABLE;
+       tmp &=3D ~DPLL_VCO_ENABLE;
        OUTREG(dpll_reg, tmp);

        /* Set PLL parameters */
diff -urN linux-2.6.11.5-orig/include/linux/pci_ids.h
linux-2.6.11.5/include/linux/pci_ids.h
--- linux-2.6.11.5-orig/include/linux/pci_ids.h 2005-03-18
22:35:06.000000000 -0800
+++ linux-2.6.11.5/include/linux/pci_ids.h      2005-04-04
13:56:30.000000000 -0700
@@ -2289,6 +2289,8 @@
 #define PCI_DEVICE_ID_INTEL_82830_CGC  0x3577
 #define PCI_DEVICE_ID_INTEL_82855GM_HB 0x3580
 #define PCI_DEVICE_ID_INTEL_82855GM_IG 0x3582
+#define PCI_DEVICE_ID_INTEL_82854_HB   0x358c
+#define PCI_DEVICE_ID_INTEL_82854_IG   0x358e
 #define PCI_DEVICE_ID_INTEL_E7520_MCH  0x3590
 #define PCI_DEVICE_ID_INTEL_E7320_MCH  0x3592
 #define PCI_DEVICE_ID_INTEL_MCH_PA     0x3595
diff -urN linux-2.6.11.5-orig/drivers/video/modedb.c
linux-2.6.11.5/drivers/video/modedb.c
--- linux-2.6.11.5-orig/drivers/video/modedb.c  2005-03-18
22:34:56.000000000 -0800
+++ linux-2.6.11.5/drivers/video/modedb.c       2005-05-03
11:41:35.957309416 -0700
@@ -118,11 +118,12 @@
        /* 1152x864 @ 70 Hz, 62.4 kHz hsync */
        NULL, 70, 1152, 864, 10869, 106, 56, 20, 1, 160, 10,
        0, FB_VMODE_NONINTERLACED
-    }, {
-       /* 1280x1024 @ 61 Hz, 64.2 kHz hsync */
-       NULL, 61, 1280, 1024, 9090, 200, 48, 26, 1, 184, 3,
-       0, FB_VMODE_NONINTERLACED
-    }, {
+    }, {
+       /*1280x1024 @ 60 Hz from vesa*/
+       NULL, 60, 1280, 1024, 9259, 248, 48, 38, 1, 112, 3,
+        FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+        FB_VMODE_NONINTERLACED
+    },{
        /* 1400x1050 @ 60Hz, 63.9 kHz hsync */
        NULL, 68, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,
        0, FB_VMODE_NONINTERLACED





-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

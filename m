From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: Added 915G to intelfb of 2.6.10-kernel-sources
Date: Fri, 28 Jan 2005 17:42:12 +0100
Message-ID: <41FA6B64.6090506@worldonline.fr>
References: <41F9BEA6.2030300@XLsigned.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuZDo-0004qU-KC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 08:43:48 -0800
Received: from smtp12.wanadoo.fr ([193.252.22.20])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CuZDK-0000aA-Tn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 08:43:48 -0800
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: "Buttchereit, Axel (XLsigned)" <XL@XLsigned.net>, linux-fbdev-devel@lists.sourceforge.net

        Hi Axel,

    Thanks for your patch but could you format it as described in this=20
document =20
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

and resend it.

The best is to use these tools to maintain and send kernel patches
http://www.zip.com.au/~akpm/linux/patches/

Also you should subscribe and send fbdev-related mails to=20
linux-fbdev-devel@lists.sourceforge.net

Regards
Sylvain

Buttchereit, Axel (XLsigned) a =E9crit:

> Hi,
>
> though I'm quite sure that the attached patch (intelfb-...) is far=20
> from complete
> I think that someone/you (guessing from the comments that you are=20
> maintaining
> the code) might be interested in my work.
>
> Having no technical documentation (from Intel) I had to "develop" the=20
> patch by
> looking at the xfree/xorg-code that already supports I915G and by using
> trial-and-error (My ThinkCentre's internal graphics device is an I915G
> and that made me start working on this subject).
>
> During development and testing I've discovered that the way "intelfb"=20
> and maybe
> other framebuffer-drivers are using "modedb" does not work, if=20
> compiled as a
> module. The initial "modedb entries" are lost (overwritten?) when=20
> "fb_find_mode"
> is called from the module. Linking "intelfb" into the kernel works as=20
> expected.
>
> ByTheWay: Why isn't the framebuffer module (intelfb) automatically=20
> loaded, if
> "video=3Dintelfb:..." is specified as kernel-parameter?
>
> I have attached an additional patch (modedb-...) that re-initialize a
> minimal-modedb (my_mini_modedb), if MY_PREFERRED_MODE (1024x768-32@73)
> is used in a call to "fb_find_mode", to show that loading "intelfb" as =
a
> module works in principle.
>
> Just for completeness I've attached a third (trivial) patch that adds=20
> support for
> the external graphics adapter (radeon X600, RV380) of my ThinkCentre,=20
> by treating
> it as an RV350.
>
> Sorry for sending direct email.
>
> --Axel
>
>
>
>
>
>
>

------------------------------------------------------------------------

diff -ruN linux/drivers/video/intelfb.orig/intelfbdrv.c=20
linux/drivers/video/intelfb/intelfbdrv.c
--- linux/drivers/video/intelfb.orig/intelfbdrv.c    2005-01-26=20
18:51:13.162054107 +0100
+++ linux/drivers/video/intelfb/intelfbdrv.c    2005-01-27=20
23:37:21.273059171 +0100
@@ -1,7 +1,8 @@
 /*
  * intelfb
  *
- * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G
+ * *** XLsigned-2005-01-27: Added 915G ***
+ * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G
  * integrated graphics chips.
  *
  * Copyright =A9 2002, 2003 David Dawes <dawes@xfree86.org>
@@ -153,6 +154,8 @@
     { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_845G, PCI_ANY_ID,=20
PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G },
     { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID,=20
PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM }=
,
     { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_865G, PCI_ANY_ID,=20
PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G },
+    /* XLsigned-2005-01-27: Added 915G */
+    { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915G, PCI_ANY_ID,=20
PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915G },
     { 0, }
 };
=20
@@ -516,13 +519,25 @@
     }
=20
     /* Set base addresses. */
-    dinfo->aperture.physical =3D pci_resource_start(pdev, 0);
-    dinfo->aperture.size     =3D pci_resource_len(pdev, 0);
-    dinfo->mmio_base_phys    =3D pci_resource_start(pdev, 1);
-
-    DBG_MSG("fb aperture: 0x%lx/0x%lx, MMIO region: 0x%lx/0x%lx\n",
-        pci_resource_start(pdev, 0), pci_resource_len(pdev, 0),
-        pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
+    /* XLsigned-2005-01-27: Added 915G */
+    if (ent->device =3D=3D PCI_DEVICE_ID_INTEL_915G) {
+        DBG_MSG("XLsigned-Debug: IS_915G\n");
+        dinfo->aperture.physical =3D pci_resource_start(pdev, 2);
+        dinfo->aperture.size     =3D pci_resource_len(pdev, 2);
+        dinfo->mmio_base_phys    =3D pci_resource_start(pdev, 0);
+      =20
+        DBG_MSG("fb aperture: 0x%lx/0x%lx, MMIO region: 0x%lx/0x%lx\n",
+            pci_resource_start(pdev, 2), pci_resource_len(pdev, 2),
+            pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
+    } else {
+        dinfo->aperture.physical =3D pci_resource_start(pdev, 0);
+        dinfo->aperture.size     =3D pci_resource_len(pdev, 0);
+        dinfo->mmio_base_phys    =3D pci_resource_start(pdev, 1);
+
+        DBG_MSG("fb aperture: 0x%lx/0x%lx, MMIO region: 0x%lx/0x%lx\n",
+            pci_resource_start(pdev, 0), pci_resource_len(pdev, 0),
+            pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
+    }
=20
     /* Reserve the fb and MMIO regions */
     if (!request_mem_region(dinfo->aperture.physical, dinfo->aperture.si=
ze,
@@ -756,6 +771,8 @@
         printk(").  Disabling mode switching.\n");
     }
=20
+    DBG_MSG("XLsigned-Debug: Value of bailearly: %d\n",bailearly);
+  =20
     if (bailearly =3D=3D 1)
         bailout(dinfo);
=20
@@ -785,7 +802,7 @@
         bailout(dinfo);
=20
=20
-    if (intelfb_set_fbinfo(dinfo)) {
+     if (intelfb_set_fbinfo(dinfo)) {
         cleanup(dinfo);
         return -ENODEV;
     }
@@ -983,17 +1000,20 @@
=20
     var =3D &dinfo->info->var;
     if (FIXED_MODE(dinfo)) {
+        DBG_MSG("XLsigned-Debug: Setting FIXED_MODE\n");
             memcpy(var, &dinfo->initial_var,
                sizeof(struct fb_var_screeninfo));
         msrc =3D 5;
     } else {
         if (mode) {
+            DBG_MSG("XLsignedi-Debug: finding given mode: %s\n",mode);
             msrc =3D fb_find_mode(var, dinfo->info, mode,
                         NULL, 0, NULL, 0);
             if (msrc)
                 msrc |=3D 8;
         }
         if (!msrc) {
+            DBG_MSG("XLsigned-Debug: finding PREFERRED_MODE:=20
%s\n",PREFERRED_MODE);
             msrc =3D fb_find_mode(var, dinfo->info, PREFERRED_MODE,
                         NULL, 0, NULL, 0);
         }
diff -ruN linux/drivers/video/intelfb.orig/intelfbdrv.h=20
linux/drivers/video/intelfb/intelfbdrv.h
--- linux/drivers/video/intelfb.orig/intelfbdrv.h    2005-01-26=20
18:51:13.162054107 +0100
+++ linux/drivers/video/intelfb/intelfbdrv.h    2005-01-27=20
13:23:55.811192427 +0100
@@ -5,7 +5,8 @@
 =20
*************************************************************************=
*****
  * intelfb
  *
- * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G
+ * *** XLsigned-2005-01-27: Added 915G ***
+ * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G
  * integrated graphics chips.
  *
  * Copyright =A9 2004 Sylvain Meyer
diff -ruN linux/drivers/video/intelfb.orig/intelfb.h=20
linux/drivers/video/intelfb/intelfb.h
--- linux/drivers/video/intelfb.orig/intelfb.h    2005-01-26=20
18:51:13.162054107 +0100
+++ linux/drivers/video/intelfb/intelfb.h    2005-01-28=20
03:59:58.630904165 +0100
@@ -10,7 +10,8 @@
 /*** Version/name ***/
 #define INTELFB_VERSION            "0.9.2"
 #define INTELFB_MODULE_NAME        "intelfb"
-#define SUPPORTED_CHIPSETS        "830M/845G/852GM/855GM/865G"
+/* XLsigned-2005-01-27: Added 915G */
+#define SUPPORTED_CHIPSETS        "830M/845G/852GM/855GM/865G/915G"
=20
=20
 /*** Debug/feature defines ***/
@@ -35,10 +36,14 @@
 #define ALLOCATE_FOR_PANNING        1
 #endif
=20
+/* XLsigned-2005-01-27: Make this a match of the (one-and-)only entry=20
of "my_mini_modedb" */
+#define PREFERRED_MODE            "1024x768-32@73"
+
 #ifndef PREFERRED_MODE
 #define PREFERRED_MODE            "1024x768-16@60"
 #endif
=20
+
 /*** hw-related values ***/
=20
 /* PCI ids for supported devices */
@@ -46,6 +51,8 @@
 #define PCI_DEVICE_ID_INTEL_845G    0x2562
 #define PCI_DEVICE_ID_INTEL_85XGM    0x3582
 #define PCI_DEVICE_ID_INTEL_865G    0x2572
+/* XLsigned-2005-01-27: Added 915G */
+#define PCI_DEVICE_ID_INTEL_915G    0x2582
=20
 /* Size of MMIO region */
 #define INTEL_REG_SIZE            0x80000
@@ -117,7 +124,9 @@
     INTEL_852GME,
     INTEL_855GM,
     INTEL_855GME,
-    INTEL_865G
+    /* XLsigned-2005-01-27: Added 915G */
+    INTEL_865G,
+    INTEL_915G
 };
=20
 struct intelfb_hwstate {
diff -ruN linux/drivers/video/intelfb.orig/intelfbhw.c=20
linux/drivers/video/intelfb/intelfbhw.c
--- linux/drivers/video/intelfb.orig/intelfbhw.c    2005-01-26=20
18:51:13.162054107 +0100
+++ linux/drivers/video/intelfb/intelfbhw.c    2005-01-27=20
20:27:12.672227462 +0100
@@ -98,6 +98,12 @@
         *chipset =3D INTEL_865G;
         *mobile =3D 0;
         return 0;
+    /* XLsigned-2005-01-27: Added 915G */
+    case PCI_DEVICE_ID_INTEL_915G:
+        *name =3D "Intel(R) 915G";
+        *chipset =3D INTEL_915G;
+        *mobile =3D 0;
+        return 0;
     default:
         return 1;
     }
@@ -169,6 +175,13 @@
         case INTEL_855_GMCH_GMS_STOLEN_32M:
             *stolen_size =3D MB(32) - KB(132);
             return 0;
+        /* XLsigned-2005-01-27: Added 915G */
+        case INTEL_915G_GMCH_GMS_STOLEN_48M:
+            *stolen_size =3D MB(48) - KB(132);
+            return 0;
+        case INTEL_915G_GMCH_GMS_STOLEN_64M:
+            *stolen_size =3D MB(64) - KB(132);
+            return 0;
         case INTEL_855_GMCH_GMS_DISABLED:
             ERR_MSG("video memory is disabled\n");
             return 0;
@@ -390,7 +403,7 @@
 #if VERBOSE > 0
     DBG_MSG("intelfbhw_read_hw_state\n");
 #endif
-
+  =20
     if (!hw || !dinfo)
         return -1;
=20
diff -ruN linux/drivers/video/intelfb.orig/intelfbhw.h=20
linux/drivers/video/intelfb/intelfbhw.h
--- linux/drivers/video/intelfb.orig/intelfbhw.h    2005-01-26=20
18:51:13.163053957 +0100
+++ linux/drivers/video/intelfb/intelfbhw.h    2005-01-27=20
14:37:30.365140440 +0100
@@ -46,6 +46,11 @@
 #define INTEL_855_GMCH_GMS_STOLEN_16M    (0x4 << 4)
 #define INTEL_855_GMCH_GMS_STOLEN_32M    (0x5 << 4)
=20
+/* XLsigned-2005-01-27: Added 915G */
+#define INTEL_915G_GMCH_GMS_STOLEN_48M    (0x6 << 4)
+#define INTEL_915G_GMCH_GMS_STOLEN_64M    (0x7 << 4)
+
+
 /* HW registers */
=20
 /* Fence registers */


------------------------------------------------------------------------

diff -ru linux/drivers/video/aty.orig/ati_ids.h=20
linux/drivers/video/aty/ati_ids.h
--- linux/drivers/video/aty.orig/ati_ids.h    2005-01-26=20
05:50:20.235665432 +0100
+++ linux/drivers/video/aty/ati_ids.h    2005-01-26 04:11:46.279111468 +0=
100
@@ -4,6 +4,9 @@
  * radeonfb
  */
=20
+/* XLsigned-2004-11-16i: added RV380 (X600) */
+#define PCI_CHIP_RV380_3E50        0x3E50
+
 #define PCI_CHIP_RS100_4136        0x4136
 #define PCI_CHIP_RS200_4137        0x4137
 #define PCI_CHIP_R300_AD        0x4144
diff -ru linux/drivers/video/aty.orig/radeon_base.c=20
linux/drivers/video/aty/radeon_base.c
--- linux/drivers/video/aty.orig/radeon_base.c    2005-01-26=20
05:48:50.965236600 +0100
+++ linux/drivers/video/aty/radeon_base.c    2005-01-26=20
06:21:33.388589496 +0100
@@ -107,6 +107,13 @@
     { PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) |=20
(CHIP_FAMILY_##family) }
=20
 static struct pci_device_id radeonfb_pci_table[] =3D {
+
+        /* XLsigned-2004-11-16: added RV380 (X600)
+         * XLsigned-2005-01-26: added CHIP_IS_MOBILITY flag to force=20
reading
+         * of PLL config from VBIOS (BIOS mapped to RAM) and not from=20
BIOS-ROM
+         */
+    CHIP_DEF(PCI_CHIP_RV380_3E50,    RV350,    CHIP_HAS_CRTC2 |=20
CHIP_IS_MOBILITY),
+  =20
     /* Mobility M6 */
     CHIP_DEF(PCI_CHIP_RADEON_LY,     RV100,    CHIP_HAS_CRTC2 |=20
CHIP_IS_MOBILITY),
     CHIP_DEF(PCI_CHIP_RADEON_LZ,    RV100,    CHIP_HAS_CRTC2 |=20
CHIP_IS_MOBILITY),


------------------------------------------------------------------------

--- linux/drivers/video/modedb.c.orig    2005-01-28 04:19:28.710375507 +0=
100
+++ linux/drivers/video/modedb.c    2005-01-28 04:20:33.595040284 +0100
@@ -18,6 +18,9 @@
=20
 #undef DEBUG
=20
+/* XLsigned-2005-01-27: Added #define DEBUG 1 */
+#define DEBUG 1
+
 #define name_matches(v, s, l) \
     ((v).name && !strncmp((s), (v).name, (l)) && strlen((v).name) =3D=3D=
 (l))
 #define res_matches(v, x, y) \
@@ -39,6 +42,19 @@
=20
 #define DEFAULT_MODEDB_INDEX    0
=20
+/* XLsigned-2005-01-27: Added my_mini_modedb */
+#define MY_PREFERRED_MODE "1024x768-32@73"
+#define IS_MY_PREFERRED_MODE(m) \
+    ((m) && \
+     !strncmp((m),MY_PREFERRED_MODE,strlen(MY_PREFERRED_MODE)) && \
+     (strlen((m)) =3D=3D strlen(MY_PREFERRED_MODE)))
+static struct fb_videomode my_mini_modedb[] =3D {
+    {
+    MY_PREFERRED_MODE, 70, 1024, 768, 13333, 180, 24, 29, 3, 136, 6,
+    0, FB_VMODE_NONINTERLACED, 0
+    }
+};
+
 static const __init struct fb_videomode modedb[] =3D {
     {
     /* 640x400 @ 70 Hz, 31.5 kHz hsync */
@@ -480,7 +496,42 @@
     if (!db) {
     db =3D modedb;
     dbsize =3D sizeof(modedb)/sizeof(*modedb);
+    /* XLsigned: 2005-01-27: Added my_mini_modedb
+     * ANY static "modedb" is obviously destroyed when this function
+     * is called from a loadable (framebuffer-)module (like intelfb)
+     */
+    if (mode_option) {
+      DPRINTK("XLsigned-Debug: mode_option =3D %s\n", mode_option);
+      DPRINTK("XLsigned-Debug: MY_PREFERRED_MODE =3D %s\n",=20
MY_PREFERRED_MODE);
+    }
+    else {
+      DPRINTK("XLsigned-Debug: No mode_option specified\n");
+    }
+    if (IS_MY_PREFERRED_MODE(mode_option)) {
+        my_mini_modedb[0].name =3D MY_PREFERRED_MODE;
+        my_mini_modedb[0].refresh =3D 70;
+        my_mini_modedb[0].xres =3D 1024;
+        my_mini_modedb[0].yres =3D 768;
+        my_mini_modedb[0].pixclock =3D 13333;
+        my_mini_modedb[0].left_margin =3D 180;
+        my_mini_modedb[0].right_margin =3D 24;
+        my_mini_modedb[0].upper_margin =3D 29;
+        my_mini_modedb[0].lower_margin =3D 3;
+        my_mini_modedb[0].hsync_len =3D 136;
+        my_mini_modedb[0].vsync_len =3D 6;
+        my_mini_modedb[0].sync =3D 0;
+        my_mini_modedb[0].vmode =3D FB_VMODE_NONINTERLACED;
+        my_mini_modedb[0].flag =3D 0;
+
+        db =3D my_mini_modedb;
+        dbsize =3D sizeof(my_mini_modedb)/sizeof(*my_mini_modedb);
+        DPRINTK("XLsigned-Debug: using my_mini_modedb: dbsize =3D %i\n",=
=20
dbsize);
+    }
+    else {
+        DPRINTK("XLsigned-Debug: using builtin modedb: dbsize =3D %i\n",=
=20
dbsize);
+    }
     }
+  =20
     if (!default_mode)
     default_mode =3D &modedb[DEFAULT_MODEDB_INDEX];
     if (!default_bpp)






-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

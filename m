From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: disable linear aperture register access
Date: Sun, 15 Feb 2004 01:47:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040214234725.GA6430@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1As9Y0-0006Hq-VS
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Feb 2004 15:50:08 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1As9VQ-0004tS-VT
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Feb 2004 15:47:29 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id E5D9A11076F3
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Feb 2004 01:47:25 +0200 (EET)
Content-Disposition: inline
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


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This atyfb patch disables register access through the linear aperture if=20
the auxiliary aperture is used. This allows access to the full 8 MB of=20
memory. Tested on 3D Rage LT Pro.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb_reg_aperture.patch"

diff -urN linux-2.4.24/drivers/video/aty/atyfb.h linux-2.4.24/drivers/video/aty/atyfb.h
--- linux-2.4.24/drivers/video/aty/atyfb.h	2004-02-15 01:25:31.000000000 +0200
+++ linux-2.4.24/drivers/video/aty/atyfb.h	2004-02-15 01:23:19.000000000 +0200
@@ -179,6 +179,7 @@
     unsigned char *save_framebuffer;
     unsigned long save_pll[64];
 #endif
+    int aux_app;
 };
 
 
diff -urN linux-2.4.24/drivers/video/aty/atyfb_base.c linux-2.4.24/drivers/video/aty/atyfb_base.c
--- linux-2.4.24/drivers/video/aty/atyfb_base.c	2004-02-15 01:25:52.000000000 +0200
+++ linux-2.4.24/drivers/video/aty/atyfb_base.c	2004-02-15 01:24:18.000000000 +0200
@@ -1006,11 +1006,13 @@
             aty_st_le32(BUS_CNTL, 0x680000f9, info);
         }  else if (M64_HAS(MOBIL_BUS)) {
             aty_st_le32(DAC_CNTL, 0x80010102, info);
-            aty_st_le32(BUS_CNTL, 0x7b33a040, info);
+            aty_st_le32(BUS_CNTL, 0x7b33a040 |
+                        (info->aux_app ? BUS_APER_REG_DIS : 0), info);
         } else {
             /* GT */
             aty_st_le32(DAC_CNTL, 0x86010102, info);
-            aty_st_le32(BUS_CNTL, 0x7b23a040, info);
+            aty_st_le32(BUS_CNTL, 0x7b23a040 |
+                        (info->aux_app ? BUS_APER_REG_DIS : 0), info);
             aty_st_le32(EXT_MEM_CNTL,
                         aty_ld_le32(EXT_MEM_CNTL, info) | 0x5000001, info);
         }
@@ -2263,13 +2265,20 @@
 
     /*
      *  Last page of 8 MB (4 MB on ISA) aperture is MMIO
-     *  FIXME: we should use the auxiliary aperture instead so we can access
-     *  the full 8 MB of video RAM on 8 MB boards
      */
-    if (info->total_vram == 0x800000 ||
+    if ((!info->aux_app && info->total_vram == 0x800000) ||
         (info->bus_type == ISA && info->total_vram == 0x400000))
             info->total_vram -= GUI_RESERVE;
 
+    /*
+     *  Disable register access through the linear aperture
+     *  if the auxiliary aperture is used so we can access
+     *  the full 8 MB of video RAM on 8 MB boards.
+     */
+    if (info->aux_app)
+        aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, info) |
+                    BUS_APER_REG_DIS, info);
+
     /* Clear the video memory */
     fb_memset((void *)info->frame_buffer, 0, info->total_vram);
 
@@ -2439,7 +2448,6 @@
         return -ENXIO;
 #else
     u16 tmp;
-    int aux_app;
     unsigned long raddr;
 #endif
 #if defined(CONFIG_FB_ATY_GENERIC_LCD)
@@ -2687,13 +2695,12 @@
 
 #else /* __sparc__ */
 
-            aux_app = 0;
             raddr = addr + 0x7ff000UL;
             rrp = &pdev->resource[2];
             if ((rrp->flags & IORESOURCE_MEM)
                 && request_mem_region(rrp->start, rrp->end - rrp->start + 1,
                                       "atyfb")) {
-                    aux_app = 1;
+                    info->aux_app = 1;
                     raddr = rrp->start;
                     printk(KERN_INFO "atyfb: using auxiliary register aperture\n");
             }
@@ -2707,8 +2714,8 @@
                     return -ENOMEM;
             }
 
-            info->ati_regbase_phys += aux_app? 0x400: 0xc00;
-            info->ati_regbase += aux_app? 0x400: 0xc00;
+            info->ati_regbase_phys += info->aux_app ? 0x400 : 0xc00;
+            info->ati_regbase += info->aux_app ? 0x400 : 0xc00;
 
             /*
              * Enable memory-space accesses using config-space
diff -urN linux-2.4.24/drivers/video/aty/mach64.h linux-2.4.24/drivers/video/aty/mach64.h
--- linux-2.4.24/drivers/video/aty/mach64.h	2004-02-15 01:25:31.000000000 +0200
+++ linux-2.4.24/drivers/video/aty/mach64.h	2004-02-15 01:13:09.000000000 +0200
@@ -635,6 +635,7 @@
 /* Mach64 engine bit constants - these are typically ORed together */
 
 /* BUS_CNTL register constants */
+#define BUS_APER_REG_DIS	0x00000010
 #define BUS_FIFO_ERR_ACK	0x00200000
 #define BUS_HOST_ERR_ACK	0x00800000
 

--VbJkn9YxBvnuCH5J--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH 5/7]
Date: Sun, 21 Mar 2004 20:38:59 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403212038.59461.alex.kern@gmx.de>
References: <200403212033.39808.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T9eXA03/4K0IL/B"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B58mx-0001yT-KZ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:39:15 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B58mw-0002sw-1I
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:39:14 -0800
In-Reply-To: <200403212033.39808.alex.kern@gmx.de>
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


--Boundary-00=_T9eXA03/4K0IL/B
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_T9eXA03/4K0IL/B
Content-Type: text/x-diff;
  charset="utf-8";
  name="05_mach64-revers-hwtriple.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="05_mach64-revers-hwtriple.diff"

diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/atyfb.h linux-2.6.alex/drivers/video/aty/atyfb.h
--- linux-2.6.4/drivers/video/aty/atyfb.h	2004-03-18 20:02:44.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb.h	2004-03-18 20:30:47.000000000 +0100
@@ -193,7 +193,7 @@ struct atyfb_par {
 #define M64F_LT_SLEEP		0x00040000
 #define M64F_XL_DLL		0x00080000
 #define M64F_MFB_FORCE_4	0x00100000
-#define M64F_NO_HW_TRIPLE	0x00200000
+#define M64F_HW_TRIPLE		0x00200000
 
     /*
      *  Register access
Only in linux-2.6.alex/drivers/video/aty/: atyfb.h.orig
Only in linux-2.6.alex/drivers/video/aty/: atyfb.o
diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/atyfb_base.c linux-2.6.alex/drivers/video/aty/atyfb_base.c
--- linux-2.6.4/drivers/video/aty/atyfb_base.c	2004-03-18 20:21:31.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb_base.c	2004-03-18 20:29:52.000000000 +0100
@@ -283,26 +283,29 @@ static unsigned long phys_size[FB_MAX] _
 static unsigned long phys_guiregbase[FB_MAX] __initdata = { 0, };
 #endif
 
-#define ATI_CHIP_88800GX (M64F_GX | M64F_NO_HW_TRIPLE)
-#define ATI_CHIP_88800CX ATI_CHIP_88800GX
-#define ATI_CHIP_264CT     (M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO | M64F_NO_HW_TRIPLE)
+#define ATI_CHIP_88800GX   (M64F_GX)
+#define ATI_CHIP_88800CX    ATI_CHIP_88800GX
+#define ATI_CHIP_264CT     (M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO)
 #define ATI_CHIP_264ET      ATI_CHIP_264CT
 
-#define ATI_CHIP_264VT     (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE)
-#define ATI_CHIP_264VTA4   (ATI_CHIP_264VT | M64F_MAGIC_POSTDIV)
-#define ATI_CHIP_264GT     (M64F_GT | M64F_INTEGRATED               | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE | M64F_EXTRA_BRIGHT)
-#define ATI_CHIP_264VTB    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_NO_HW_TRIPLE)
-#define ATI_CHIP_264GTB    (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_NO_HW_TRIPLE | M64F_EXTRA_BRIGHT | M64F_SDRAM_MAGIC_PLL) 
-#define ATI_CHIP_264VT3    (ATI_CHIP_264VTB | M64F_SDRAM_MAGIC_PLL)
+#define ATI_CHIP_264VT     (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24)
+#define ATI_CHIP_264VTA4   (ATI_CHIP_264VT                                                           | M64F_MAGIC_POSTDIV)
+#define ATI_CHIP_264GT     (M64F_GT | M64F_INTEGRATED               | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT)
+#define ATI_CHIP_264VTB    (M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP    | M64F_FIFO_24)
+#define ATI_CHIP_264GTB    (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT) 
+#define ATI_CHIP_264VT3    (ATI_CHIP_264VTB                                                          | M64F_SDRAM_MAGIC_PLL)
 /*#define ATI_CHIP_264GTDVD  ?*/
-#define ATI_CHIP_264LT     (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_NO_HW_TRIPLE)
+#define ATI_CHIP_264LT     (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24)
 #define ATI_CHIP_264LTG    (ATI_CHIP_264LT                                                           | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT)
-#define ATI_CHIP_264VT4    (M64F_VT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_NO_HW_TRIPLE)
-#define ATI_CHIP_264GT2C   (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT)
-#define ATI_CHIP_264GTPRO  (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP                   | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_RESET_3D)
-#define ATI_CHIP_264LTPRO  (M64F_GT | M64F_INTEGRATED               | M64F_GTB_DSP                                          | M64F_EXTRA_BRIGHT | M64F_RESET_3D)
-#define ATI_CHIP_264XL     (ATI_CHIP_264GTPRO | M64F_XL_DLL | M64F_MFB_FORCE_4)
-#define ATI_CHIP_MOBILITY  (ATI_CHIP_264LTPRO | M64F_XL_DLL | M64F_MFB_FORCE_4 | M64F_MOBIL_BUS )
+#define ATI_CHIP_264VT4    (M64F_VT | M64F_INTEGRATED               | M64F_GTB_DSP    | M64F_FIFO_24)
+
+#define ATI_MODERN_SET     (M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_EXTRA_BRIGHT | M64F_HW_TRIPLE)
+
+#define ATI_CHIP_264GT2C   (ATI_MODERN_SET | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL)
+#define ATI_CHIP_264GTPRO  (ATI_MODERN_SET                | M64F_SDRAM_MAGIC_PLL | M64F_RESET_3D)
+#define ATI_CHIP_264LTPRO  (ATI_MODERN_SET                                       | M64F_RESET_3D)
+#define ATI_CHIP_264XL     (ATI_MODERN_SET                | M64F_SDRAM_MAGIC_PLL | M64F_RESET_3D | M64F_XL_DLL | M64F_MFB_FORCE_4)
+#define ATI_CHIP_MOBILITY  (ATI_MODERN_SET                                       | M64F_RESET_3D | M64F_XL_DLL | M64F_MFB_FORCE_4 | M64F_MOBIL_BUS )
 
 static struct {
 	u16 pci_id;
diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/mach64_accel.c linux-2.6.alex/drivers/video/aty/mach64_accel.c
--- linux-2.6.4/drivers/video/aty/mach64_accel.c	2004-03-13 21:13:43.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/mach64_accel.c	2004-03-18 20:22:50.000000000 +0100
@@ -345,7 +345,7 @@ void atyfb_imageblit(struct fb_info *inf
 		 * since Rage 3D IIc we have DP_HOST_TRIPLE_EN bit
 		 * this hwaccelerated triple has an issue with not aligned data
 		 */
-		if (!M64_HAS(NO_HW_TRIPLE) && image->width % 8 == 0)
+		if (M64_HAS(HW_TRIPLE) && image->width % 8 == 0)
 			pix_width |= DP_HOST_TRIPLE_EN;
 	}
 


--Boundary-00=_T9eXA03/4K0IL/B--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH 7/7]
Date: Sun, 21 Mar 2004 20:39:53 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403212039.53093.alex.kern@gmx.de>
References: <200403212033.39808.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J+eXAIH/2kytqGv"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B58nj-0002IP-GC
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:40:03 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B58nh-00035a-Tz
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:40:02 -0800
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
Cc: James Simmons <jsimmons@infradead.org>


--Boundary-00=_J+eXAIH/2kytqGv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_J+eXAIH/2kytqGv
Content-Type: text/x-diff;
  charset="utf-8";
  name="07_mach64-aux_correct.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="07_mach64-aux_correct.diff"

Only in linux-2.6.alex/drivers/video/aty/: .atyfb.o.cmd
Only in linux-2.6.alex/drivers/video/aty/: .atyfb_base.o.cmd
Only in linux-2.6.alex/drivers/video/aty/: .built-in.o.cmd
Only in linux-2.6.alex/drivers/video/aty/: .mach64_accel.o.cmd
Only in linux-2.6.alex/drivers/video/aty/: .mach64_ct.o.cmd
Only in linux-2.6.alex/drivers/video/aty/: .mach64_cursor.o.cmd
diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/atyfb.h linux-2.6.alex/drivers/video/aty/atyfb.h
--- linux-2.6.4/drivers/video/aty/atyfb.h	2004-03-19 21:18:14.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb.h	2004-03-20 21:25:44.620076176 +0100
@@ -163,7 +163,8 @@ struct atyfb_par {
 	u16 lcd_hblank_len;
 	u16 lcd_vblank_len;
 #endif
-	int aux_app; /* auxiliary aperture */
+	unsigned long aux_start; /* auxiliary aperture */
+	unsigned long aux_size;
 };
 
     /*
Only in linux-2.6.alex/drivers/video/aty/: atyfb.h.orig
Only in linux-2.6.alex/drivers/video/aty/: atyfb.o
diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/atyfb_base.c linux-2.6.alex/drivers/video/aty/atyfb_base.c
--- linux-2.6.4/drivers/video/aty/atyfb_base.c	2004-03-20 21:20:18.748616168 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb_base.c	2004-03-20 21:33:24.479166968 +0100
@@ -1267,11 +1267,11 @@ static int atyfb_set_par(struct fb_info 
 			aty_st_le32(BUS_CNTL, 0x680000f9, par);
 		} else if (M64_HAS(MOBIL_BUS)) {
 			aty_st_le32(DAC_CNTL, 0x80010102, par);
-			aty_st_le32(BUS_CNTL, 0x7b33a040 | (par->aux_app ? BUS_APER_REG_DIS : 0), par);
+			aty_st_le32(BUS_CNTL, 0x7b33a040 | (par->aux_start ? BUS_APER_REG_DIS : 0), par);
 		} else {
 			/* GT */
 			aty_st_le32(DAC_CNTL, 0x86010102, par);
-			aty_st_le32(BUS_CNTL, 0x7b23a040 | (par->aux_app ? BUS_APER_REG_DIS : 0), par);
+			aty_st_le32(BUS_CNTL, 0x7b23a040 | (par->aux_start ? BUS_APER_REG_DIS : 0), par);
 			aty_st_le32(EXT_MEM_CNTL, aty_ld_le32(EXT_MEM_CNTL, par) | 0x5000001, par);
 		}
 		aty_st_le32(MEM_CNTL, tmp, par);
@@ -2250,7 +2250,7 @@ static int __init aty_init(struct fb_inf
 	 *  the full 8 MB of video RAM on 8 MB boards
 	 */
 
-	if (!par->aux_app &&
+	if (!par->aux_start &&
 		(info->fix.smem_len == 0x800000 || (par->bus_type == ISA && info->fix.smem_len == 0x400000)))
 		info->fix.smem_len -= GUI_RESERVE;
 
@@ -2259,7 +2259,7 @@ static int __init aty_init(struct fb_inf
 	 *  if the auxiliary aperture is used so we can access
 	 *  the full 8 MB of video RAM on 8 MB boards.
 	 */
-	if (par->aux_app)
+	if (par->aux_start)
 		aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, par) | BUS_APER_REG_DIS, par);
 
 	/* Clear the video memory */
@@ -3063,7 +3063,8 @@ static int __devinit atyfb_setup_generic
 	raddr = addr + 0x7ff000UL;
 	rrp = &pdev->resource[2];
 	if ((rrp->flags & IORESOURCE_MEM) && request_mem_region(rrp->start, rrp->end - rrp->start + 1, "atyfb")) {
-		par->aux_app = 1;
+		par->aux_start = rrp->start;
+		par->aux_size = rrp->end - rrp->start + 1;
 		raddr = rrp->start;
 		printk(KERN_INFO "atyfb: using auxiliary register aperture\n");
 	}
@@ -3073,8 +3074,8 @@ static int __devinit atyfb_setup_generic
 	if (par->ati_regbase == 0)
 		return -ENOMEM;
 
-	info->fix.mmio_start += par->aux_app ? 0x400 : 0xc00;
-	par->ati_regbase += par->aux_app ? 0x400 : 0xc00;
+	info->fix.mmio_start += par->aux_start ? 0x400 : 0xc00;
+	par->ati_regbase += par->aux_start ? 0x400 : 0xc00;
 
 	/*
 	 * Enable memory-space accesses using config-space
@@ -3211,6 +3212,9 @@ err_release_io:
 		iounmap((void *) info->screen_base);
 #endif
 err_release_mem:
+	if(par->aux_start)
+		release_mem_region(par->aux_start, par->aux_size);
+
 	release_mem_region(par->res_start, par->res_size);
 err_free:
 	framebuffer_release(info);
@@ -3302,8 +3306,12 @@ static void __devexit atyfb_remove(struc
 	if (par->mmap_map)
 		kfree(par->mmap_map);
 #endif
+	if (par->aux_start)
+		release_mem_region(par->aux_start, par->aux_size);
+
 	if (par->res_start)
 		release_mem_region(par->res_start, par->res_size);
+
 	framebuffer_release(info);
 }
 
Only in linux-2.6.alex/drivers/video/aty/: atyfb_base.c.orig
Only in linux-2.6.alex/drivers/video/aty/: atyfb_base.o
Only in linux-2.6.alex/drivers/video/aty/: built-in.o
Only in linux-2.6.alex/drivers/video/aty/: mach64_accel.c.orig
Only in linux-2.6.alex/drivers/video/aty/: mach64_accel.o
Only in linux-2.6.alex/drivers/video/aty/: mach64_ct.c.orig
Only in linux-2.6.alex/drivers/video/aty/: mach64_ct.o
Only in linux-2.6.alex/drivers/video/aty/: mach64_cursor.o
Only in linux-2.6.alex/drivers/video/aty/: xlinit.c.orig

--Boundary-00=_J+eXAIH/2kytqGv--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

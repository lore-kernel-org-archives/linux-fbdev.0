From: sylvain.meyer@worldonline.fr
Subject: [patch 1/1] fbdev: Add vram option to intelfb
Date: Tue, 09 Nov 2004 22:27:12 +0100
Message-ID: <20041109212713.B174E1BFC356@mwinf0103.wanadoo.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRdWO-00031b-T3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Nov 2004 13:27:24 -0800
Received: from smtp1.wanadoo.fr ([193.252.22.30] helo=mwinf0103.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CRdWN-00081T-KD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Nov 2004 13:27:24 -0800
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@osdl.com
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, sylvain.meyer@worldonline.fr


- add vram option to reserve more memory than stolen by BIOS if needed
- fix intelfbhw_pan_display typo
- add __initdata annotations

Signed-off-by: Sylvain Meyer <sylvain.meyer@worldonline.fr>
---

 linux-2.6.10-rc1-mm2-root/drivers/video/intelfb/intelfb.h    |    7 
 linux-2.6.10-rc1-mm2-root/drivers/video/intelfb/intelfbdrv.c |   95 ++++++++---
 linux-2.6.10-rc1-mm2-root/drivers/video/intelfb/intelfbhw.c  |    2 
 3 files changed, 81 insertions(+), 23 deletions(-)

diff -puN drivers/video/intelfb/intelfbdrv.c~intelfb-vram drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.10-rc1-mm2/drivers/video/intelfb/intelfbdrv.c~intelfb-vram	2004-11-09 21:14:28.000000000 +0100
+++ linux-2.6.10-rc1-mm2-root/drivers/video/intelfb/intelfbdrv.c	2004-11-09 22:20:59.418754824 +0100
@@ -94,6 +94,11 @@
  *              Use module_param instead of old MODULE_PARM
  *              Some cleanup
  *
+ *    11/2004 - Version 0.9.2
+ *              Add vram option to reserve more memory than stolen by BIOS
+ *              Fix intelfbhw_pan_display typo
+ *              Add __initdata annotations
+ *
  * TODO:
  *
  *
@@ -186,19 +191,22 @@ MODULE_DESCRIPTION(
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DEVICE_TABLE(pci, intelfb_pci_table);
 
-static int accel        = 1;
-static int hwcursor     = 1;
-static int mtrr         = 1;
-static int fixed        = 0;
-static int noinit       = 0;
-static int noregister   = 0;
-static int probeonly    = 0;
-static int idonly       = 0;
-static int bailearly    = 0;
-static char *mode       = NULL;
+static int accel        __initdata = 1;
+static int vram         __initdata = 4;
+static int hwcursor     __initdata = 1;
+static int mtrr         __initdata = 1;
+static int fixed        __initdata = 0;
+static int noinit       __initdata = 0;
+static int noregister   __initdata = 0;
+static int probeonly    __initdata = 0;
+static int idonly       __initdata = 0;
+static int bailearly    __initdata = 0;
+static char *mode       __initdata = NULL;
 
 module_param(accel, bool, S_IRUGO);
 MODULE_PARM_DESC(accel, "Enable console acceleration");
+module_param(vram, int, S_IRUGO);
+MODULE_PARM_DESC(vram, "System RAM to allocate to framebuffer in MiB");
 module_param(hwcursor, bool, S_IRUGO);
 MODULE_PARM_DESC(hwcursor, "Enable HW cursor");
 module_param(mtrr, bool, S_IRUGO);
@@ -257,6 +265,7 @@ intelfb_exit(void)
 
 #ifndef MODULE
 #define OPT_EQUAL(opt, name) (!strncmp(opt, name, strlen(name)))
+#define OPT_INTVAL(opt, name) simple_strtoul(opt + strlen(name), NULL, 0)
 #define OPT_STRVAL(opt, name) (opt + strlen(name))
 
 static __inline__ char *
@@ -279,6 +288,19 @@ get_opt_string(const char *this_opt, con
 }
 
 static __inline__ int
+get_opt_int(const char *this_opt, const char *name, int *ret)
+{
+	if (!ret)
+		return 0;
+
+	if (!OPT_EQUAL(this_opt, name))
+		return 0;
+
+	*ret = OPT_INTVAL(this_opt, name);
+	return 1;
+}
+
+static __inline__ int
 get_opt_bool(const char *this_opt, const char *name, int *ret)
 {
 	if (!ret)
@@ -330,6 +352,8 @@ intelfb_setup(char *options)
 			continue;
 		if (get_opt_bool(this_opt, "accel", &accel))
 			;
+ 		else if (get_opt_int(this_opt, "vram", &vram))
+			;
 		else if (get_opt_bool(this_opt, "hwcursor", &hwcursor))
 			;
 		else if (get_opt_bool(this_opt, "mtrr", &mtrr))
@@ -402,8 +426,10 @@ cleanup(struct intelfb_info *dinfo)
 
 	unset_mtrr(dinfo);
 
-	if (dinfo->gtt_fb_mem)
+	if (dinfo->fbmem_gart && dinfo->gtt_fb_mem) {
 		agp_unbind_memory(dinfo->gtt_fb_mem);
+		agp_free_memory(dinfo->gtt_fb_mem);
+	}
 	if (dinfo->gtt_cursor_mem) {
 		agp_unbind_memory(dinfo->gtt_cursor_mem);
 		agp_free_memory(dinfo->gtt_cursor_mem);
@@ -560,13 +586,14 @@ intelfb_pci_register(struct pci_dev *pde
 		dinfo->accel = 0;
 	}
 
-	/* Framebuffer parameters - Use all the stolen memory */
-	dinfo->fb.size = ROUND_UP_TO_PAGE(stolen_size);
-	dinfo->fb.offset = 0;   // starts at offset 0
-	dinfo->fb.physical = dinfo->aperture.physical
-		+ (dinfo->fb.offset << 12);
-	dinfo->fb.virtual = dinfo->aperture.virtual + (dinfo->fb.offset << 12);
-	dinfo->fb_start = dinfo->fb.offset << 12;
+	/* Framebuffer parameters - Use all the stolen memory if >= vram */
+	if (ROUND_UP_TO_PAGE(stolen_size) >= MB(vram)) {
+		dinfo->fb.size = ROUND_UP_TO_PAGE(stolen_size);
+		dinfo->fbmem_gart = 0;
+	} else {
+		dinfo->fb.size =  MB(vram);
+		dinfo->fbmem_gart = 1;
+	}
 
 	/* Allocate space for the ring buffer and HW cursor if enabled. */
 	if (dinfo->accel) {
@@ -601,6 +628,11 @@ intelfb_pci_register(struct pci_dev *pde
 		dinfo->cursor.offset = (stolen_size >> 12) +
 			+ gtt_info.current_memory + (dinfo->ring.size >> 12);
 	}
+	if (dinfo->fbmem_gart) {
+		dinfo->fb.offset = (stolen_size >> 12) +
+			+ gtt_info.current_memory + (dinfo->ring.size >> 12)
+			+ (dinfo->cursor.size >> 12);
+	}
 
 	/* Allocate memories (which aren't stolen) */
 	if (dinfo->accel) {
@@ -652,6 +684,29 @@ intelfb_pci_register(struct pci_dev *pde
 		dinfo->cursor.virtual = dinfo->aperture.virtual
 			+ (dinfo->cursor.offset << 12);
 	}
+	if (dinfo->fbmem_gart) {
+		if (!(dinfo->gtt_fb_mem =
+		      agp_allocate_memory(dinfo->fb.size >> 12,
+					  AGP_NORMAL_MEMORY))) {
+			WRN_MSG("cannot allocate framebuffer memory - use "
+				"the stolen one\n");
+			dinfo->fbmem_gart = 0;
+		}
+		if (agp_bind_memory(dinfo->gtt_fb_mem,
+				    dinfo->fb.offset)) {
+			WRN_MSG("cannot bind framebuffer memory - use "
+				"the stolen one\n");
+			dinfo->fbmem_gart = 0;
+		}
+	}
+
+	/* update framebuffer memory parameters */
+	if (!dinfo->fbmem_gart)
+		dinfo->fb.offset = 0;   /* starts at offset 0 */
+	dinfo->fb.physical = dinfo->aperture.physical
+		+ (dinfo->fb.offset << 12);
+	dinfo->fb.virtual = dinfo->aperture.virtual + (dinfo->fb.offset << 12);
+	dinfo->fb_start = dinfo->fb.offset << 12;
 
 	/* release agpgart */
 	agp_backend_release();
@@ -673,8 +728,8 @@ intelfb_pci_register(struct pci_dev *pde
 		(u32 __iomem ) dinfo->cursor.virtual, dinfo->cursor.offset,
 		dinfo->cursor.physical);
 
-	DBG_MSG("options: accel = %d, hwcursor = %d, fixed = %d, "
-		"noinit = %d\n", accel, hwcursor, fixed, noinit);
+	DBG_MSG("options: vram = %d, accel = %d, hwcursor = %d, fixed = %d, "
+		"noinit = %d\n", vram, accel, hwcursor, fixed, noinit);
 	DBG_MSG("options: mode = \"%s\"\n", mode ? mode : "");
 
 	if (probeonly)
diff -puN drivers/video/intelfb/intelfb.h~intelfb-vram drivers/video/intelfb/intelfb.h
--- linux-2.6.10-rc1-mm2/drivers/video/intelfb/intelfb.h~intelfb-vram	2004-11-09 21:14:28.000000000 +0100
+++ linux-2.6.10-rc1-mm2-root/drivers/video/intelfb/intelfb.h	2004-11-09 22:20:59.416755128 +0100
@@ -8,7 +8,7 @@
 
 
 /*** Version/name ***/
-#define INTELFB_VERSION			"0.9.1"
+#define INTELFB_VERSION			"0.9.2"
 #define INTELFB_MODULE_NAME		"intelfb"
 #define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G"
 
@@ -199,10 +199,13 @@ struct intelfb_info {
 	struct intelfb_hwstate save_state;
 
 	/* agpgart structs */
-	struct agp_memory *gtt_fb_mem;     // use all stolen memory
+	struct agp_memory *gtt_fb_mem;     // use all stolen memory or vram
 	struct agp_memory *gtt_ring_mem;   // ring buffer
 	struct agp_memory *gtt_cursor_mem; // hw cursor
 
+	/* use a gart reserved fb mem */
+	u8 fbmem_gart;
+
 	/* mtrr support */
 	u32 mtrr_reg;
 	u32 has_mtrr;
diff -puN drivers/video/intelfb/intelfbhw.c~intelfb-vram drivers/video/intelfb/intelfbhw.c
--- linux-2.6.10-rc1-mm2/drivers/video/intelfb/intelfbhw.c~intelfb-vram	2004-11-09 22:07:54.000000000 +0100
+++ linux-2.6.10-rc1-mm2-root/drivers/video/intelfb/intelfbhw.c	2004-11-09 22:20:59.419754672 +0100
@@ -295,7 +295,7 @@ intelfbhw_pan_display(struct fb_var_scre
 	offset = (yoffset * dinfo->pitch) +
 		 (xoffset * var->bits_per_pixel) / 8;
 
-	offset += dinfo->fb.offset >> 12;
+	offset += dinfo->fb.offset << 12;
 
 	OUTREG(DSPABASE, offset);
 
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

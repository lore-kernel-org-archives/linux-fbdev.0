From: Joe Perches <joe@perches.com>
Date: Mon, 12 Jun 2017 17:05:45 +0000
Subject: [PATCH] uvesafb: Fix continuation printks without KERN_LEVEL to pr_cont, neatening
Message-Id: <c6cbf28b5763bb945d1f55b72f2b79a7772b9966.1497287034.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Linus recently broke the printk without KERN_CONT behavior.
Fix it for uvesafb.

While there, convert printk(KERN_<LEVEL> to pr_<level>.
Add pr_fmt and remove the embedded prefixes.

Miscellanea:

o Coalesce formats and realign arguments
o Add a missing space to a format when coalescing.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/uvesafb.c | 148 ++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 86 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 98af9e02959b..dc0e8d90d9cc 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -5,6 +5,9 @@
  *     Loosely based upon the vesafb driver.
  *
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -149,8 +152,8 @@ static int uvesafb_exec(struct uvesafb_ktask *task)
 	 * allowed by connector.
 	 */
 	if (sizeof(*m) + len > CONNECTOR_MAX_MSG_SIZE) {
-		printk(KERN_WARNING "uvesafb: message too long (%d), "
-			"can't execute task\n", (int)(sizeof(*m) + len));
+		pr_warn("message too long (%d), can't execute task\n",
+			(int)(sizeof(*m) + len));
 		return -E2BIG;
 	}
 
@@ -198,10 +201,8 @@ static int uvesafb_exec(struct uvesafb_ktask *task)
 		 */
 		err = uvesafb_helper_start();
 		if (err) {
-			printk(KERN_ERR "uvesafb: failed to execute %s\n",
-					v86d_path);
-			printk(KERN_ERR "uvesafb: make sure that the v86d "
-					"helper is installed and executable\n");
+			pr_err("failed to execute %s\n", v86d_path);
+			pr_err("make sure that the v86d helper is installed and executable\n");
 		} else {
 			v86d_started = 1;
 			err = cn_netlink_send(m, 0, 0, gfp_any());
@@ -375,9 +376,8 @@ static u8 *uvesafb_vbe_state_save(struct uvesafb_par *par)
 	err = uvesafb_exec(task);
 
 	if (err || (task->t.regs.eax & 0xffff) != 0x004f) {
-		printk(KERN_WARNING "uvesafb: VBE get state call "
-				"failed (eax=0x%x, err=%d)\n",
-				task->t.regs.eax, err);
+		pr_warn("VBE get state call failed (eax=0x%x, err=%d)\n",
+			task->t.regs.eax, err);
 		kfree(state);
 		state = NULL;
 	}
@@ -407,9 +407,8 @@ static void uvesafb_vbe_state_restore(struct uvesafb_par *par, u8 *state_buf)
 
 	err = uvesafb_exec(task);
 	if (err || (task->t.regs.eax & 0xffff) != 0x004f)
-		printk(KERN_WARNING "uvesafb: VBE state restore call "
-				"failed (eax=0x%x, err=%d)\n",
-				task->t.regs.eax, err);
+		pr_warn("VBE state restore call failed (eax=0x%x, err=%d)\n",
+			task->t.regs.eax, err);
 
 	uvesafb_free(task);
 }
@@ -427,24 +426,22 @@ static int uvesafb_vbe_getinfo(struct uvesafb_ktask *task,
 
 	err = uvesafb_exec(task);
 	if (err || (task->t.regs.eax & 0xffff) != 0x004f) {
-		printk(KERN_ERR "uvesafb: Getting VBE info block failed "
-				"(eax=0x%x, err=%d)\n", (u32)task->t.regs.eax,
-				err);
+		pr_err("Getting VBE info block failed (eax=0x%x, err=%d)\n",
+		       (u32)task->t.regs.eax, err);
 		return -EINVAL;
 	}
 
 	if (par->vbe_ib.vbe_version < 0x0200) {
-		printk(KERN_ERR "uvesafb: Sorry, pre-VBE 2.0 cards are "
-				"not supported.\n");
+		pr_err("Sorry, pre-VBE 2.0 cards are not supported\n");
 		return -EINVAL;
 	}
 
 	if (!par->vbe_ib.mode_list_ptr) {
-		printk(KERN_ERR "uvesafb: Missing mode list!\n");
+		pr_err("Missing mode list!\n");
 		return -EINVAL;
 	}
 
-	printk(KERN_INFO "uvesafb: ");
+	pr_info("");
 
 	/*
 	 * Convert string pointers and the mode list pointer into
@@ -452,23 +449,24 @@ static int uvesafb_vbe_getinfo(struct uvesafb_ktask *task,
 	 * video adapter and its vendor.
 	 */
 	if (par->vbe_ib.oem_vendor_name_ptr)
-		printk("%s, ",
+		pr_cont("%s, ",
 			((char *)task->buf) + par->vbe_ib.oem_vendor_name_ptr);
 
 	if (par->vbe_ib.oem_product_name_ptr)
-		printk("%s, ",
+		pr_cont("%s, ",
 			((char *)task->buf) + par->vbe_ib.oem_product_name_ptr);
 
 	if (par->vbe_ib.oem_product_rev_ptr)
-		printk("%s, ",
+		pr_cont("%s, ",
 			((char *)task->buf) + par->vbe_ib.oem_product_rev_ptr);
 
 	if (par->vbe_ib.oem_string_ptr)
-		printk("OEM: %s, ",
+		pr_cont("OEM: %s, ",
 			((char *)task->buf) + par->vbe_ib.oem_string_ptr);
 
-	printk("VBE v%d.%d\n", ((par->vbe_ib.vbe_version & 0xff00) >> 8),
-			par->vbe_ib.vbe_version & 0xff);
+	pr_cont("VBE v%d.%d\n",
+		(par->vbe_ib.vbe_version & 0xff00) >> 8,
+		par->vbe_ib.vbe_version & 0xff);
 
 	return 0;
 }
@@ -507,8 +505,7 @@ static int uvesafb_vbe_getmodes(struct uvesafb_ktask *task,
 
 		err = uvesafb_exec(task);
 		if (err || (task->t.regs.eax & 0xffff) != 0x004f) {
-			printk(KERN_WARNING "uvesafb: Getting mode info block "
-				"for mode 0x%x failed (eax=0x%x, err=%d)\n",
+			pr_warn("Getting mode info block for mode 0x%x failed (eax=0x%x, err=%d)\n",
 				*mode, (u32)task->t.regs.eax, err);
 			mode++;
 			par->vbe_modes_cnt--;
@@ -569,23 +566,20 @@ static int uvesafb_vbe_getpmi(struct uvesafb_ktask *task,
 						+ task->t.regs.edi);
 		par->pmi_start = (u8 *)par->pmi_base + par->pmi_base[1];
 		par->pmi_pal = (u8 *)par->pmi_base + par->pmi_base[2];
-		printk(KERN_INFO "uvesafb: protected mode interface info at "
-				 "%04x:%04x\n",
-				 (u16)task->t.regs.es, (u16)task->t.regs.edi);
-		printk(KERN_INFO "uvesafb: pmi: set display start = %p, "
-				 "set palette = %p\n", par->pmi_start,
-				 par->pmi_pal);
+		pr_info("protected mode interface info at %04x:%04x\n",
+			(u16)task->t.regs.es, (u16)task->t.regs.edi);
+		pr_info("pmi: set display start = %p, set palette = %p\n",
+			par->pmi_start, par->pmi_pal);
 
 		if (par->pmi_base[3]) {
-			printk(KERN_INFO "uvesafb: pmi: ports = ");
+			pr_info("pmi: ports =");
 			for (i = par->pmi_base[3]/2;
 					par->pmi_base[i] != 0xffff; i++)
-				printk("%x ", par->pmi_base[i]);
-			printk("\n");
+				pr_cont(" %x", par->pmi_base[i]);
+			pr_cont("\n");
 
 			if (par->pmi_base[i] != 0xffff) {
-				printk(KERN_INFO "uvesafb: can't handle memory"
-						 " requests, pmi disabled\n");
+				pr_info("can't handle memory requests, pmi disabled\n");
 				par->ypan = par->pmi_setpal = 0;
 			}
 		}
@@ -634,17 +628,13 @@ static int uvesafb_vbe_getedid(struct uvesafb_ktask *task, struct fb_info *info)
 		return -EINVAL;
 
 	if ((task->t.regs.ebx & 0x3) = 3) {
-		printk(KERN_INFO "uvesafb: VBIOS/hardware supports both "
-				 "DDC1 and DDC2 transfers\n");
+		pr_info("VBIOS/hardware supports both DDC1 and DDC2 transfers\n");
 	} else if ((task->t.regs.ebx & 0x3) = 2) {
-		printk(KERN_INFO "uvesafb: VBIOS/hardware supports DDC2 "
-				 "transfers\n");
+		pr_info("VBIOS/hardware supports DDC2 transfers\n");
 	} else if ((task->t.regs.ebx & 0x3) = 1) {
-		printk(KERN_INFO "uvesafb: VBIOS/hardware supports DDC1 "
-				 "transfers\n");
+		pr_info("VBIOS/hardware supports DDC1 transfers\n");
 	} else {
-		printk(KERN_INFO "uvesafb: VBIOS/hardware doesn't support "
-				 "DDC transfers\n");
+		pr_info("VBIOS/hardware doesn't support DDC transfers\n");
 		return -EINVAL;
 	}
 
@@ -718,14 +708,12 @@ static void uvesafb_vbe_getmonspecs(struct uvesafb_ktask *task,
 	}
 
 	if (info->monspecs.gtf)
-		printk(KERN_INFO
-			"uvesafb: monitor limits: vf = %d Hz, hf = %d kHz, "
-			"clk = %d MHz\n", info->monspecs.vfmax,
+		pr_info("monitor limits: vf = %d Hz, hf = %d kHz, clk = %d MHz\n",
+			info->monspecs.vfmax,
 			(int)(info->monspecs.hfmax / 1000),
 			(int)(info->monspecs.dclkmax / 1000000));
 	else
-		printk(KERN_INFO "uvesafb: no monitor limits have been set, "
-				 "default refresh rate will be used\n");
+		pr_info("no monitor limits have been set, default refresh rate will be used\n");
 
 	/* Add VBE modes to the modelist. */
 	for (i = 0; i < par->vbe_modes_cnt; i++) {
@@ -779,8 +767,7 @@ static void uvesafb_vbe_getstatesize(struct uvesafb_ktask *task,
 	err = uvesafb_exec(task);
 
 	if (err || (task->t.regs.eax & 0xffff) != 0x004f) {
-		printk(KERN_WARNING "uvesafb: VBE state buffer size "
-			"cannot be determined (eax=0x%x, err=%d)\n",
+		pr_warn("VBE state buffer size cannot be determined (eax=0x%x, err=%d)\n",
 			task->t.regs.eax, err);
 		par->vbe_state_size = 0;
 		return;
@@ -815,8 +802,7 @@ static int uvesafb_vbe_init(struct fb_info *info)
 	if (par->pmi_setpal || par->ypan) {
 		if (__supported_pte_mask & _PAGE_NX) {
 			par->pmi_setpal = par->ypan = 0;
-			printk(KERN_WARNING "uvesafb: NX protection is active, "
-					    "better not use the PMI.\n");
+			pr_warn("NX protection is active, better not use the PMI\n");
 		} else {
 			uvesafb_vbe_getpmi(task, par);
 		}
@@ -859,8 +845,7 @@ static int uvesafb_vbe_init_mode(struct fb_info *info)
 				goto gotmode;
 			}
 		}
-		printk(KERN_INFO "uvesafb: requested VBE mode 0x%x is "
-				 "unavailable\n", vbemode);
+		pr_info("requested VBE mode 0x%x is unavailable\n", vbemode);
 		vbemode = 0;
 	}
 
@@ -1181,8 +1166,8 @@ static int uvesafb_open(struct fb_info *info, int user)
 	if (!cnt && par->vbe_state_size) {
 		buf =  uvesafb_vbe_state_save(par);
 		if (IS_ERR(buf)) {
-			printk(KERN_WARNING "uvesafb: save hardware state"
-				"failed, error code is %ld!\n", PTR_ERR(buf));
+			pr_warn("save hardware state failed, error code is %ld!\n",
+				PTR_ERR(buf));
 		} else {
 			par->vbe_state_orig = buf;
 		}
@@ -1293,17 +1278,16 @@ static int uvesafb_set_par(struct fb_info *info)
 		 * use our own timings.  Try again with the default timings.
 		 */
 		if (crtc != NULL) {
-			printk(KERN_WARNING "uvesafb: mode switch failed "
-				"(eax=0x%x, err=%d). Trying again with "
-				"default timings.\n", task->t.regs.eax, err);
+			pr_warn("mode switch failed (eax=0x%x, err=%d) - trying again with default timings\n",
+				task->t.regs.eax, err);
 			uvesafb_reset(task);
 			kfree(crtc);
 			crtc = NULL;
 			info->var.pixclock = 0;
 			goto setmode;
 		} else {
-			printk(KERN_ERR "uvesafb: mode switch failed (eax="
-				"0x%x, err=%d)\n", task->t.regs.eax, err);
+			pr_err("mode switch failed (eax=0x%x, err=%d)\n",
+			       task->t.regs.eax, err);
 			err = -EINVAL;
 			goto out;
 		}
@@ -1510,13 +1494,11 @@ static void uvesafb_init_info(struct fb_info *info, struct vbe_mode_ib *mode)
 				 mode->bytes_per_scan_line;
 
 	if (par->ypan && info->var.yres_virtual > info->var.yres) {
-		printk(KERN_INFO "uvesafb: scrolling: %s "
-			"using protected mode interface, "
-			"yres_virtual=%d\n",
+		pr_info("scrolling: %s using protected mode interface, yres_virtual=%d\n",
 			(par->ypan > 1) ? "ywrap" : "ypan",
 			info->var.yres_virtual);
 	} else {
-		printk(KERN_INFO "uvesafb: scrolling: redraw\n");
+		pr_info("scrolling: redraw\n");
 		info->var.yres_virtual = info->var.yres;
 		par->ypan = 0;
 	}
@@ -1704,7 +1686,7 @@ static int uvesafb_probe(struct platform_device *dev)
 
 	err = uvesafb_vbe_init(info);
 	if (err) {
-		printk(KERN_ERR "uvesafb: vbe_init() failed with %d\n", err);
+		pr_err("vbe_init() failed with %d\n", err);
 		goto out;
 	}
 
@@ -1726,15 +1708,15 @@ static int uvesafb_probe(struct platform_device *dev)
 	uvesafb_init_info(info, mode);
 
 	if (!request_region(0x3c0, 32, "uvesafb")) {
-		printk(KERN_ERR "uvesafb: request region 0x3c0-0x3e0 failed\n");
+		pr_err("request region 0x3c0-0x3e0 failed\n");
 		err = -EIO;
 		goto out_mode;
 	}
 
 	if (!request_mem_region(info->fix.smem_start, info->fix.smem_len,
 				"uvesafb")) {
-		printk(KERN_ERR "uvesafb: cannot reserve video memory at "
-				"0x%lx\n", info->fix.smem_start);
+		pr_err("cannot reserve video memory at 0x%lx\n",
+		       info->fix.smem_start);
 		err = -EIO;
 		goto out_reg;
 	}
@@ -1743,10 +1725,8 @@ static int uvesafb_probe(struct platform_device *dev)
 	uvesafb_ioremap(info);
 
 	if (!info->screen_base) {
-		printk(KERN_ERR
-			"uvesafb: abort, cannot ioremap 0x%x bytes of video "
-			"memory at 0x%lx\n",
-			info->fix.smem_len, info->fix.smem_start);
+		pr_err("abort, cannot ioremap 0x%x bytes of video memory at 0x%lx\n",
+		       info->fix.smem_len, info->fix.smem_start);
 		err = -EIO;
 		goto out_mem;
 	}
@@ -1754,16 +1734,14 @@ static int uvesafb_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, info);
 
 	if (register_framebuffer(info) < 0) {
-		printk(KERN_ERR
-			"uvesafb: failed to register framebuffer device\n");
+		pr_err("failed to register framebuffer device\n");
 		err = -EINVAL;
 		goto out_unmap;
 	}
 
-	printk(KERN_INFO "uvesafb: framebuffer at 0x%lx, mapped to 0x%p, "
-			"using %dk, total %dk\n", info->fix.smem_start,
-			info->screen_base, info->fix.smem_len/1024,
-			par->vbe_ib.total_memory * 64);
+	pr_info("framebuffer at 0x%lx, mapped to 0x%p, using %dk, total %dk\n",
+		info->fix.smem_start, info->screen_base,
+		info->fix.smem_len / 1024, par->vbe_ib.total_memory * 64);
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 
 	err = sysfs_create_group(&dev->dev.kobj, &uvesafb_dev_attgrp);
@@ -1871,8 +1849,7 @@ static int uvesafb_setup(char *options)
 		else if (this_opt[0] >= '0' && this_opt[0] <= '9') {
 			mode_option = this_opt;
 		} else {
-			printk(KERN_WARNING
-				"uvesafb: unrecognized option %s\n", this_opt);
+			pr_warn("unrecognized option %s\n", this_opt);
 		}
 	}
 
@@ -1931,8 +1908,7 @@ static int uvesafb_init(void)
 		err = driver_create_file(&uvesafb_driver.driver,
 				&driver_attr_v86d);
 		if (err) {
-			printk(KERN_WARNING "uvesafb: failed to register "
-					"attributes\n");
+			pr_warn("failed to register attributes\n");
 			err = 0;
 		}
 	}
-- 
2.10.0.rc2.1.g053435c


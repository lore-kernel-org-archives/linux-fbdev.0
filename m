From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Framebuffer and non-PCI devices
Date: Sat, 19 Feb 2005 16:59:46 -0500
Message-ID: <9e473391050219135923cc6455@mail.gmail.com>
References: <9e47339105021910257461d4cc@mail.gmail.com>
	 <Pine.LNX.4.62.0502191937500.3355@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2cdh-0000Wn-Km
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 13:59:49 -0800
Received: from rproxy.gmail.com ([64.233.170.194])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D2cdf-0003dy-5Z
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 13:59:49 -0800
Received: by rproxy.gmail.com with SMTP id z35so166168rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Feb 2005 13:59:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.62.0502191937500.3355@numbat.sonytel.be>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

I started editing all of the drivers to make assigning fb_info->device
explicit.  Does this look like it is useful? I was surprised some
architectures don't make use of 'struct device'. If this is
interesting there are about ten more drivers that I need to patch.  I
did find several drivers which have device struct's that are not
assigning them to fb_info->device.

--=20
Jon Smirl
jonsmirl@gmail.com


=3D=3D=3D=3D=3D drivers/video/68328fb.c 1.8 vs edited =3D=3D=3D=3D=3D
--- 1.8/drivers/video/68328fb.c=092004-09-22 16:28:16 -04:00
+++ edited/drivers/video/68328fb.c=092005-02-19 15:12:20 -05:00
@@ -477,7 +477,7 @@
=20
 =09fb_alloc_cmap(&fb_info.cmap, 256, 0);
=20
-=09if (register_framebuffer(&fb_info) < 0) {
+=09if (register_framebuffer(&fb_info, NULL) < 0) {
 =09=09return -EINVAL;
 =09}
=20
=3D=3D=3D=3D=3D drivers/video/acornfb.c 1.34 vs edited =3D=3D=3D=3D=3D
--- 1.34/drivers/video/acornfb.c=092004-11-07 21:13:25 -05:00
+++ edited/drivers/video/acornfb.c=092005-02-19 15:12:55 -05:00
@@ -1449,7 +1449,7 @@
 =09if (fb_set_var(&fb_info, &fb_info.var))
 =09=09printk(KERN_ERR "Acornfb: unable to set display parameters\n");
=20
-=09if (register_framebuffer(&fb_info) < 0)
+=09if (register_framebuffer(&fb_info, dev) < 0)
 =09=09return -EINVAL;
 =09return 0;
 }
=3D=3D=3D=3D=3D drivers/video/amba-clcd.c 1.5 vs edited =3D=3D=3D=3D=3D
--- 1.5/drivers/video/amba-clcd.c=092004-12-30 19:00:46 -05:00
+++ edited/drivers/video/amba-clcd.c=092005-02-19 15:16:50 -05:00
@@ -414,7 +414,7 @@
         printk(KERN_INFO "CLCD: %s hardware, %s display\n",
                fb->board->name, fb->panel->mode.name);
=20
-=09ret =3D register_framebuffer(&fb->fb);
+=09ret =3D register_framebuffer(&fb->fb, &fb->dev.dev);
 =09if (ret =3D=3D 0)
 =09=09goto out;
=20
=3D=3D=3D=3D=3D drivers/video/amifb.c 1.38 vs edited =3D=3D=3D=3D=3D
--- 1.38/drivers/video/amifb.c=092004-11-11 03:39:04 -05:00
+++ edited/drivers/video/amifb.c=092005-02-19 15:18:36 -05:00
@@ -2438,7 +2438,7 @@
=20
 =09fb_alloc_cmap(&fb_info.cmap, 1<<fb_info.var.bits_per_pixel, 0);
=20
-=09if (register_framebuffer(&fb_info) < 0) {
+=09if (register_framebuffer(&fb_info, NULL) < 0) {
 =09=09err =3D -EINVAL;
 =09=09goto amifb_error;
 =09}
=3D=3D=3D=3D=3D drivers/video/asiliantfb.c 1.6 vs edited =3D=3D=3D=3D=3D
--- 1.6/drivers/video/asiliantfb.c=092004-10-29 04:13:41 -04:00
+++ edited/drivers/video/asiliantfb.c=092005-02-19 14:35:18 -05:00
@@ -528,11 +528,6 @@
=20
 =09fb_alloc_cmap(&p->cmap, 256, 0);
=20
-=09if (register_framebuffer(p) < 0) {
-=09=09printk(KERN_ERR "C&T 69000 framebuffer failed to register\n");
-=09=09return;
-=09}
-
 =09printk(KERN_INFO "fb%d: Asiliant 69000 frame buffer (%dK RAM detected)\=
n",
 =09=09p->node, p->fix.smem_len / 1024);
=20
@@ -573,6 +568,10 @@
 =09pci_write_config_dword(dp, 4, 0x02800083);
 =09writeb(3, p->screen_base + 0x400784);
=20
+=09if (register_framebuffer(p, &dp->dev) < 0) {
+=09=09printk(KERN_ERR "C&T 69000 framebuffer failed to register\n");
+=09=09return -ENODEV;
+=09}
 =09init_asiliant(p, addr);
=20
 =09pci_set_drvdata(dp, p);
=3D=3D=3D=3D=3D drivers/video/atafb.c 1.23 vs edited =3D=3D=3D=3D=3D
--- 1.23/drivers/video/atafb.c=092004-05-10 07:25:55 -04:00
+++ edited/drivers/video/atafb.c=092005-02-19 15:19:34 -05:00
@@ -2806,7 +2806,7 @@
 =09atafb_set_disp(-1, &fb_info);
 =09do_install_cmap(0, &fb_info);
=20
-=09if (register_framebuffer(&fb_info) < 0)
+=09if (register_framebuffer(&fb_info, NULL) < 0)
 =09=09return -EINVAL;
=20
 =09printk("Determined %dx%d, depth %d\n",
=3D=3D=3D=3D=3D drivers/video/au1100fb.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/drivers/video/au1100fb.c=092005-01-31 01:33:41 -05:00
+++ edited/drivers/video/au1100fb.c=092005-02-19 15:20:23 -05:00
@@ -596,7 +596,7 @@
 =09fbgen_do_set_var(&disp.var, 1, &fb_info.gen);
 =09fbgen_set_disp(-1, &fb_info.gen);
 =09fbgen_install_cmap(0, &fb_info.gen);
-=09if (register_framebuffer(&fb_info.gen.info) < 0)
+=09if (register_framebuffer(&fb_info.gen.info, NULL) < 0)
 =09=09return -EINVAL;
 =09printk(KERN_INFO "fb%d: %s frame buffer device\n",
 =09=09=09GET_FB_IDX(fb_info.gen.info.node),
=3D=3D=3D=3D=3D drivers/video/bw2.c 1.16 vs edited =3D=3D=3D=3D=3D
--- 1.16/drivers/video/bw2.c=092004-11-27 09:52:46 -05:00
+++ edited/drivers/video/bw2.c=092005-02-19 15:20:59 -05:00
@@ -366,7 +366,7 @@
=20
 =09bw2_init_fix(&all->info, linebytes);
=20
-=09if (register_framebuffer(&all->info) < 0) {
+=09if (register_framebuffer(&all->info, NULL) < 0) {
 =09=09printk(KERN_ERR "bw2: Could not register framebuffer.\n");
 =09=09kfree(all);
 =09=09return;
=3D=3D=3D=3D=3D drivers/video/cg14.c 1.17 vs edited =3D=3D=3D=3D=3D
--- 1.17/drivers/video/cg14.c=092005-02-05 00:32:58 -05:00
+++ edited/drivers/video/cg14.c=092005-02-19 15:21:40 -05:00
@@ -573,7 +573,7 @@
=20
 =09cg14_init_fix(&all->info, linebytes);
=20
-=09if (register_framebuffer(&all->info) < 0) {
+=09if (register_framebuffer(&all->info, NULL) < 0) {
 =09=09printk(KERN_ERR "cg14: Could not register framebuffer.\n");
 =09=09fb_dealloc_cmap(&all->info.cmap);
 =09=09kfree(all);
=3D=3D=3D=3D=3D drivers/video/cg3.c 1.17 vs edited =3D=3D=3D=3D=3D
--- 1.17/drivers/video/cg3.c=092005-02-15 10:40:51 -05:00
+++ edited/drivers/video/cg3.c=092005-02-19 15:22:26 -05:00
@@ -426,7 +426,7 @@
=20
 =09cg3_init_fix(&all->info, linebytes);
=20
-=09if (register_framebuffer(&all->info) < 0) {
+=09if (register_framebuffer(&all->info, NULL) < 0) {
 =09=09printk(KERN_ERR "cg3: Could not register framebuffer.\n");
 =09=09fb_dealloc_cmap(&all->info.cmap);
 =09=09kfree(all);
=3D=3D=3D=3D=3D drivers/video/cg6.c 1.13 vs edited =3D=3D=3D=3D=3D
--- 1.13/drivers/video/cg6.c=092005-01-02 04:37:36 -05:00
+++ edited/drivers/video/cg6.c=092005-02-19 15:22:14 -05:00
@@ -738,7 +738,7 @@
 =09fb_set_cmap(&all->info.cmap, &all->info);
 =09cg6_init_fix(&all->info, linebytes);
=20
-=09if (register_framebuffer(&all->info) < 0) {
+=09if (register_framebuffer(&all->info, NULL) < 0) {
 =09=09printk(KERN_ERR "cg6: Could not register framebuffer.\n");
 =09=09fb_dealloc_cmap(&all->info.cmap);
 =09=09kfree(all);
=3D=3D=3D=3D=3D drivers/video/chipsfb.c 1.25 vs edited =3D=3D=3D=3D=3D
--- 1.25/drivers/video/chipsfb.c=092004-10-19 05:40:21 -04:00
+++ edited/drivers/video/chipsfb.c=092005-02-19 16:03:45 -05:00
@@ -354,7 +354,7 @@
 =09.vsync_len =3D 8,
 };
=20
-static void __init init_chips(struct fb_info *p, unsigned long addr)
+static void __init init_chips(struct fb_info *p, struct pci_dev *dp,
unsigned long addr)
 {
 =09p->fix =3D chipsfb_fix;
 =09p->fix.smem_start =3D addr;
@@ -366,7 +366,7 @@
=20
 =09fb_alloc_cmap(&p->cmap, 256, 0);
=20
-=09if (register_framebuffer(p) < 0) {
+=09if (register_framebuffer(p, &dp->dev) < 0) {
 =09=09printk(KERN_ERR "C&T 65550 framebuffer failed to register\n");
 =09=09return;
 =09}
@@ -417,7 +417,7 @@
 =09=09return -ENOMEM;
 =09}
 =09p->device =3D &dp->dev;
-=09init_chips(p, addr);
+=09init_chips(p, dp, addr);
=20
 #ifdef CONFIG_PMAC_PBOOK
 =09pmu_register_sleep_notifier(&chips_sleep_notifier);
=3D=3D=3D=3D=3D drivers/video/cirrusfb.c 1.37 vs edited =3D=3D=3D=3D=3D
--- 1.37/drivers/video/cirrusfb.c=092004-11-11 03:39:04 -05:00
+++ edited/drivers/video/cirrusfb.c=092005-02-19 14:57:36 -05:00
@@ -2294,7 +2294,7 @@
 =09return 0;
 }
=20
-static int cirrusfb_register(struct cirrusfb_info *cinfo)
+static int cirrusfb_register(struct cirrusfb_info *cinfo, struct
device *device)
 {
 =09struct fb_info *info;
 =09int err;
@@ -2327,7 +2327,7 @@
 =09/* set all the vital stuff */
 =09cirrusfb_set_fbinfo(cinfo);
=20
-=09err =3D register_framebuffer(info);
+=09err =3D register_framebuffer(info, device);
 =09if (err < 0) {
 =09=09printk (KERN_ERR "cirrusfb: could not register fb device; err =3D %d=
!\n", err);
 =09=09goto err_dealloc_cmap;
@@ -2441,7 +2441,7 @@
 =09printk ("Cirrus Logic chipset on PCI bus\n");
 =09pci_set_drvdata(pdev, info);
=20
-=09return cirrusfb_register(cinfo);
+=09return cirrusfb_register(cinfo, &pdev->dev);
=20
 err_release_legacy:
 =09if (release_io_ports)
@@ -2574,7 +2574,7 @@
 =09printk (KERN_INFO "Cirrus Logic chipset on Zorro bus\n");
 =09zorro_set_drvdata(z, info);
=20
-=09return cirrusfb_register(cinfo);
+=09return cirrusfb_register(cinfo, NULL);
=20
 err_unmap_regbase:
 =09/* Parental advisory: explicit hack */
=3D=3D=3D=3D=3D drivers/video/clps711xfb.c 1.23 vs edited =3D=3D=3D=3D=3D
--- 1.23/drivers/video/clps711xfb.c=092004-09-22 16:28:16 -04:00
+++ edited/drivers/video/clps711xfb.c=092005-02-19 16:05:29 -05:00
@@ -416,7 +416,7 @@
 =09=09clps_writeb(clps_readb(PDDR) | EDB_PD3_LCDBL, PDDR);
 =09}
=20
-=09err =3D register_framebuffer(cfb);
+=09err =3D register_framebuffer(cfb, NULL);
=20
 out:=09return err;
 }
=3D=3D=3D=3D=3D drivers/video/controlfb.c 1.32 vs edited =3D=3D=3D=3D=3D
--- 1.32/drivers/video/controlfb.c=092004-11-27 09:53:02 -05:00
+++ edited/drivers/video/controlfb.c=092005-02-19 16:06:13 -05:00
@@ -480,7 +480,7 @@
 =09=09goto try_again;
=20
 =09/* Register with fbdev layer */
-=09if (register_framebuffer(&p->info) < 0)
+=09if (register_framebuffer(&p->info, NULL) < 0)
 =09=09return -ENXIO;
 =09
 =09printk(KERN_INFO "fb%d: control display adapter\n", p->info.node);=09
=3D=3D=3D=3D=3D drivers/video/cyber2000fb.c 1.41 vs edited =3D=3D=3D=3D=3D
--- 1.41/drivers/video/cyber2000fb.c=092005-01-08 00:44:25 -05:00
+++ edited/drivers/video/cyber2000fb.c=092005-02-19 14:47:46 -05:00
@@ -1399,9 +1399,7 @@
 =09=09cfb->fb.var.xres, cfb->fb.var.yres,
 =09=09h_sync / 1000, h_sync % 1000, v_sync);
=20
-=09if (cfb->dev)
-=09=09cfb->fb.device =3D &cfb->dev->dev;
-=09err =3D register_framebuffer(&cfb->fb);
+=09err =3D register_framebuffer(&cfb->fb, (cfb->dev ? &cfb->dev->dev : NUL=
L));
=20
 failed:
 =09return err;
=3D=3D=3D=3D=3D drivers/video/cyberfb.c 1.17 vs edited =3D=3D=3D=3D=3D
--- 1.17/drivers/video/cyberfb.c=092004-05-10 07:25:55 -04:00
+++ edited/drivers/video/cyberfb.c=092005-02-19 16:06:51 -05:00
@@ -1054,7 +1054,7 @@
 =09    cyberfb_set_disp(-1, &fb_info);
 =09    do_install_cmap(0, &fb_info);
=20
-=09    if (register_framebuffer(&fb_info) < 0) {
+=09    if (register_framebuffer(&fb_info, NULL) < 0) {
 =09=09    DPRINTK("EXIT - register_framebuffer failed\n");
 =09=09    release_mem_region(CyberMem_phys, 0x400000);
 =09=09    release_mem_region(CyberRegs_phys, 0x10000);
=3D=3D=3D=3D=3D drivers/video/dnfb.c 1.28 vs edited =3D=3D=3D=3D=3D
--- 1.28/drivers/video/dnfb.c=092004-09-22 16:28:16 -04:00
+++ edited/drivers/video/dnfb.c=092005-02-19 16:07:31 -05:00
@@ -250,7 +250,7 @@
 =09=09return err;
 =09}
=20
-=09err =3D register_framebuffer(info);
+=09err =3D register_framebuffer(info, device);
 =09if (err < 0) {
 =09=09fb_dealloc_cmap(&info->cmap);
 =09=09framebuffer_release(info);
=3D=3D=3D=3D=3D drivers/video/epson1355fb.c 1.18 vs edited =3D=3D=3D=3D=3D
--- 1.18/drivers/video/epson1355fb.c=092004-11-11 03:39:04 -05:00
+++ edited/drivers/video/epson1355fb.c=092005-02-19 16:08:07 -05:00
@@ -705,7 +705,7 @@
 =09backlight_enable(1);
 =09lcd_enable(default_par, 1);
=20
-=09if (register_framebuffer(info) < 0) {
+=09if (register_framebuffer(info, device) < 0) {
 =09=09rc =3D -EINVAL;
 =09=09goto bail;
 =09}
=3D=3D=3D=3D=3D drivers/video/fbmem.c 1.151 vs edited =3D=3D=3D=3D=3D
--- 1.151/drivers/video/fbmem.c=092005-02-17 19:03:05 -05:00
+++ edited/drivers/video/fbmem.c=092005-02-19 14:14:59 -05:00
@@ -1055,7 +1055,7 @@
  */
=20
 int
-register_framebuffer(struct fb_info *fb_info)
+register_framebuffer(struct fb_info *fb_info, struct device *device)
 {
 =09int i;
 =09struct class_device *c;
@@ -1068,6 +1068,7 @@
 =09=09if (!registered_fb[i])
 =09=09=09break;
 =09fb_info->node =3D i;
+=09fb_info->device =3D device;
=20
 =09c =3D class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
 =09=09=09=09    fb_info->device, "fb%d", i);
=3D=3D=3D=3D=3D drivers/video/ffb.c 1.16 vs edited =3D=3D=3D=3D=3D
--- 1.16/drivers/video/ffb.c=092004-11-11 03:39:04 -05:00
+++ edited/drivers/video/ffb.c=092005-02-19 16:08:41 -05:00
@@ -1017,7 +1017,7 @@
=20
 =09ffb_init_fix(&all->info);
=20
-=09if (register_framebuffer(&all->info) < 0) {
+=09if (register_framebuffer(&all->info, NULL) < 0) {
 =09=09printk(KERN_ERR "ffb: Could not register framebuffer.\n");
 =09=09fb_dealloc_cmap(&all->info.cmap);
 =09=09kfree(all);
=3D=3D=3D=3D=3D drivers/video/fm2fb.c 1.30 vs edited =3D=3D=3D=3D=3D
--- 1.30/drivers/video/fm2fb.c=092004-11-19 02:03:13 -05:00
+++ edited/drivers/video/fm2fb.c=092005-02-19 16:10:27 -05:00
@@ -282,7 +282,7 @@
 =09info->fix =3D fb_fix;
 =09info->flags =3D FBINFO_DEFAULT;
=20
-=09if (register_framebuffer(info) < 0) {
+=09if (register_framebuffer(info, &z->dev) < 0) {
 =09=09fb_dealloc_cmap(&info->cmap);
 =09=09framebuffer_release(info);
 =09=09zorro_release_device(z);
=3D=3D=3D=3D=3D drivers/video/g364fb.c 1.25 vs edited =3D=3D=3D=3D=3D
--- 1.25/drivers/video/g364fb.c=092005-01-31 01:33:42 -05:00
+++ edited/drivers/video/g364fb.c=092005-02-19 16:11:05 -05:00
@@ -249,7 +249,7 @@
=20
 =09fb_alloc_cmap(&fb_info.cmap, 255, 0);
=20
-=09if (register_framebuffer(&fb_info) < 0)
+=09if (register_framebuffer(&fb_info, NULL) < 0)
 =09=09return -EINVAL;
 =09return 0;
 }
=3D=3D=3D=3D=3D drivers/video/gbefb.c 1.9 vs edited =3D=3D=3D=3D=3D
--- 1.9/drivers/video/gbefb.c=092005-01-31 01:33:42 -05:00
+++ edited/drivers/video/gbefb.c=092005-02-19 16:11:47 -05:00
@@ -1193,7 +1193,7 @@
 =09gbefb_check_var(&par->var, info);
 =09gbefb_encode_fix(&info->fix, &info->var);
=20
-=09if (register_framebuffer(info) < 0) {
+=09if (register_framebuffer(info, dev) < 0) {
 =09=09printk(KERN_ERR "gbefb: couldn't register framebuffer\n");
 =09=09ret =3D -ENXIO;
 =09=09goto out_gbe_unmap;
=3D=3D=3D=3D=3D drivers/video/hgafb.c 1.35 vs edited =3D=3D=3D=3D=3D
--- 1.35/drivers/video/hgafb.c=092005-01-21 00:02:09 -05:00
+++ edited/drivers/video/hgafb.c=092005-02-19 14:52:45 -05:00
@@ -577,7 +577,7 @@
 =09fb_info.fbops =3D &hgafb_ops;
 =09fb_info.screen_base =3D hga_vram;
=20
-        if (register_framebuffer(&fb_info) < 0) {
+        if (register_framebuffer(&fb_info, NULL) < 0) {
 =09=09iounmap(hga_vram);
 =09=09return -EINVAL;
 =09}
=3D=3D=3D=3D=3D drivers/video/hitfb.c 1.26 vs edited =3D=3D=3D=3D=3D
--- 1.26/drivers/video/hitfb.c=092004-09-22 16:28:16 -04:00
+++ edited/drivers/video/hitfb.c=092005-02-19 16:12:29 -05:00
@@ -331,7 +331,7 @@
 =09size =3D (fb_info.var.bits_per_pixel =3D=3D 8) ? 256 : 16;
 =09fb_alloc_cmap(&fb_info.cmap, size, 0);
=20
-=09if (register_framebuffer(&fb_info) < 0)
+=09if (register_framebuffer(&fb_info, NULL) < 0)
 =09=09return -EINVAL;
=20
 =09printk(KERN_INFO "fb%d: %s frame buffer device\n",
=3D=3D=3D=3D=3D drivers/video/hpfb.c 1.25 vs edited =3D=3D=3D=3D=3D
--- 1.25/drivers/video/hpfb.c=092004-10-06 16:47:54 -04:00
+++ edited/drivers/video/hpfb.c=092005-02-19 16:14:34 -05:00
@@ -210,7 +210,7 @@
 #define HPFB_FBOMSB=090x5d=09/* Frame buffer offset=09=09*/
 #define HPFB_FBOLSB=090x5f
=20
-static int __init hpfb_init_one(unsigned long phys_base, unsigned
long virt_base)
+static int __init hpfb_init_one(unsigned long phys_base, struct
dio_dev * d, unsigned long virt_base)
 {
 =09unsigned long fboff, fb_width, fb_height, fb_start;
=20
@@ -295,7 +295,7 @@
=20
 =09fb_alloc_cmap(&fb_info.cmap, 1 << hpfb_defined.bits_per_pixel, 0);
=20
-=09if (register_framebuffer(&fb_info) < 0) {
+=09if (register_framebuffer(&fb_info, &d->dev) < 0) {
 =09=09fb_dealloc_cmap(&fb_info.cmap);
 =09=09return 1;
 =09}
@@ -332,7 +332,7 @@
 =09}
 =09printk(KERN_INFO "Topcat found at DIO select code %d "
 =09       "(secondary id %02x)\n", d->scode, (d->id >> 8) & 0xff);
-=09if (hpfb_init_one(paddr, vaddr)) {
+=09if (hpfb_init_one(paddr, d, vaddr)) {
 =09=09if (d->scode >=3D DIOII_SCBASE)
 =09=09=09iounmap((void *)vaddr);
 =09=09return -ENOMEM;
@@ -398,7 +398,7 @@
 =09=09if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat"))
 =09=09=09return -EBUSY;
 =09=09printk(KERN_INFO "Internal Topcat found (secondary id %02x)\n", sid)=
;
-=09=09if (hpfb_init_one(INTFBPADDR, INTFBVADDR)) {
+=09=09if (hpfb_init_one(INTFBPADDR, NULL, INTFBVADDR)) {
 =09=09=09return -ENOMEM;
 =09=09}
 =09}
=3D=3D=3D=3D=3D drivers/video/igafb.c 1.24 vs edited =3D=3D=3D=3D=3D
--- 1.24/drivers/video/igafb.c=092004-10-20 04:37:06 -04:00
+++ edited/drivers/video/igafb.c=092005-02-19 16:17:19 -05:00
@@ -361,9 +361,6 @@
=20
 =09fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
=20
-=09if (register_framebuffer(info) < 0)
-=09=09return 0;
-
 =09printk("fb%d: %s frame buffer device at 0x%08lx [%dMB VRAM]\n",
 =09       info->node, info->fix.id,=20
 =09       par->frame_buffer_phys, info->fix.smem_len >> 20);
@@ -533,7 +530,7 @@
 =09info->pseudo_palette =3D (void *)(par + 1);
 =09info->device =3D &pdev->dev;
=20
-=09if (!iga_init(info, par)) {
+=09if (!(register_framebuffer(info, &pdev->dev) < 0) || (!iga_init(info, p=
ar))) {
 =09=09iounmap((void *)par->io_base);
 =09=09iounmap(info->screen_base);
 =09=09if (par->mmap_map)
=3D=3D=3D=3D=3D drivers/video/imsttfb.c 1.38 vs edited =3D=3D=3D=3D=3D
--- 1.38/drivers/video/imsttfb.c=092004-11-21 05:51:36 -05:00
+++ edited/drivers/video/imsttfb.c=092005-02-19 14:33:32 -05:00
@@ -1449,11 +1449,6 @@
=20
 =09fb_alloc_cmap(&info->cmap, 0, 0);
=20
-=09if (register_framebuffer(info) < 0) {
-=09=09kfree(info);
-=09=09return;
-=09}
-
 =09tmp =3D (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 =09printk("fb%u: %s frame buffer; %uMB vram; chip version %u\n",
 =09=09info->node, info->fix.id, info->fix.smem_len >> 20, tmp);
@@ -1524,7 +1519,10 @@
 =09par->cmap_regs =3D (__u8 *)ioremap(addr + 0x840000, 0x1000);
 =09info->par =3D par;
 =09info->pseudo_palette =3D (void *) (par + 1);
-=09info->device =3D &pdev->dev;
+=09if (register_framebuffer(info, &pdev->dev) < 0) {
+=09=09kfree(info);
+=09=09return -ENODEV;
+=09}
 =09init_imstt(info);
=20
 =09pci_set_drvdata(pdev, info);
=3D=3D=3D=3D=3D drivers/video/leo.c 1.12 vs edited =3D=3D=3D=3D=3D
--- 1.12/drivers/video/leo.c=092004-11-27 09:53:11 -05:00
+++ edited/drivers/video/leo.c=092005-02-19 16:19:30 -05:00
@@ -605,7 +605,7 @@
=20
 =09leo_init_fix(&all->info);
=20
-=09if (register_framebuffer(&all->info) < 0) {
+=09if (register_framebuffer(&all->info, NULL) < 0) {
 =09=09printk(KERN_ERR "leo: Could not register framebuffer.\n");
 =09=09fb_dealloc_cmap(&all->info.cmap);
 =09=09kfree(all);
=3D=3D=3D=3D=3D drivers/video/macfb.c 1.32 vs edited =3D=3D=3D=3D=3D
--- 1.32/drivers/video/macfb.c=092004-09-22 16:28:16 -04:00
+++ edited/drivers/video/macfb.c=092005-02-19 16:20:13 -05:00
@@ -959,7 +959,7 @@
=20
 =09fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 =09
-=09if (register_framebuffer(&fb_info) < 0)
+=09if (register_framebuffer(&fb_info, NULL) < 0)
 =09=09return;
=20
 =09printk("fb%d: %s frame buffer device\n",
=3D=3D=3D=3D=3D drivers/video/maxinefb.c 1.23 vs edited =3D=3D=3D=3D=3D
--- 1.23/drivers/video/maxinefb.c=092005-01-31 01:33:42 -05:00
+++ edited/drivers/video/maxinefb.c=092005-02-19 16:23:18 -05:00
@@ -162,7 +162,7 @@
=20
 =09fb_alloc_cmap(&fb_info.cmap, 256, 0);
=20
-=09if (register_framebuffer(&fb_info) < 0)
+=09if (register_framebuffer(&fb_info, NULL) < 0)
 =09=09return 1;
 =09return 0;
 }
=3D=3D=3D=3D=3D drivers/video/neofb.c 1.42 vs edited =3D=3D=3D=3D=3D
--- 1.42/drivers/video/neofb.c=092005-01-08 00:44:32 -05:00
+++ edited/drivers/video/neofb.c=092005-02-19 14:50:06 -05:00
@@ -2133,7 +2133,7 @@
 =09if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
 =09=09goto err_map_video;
=20
-=09err =3D register_framebuffer(info);
+=09err =3D register_framebuffer(info, &dev->dev);
 =09if (err < 0)
 =09=09goto err_reg_fb;
=20
=3D=3D=3D=3D=3D drivers/video/offb.c 1.34 vs edited =3D=3D=3D=3D=3D
--- 1.34/drivers/video/offb.c=092004-11-27 09:53:14 -05:00
+++ edited/drivers/video/offb.c=092005-02-19 16:25:36 -05:00
@@ -515,7 +515,7 @@
=20
 =09fb_alloc_cmap(&info->cmap, 256, 0);
=20
-=09if (register_framebuffer(info) < 0) {
+=09if (register_framebuffer(info, NULL) < 0) {
 =09=09kfree(info);
 =09=09release_mem_region(res_start, res_size);
 =09=09return;
=3D=3D=3D=3D=3D drivers/video/p9100.c 1.12 vs edited =3D=3D=3D=3D=3D
--- 1.12/drivers/video/p9100.c=092004-11-27 09:53:18 -05:00
+++ edited/drivers/video/p9100.c=092005-02-19 16:26:14 -05:00
@@ -317,7 +317,7 @@
=20
 =09p9100_init_fix(&all->info, linebytes);
=20
-=09if (register_framebuffer(&all->info) < 0) {
+=09if (register_framebuffer(&all->info, NULL) < 0) {
 =09=09printk(KERN_ERR "p9100: Could not register framebuffer.\n");
 =09=09fb_dealloc_cmap(&all->info.cmap);
 =09=09kfree(all);
=3D=3D=3D=3D=3D drivers/video/platinumfb.c 1.27 vs edited =3D=3D=3D=3D=3D
--- 1.27/drivers/video/platinumfb.c=092004-11-27 09:53:22 -05:00
+++ edited/drivers/video/platinumfb.c=092005-02-19 16:27:05 -05:00
@@ -388,7 +388,7 @@
 =09=09goto try_again;
=20
 =09/* Register with fbdev layer */
-=09rc =3D register_framebuffer(info);
+=09rc =3D register_framebuffer(info, NULL);
 =09if (rc < 0)
 =09=09return rc;
=20
=3D=3D=3D=3D=3D drivers/video/pm2fb.c 1.39 vs edited =3D=3D=3D=3D=3D
--- 1.39/drivers/video/pm2fb.c=092005-01-08 00:44:32 -05:00
+++ edited/drivers/video/pm2fb.c=092005-02-19 14:48:29 -05:00
@@ -1170,7 +1170,7 @@
 =09if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
 =09=09goto err_exit_all;
=20
-=09if (register_framebuffer(info) < 0)
+=09if (register_framebuffer(info, &pdev->dev) < 0)
 =09=09goto err_exit_both;
=20
 =09printk(KERN_INFO "fb%d: %s frame buffer device, memory =3D %dK.\n",
=3D=3D=3D=3D=3D drivers/video/pm3fb.c 1.10 vs edited =3D=3D=3D=3D=3D
--- 1.10/drivers/video/pm3fb.c=092003-09-29 20:23:11 -04:00
+++ edited/drivers/video/pm3fb.c=092005-02-19 16:29:02 -05:00
@@ -1631,7 +1631,7 @@
=20
 =09do_install_cmap(0, &l_fb_info->gen.info);
=20
-=09if (register_framebuffer(&l_fb_info->gen.info) < 0) {
+=09if (register_framebuffer(&l_fb_info->gen.info, NULL) < 0) {
 =09=09DPRINTK(1, "Couldn't register framebuffer\n");
 =09=09return;
 =09}
=3D=3D=3D=3D=3D drivers/video/pmag-aa-fb.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/drivers/video/pmag-aa-fb.c=092005-01-31 01:33:42 -05:00
+++ edited/drivers/video/pmag-aa-fb.c=092005-02-19 16:30:22 -05:00
@@ -459,7 +459,7 @@
 =09/* Clear the screen. */
 =09memset ((void *)ip->fb_start, 0, ip->fb_size);
=20
-=09if (register_framebuffer(&ip->info) < 0)
+=09if (register_framebuffer(&ip->info, NULL) < 0)
 =09=09return -EINVAL;
=20
 =09printk(KERN_INFO "fb%d: %s frame buffer in TC slot %d\n",
=3D=3D=3D=3D=3D drivers/video/pmag-ba-fb.c 1.21 vs edited =3D=3D=3D=3D=3D
--- 1.21/drivers/video/pmag-ba-fb.c=092005-01-31 01:33:42 -05:00
+++ edited/drivers/video/pmag-ba-fb.c=092005-02-19 16:30:18 -05:00
@@ -149,7 +149,7 @@
=20
 =09fb_alloc_cmap(&fb_info.cmap, 256, 0);
=20
-=09if (register_framebuffer(info) < 0)
+=09if (register_framebuffer(info, NULL) < 0)
 =09=09return 1;
 =09return 0;
 }
=3D=3D=3D=3D=3D drivers/video/pmagb-b-fb.c 1.20 vs edited =3D=3D=3D=3D=3D
--- 1.20/drivers/video/pmagb-b-fb.c=092005-01-31 01:33:42 -05:00
+++ edited/drivers/video/pmagb-b-fb.c=092005-02-19 16:30:21 -05:00
@@ -149,7 +149,7 @@
=20
 =09fb_alloc_cmap(&fb_info.cmap, 256, 0);
=20
-=09if (register_framebuffer(info) < 0)
+=09if (register_framebuffer(info, NULL) < 0)
 =09=09return 1;
 =09return 0;
 }
=3D=3D=3D=3D=3D drivers/video/radeonfb.c 1.50 vs edited =3D=3D=3D=3D=3D
--- 1.50/drivers/video/radeonfb.c=092005-02-11 01:57:44 -05:00
+++ edited/drivers/video/radeonfb.c=092005-02-19 14:49:17 -05:00
@@ -3017,8 +3017,7 @@
 =09pci_set_drvdata(pdev, rinfo);
 =09rinfo->next =3D board_list;
 =09board_list =3D rinfo;
-=09((struct fb_info *) rinfo)->device =3D &pdev->dev;
-=09if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
+=09if (register_framebuffer ((struct fb_info *) rinfo, &pdev->dev) < 0) {
 =09=09printk ("radeonfb: could not register framebuffer\n");
 =09=09iounmap(rinfo->fb_base);
 =09=09iounmap(rinfo->mmio_base);
=3D=3D=3D=3D=3D drivers/video/skeletonfb.c 1.27 vs edited =3D=3D=3D=3D=3D
--- 1.27/drivers/video/skeletonfb.c=092004-10-25 15:56:29 -04:00
+++ edited/drivers/video/skeletonfb.c=092005-02-19 14:16:31 -05:00
@@ -550,6 +550,7 @@
 int __init xxxfb_init(void)
 {
     int cmap_len, retval;=09
+    struct device *device =3D NULL; /* pointer to device structure */
   =20
     /*
      *  For kernel boot options (in 'video=3Dxxxfb:<options>' format)
@@ -602,7 +603,7 @@
      */=09
     info.var =3D xxxfb_var;
 =09
-    if (register_framebuffer(&info) < 0)
+    if (register_framebuffer(&info, device) < 0)
 =09return -EINVAL;
     printk(KERN_INFO "fb%d: %s frame buffer device\n", info.node,
 =09   info.fix.id);
=3D=3D=3D=3D=3D drivers/video/sstfb.c 1.37 vs edited =3D=3D=3D=3D=3D
--- 1.37/drivers/video/sstfb.c=092005-01-08 00:44:25 -05:00
+++ edited/drivers/video/sstfb.c=092005-02-19 14:53:51 -05:00
@@ -1502,8 +1502,7 @@
 =09fb_alloc_cmap(&info->cmap, 256, 0);
=20
 =09/* register fb */
-=09info->device =3D &pdev->dev;
-=09if (register_framebuffer(info) < 0) {
+=09if (register_framebuffer(info, &pdev->dev) < 0) {
 =09=09eprintk("can't register framebuffer.\n");
 =09=09goto fail;
 =09}
=3D=3D=3D=3D=3D drivers/video/tdfxfb.c 1.56 vs edited =3D=3D=3D=3D=3D
--- 1.56/drivers/video/tdfxfb.c=092005-01-08 00:44:32 -05:00
+++ edited/drivers/video/tdfxfb.c=092005-02-19 14:50:58 -05:00
@@ -4,7 +4,7 @@
  *
  * Author: Hannu Mallat <hmallat@cc.hut.fi>
  *
- * Copyright =A9 1999 Hannu Mallat
+ * Copyright  1999 Hannu Mallat
  * All rights reserved
  *
  * Created      : Thu Sep 23 18:17:43 1999, hmallat
@@ -1269,7 +1269,7 @@
 =09=09goto out_err;
 =09}
=20
-=09if (register_framebuffer(info) < 0) {
+=09if (register_framebuffer(info, &pdev->dev) < 0) {
 =09=09printk("tdfxfb: can't register framebuffer\n");
 =09=09fb_dealloc_cmap(&info->cmap);
 =09=09goto out_err;
=3D=3D=3D=3D=3D drivers/video/tridentfb.c 1.23 vs edited =3D=3D=3D=3D=3D
--- 1.23/drivers/video/tridentfb.c=092005-01-08 00:44:32 -05:00
+++ edited/drivers/video/tridentfb.c=092005-02-19 14:51:35 -05:00
@@ -1161,8 +1161,7 @@
 =09=09default_var.accel_flags &=3D ~FB_ACCELF_TEXT;
 =09default_var.activate |=3D FB_ACTIVATE_NOW;
 =09fb_info.var =3D default_var;
-=09fb_info.device =3D &dev->dev;
-=09if (register_framebuffer(&fb_info) < 0) {
+=09if (register_framebuffer(&fb_info, &dev->dev) < 0) {
 =09=09output("Could not register Trident framebuffer\n");
 =09=09return -EINVAL;
 =09}
=3D=3D=3D=3D=3D drivers/video/vesafb.c 1.46 vs edited =3D=3D=3D=3D=3D
--- 1.46/drivers/video/vesafb.c=092005-01-25 16:50:28 -05:00
+++ edited/drivers/video/vesafb.c=092005-02-19 14:44:40 -05:00
@@ -410,7 +410,7 @@
 =09=09err =3D -ENOMEM;
 =09=09goto err;
 =09}
-=09if (register_framebuffer(info)<0) {
+=09if (register_framebuffer(info, device) < 0) {
 =09=09err =3D -EINVAL;
 =09=09fb_dealloc_cmap(&info->cmap);
 =09=09goto err;
@@ -424,10 +424,17 @@
 =09return err;
 }
=20
+static int __devexit vesafb_remove(struct device *device)
+{
+=09printk(KERN_WARNING "vesafb: implement a remove function\n");
+=09return 0;
+}
+
 static struct device_driver vesafb_driver =3D {
 =09.name=09=3D "vesafb",
 =09.bus=09=3D &platform_bus_type,
 =09.probe=09=3D vesafb_probe,
+=09.remove =3D vesafb_remove,
 };
=20
 static struct platform_device vesafb_device =3D {
=3D=3D=3D=3D=3D drivers/video/vfb.c 1.32 vs edited =3D=3D=3D=3D=3D
--- 1.32/drivers/video/vfb.c=092005-01-08 00:44:25 -05:00
+++ edited/drivers/video/vfb.c=092005-02-19 14:59:30 -05:00
@@ -447,7 +447,7 @@
 =09if (retval < 0)
 =09=09goto err1;
=20
-=09retval =3D register_framebuffer(info);
+=09retval =3D register_framebuffer(info, device);
 =09if (retval < 0)
 =09=09goto err2;
 =09dev_set_drvdata(&dev->dev, info);
=3D=3D=3D=3D=3D drivers/video/vga16fb.c 1.47 vs edited =3D=3D=3D=3D=3D
--- 1.47/drivers/video/vga16fb.c=092005-01-04 21:48:33 -05:00
+++ edited/drivers/video/vga16fb.c=092005-02-19 14:58:56 -05:00
@@ -1400,7 +1400,7 @@
=20
 =09vga16fb_update_fix(&vga16fb);
=20
-=09if (register_framebuffer(&vga16fb) < 0) {
+=09if (register_framebuffer(&vga16fb, NULL) < 0) {
 =09=09printk(KERN_ERR "vga16fb: unable to register framebuffer\n");
 =09=09ret =3D -EINVAL;
 =09=09goto err_check_var;
=3D=3D=3D=3D=3D drivers/video/w100fb.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/drivers/video/w100fb.c=092005-01-15 17:31:05 -05:00
+++ edited/drivers/video/w100fb.c=092005-02-19 14:17:38 -05:00
@@ -605,7 +605,6 @@
 =09=09return -ENOMEM;
 =09}
=20
-=09info->device=3Ddev;
 =09par =3D info->par;
 =09current_par=3Dinfo->par;
 =09dev_set_drvdata(dev, info);
@@ -658,7 +657,7 @@
 =09w100fb_check_var(&info->var, info);
 =09w100fb_set_par(info);
=20
-=09if (register_framebuffer(info) < 0) {
+=09if (register_framebuffer(info, dev) < 0) {
 =09=09kfree(info->pseudo_palette);
 =09=09iounmap(remapped_base);
 =09=09iounmap(remapped_regs);
=3D=3D=3D=3D=3D drivers/video/aty/aty128fb.c 1.56 vs edited =3D=3D=3D=3D=3D
--- 1.56/drivers/video/aty/aty128fb.c=092005-02-11 01:57:44 -05:00
+++ edited/drivers/video/aty/aty128fb.c=092005-02-19 14:19:01 -05:00
@@ -1845,7 +1845,7 @@
=20
 =09aty128_init_engine(par);
=20
-=09if (register_framebuffer(info) < 0)
+=09if (register_framebuffer(info, &pdev->dev) < 0)
 =09=09return 0;
=20
 #ifdef CONFIG_PMAC_BACKLIGHT
=3D=3D=3D=3D=3D drivers/video/aty/atyfb_base.c 1.83 vs edited =3D=3D=3D=3D=
=3D
--- 1.83/drivers/video/aty/atyfb_base.c=092005-02-15 11:22:09 -05:00
+++ edited/drivers/video/aty/atyfb_base.c=092005-02-19 14:25:02 -05:00
@@ -2551,9 +2551,6 @@
=20
 =09fb_alloc_cmap(&info->cmap, 256, 0);
=20
-=09if (register_framebuffer(info) < 0)
-=09=09goto aty_init_exit;
-
 =09fb_list =3D info;
=20
 =09PRINTKI("fb%d: %s frame buffer device on %s\n",
@@ -3383,7 +3380,6 @@
 =09}
 =09par =3D info->par;
 =09info->fix =3D atyfb_fix;
-=09info->device =3D &pdev->dev;
 =09par->pci_id =3D aty_chips[i].pci_id;
 =09par->res_start =3D res_start;
 =09par->res_size =3D res_size;
@@ -3399,6 +3395,9 @@
 =09=09goto err_release_mem;
=20
 =09pci_set_drvdata(pdev, info);
+=09
+=09if (register_framebuffer(info, &pdev->dev) < 0)
+=09=09goto err_release_io;
=20
 =09/* Init chip & register framebuffer */
 =09if (aty_init(info, "PCI"))
=3D=3D=3D=3D=3D drivers/video/aty/radeon_base.c 1.40 vs edited =3D=3D=3D=3D=
=3D
--- 1.40/drivers/video/aty/radeon_base.c=092005-02-15 21:25:30 -05:00
+++ edited/drivers/video/aty/radeon_base.c=092005-02-19 14:20:02 -05:00
@@ -2362,7 +2362,7 @@
 =09pci_set_drvdata(pdev, info);
=20
 =09/* Register with fbdev layer */
-=09ret =3D register_framebuffer(info);
+=09ret =3D register_framebuffer(info, &pdev->dev);
 =09if (ret < 0) {
 =09=09printk (KERN_ERR "radeonfb (%s): could not register framebuffer\n",
 =09=09=09pci_name(rinfo->pdev));
=3D=3D=3D=3D=3D drivers/video/i810/i810_main.c 1.29 vs edited =3D=3D=3D=3D=
=3D
--- 1.29/drivers/video/i810/i810_main.c=092005-01-15 17:31:04 -05:00
+++ edited/drivers/video/i810/i810_main.c=092005-02-19 15:00:37 -05:00
@@ -1902,7 +1902,7 @@
 =09encode_fix(&info->fix, info);=20
 =09 =09   =20
 =09i810fb_init_ringbuffer(info);
-=09err =3D register_framebuffer(info);
+=09err =3D register_framebuffer(info, &dev->dev);
 =09if (err < 0) {
     =09=09i810fb_release_resource(info, par);=20
 =09=09printk("i810fb_init: cannot register framebuffer device\n");
=3D=3D=3D=3D=3D drivers/video/intelfb/intelfbdrv.c 1.9 vs edited =3D=3D=3D=
=3D=3D
--- 1.9/drivers/video/intelfb/intelfbdrv.c=092005-01-04 21:48:33 -05:00
+++ edited/drivers/video/intelfb/intelfbdrv.c=092005-02-19 15:01:34 -05:00
@@ -837,7 +837,7 @@
 =09if (noregister)
 =09=09bailout(dinfo);
=20
-=09if (register_framebuffer(dinfo->info) < 0) {
+=09if (register_framebuffer(dinfo->info, &pdev->dev) < 0) {
 =09=09ERR_MSG("Cannot register framebuffer.\n");
 =09=09cleanup(dinfo);
 =09=09return -ENODEV;
=3D=3D=3D=3D=3D drivers/video/kyro/fbdev.c 1.10 vs edited =3D=3D=3D=3D=3D
--- 1.10/drivers/video/kyro/fbdev.c=092004-10-20 09:47:58 -04:00
+++ edited/drivers/video/kyro/fbdev.c=092005-02-19 14:26:04 -05:00
@@ -735,8 +735,7 @@
=20
 =09fb_memset(info->screen_base, 0, size);
=20
-=09info->device =3D &pdev->dev;
-=09if (register_framebuffer(info) < 0)
+=09if (register_framebuffer(info, &pdev->dev) < 0)
 =09=09goto out_unmap;
=20
 =09printk("fb%d: %s frame buffer device, at %dx%d@%d using %ldk/%ldk of VR=
AM\n",
=3D=3D=3D=3D=3D drivers/video/matrox/matroxfb_base.c 1.57 vs edited =3D=3D=
=3D=3D=3D
--- 1.57/drivers/video/matrox/matroxfb_base.c=092005-02-02 03:12:10 -05:00
+++ edited/drivers/video/matrox/matroxfb_base.c=092005-02-19 14:27:10 -05:0=
0
@@ -1876,8 +1876,7 @@
 /* We do not have to set currcon to 0... register_framebuffer do it
for us on first console
  * and we do not want currcon =3D=3D 0 for subsequent framebuffers */
=20
-=09ACCESS_FBINFO(fbcon).device =3D &ACCESS_FBINFO(pcidev)->dev;
-=09if (register_framebuffer(&ACCESS_FBINFO(fbcon)) < 0) {
+=09if (register_framebuffer(&ACCESS_FBINFO(fbcon),
&ACCESS_FBINFO(pcidev)->dev) < 0) {
 =09=09goto failVideoIO;
 =09}
 =09printk("fb%d: %s frame buffer device\n",
=3D=3D=3D=3D=3D drivers/video/matrox/matroxfb_crtc2.c 1.34 vs edited =3D=3D=
=3D=3D=3D
--- 1.34/drivers/video/matrox/matroxfb_crtc2.c=092005-01-08 00:44:25 -05:00
+++ edited/drivers/video/matrox/matroxfb_crtc2.c=092005-02-19 16:22:35 -05:=
00
@@ -631,7 +631,7 @@
 =09m2info->mmio.len =3D ACCESS_FBINFO(mmio.len);
=20
 =09matroxfb_dh_init_fix(m2info);
-=09if (register_framebuffer(&m2info->fbcon)) {
+=09if (register_framebuffer(&m2info->fbcon, m2info->fbcon.device)) {
 =09=09return -ENXIO;
 =09}
 =09if (!m2info->initialized)
=3D=3D=3D=3D=3D drivers/video/riva/fbdev.c 1.84 vs edited =3D=3D=3D=3D=3D
--- 1.84/drivers/video/riva/fbdev.c=092005-01-08 00:44:07 -05:00
+++ edited/drivers/video/riva/fbdev.c=092005-02-19 14:28:53 -05:00
@@ -2053,7 +2053,7 @@
=20
 =09fb_destroy_modedb(info->monspecs.modedb);
 =09info->monspecs.modedb =3D NULL;
-=09ret =3D register_framebuffer(info);
+=09ret =3D register_framebuffer(info, &pd->dev);
 =09if (ret < 0) {
 =09=09printk(KERN_ERR PFX
 =09=09=09"error registering riva framebuffer\n");
=3D=3D=3D=3D=3D drivers/video/savage/savagefb.c 1.5 vs edited =3D=3D=3D=3D=
=3D
--- 1.5/drivers/video/savage/savagefb.c=092004-11-21 17:44:00 -05:00
+++ edited/drivers/video/savage/savagefb.c=092005-02-19 14:29:43 -05:00
@@ -2033,7 +2033,7 @@
 =09fb_destroy_modedb(info->monspecs.modedb);
 =09info->monspecs.modedb =3D NULL;
=20
-=09err =3D register_framebuffer (info);
+=09err =3D register_framebuffer (info, &dev->dev);
 =09if (err < 0)
 =09=09goto failed;
=20
=3D=3D=3D=3D=3D drivers/video/sis/sis_main.c 1.34 vs edited =3D=3D=3D=3D=3D
--- 1.34/drivers/video/sis/sis_main.c=092005-02-16 20:32:38 -05:00
+++ edited/drivers/video/sis/sis_main.c=092005-02-19 14:31:06 -05:00
@@ -5587,7 +5587,7 @@
 =09=09vc_resize_con(1, 1, 0);
 #endif
=20
-=09=09if(register_framebuffer(sis_fb_info) < 0) {
+=09=09if(register_framebuffer(sis_fb_info, &pdev->dev) < 0) {
 =09=09=09printk(KERN_ERR "sisfb: Fatal error: Failed to register framebuff=
er\n");
 =09=09=09iounmap(ivideo->video_vbase);
 =09=09=09iounmap(ivideo->mmio_vbase);
=3D=3D=3D=3D=3D include/linux/fb.h 1.95 vs edited =3D=3D=3D=3D=3D
--- 1.95/include/linux/fb.h=092005-02-15 12:38:28 -05:00
+++ edited/include/linux/fb.h=092005-02-19 14:12:00 -05:00
@@ -803,7 +803,7 @@
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *ima=
ge);
=20
 /* drivers/video/fbmem.c */
-extern int register_framebuffer(struct fb_info *fb_info);
+extern int register_framebuffer(struct fb_info *fb_info, struct
device *device);
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

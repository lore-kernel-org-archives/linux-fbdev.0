From: akpm@osdl.org
Subject: framebuffer-driver-for-arc-lcd-board-tidy.patch added to -mm tree
Date: Sun, 05 Jun 2005 22:29:13 -0700
Message-ID: <200506060529.j565TGcr008590@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfAB7-0002QV-CO
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Jun 2005 22:29:37 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DfAB6-0007r7-2K
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Jun 2005 22:29:37 -0700
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
To: akpm@osdl.org, adaplas@pol.net, jayalk@intworks.biz, linux-fbdev-devel@lists.sourceforge.net, mm-commits@vger.kernel.org


The patch titled

     framebuffer-driver-for-arc-lcd-board tidy

has been added to the -mm tree.  Its filename is

     framebuffer-driver-for-arc-lcd-board-tidy.patch

Patches currently in -mm which might be from akpm@osdl.org are

i2c-chips-need-hwmon.patch
git-ia64-pre.patch
git-ia64-post.patch
tcp-tcp_westwood-kconfig-fix.patch
bk-nfs.patch
git-scsi-misc-mptfusion-fix.patch
git-scsi-misc-qla-build-fix.patch
gregkh-usb-speedtch-prep.patch
hub-use-kthread.patch
bk-watchdog.patch
is_multicast_ether_addr-hack.patch
wireless-device-attr-fixes.patch
wireless-device-attr-fixes-2.patch
ipw2100-old-gcc-fix.patch
add-x86-64-specific-support-for-sparsemem-tidy.patch
add-page_state-info-to-show_mem-warning-fixes.patch
hugepage-consolidation-ia64-fix.patch
node-local-per-cpu-pages-tidy.patch
node-local-per-cpu-pages-tidy-2.patch
node-local-per-cpu-pages-tidy-2-fix.patch
avoiding-mmap-fragmentation-tidy.patch
mm-remove-pg_highmem-tidy.patch
cs89x0c-support-for-philips-pnx0105-network-adapter-tidy.patch
dmfe-warning-fix.patch
x86-x86_64-pcibus_to_node-fix.patch
numa-aware-block-device-control-structure-allocation-tidy.patch
i386-selectable-frequency-of-the-timer-interrupt-fix.patch
optimise-storage-of-read-mostly-variables-x86_64-fix-fix-fix.patch
mempool-bounce-buffer-restriction.patch
i386-cpu-hotplug-updated-for-mm-smp_processor_id-cleanup-fix.patch
sibling-map-initializing-rework-smp_processor_id-cleanup-fix.patch
cpu-state-clean-after-hot-remove-smp_processor_id-cleanup-fix.patch
detect-soft-lockups-smp_processor_id-cleanup-fix.patch
blk-reduce-locking.patch
blk-reduce-locking-fixes.patch
timers-fixes-improvements-smp_processor_id-cleanup-fix.patch
page_uptodate_lock-hashing.patch
kprobes-function-return-probes-fix-4.patch
fix-of-dcache-race-leading-to-busy-inodes-on-umount-fix.patch
fix-of-dcache-race-leading-to-busy-inodes-on-umount-tidy.patch
fix-tpm-driver-sysfs-owernship-changes-fix-3.patch
dlm-lockspaces-callbacks-directory-build-fix.patch
dlm-lockspaces-callbacks-directory-fix-2.patch
dlm-device-interface-fix.patch
connector-warning-fixes.patch
connector-netlink-id-fix.patch
connector-add-a-fork-connector-build-fix.patch
i2o-new-sysfs-attributes-and-adaptec-specific-block-fix-fix.patch
i2o-build-fix.patch
nr_blockdev_pages-in_interrupt-warning.patch
dynamic-sched-domains-sched-changes-fix.patch
bttv-support-for-adlink-rtv24-capture-card-tidy.patch
bttv-support-for-adlink-rtv24-capture-card-more-tidy.patch
kexec-x86_64-optimise-storage-of-read-mostly-variables-x86_64-fix.patch
kdump-accessing-dump-file-in-linear-raw-format.patch
kdump-use-real-pt_regs-from-exception-fix.patch
reiser4-mm-remove-pg_highmem-fix.patch
s1d13xxxfb-linkage-fix.patch
intelfbdrv-naming-fix.patch
intelfb-add-voffset-option-to-avoid-conficts-with-xorg-i810-driver-fix.patch
intelfb-documentation-fix.patch
framebuffer-driver-for-arc-lcd-board-tidy.patch
xip-fs-mm-execute-in-place-3rd-version-fix.patch
xip-ext2-execute-in-place-3rd-version-fixes.patch



From: Andrew Morton <akpm@osdl.org>

- Coding style fixes

- Remove unneeded typecasts

- namespace fixes

- arcfb_setup() is only needed for static builds

  (this all seems wrong - why does fb_get_options() exist now that module
  parameters can be passed to static drivers from the kernel command line?)


Cc: Jaya Kumar <jayalk@intworks.biz>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/arcfb.c |   77 ++++++++++++++++++++++++--------------------------
 1 files changed, 38 insertions(+), 39 deletions(-)

diff -puN drivers/video/arcfb.c~framebuffer-driver-for-arc-lcd-board-tidy drivers/video/arcfb.c
--- 25/drivers/video/arcfb.c~framebuffer-driver-for-arc-lcd-board-tidy	2005-06-05 22:23:08.000000000 -0700
+++ 25-akpm/drivers/video/arcfb.c	2005-06-05 22:27:07.000000000 -0700
@@ -44,10 +44,11 @@
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <asm/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 
+#include <asm/uaccess.h>
+
 #define ceil64(a) (a|0x3F)
 #define floor8(a) (a&(~0x07))
 #define floorXres(a,info) (a&(~(xres - 1)))
@@ -81,17 +82,14 @@ static struct fb_var_screeninfo arcfb_va
 	.nonstd		= 1,
 };
 
-unsigned long arcfb_num_cols;
-unsigned long arcfb_num_rows;
-unsigned long data_io_addr;
-unsigned long ctl_io_addr;
-unsigned long splashvalue;
-unsigned long tuhold;
-unsigned int nosplash;
-unsigned int arcfb_enable;
-
-int arcfb_init(void);
-int arcfb_setup(char*);
+static unsigned long arcfb_num_cols;
+static unsigned long arcfb_num_rows;
+static unsigned long data_io_addr;
+static unsigned long ctl_io_addr;
+static unsigned long splashvalue;
+static unsigned long tuhold;
+static unsigned int nosplash;
+static unsigned int arcfb_enable;
 
 /* ks108 chipset specific defines and code */
 
@@ -149,10 +147,10 @@ static void ks108_clear_lcd(struct arcfb
 {
 	int i,j;
 
-	for (i=0; i <= 8; i++) {
+	for (i = 0; i <= 8; i++) {
 		ks108_set_yaddr(par, chipindex, i);
 		ks108_set_xaddr(par, chipindex, 0);
-		for (j=0; j < 64; j++) {
+		for (j = 0; j < 64; j++) {
 			ks108_writeb_data(par, chipindex,
 				(unsigned char) splashvalue);
 		}
@@ -163,15 +161,17 @@ static void ks108_clear_lcd(struct arcfb
 
 static int arcfb_open(struct fb_info *info, int user)
 {
-	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	struct arcfb_par *par = info->par;
+
 	atomic_inc(&par->ref_count);
 	return 0;
 }
 
 static int arcfb_release(struct fb_info *info, int user)
 {
-	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	struct arcfb_par *par = info->par;
 	int count = atomic_read(&par->ref_count);
+
 	if (!count)
 		return -EINVAL;
 	atomic_dec(&par->ref_count);
@@ -182,13 +182,12 @@ static int arcfb_pan_display(struct fb_v
 				struct fb_info *info)
 {
 	int i;
-	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	struct arcfb_par *par = info->par;
 
 	if ((var->vmode & FB_VMODE_YWRAP) && (var->yoffset < 64)
 		&& (info->var.yres <= 64)) {
-		for (i=0; i < arcfb_num_cols; i++) {
+		for (i = 0; i < arcfb_num_cols; i++)
 			ks108_set_start_line(par, i, var->yoffset);
-		}
 		info->var.yoffset = var->yoffset;
 		return 0;
 	}
@@ -224,8 +223,8 @@ static void arcfb_lcd_update_page(struct
 	bitmask=1;
 	rightshift=0;
 	while (left <= right) {
-		val = 0; i=0;
-		for (i=0; i < 8; i++) {
+		val = 0;
+		for (i = 0; i < 8; i++) {
 			if ( i > rightshift) {
 				val |= (*(src + (i*linesize)) & bitmask)
 						<< (i - rightshift);
@@ -283,13 +282,13 @@ static void arcfb_lcd_update_horiz(struc
 
 	distance = h;
 	upper = floor8(top);
-	lower = min( (upper + distance - 1), ceil64(upper) );
+	lower = min(upper + distance - 1, ceil64(upper));
 
 	while (distance > 0) {
-		distance -= ( (lower - upper) + 1 );
+		distance -= ((lower - upper) + 1);
 		arcfb_lcd_update_vert(par, upper, lower, left, right);
 		upper = lower + 1;
-		lower = min( (upper + distance - 1), ceil64(upper) );
+		lower = min(upper + distance - 1, ceil64(upper));
 	}
 }
 
@@ -304,19 +303,19 @@ static void arcfb_lcd_update(struct arcf
 	unsigned int left, right, distance;
 	distance = w;
 	left = dx;
-	right = min( (left + w - 1), ceil64(left) );
+	right = min(left + w - 1, ceil64(left));
 
 	while (distance > 0) {
-		arcfb_lcd_update_horiz(par,left,right,dy,h);
+		arcfb_lcd_update_horiz(par, left, right, dy, h);
 		distance -= ((right - left) + 1);
 		left = right + 1;
-		right = min((left + distance - 1), ceil64(left));
+		right = min(left + distance - 1, ceil64(left));
 	}
 }
 
 void arcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	struct arcfb_par *par = info->par;
 	int y, h;
 
 	cfb_fillrect(info, rect);
@@ -332,7 +331,7 @@ void arcfb_fillrect(struct fb_info *info
 void arcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	unsigned int y, h;
-	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	struct arcfb_par *par = info->par;
 
 	cfb_copyarea(info, area);
 
@@ -347,7 +346,7 @@ void arcfb_copyarea(struct fb_info *info
 void arcfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	unsigned int y, h;
-	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	struct arcfb_par *par = info->par;
 
 	cfb_imageblit(info, image);
 
@@ -383,14 +382,13 @@ static ssize_t arcfb_write(struct file *
 	inode = file->f_dentry->d_inode;
 	fbidx = iminor(inode);
 	info = registered_fb[fbidx];
-	par = (struct arcfb_par *) info->par;
-
+	par = info->par;
 
 	if (!info || !info->screen_base)
 		return -ENODEV;
 
 	xres = info->var.xres;
-	fbmemlength = ( xres * info->var.yres)/8;
+	fbmemlength = (xres * info->var.yres)/8;
 
 	if (p > fbmemlength)
 		return -ENOSPC;
@@ -428,7 +426,8 @@ static ssize_t arcfb_write(struct file *
 	return err;
 }
 
-int __init arcfb_setup(char *options)
+#ifndef MODULE
+static int __init arcfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -462,6 +461,7 @@ int __init arcfb_setup(char *options)
 	}
 	return 0;
 }
+#endif
 
 static void arcfb_platform_release(struct device *device)
 {
@@ -507,7 +507,7 @@ static int __init arcfb_probe(struct dev
 
 	info->var = arcfb_var;
 	info->fix = arcfb_fix;
-	par = (struct arcfb_par *) info->par;
+	par = info->par;
 	par->info = info;
 	par->data_io_addr = data_io_addr;
 	par->ctl_io_addr = ctl_io_addr;
@@ -525,7 +525,7 @@ static int __init arcfb_probe(struct dev
 	       info->node, videomemorysize >> 10);
 
 	/* this inits the lcd but doesn't clear dirty pixels */
-	for (i=0; i < (arcfb_num_cols*arcfb_num_rows); i++) {
+	for (i = 0; i < arcfb_num_cols * arcfb_num_rows; i++) {
 		ks108_writeb_ctl(par, i, KS_DPY_OFF);
 		ks108_set_start_line(par, i, 0);
 		ks108_set_yaddr(par, i, 0);
@@ -535,7 +535,7 @@ static int __init arcfb_probe(struct dev
 
 	/* if we were told to splash the screen, we just clear it */
 	if (!nosplash) {
-		for (i=0; i < (arcfb_num_cols*arcfb_num_rows); i++) {
+		for (i = 0; i < arcfb_num_cols * arcfb_num_rows; i++) {
 			printk(KERN_INFO "fb%d: splashing lcd %d\n",
 				info->node, i);
 			ks108_set_start_line(par, i, 0);
@@ -578,7 +578,7 @@ static struct platform_device arcfb_devi
 	}
 };
 
-int __init arcfb_init(void)
+static int __init arcfb_init(void)
 {
 	int ret;
 
@@ -625,4 +625,3 @@ module_exit(arcfb_exit);
 MODULE_DESCRIPTION("fbdev driver for Arc monochrome LCD board");
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
-
_


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

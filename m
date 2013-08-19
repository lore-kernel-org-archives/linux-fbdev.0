From: Jonathan Campbell <jonathan@castus.tv>
Date: Mon, 19 Aug 2013 04:22:05 +0000
Subject: efifb: patch to allow userspace to unbind efi framebuffer driver from VGA device
Message-Id: <52119D6D.5070209@castus.tv>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060405010701080709090309"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------060405010701080709090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch allows userspace to direct efifb to let go of the VGA device 
and unregister it's framebuffer. As far as I can tell, the Linux kernel 
framebuffer console knows to let go when efifb unregisters it's 
framebuffer. The problem I'm trying to solve is that I need efifb so the 
kernel can show it's status on-screen during boot, but then I need efifb 
to step aside and let a better driver load and take the VGA device later 
during boot up.

The custom Linux distribution I've made for myself uses a userspace 
program to "boot" secondary VGA devices and load both fbdev and drm/kms 
drivers to bring video online. When I wrote this, I needed the ability 
for efifb to let go so that it could load bochsfb to better use the VGA 
output of VirtualBox and bochs. Without it, my console is stuck at 
whatever video mode the UEFI BIOS happened to leave it at and the more 
specialized driver cannot acquire the resources it needs to do it's work.

The patch adds a sysfs device file "bind_fb" to the 
/sys/bus/platform/devices/efifb.0 filesystem tree. Writing "1" causes it 
to re-register the framebuffer, "0" to unregister. Checks are in place 
to not register the framebuffer if already registered, etc.

I realize it's not perfect and I wanted to know what I could do to 
improve it and eventually make it to mainline.

On a related issue, when will efifb make use of the Graphics Output 
Protocol through UEFI to offer modesetting? Is that possible? If no 
specialized drivers are available it'd be nice to at least have basic 
modesetting as needed.


--------------060405010701080709090309
Content-Type: text/plain; charset=UTF-8;
 name="efifb-bind-ctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="efifb-bind-ctl.patch"

--- a/drivers/video/efifb.c	2013-08-15 05:59:42.000000000 +0000
+++ b/drivers/video/efifb.c	2013-08-17 23:56:56.929260269 +0000
@@ -18,7 +18,8 @@
 
 static bool request_mem_succeeded = false;
 
-static struct pci_dev *default_vga;
+static struct pci_dev *default_vga = NULL;
+static struct fb_info *efifb_info = NULL;
 
 static struct fb_var_screeninfo efifb_defined = {
 	.activate		= FB_ACTIVATE_NOW,
@@ -86,7 +87,7 @@
 	int width;
 	int height;
 	int flags;
-} dmi_list[] __initdata = {
+} dmi_list[] = {
 	[M_I17] = { "i17", 0x80010000, 1472 * 4, 1440, 900, OVERRIDE_NONE },
 	[M_I20] = { "i20", 0x80010000, 1728 * 4, 1680, 1050, OVERRIDE_NONE }, /* guess */
 	[M_I20_SR] = { "imac7", 0x40010000, 1728 * 4, 1680, 1050, OVERRIDE_NONE },
@@ -127,7 +128,7 @@
 		DMI_MATCH(DMI_PRODUCT_NAME, name) },		\
 	  &dmi_list[enumid] }
 
-static const struct dmi_system_id dmi_system_table[] __initconst = {
+static const struct dmi_system_id dmi_system_table[] = {
 	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac4,1", M_I17),
 	/* At least one of these two will be right; maybe both? */
 	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac5,1", M_I20),
@@ -288,6 +289,7 @@
 	if (request_mem_succeeded)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
+	fb_dealloc_cmap(&info->cmap);
 	framebuffer_release(info);
 }
 
@@ -312,7 +314,7 @@
 	default_vga = pdev;
 }
 
-static int __init efifb_setup(char *options)
+static int efifb_setup(char *options)
 {
 	char *this_opt;
 	int i;
@@ -369,9 +371,8 @@
 	return 0;
 }
 
-static int __init efifb_probe(struct platform_device *dev)
+static int efifb_probe(struct platform_device *dev)
 {
-	struct fb_info *info;
 	int err;
 	unsigned int size_vmode;
 	unsigned int size_remap;
@@ -438,25 +439,25 @@
 			efifb_fix.smem_start);
 	}
 
-	info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
-	if (!info) {
+	efifb_info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
+	if (!efifb_info) {
 		printk(KERN_ERR "efifb: cannot allocate framebuffer\n");
 		err = -ENOMEM;
 		goto err_release_mem;
 	}
-	info->pseudo_palette = info->par;
-	info->par = NULL;
+	efifb_info->pseudo_palette = efifb_info->par;
+	efifb_info->par = NULL;
 
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures) {
+	efifb_info->apertures = alloc_apertures(1);
+	if (!efifb_info->apertures) {
 		err = -ENOMEM;
 		goto err_release_fb;
 	}
-	info->apertures->ranges[0].base = efifb_fix.smem_start;
-	info->apertures->ranges[0].size = size_remap;
+	efifb_info->apertures->ranges[0].base = efifb_fix.smem_start;
+	efifb_info->apertures->ranges[0].size = size_remap;
 
-	info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
-	if (!info->screen_base) {
+	efifb_info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
+	if (!efifb_info->screen_base) {
 		printk(KERN_ERR "efifb: abort, cannot ioremap video memory "
 				"0x%x @ 0x%lx\n",
 			efifb_fix.smem_len, efifb_fix.smem_start);
@@ -466,7 +467,7 @@
 
 	printk(KERN_INFO "efifb: framebuffer at 0x%lx, mapped to 0x%p, "
 	       "using %dk, total %dk\n",
-	       efifb_fix.smem_start, info->screen_base,
+	       efifb_fix.smem_start, efifb_info->screen_base,
 	       size_remap/1024, size_total/1024);
 	printk(KERN_INFO "efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       efifb_defined.xres, efifb_defined.yres,
@@ -509,29 +510,29 @@
 	efifb_fix.ypanstep  = 0;
 	efifb_fix.ywrapstep = 0;
 
-	info->fbops = &efifb_ops;
-	info->var = efifb_defined;
-	info->fix = efifb_fix;
-	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;
+	efifb_info->fbops = &efifb_ops;
+	efifb_info->var = efifb_defined;
+	efifb_info->fix = efifb_fix;
+	efifb_info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;
 
-	if ((err = fb_alloc_cmap(&info->cmap, 256, 0)) < 0) {
+	if ((err = fb_alloc_cmap(&efifb_info->cmap, 256, 0)) < 0) {
 		printk(KERN_ERR "efifb: cannot allocate colormap\n");
 		goto err_unmap;
 	}
-	if ((err = register_framebuffer(info)) < 0) {
+	if ((err = register_framebuffer(efifb_info)) < 0) {
 		printk(KERN_ERR "efifb: cannot register framebuffer\n");
 		goto err_fb_dealoc;
 	}
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-		info->node, info->fix.id);
+		efifb_info->node, efifb_info->fix.id);
 	return 0;
 
 err_fb_dealoc:
-	fb_dealloc_cmap(&info->cmap);
+	fb_dealloc_cmap(&efifb_info->cmap);
 err_unmap:
-	iounmap(info->screen_base);
+	iounmap(efifb_info->screen_base);
 err_release_fb:
-	framebuffer_release(info);
+	framebuffer_release(efifb_info);
 err_release_mem:
 	if (request_mem_succeeded)
 		release_mem_region(efifb_fix.smem_start, size_total);
@@ -548,6 +549,38 @@
 	.name	= "efifb",
 };
 
+/* use a sysfs file "trace_running" to start/stop tracing */
+static ssize_t efifb_bind_fb_attr_show(struct device *dev,struct device_attribute *attr,char *buf)
+{
+	return sprintf(buf, "%u\n", efifb_info != NULL ? 1 : 0);
+}
+
+static ssize_t efifb_bind_fb_attr_store(struct device *dev,struct device_attribute *attr,const char *buf,size_t n)
+{
+	unsigned int value;
+	int ret = 0;
+
+	if (sscanf(buf, "%u", &value) != 1)
+		return -EINVAL;
+	if (value > 1)
+		return -EINVAL;
+
+	if ((efifb_info != NULL ? 1 : 0) != value) {
+		if (value)
+			ret = efifb_probe(&efifb_device);
+		else {
+			ret = unregister_framebuffer(efifb_info);
+			if (ret >= 0) efifb_info = NULL;
+		}
+	}
+
+	return (ret < 0 ? ret : n);
+}
+
+static const struct device_attribute efifb_bind_fb_attr =
+	__ATTR(bind_fb, 0644, efifb_bind_fb_attr_show, efifb_bind_fb_attr_store);
+
+
 static int __init efifb_init(void)
 {
 	int ret;
@@ -575,6 +608,11 @@
 	if (ret)
 		return ret;
 
+	/* create "bind_fb" sysfs file */
+	if (device_create_file(&efifb_device.dev,&efifb_bind_fb_attr))
+		printk(KERN_WARNING
+		       "efifb: cannot create bind_fb attribute\n");
+
 	/*
 	 * This is not just an optimization.  We will interfere
 	 * with a real driver if we get reprobed, so don't allow

--------------060405010701080709090309--

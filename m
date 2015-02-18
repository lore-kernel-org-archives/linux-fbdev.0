From: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Date: Wed, 18 Feb 2015 08:29:45 +0000
Subject: [PATCH 1/3] Printk() is replaced with pr_* respective functions in efifb.c
Message-Id: <20150218082942.GB9820@linuxteamdev.amer.dell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pjones@redhat.com, plagnioj@jcrosoft.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is a trivial patch:

I have replaced printk() with respective pr_* functions.

Signed-off-by: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
---
 drivers/video/fbdev/efifb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 4bfff34..facfbb3 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -142,10 +142,10 @@ static int efifb_probe(struct platform_device *dev)
        if (!screen_info.pages)
                screen_info.pages = 1;
        if (!screen_info.lfb_base) {
-               printk(KERN_DEBUG "efifb: invalid framebuffer address\n");
+               pr_err("efifb: invalid framebuffer address\n");
                return -ENODEV;
        }
-       printk(KERN_INFO "efifb: probing for efifb\n");
+       pr_info("efifb: probing for efifb\n");

        /* just assume they're all unset if any are */
        if (!screen_info.blue_size) {
@@ -193,14 +193,14 @@ static int efifb_probe(struct platform_device *dev)
        } else {
                /* We cannot make this fatal. Sometimes this comes from magic
                   spaces our resource handlers simply don't know about */
-               printk(KERN_WARNING
+               pr_warn(
                       "efifb: cannot reserve video memory at 0x%lx\n",
                        efifb_fix.smem_start);
        }

        info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
        if (!info) {
-               printk(KERN_ERR "efifb: cannot allocate framebuffer\n");
+               pr_err("efifb: cannot allocate framebuffer\n");
                err = -ENOMEM;
                goto err_release_mem;
        }
@@ -218,18 +218,18 @@ static int efifb_probe(struct platform_device *dev)

        info->screen_base = ioremap_wc(efifb_fix.smem_start,
efifb_fix.smem_len);
        if (!info->screen_base) {
-               printk(KERN_ERR "efifb: abort, cannot ioremap video memory "
+               pr_err("efifb: abort, cannot ioremap video memory "
                                "0x%x @ 0x%lx\n",
                        efifb_fix.smem_len, efifb_fix.smem_start);
                err = -EIO;
                goto err_release_fb;
        }

-       printk(KERN_INFO "efifb: framebuffer at 0x%lx, mapped to 0x%p, "
+       pr_info("efifb: framebuffer at 0x%lx, mapped to 0x%p, "
               "using %dk, total %dk\n",
               efifb_fix.smem_start, info->screen_base,
               size_remap/1024, size_total/1024);
-       printk(KERN_INFO "efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
+       pr_info("efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
               efifb_defined.xres, efifb_defined.yres,
               efifb_defined.bits_per_pixel, efifb_fix.line_length,
               screen_info.pages);
@@ -237,7 +237,7 @@ static int efifb_probe(struct platform_device *dev)
        efifb_defined.xres_virtual = efifb_defined.xres;
        efifb_defined.yres_virtual = efifb_fix.smem_len /
                                        efifb_fix.line_length;
-       printk(KERN_INFO "efifb: scrolling: redraw\n");
+       pr_info("efifb: scrolling: redraw\n");
        efifb_defined.yres_virtual = efifb_defined.yres;

        /* some dummy values for timing to make fbset happy */
@@ -255,7 +255,7 @@ static int efifb_probe(struct platform_device *dev)
        efifb_defined.transp.offset = screen_info.rsvd_pos;
        efifb_defined.transp.length = screen_info.rsvd_size;

-       printk(KERN_INFO "efifb: %s: "
+       pr_info("efifb: %s: "
               "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
               "Truecolor",
               screen_info.rsvd_size,
@@ -276,11 +276,11 @@ static int efifb_probe(struct platform_device *dev)
        info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;

        if ((err = fb_alloc_cmap(&info->cmap, 256, 0)) < 0) {
-               printk(KERN_ERR "efifb: cannot allocate colormap\n");
+               pr_err("efifb: cannot allocate colormap\n");
                goto err_unmap;
        }
        if ((err = register_framebuffer(info)) < 0) {
-               printk(KERN_ERR "efifb: cannot register framebuffer\n");
+               pr_err("efifb: cannot register framebuffer\n");
                goto err_fb_dealoc;
        }
        fb_info(info, "%s frame buffer device\n", info->fix.id);
--
1.9.3

-Parmeshwr

From: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Date: Fri, 13 Feb 2015 11:21:33 +0000
Subject: [PATCH 1/2]Trivial patch: to solve indentation warnings in amba-clcd.c driver
Message-Id: <20150213112125.GA25078@linuxteamdev.amer.dell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@arm.linux.org.uk
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, trivial@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi All,


This patch soves the indentation warning in amba-clcd.c file.
Please review the same.

From a5f58880b2a6fd7cc532c4fb2bf6543cf1945195 Mon Sep 17 00:00:00 2001
From: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Date: Thu, 12 Feb 2015 07:30:04 -0500
Subject: [PATCH 1/2] Trivial patch: Removed indentation warnings

Signed-off-by: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
---
 drivers/video/fbdev/amba-clcd.c | 234 ++++++++++++++++++++--------------------
 1 file changed, 118 insertions(+), 116 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 32c0b6b..0ddc1f0 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -135,8 +135,7 @@ clcdfb_set_bitfields(struct clcd_fb *fb, struct
fb_var_screeninfo *var)
                caps = fb->panel->caps & fb->board->caps;
        else {
                /* Old way of specifying what can be used */
-               caps = fb->panel->cntl & CNTL_BGR ?
-                       CLCD_CAP_BGR : CLCD_CAP_RGB;
+               caps = fb->panel->cntl & CNTL_BGR ? CLCD_CAP_BGR : CLCD_CAP_RGB;
                /* But mask out 444 modes as they weren't supported */
                caps &= ~CLCD_CAP_444;
        }
@@ -163,12 +162,12 @@ clcdfb_set_bitfields(struct clcd_fb *fb, struct
fb_var_screeninfo *var)
                        break;
                }

-               var->red.length         = var->bits_per_pixel;
-               var->red.offset         = 0;
-               var->green.length       = var->bits_per_pixel;
-               var->green.offset       = 0;
-               var->blue.length        = var->bits_per_pixel;
-               var->blue.offset        = 0;
+               var->red.length = var->bits_per_pixel;
+               var->red.offset = 0;
+               var->green.length = var->bits_per_pixel;
+               var->green.offset = 0;
+               var->blue.length = var->bits_per_pixel;
+               var->blue.offset = 0;
                break;

        case 16:
@@ -256,7 +255,8 @@ clcdfb_set_bitfields(struct clcd_fb *fb, struct
fb_var_screeninfo *var)
                } else {
                        var->red.offset = 0;
                        var->green.offset = var->red.offset + var->red.length;
-                       var->blue.offset = var->green.offset +
var->green.length;
+                       var->blue.offset +                           var->green.offset + var->green.length;
                }
        }

@@ -288,7 +288,7 @@ static int clcdfb_set_par(struct fb_info *info)
        struct clcd_regs regs;

        fb->fb.fix.line_length = fb->fb.var.xres_virtual *
-                                fb->fb.var.bits_per_pixel / 8;
+           fb->fb.var.bits_per_pixel / 8;

        if (fb->fb.var.bits_per_pixel <= 8)
                fb->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
@@ -317,10 +317,10 @@ static int clcdfb_set_par(struct fb_info *info)
               "CLCD: Registers set to\n"
               "  %08x %08x %08x %08x\n"
               "  %08x %08x %08x %08x\n",
-               readl(fb->regs + CLCD_TIM0), readl(fb->regs + CLCD_TIM1),
-               readl(fb->regs + CLCD_TIM2), readl(fb->regs + CLCD_TIM3),
-               readl(fb->regs + CLCD_UBAS), readl(fb->regs + CLCD_LBAS),
-               readl(fb->regs + fb->off_ienb), readl(fb->regs + fb->off_cntl));
+              readl(fb->regs + CLCD_TIM0), readl(fb->regs + CLCD_TIM1),
+              readl(fb->regs + CLCD_TIM2), readl(fb->regs + CLCD_TIM3),
+              readl(fb->regs + CLCD_UBAS), readl(fb->regs + CLCD_LBAS),
+              readl(fb->regs + fb->off_ienb), readl(fb->regs + fb->off_cntl));
 #endif

        return 0;
@@ -345,17 +345,17 @@ clcdfb_setcolreg(unsigned int regno, unsigned int red,
unsigned int green,

        if (regno < 16)
                fb->cmap[regno] = convert_bitfield(transp, &fb->fb.var.transp) |
-                                 convert_bitfield(blue, &fb->fb.var.blue) |
-                                 convert_bitfield(green, &fb->fb.var.green) |
-                                 convert_bitfield(red, &fb->fb.var.red);
+                   convert_bitfield(blue, &fb->fb.var.blue) |
+                   convert_bitfield(green, &fb->fb.var.green) |
+                   convert_bitfield(red, &fb->fb.var.red);

        if (fb->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR && regno < 256) {
                int hw_reg = CLCD_PALETTE + ((regno * 2) & ~3);
                u32 val, mask, newval;

-               newval  = (red >> 11)  & 0x001f;
+               newval = (red >> 11) & 0x001f;
                newval |= (green >> 6) & 0x03e0;
-               newval |= (blue >> 1)  & 0x7c00;
+               newval |= (blue >> 1) & 0x7c00;

                /*
                 * 3.2.11: if we're configured for big endian
@@ -400,8 +400,7 @@ static int clcdfb_blank(int blank_mode, struct fb_info
*info)
        return 0;
 }

-static int clcdfb_mmap(struct fb_info *info,
-                      struct vm_area_struct *vma)
+static int clcdfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
        struct clcd_fb *fb = to_clcd(info);
        unsigned long len, off = vma->vm_pgoff << PAGE_SHIFT;
@@ -417,15 +416,15 @@ static int clcdfb_mmap(struct fb_info *info,
 }

 static struct fb_ops clcdfb_ops = {
-       .owner          = THIS_MODULE,
-       .fb_check_var   = clcdfb_check_var,
-       .fb_set_par     = clcdfb_set_par,
-       .fb_setcolreg   = clcdfb_setcolreg,
-       .fb_blank       = clcdfb_blank,
-       .fb_fillrect    = cfb_fillrect,
-       .fb_copyarea    = cfb_copyarea,
-       .fb_imageblit   = cfb_imageblit,
-       .fb_mmap        = clcdfb_mmap,
+       .owner = THIS_MODULE,
+       .fb_check_var = clcdfb_check_var,
+       .fb_set_par = clcdfb_set_par,
+       .fb_setcolreg = clcdfb_setcolreg,
+       .fb_blank = clcdfb_blank,
+       .fb_fillrect = cfb_fillrect,
+       .fb_copyarea = cfb_copyarea,
+       .fb_imageblit = cfb_imageblit,
+       .fb_mmap = clcdfb_mmap,
 };

 static int clcdfb_register(struct clcd_fb *fb)
@@ -459,10 +458,10 @@ static int clcdfb_register(struct clcd_fb *fb)
        if (ret)
                goto free_clk;

-       fb->fb.device           = &fb->dev->dev;
+       fb->fb.device = &fb->dev->dev;

-       fb->fb.fix.mmio_start   = fb->dev->res.start;
-       fb->fb.fix.mmio_len     = resource_size(&fb->dev->res);
+       fb->fb.fix.mmio_start = fb->dev->res.start;
+       fb->fb.fix.mmio_len = resource_size(&fb->dev->res);

        fb->regs = ioremap(fb->fb.fix.mmio_start, fb->fb.fix.mmio_len);
        if (!fb->regs) {
@@ -471,45 +470,45 @@ static int clcdfb_register(struct clcd_fb *fb)
                goto clk_unprep;
        }

-       fb->fb.fbops            = &clcdfb_ops;
-       fb->fb.flags            = FBINFO_FLAG_DEFAULT;
-       fb->fb.pseudo_palette   = fb->cmap;
+       fb->fb.fbops = &clcdfb_ops;
+       fb->fb.flags = FBINFO_FLAG_DEFAULT;
+       fb->fb.pseudo_palette = fb->cmap;

        strncpy(fb->fb.fix.id, clcd_name, sizeof(fb->fb.fix.id));
-       fb->fb.fix.type         = FB_TYPE_PACKED_PIXELS;
-       fb->fb.fix.type_aux     = 0;
-       fb->fb.fix.xpanstep     = 0;
-       fb->fb.fix.ypanstep     = 0;
-       fb->fb.fix.ywrapstep    = 0;
-       fb->fb.fix.accel        = FB_ACCEL_NONE;
-
-       fb->fb.var.xres         = fb->panel->mode.xres;
-       fb->fb.var.yres         = fb->panel->mode.yres;
-       fb->fb.var.xres_virtual = fb->panel->mode.xres;
-       fb->fb.var.yres_virtual = fb->panel->mode.yres;
+       fb->fb.fix.type = FB_TYPE_PACKED_PIXELS;
+       fb->fb.fix.type_aux = 0;
+       fb->fb.fix.xpanstep = 0;
+       fb->fb.fix.ypanstep = 0;
+       fb->fb.fix.ywrapstep = 0;
+       fb->fb.fix.accel = FB_ACCEL_NONE;
+
+       fb->fb.var.xres = fb->panel->mode.xres;
+       fb->fb.var.yres = fb->panel->mode.yres;
+       fb->fb.var.xres_virtual = fb->panel->mode.xres;
+       fb->fb.var.yres_virtual = fb->panel->mode.yres;
        fb->fb.var.bits_per_pixel = fb->panel->bpp;
-       fb->fb.var.grayscale    = fb->panel->grayscale;
-       fb->fb.var.pixclock     = fb->panel->mode.pixclock;
-       fb->fb.var.left_margin  = fb->panel->mode.left_margin;
-       fb->fb.var.right_margin = fb->panel->mode.right_margin;
-       fb->fb.var.upper_margin = fb->panel->mode.upper_margin;
-       fb->fb.var.lower_margin = fb->panel->mode.lower_margin;
-       fb->fb.var.hsync_len    = fb->panel->mode.hsync_len;
-       fb->fb.var.vsync_len    = fb->panel->mode.vsync_len;
-       fb->fb.var.sync         = fb->panel->mode.sync;
-       fb->fb.var.vmode        = fb->panel->mode.vmode;
-       fb->fb.var.activate     = FB_ACTIVATE_NOW;
-       fb->fb.var.nonstd       = 0;
-       fb->fb.var.height       = fb->panel->height;
-       fb->fb.var.width        = fb->panel->width;
-       fb->fb.var.accel_flags  = 0;
-
-       fb->fb.monspecs.hfmin   = 0;
-       fb->fb.monspecs.hfmax   = 100000;
-       fb->fb.monspecs.vfmin   = 0;
-       fb->fb.monspecs.vfmax   = 400;
+       fb->fb.var.grayscale = fb->panel->grayscale;
+       fb->fb.var.pixclock = fb->panel->mode.pixclock;
+       fb->fb.var.left_margin = fb->panel->mode.left_margin;
+       fb->fb.var.right_margin = fb->panel->mode.right_margin;
+       fb->fb.var.upper_margin = fb->panel->mode.upper_margin;
+       fb->fb.var.lower_margin = fb->panel->mode.lower_margin;
+       fb->fb.var.hsync_len = fb->panel->mode.hsync_len;
+       fb->fb.var.vsync_len = fb->panel->mode.vsync_len;
+       fb->fb.var.sync = fb->panel->mode.sync;
+       fb->fb.var.vmode = fb->panel->mode.vmode;
+       fb->fb.var.activate = FB_ACTIVATE_NOW;
+       fb->fb.var.nonstd = 0;
+       fb->fb.var.height = fb->panel->height;
+       fb->fb.var.width = fb->panel->width;
+       fb->fb.var.accel_flags = 0;
+
+       fb->fb.monspecs.hfmin = 0;
+       fb->fb.monspecs.hfmax = 100000;
+       fb->fb.monspecs.vfmin = 0;
+       fb->fb.monspecs.vfmax = 400;
        fb->fb.monspecs.dclkmin = 1000000;
-       fb->fb.monspecs.dclkmax = 100000000;
+       fb->fb.monspecs.dclkmax = 100000000;

        /*
         * Make sure that the bitfields are set appropriately.
@@ -531,7 +530,7 @@ static int clcdfb_register(struct clcd_fb *fb)
        fb_set_var(&fb->fb, &fb->fb.var);

        dev_info(&fb->dev->dev, "%s hardware, %s display\n",
-                fb->board->name, fb->panel->mode.name);
+                fb->board->name, fb->panel->mode.name);

        ret = register_framebuffer(&fb->fb);
        if (ret = 0)
@@ -540,19 +539,19 @@ static int clcdfb_register(struct clcd_fb *fb)
        printk(KERN_ERR "CLCD: cannot register framebuffer (%d)\n", ret);

        fb_dealloc_cmap(&fb->fb.cmap);
- unmap:
+unmap:
        iounmap(fb->regs);
- clk_unprep:
+clk_unprep:
        clk_unprepare(fb->clk);
- free_clk:
+free_clk:
        clk_put(fb->clk);
- out:
+out:
        return ret;
 }

 #ifdef CONFIG_OF
 static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
-               struct fb_videomode *mode)
+                                       struct fb_videomode *mode)
 {
        int err;
        struct display_timing timing;
@@ -578,7 +577,7 @@ static int clcdfb_snprintf_mode(char *buf, int size, struct
fb_videomode *mode)
 }

 static int clcdfb_of_get_mode(struct device *dev, struct device_node *endpoint,
-               struct fb_videomode *mode)
+                             struct fb_videomode *mode)
 {
        int err;
        struct device_node *panel;
@@ -612,15 +611,15 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb,
u32 r0, u32 g0, u32 b0)
                u32 r0, g0, b0;
                u32 caps;
        } panels[] = {
-               { 0x110, 1,  7, 13, CLCD_CAP_5551 },
-               { 0x110, 0,  8, 16, CLCD_CAP_888 },
-               { 0x111, 4, 14, 20, CLCD_CAP_444 },
-               { 0x111, 3, 11, 19, CLCD_CAP_444 | CLCD_CAP_5551 },
-               { 0x111, 3, 10, 19, CLCD_CAP_444 | CLCD_CAP_5551 |
-                                   CLCD_CAP_565 },
-               { 0x111, 0,  8, 16, CLCD_CAP_444 | CLCD_CAP_5551 |
-                                   CLCD_CAP_565 | CLCD_CAP_888 },
-       };
+               {
+               0x110, 1, 7, 13, CLCD_CAP_5551}, {
+               0x110, 0, 8, 16, CLCD_CAP_888}, {
+               0x111, 4, 14, 20, CLCD_CAP_444}, {
+               0x111, 3, 11, 19, CLCD_CAP_444 | CLCD_CAP_5551}, {
+               0x111, 3, 10, 19, CLCD_CAP_444 | CLCD_CAP_5551 |
+                           CLCD_CAP_565}, {
+       0x111, 0, 8, 16, CLCD_CAP_444 | CLCD_CAP_5551 |
+                           CLCD_CAP_565 | CLCD_CAP_888},};
        int i;

        /* Bypass pixel clock divider, data output on the falling edge */
@@ -665,7 +664,7 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
                return err;

        err = of_property_read_u32(fb->dev->dev.of_node, "max-memory-bandwidth",
-                       &max_bandwidth);
+                                  &max_bandwidth);
        if (!err) {
                /*
                 * max_bandwidth is in bytes per second and pixclock in
@@ -675,7 +674,7 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
                 * result is a valid format.
                 */
                bpp = max_bandwidth / (1000 / 8)
-                       / PICOS2KHZ(fb->panel->mode.pixclock);
+                   / PICOS2KHZ(fb->panel->mode.pixclock);
                bpp = rounddown_pow_of_two(bpp);
                if (bpp > 32)
                        bpp = 32;
@@ -690,10 +689,10 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
        fb->panel->height = -1;

        if (of_property_read_u32_array(endpoint,
-                       "arm,pl11x,tft-r0g0b0-pads",
-                       tft_r0b0g0, ARRAY_SIZE(tft_r0b0g0)) = 0)
+                                      "arm,pl11x,tft-r0g0b0-pads",
+                                      tft_r0b0g0, ARRAY_SIZE(tft_r0b0g0)) = 0)
                return clcdfb_of_init_tft_panel(fb, tft_r0b0g0[0],
-                                tft_r0b0g0[1],  tft_r0b0g0[2]);
+                                               tft_r0b0g0[1], tft_r0b0g0[2]);

        return -ENOENT;
 }
@@ -717,7 +716,9 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
                return -ENOMEM;

        fb->fb.fix.smem_start = of_translate_address(memory,
-                       of_get_address(memory, 0, &size, NULL));
+                                                    of_get_address(memory, 0,
+                                                                   &size,
+                                                                   NULL));
        fb->fb.fix.smem_len = size;

        return 0;
@@ -727,7 +728,6 @@ static int clcdfb_of_vram_mmap(struct clcd_fb *fb, struct
vm_area_struct *vma)
 {
        unsigned long off, user_size, kernel_size;

-
        off = vma->vm_pgoff << PAGE_SHIFT;
        user_size = vma->vm_end - vma->vm_start;
        kernel_size = fb->fb.fix.smem_len;
@@ -736,9 +736,9 @@ static int clcdfb_of_vram_mmap(struct clcd_fb *fb, struct
vm_area_struct *vma)
                return -ENXIO;

        return remap_pfn_range(vma, vma->vm_start,
-                       __phys_to_pfn(fb->fb.fix.smem_start) + vma->vm_pgoff,
-                       user_size,
-                       pgprot_writecombine(vma->vm_page_prot));
+                              __phys_to_pfn(fb->fb.fix.smem_start) +
+                              vma->vm_pgoff, user_size,
+                              pgprot_writecombine(vma->vm_page_prot));
 }

 static void clcdfb_of_vram_remove(struct clcd_fb *fb)
@@ -757,9 +757,9 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
                return err;

        framesize = fb->panel->mode.xres * fb->panel->mode.yres *
-                       fb->panel->bpp / 8;
+           fb->panel->bpp / 8;
        fb->fb.screen_base = dma_alloc_coherent(&fb->dev->dev, framesize,
-                       &dma, GFP_KERNEL);
+                                               &dma, GFP_KERNEL);
        if (!fb->fb.screen_base)
                return -ENOMEM;

@@ -772,19 +772,20 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
 static int clcdfb_of_dma_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
 {
        return dma_mmap_writecombine(&fb->dev->dev, vma, fb->fb.screen_base,
-                       fb->fb.fix.smem_start, fb->fb.fix.smem_len);
+                                    fb->fb.fix.smem_start,
+                                    fb->fb.fix.smem_len);
 }

 static void clcdfb_of_dma_remove(struct clcd_fb *fb)
 {
        dma_free_coherent(&fb->dev->dev, fb->fb.fix.smem_len,
-                       fb->fb.screen_base, fb->fb.fix.smem_start);
+                         fb->fb.screen_base, fb->fb.fix.smem_start);
 }

 static struct clcd_board *clcdfb_of_get_board(struct amba_device *dev)
 {
        struct clcd_board *board = devm_kzalloc(&dev->dev, sizeof(*board),
-                       GFP_KERNEL);
+                                               GFP_KERNEL);
        struct device_node *node = dev->dev.of_node;

        if (!board)
@@ -837,7 +838,8 @@ static int clcdfb_probe(struct amba_device *dev, const
struct amba_id *id)

        fb = kzalloc(sizeof(struct clcd_fb), GFP_KERNEL);
        if (!fb) {
-               printk(KERN_INFO "CLCD: could not allocate new clcd_fb
struct\n");
+               printk(KERN_INFO
+                      "CLCD: could not allocate new clcd_fb struct\n");
                ret = -ENOMEM;
                goto free_region;
        }
@@ -846,25 +848,25 @@ static int clcdfb_probe(struct amba_device *dev, const
struct amba_id *id)
        fb->board = board;

        dev_info(&fb->dev->dev, "PL%03x rev%u at 0x%08llx\n",
-               amba_part(dev), amba_rev(dev),
-               (unsigned long long)dev->res.start);
+                amba_part(dev), amba_rev(dev),
+                (unsigned long long)dev->res.start);

        ret = fb->board->setup(fb);
        if (ret)
                goto free_fb;

-       ret = clcdfb_register(fb);
+       ret = clcdfb_register(fb);
        if (ret = 0) {
                amba_set_drvdata(dev, fb);
                goto out;
        }

        fb->board->remove(fb);
- free_fb:
+free_fb:
        kfree(fb);
- free_region:
+free_region:
        amba_release_regions(dev);
- out:
+out:
        return ret;
 }

@@ -891,21 +893,21 @@ static int clcdfb_remove(struct amba_device *dev)

 static struct amba_id clcdfb_id_table[] = {
        {
-               .id     = 0x00041110,
-               .mask   = 0x000ffffe,
-       },
-       { 0, 0 },
+        .id = 0x00041110,
+        .mask = 0x000ffffe,
+        },
+       {0, 0},
 };

 MODULE_DEVICE_TABLE(amba, clcdfb_id_table);

 static struct amba_driver clcd_driver = {
-       .drv            = {
-               .name   = "clcd-pl11x",
-       },
-       .probe          = clcdfb_probe,
-       .remove         = clcdfb_remove,
-       .id_table       = clcdfb_id_table,
+       .drv = {
+               .name = "clcd-pl11x",
+               },
+       .probe = clcdfb_probe,
+       .remove = clcdfb_remove,
+       .id_table = clcdfb_id_table,
 };

 static int __init amba_clcdfb_init(void)
--
1.9.3


-Parmeshwr

From: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Date: Fri, 13 Feb 2015 13:28:10 +0000
Subject: Re: [PATCH 2/2]Trivial patch: to solve indentation warnings in amba-clcd.c driver
Message-Id: <20150213132805.GA1296@linuxteamdev.amer.dell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150213112125.GA25078@linuxteamdev.amer.dell.com>
 <20150213113515.GW8656@n2100.arm.linux.org.uk>
 <1423828796.2795.7.camel@perches.com>
In-Reply-To: <1423828796.2795.7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "trivial@kernel.org" <trivial@kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


This is second patch in series.
In driver in_atomic we should not use to check if code is unning in IRQ.
clcdfb_sleep() function is used to give some delay between operation.
I have used schedule_timeout() function for same amount of delay.

Please review the same.
Patch 1/2 I will fix comments and re-submitt.
From 06b275e44a3951ec0a57af59aea2a4c82595e456 Mon Sep 17 00:00:00 2001
From: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Date: Fri, 13 Feb 2015 06:10:34 -0500
Subject: [PATCH 2/2] Patch to replace in_atomic with proper function from
 amba-clcd.c driver. In driver code in_atomic should not be used to check the
 IRQ or kernel context. to remove that I have used schedule_timeout() with
 respective delay. In this patch I have also removed printk() with respective
 pr_* functions

Signed-off-by: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
---
 drivers/video/fbdev/amba-clcd.c | 48 +++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 0ddc1f0..7e630f5c 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -33,8 +33,9 @@
 #include <video/display_timing.h>
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
-
-#include <asm/sizes.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/sizes.h>

 #define to_clcd(info)  container_of(info, struct clcd_fb, fb)

@@ -42,16 +43,15 @@
 static const char *clcd_name = "CLCD FB";

 /*
- * Unfortunately, the enable/disable functions may be called either from
- * process or IRQ context, and we _need_ to delay.  This is _not_ good.
+ * Hardware need certain time for power setting
  */
-static inline void clcdfb_sleep(unsigned int ms)
+static inline void clcdfb_sleep(signed long ms)
 {
-       if (in_atomic()) {
-               mdelay(ms);
-       } else {
-               msleep(ms);
-       }
+       unsigned long delay;
+
+       delay = jiffies + (HZ / 1000) * ms;
+       set_current_state(TASK_INTERRUPTIBLE);
+       schedule_timeout(delay);
 }

 static inline void clcdfb_set_start(struct clcd_fb *fb)
@@ -313,14 +313,13 @@ static int clcdfb_set_par(struct fb_info *info)
        clcdfb_enable(fb, regs.cntl);

 #ifdef DEBUG
-       printk(KERN_INFO
-              "CLCD: Registers set to\n"
-              "  %08x %08x %08x %08x\n"
-              "  %08x %08x %08x %08x\n",
-              readl(fb->regs + CLCD_TIM0), readl(fb->regs + CLCD_TIM1),
-              readl(fb->regs + CLCD_TIM2), readl(fb->regs + CLCD_TIM3),
-              readl(fb->regs + CLCD_UBAS), readl(fb->regs + CLCD_LBAS),
-              readl(fb->regs + fb->off_ienb), readl(fb->regs + fb->off_cntl));
+       pr_info("CLCD: Registers set to\n"
+               "  %08x %08x %08x %08x\n"
+               "  %08x %08x %08x %08x\n",
+               readl(fb->regs + CLCD_TIM0), readl(fb->regs + CLCD_TIM1),
+               readl(fb->regs + CLCD_TIM2), readl(fb->regs + CLCD_TIM3),
+               readl(fb->regs + CLCD_UBAS), readl(fb->regs + CLCD_LBAS),
+               readl(fb->regs + fb->off_ienb), readl(fb->regs + fb->off_cntl));
 #endif

        return 0;
@@ -392,11 +391,10 @@ static int clcdfb_blank(int blank_mode, struct fb_info
*info)
 {
        struct clcd_fb *fb = to_clcd(info);

-       if (blank_mode != 0) {
+       if (blank_mode != 0)
                clcdfb_disable(fb);
-       } else {
+       else
                clcdfb_enable(fb, fb->clcd_cntl);
-       }
        return 0;
 }

@@ -465,7 +463,7 @@ static int clcdfb_register(struct clcd_fb *fb)

        fb->regs = ioremap(fb->fb.fix.mmio_start, fb->fb.fix.mmio_len);
        if (!fb->regs) {
-               printk(KERN_ERR "CLCD: unable to remap registers\n");
+               pr_err("CLCD: unable to remap registers\n");
                ret = -ENOMEM;
                goto clk_unprep;
        }
@@ -536,7 +534,7 @@ static int clcdfb_register(struct clcd_fb *fb)
        if (ret = 0)
                goto out;

-       printk(KERN_ERR "CLCD: cannot register framebuffer (%d)\n", ret);
+       pr_info("CLCD: cannot register framebuffer (%d)\n", ret);

        fb_dealloc_cmap(&fb->fb.cmap);
 unmap:
@@ -832,14 +830,12 @@ static int clcdfb_probe(struct amba_device *dev, const
struct amba_id *id)

        ret = amba_request_regions(dev, NULL);
        if (ret) {
-               printk(KERN_ERR "CLCD: unable to reserve regs region\n");
+               pr_err("CLCD: unable to reserve regs region\n");
                goto out;
        }

        fb = kzalloc(sizeof(struct clcd_fb), GFP_KERNEL);
        if (!fb) {
-               printk(KERN_INFO
-                      "CLCD: could not allocate new clcd_fb struct\n");
                ret = -ENOMEM;
                goto free_region;
        }
--
1.9.3

-Parmeshwr
On Fri, Feb 13, 2015 at 05:59:56AM -0600, Joe Perches wrote:
> On Fri, 2015-02-13 at 11:35 +0000, Russell King - ARM Linux wrote:
> > On Fri, Feb 13, 2015 at 06:21:33AM -0500, Parmeshwr Prasad wrote:
> > > @@ -288,7 +288,7 @@ static int clcdfb_set_par(struct fb_info *info)
> > >         struct clcd_regs regs;
> > > 
> > >         fb->fb.fix.line_length = fb->fb.var.xres_virtual *
> > > -                                fb->fb.var.bits_per_pixel / 8;
> > > +           fb->fb.var.bits_per_pixel / 8;
> > 
> > NAK on this one.  The code as it stood before is much clearer since
> > we align the expression with the start of it on the preceding line.
> 
> I agree with all of what Russell wrote, but maybe this;
> 
> > > @@ -717,7 +716,9 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
> > >                 return -ENOMEM;
> > > 
> > >         fb->fb.fix.smem_start = of_translate_address(memory,
> > > -                       of_get_address(memory, 0, &size, NULL));
> > > +                                                    of_get_address(memory, 0,
> > > +                                                                   &size,
> > > +                                                                   NULL));
> > 
> > Thi sis the exception to the rule - where scrunching an expression so that
> > it takes multiple lines because of lack of right-hand space is not on.
> > The former version was a lot better.
> 
> Perhaps this could be better as:
> 
> 	fb->fb.fix.smem_start > 		 of_translate_address(memory,
> 				      of_get_address(memory, 0, &size, NULL));
> 
> But sometimes using multiple statements instead of
> embedding function calls as arguments can be simpler
> and more intelligible for the reader.
> 
> 	__be32 addr;
> 
> 	...
> 
> 	addr = of_get_address(memory, 0, &size, NULL);
> 	fb->fb.fix.smem_start = of_translate_address(memory, addr);
> 
> 
> 

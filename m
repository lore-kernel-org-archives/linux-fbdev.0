From: Martin Fuzzey <mfuzzey@gmail.com>
Date: Sat, 19 Jun 2010 15:48:08 +0000
Subject: Re: [PATCH] imxfb: add flag to avoid disabling clk multiple times
Message-Id: <4C1CE6B8.4090504@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1275561288-20661-1-git-send-email-l.fu@pengutronix.de>
In-Reply-To: <1275561288-20661-1-git-send-email-l.fu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Luotao,

Luotao Fu wrote:
> while the imxfb driver blanks the screen. The clock supply to the framebuffer
> controller is disabled. The same callback to disable the fb is, however, also
> used the remove and shutdown hooks of the imxfb platform driver. This means that
> the imxfb driver can run into a WARN in clock_disable while unloading or
> rebooting, if the screen is blanked previously, since the same clock will be
> than eventually disabled multiple times.  This patch adds a flag to make sure
> that the clock will only be disabled, if it was not already disabled before.
>
>   
Actually it's worse than that - you don't need to unload the
driver or reboot to run into this problem because imxfb_blank()
calls imxfb_disable_controller() for cases
    case FB_BLANK_POWERDOWN:
    case FB_BLANK_VSYNC_SUSPEND:
    case FB_BLANK_HSYNC_SUSPEND:
    case FB_BLANK_NORMAL:

Often an X server will call these after successive timeouts
(eg Normal, Suspend, Powerdown) so you can get into the
multiple suspend problem you describe just by waiting long
enough for at least two blank levels to be activated.

Furthermore once this happens, not only does a WARN occur
in clock_disable but the clock usage counter will actually become
negative so it will require multiple wake up requests to switch
the display back on.

I was just about to post a patch for this but I see you beat
me to it :).

Your patch fixes the clock_disable problem but fbi->backlight_power()
and fbi->lcd_power() can still be called multiple times.
Not sure if that is really a problem - they should be idempotent.

I did it by making all of imxfb_disable_controller() do nothing if the
disable was already done like this  (just for illustration not submission,
lines may be mangled):


--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -175,6 +175,7 @@ struct imxfb_info {
 
        struct imx_fb_videomode *mode;
        int                     num_modes;
+       int                     enabled;
 
        void (*lcd_power)(int);
        void (*backlight_power)(int);
@@ -451,6 +452,9 @@ static int imxfb_set_par(struct fb_info *info)
 
 static void imxfb_enable_controller(struct imxfb_info *fbi)
 {
+       if (fbi->enabled)
+               return;
+
        pr_debug("Enabling LCD controller\n");
 
        writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
@@ -470,10 +474,13 @@ static void imxfb_enable_controller(struct
imxfb_info *fbi)
                fbi->backlight_power(1);
        if (fbi->lcd_power)
                fbi->lcd_power(1);
+       fbi->enabled = 1;
 }
 
 static void imxfb_disable_controller(struct imxfb_info *fbi)
 {
+       if (!fbi->enabled)
+               return;
        pr_debug("Disabling LCD controller\n");
 
        if (fbi->backlight_power)
@@ -484,6 +491,7 @@ static void imxfb_disable_controller(struct
imxfb_info *fbi)
        clk_disable(fbi->clk);
 
        writel(0, fbi->regs + LCDC_RMCR);
+       fbi->enabled = 0;
 }
 
 static int imxfb_blank(int blank, struct fb_info *info)


Though this does miss the explicit  clk_disable() in imxfb_remove()


Cheers,

Martin



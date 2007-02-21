From: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: [PATCH 1/1] PXAFB: Support for backlight control
Date: Wed, 21 Feb 2007 18:00:37 +0200
Message-ID: <1056908425.20070221180037@gmail.com>
References: <20070221145353.GA23916@enneenne.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161317AbXBUQAh@vger.kernel.org>
In-Reply-To: <20070221145353.GA23916@enneenne.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>

Hello Rodolfo,

Wednesday, February 21, 2007, 4:53:53 PM, you wrote:

> Backlight control support for the PXA fram buffer.


  Here're some comments: backlight support is already confusing
matter, and your patch IMHO makes it even more confusing for PXAFB.

  Before even start with details, let's first think what backlight has
to do with framebuffer? The facts that the physical object implementing
the former is usually put in close proximity to the latter, and they mostly
should be powered on synchronously, probably don't yet mean that
each and every FB driver should include good chunk of code to support
doing BL in its own special way.

  On the other hand, there's already
drivers/video/backlight/backlight.c which provides generic BL support,
implemented using notifier callback for FB core. Moreover, there's
corgi_bl.c driver which, contrary to its name is a generic driver for
embedded/PDA device backlight. It essentially subclassses pretty
abstract backlight.c, and provides good implementation for most BL
implementation. What you really need to do to use it, is to supply
single machine-dependent method, set_bl_intensity(). That method is
usually <10 lines.

  With this in mind, adhoc backlight handlers in pxafb and few other
drivers are artifacts of older times. And it's sad they are tried to
be resurrected instead of being removed.


> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

> ---

> Each platform should define the backlight properties in its own setup
> file in "linux/arch/arm/mach-pxa/" as follow:

>    static int pxafb_bl_get_brightness(struct backlight_device *bl_dev)
>    {
>         return read_the_backlight_brightness();
>    }

>    static int pxafb_bl_update_status(struct backlight_device *bl_dev)
>    {
>            int perc, ret;

>            if (bl_dev->props->power != FB_BLANK_UNBLANK ||
>                bl_dev->props->fb_blank != FB_BLANK_UNBLANK)
>                    perc = 0;
>            else
>                    perc = bl_dev->props->brightness;

>         write_the_backlight_brightness(perc);

>            return 0;
>    }

>    static struct backlight_properties wwpc1100_backlight_props = {
>            .get_brightness         = pxafb_bl_get_brightness,
>            .update_status          = pxafb_bl_update_status,
>            .max_brightness         = 100,
>    };
>       
> and then seting up the fb info as follow:

>    wwpc1100_pxafb_info.modes = &special_modes;
>    wwpc1100_pxafb_info.bl_props = &wwpc1100_backlight_props;
>    set_pxa_fb_info(&wwpc1100_pxafb_info);



-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

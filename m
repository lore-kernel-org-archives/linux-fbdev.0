Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013CFC2BA4C
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 11:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbiAZLOx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbiAZLOx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 06:14:53 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE3C06161C
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 03:14:53 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id m9so22324168oia.12
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kl2oEMPJE4ww4Hxl+lYFpaOA+BaBoN/MYSi9yoz3HIs=;
        b=SSWut5VJV6G6Sq61mn82ZkfomaVm3lstbRwrvYRhJCTlvVYarIwFEEFmlv5lvHgzoS
         jvwTTREiiB/aLk6Pp//CZXQzfkSCk+rhftZF8ELHFamw7Bwri0dziU0h7CNlRTrrTKSg
         roCqRhAQVeWWApR+1Uh+7kujMVkELSdRTWNJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kl2oEMPJE4ww4Hxl+lYFpaOA+BaBoN/MYSi9yoz3HIs=;
        b=o8O+kKxysBkzNeGRBsJPS2WGC6CEuIct0XAtSURB09bYRz5CWaiK22iVKH4FEzrG7i
         FyHvka4KLDE3mUs6CrsTMROVkIKIHiRzTVAi/SKn1x6LJ6CdrMKQHkWKIHl1+/eZqR36
         IR3iZRLoYEF8Q1Juqra8IWWNX0uJIJzWpEfwbDx2zB4+DQeA0LIcEyKrFaDDZvcdnN1b
         OSeg1qzMGtcitAJeqws/C6RaO7VT6IEXySaCK44ut3p/Ftk3mUHBIVGbMKBVg94h+33F
         7gC35wQHSaQ1vFJ8tHs9ecUANxX81Jq6PPRcAK0sC/I856luYrU9NhkrJVHJ8dK+mdiV
         5f1Q==
X-Gm-Message-State: AOAM533EPAQnFCtcJP1gEAtXcLN/I2+Gyeq0oj9NSlf7XSUAjK/Xex9T
        3AmDpNCWwMd2pvX3F+g2fIE3YnRuZyc/ofpDTt3OMk0dFF8=
X-Google-Smtp-Source: ABdhPJyhXeRf+enuzSx2pBx/wF0n2BF4M6TDtdQ5w7YMW8zGqyceJuCbrHqscXdbd6TFvtZv9dWw8OSWjpTEV+FuAR8=
X-Received: by 2002:a05:6808:f03:: with SMTP id m3mr3327231oiw.330.1643195692341;
 Wed, 26 Jan 2022 03:14:52 -0800 (PST)
MIME-Version: 1.0
References: <YfBLiUMokw6tLq0O@p100> <06f83d81-5df2-916a-4ae1-5a6e12b96832@gmx.de>
 <c1ec52f6-796d-63f2-1419-c73f6554de16@gmx.de>
In-Reply-To: <c1ec52f6-796d-63f2-1419-c73f6554de16@gmx.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 26 Jan 2022 12:14:41 +0100
Message-ID: <CAKMK7uHZkS0H=89QJdiG0nCod6k6FpKihRcBFPinBCXMcEZcZw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] fbcon: Add option to enable legacy hardware acceleration
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jan 25, 2022 at 8:44 PM Helge Deller <deller@gmx.de> wrote:
>
> On 1/25/22 20:17, Helge Deller wrote:
> > On 1/25/22 20:12, Helge Deller wrote:
> >> Add a config option CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION to
> >> enable bitblt and fillrect hardware acceleration in the framebuffer
> >> console. If disabled, such acceleration will not be used, even if it is
> >> supported by the graphics hardware driver.
> >>
> >> If you plan to use DRM as your main graphics output system, you should
> >> disable this option since it will prevent compiling in code which isn't
> >> used later on when DRM takes over.
> >>
> >> For all other configurations, e.g. if none of your graphic cards support
> >> DRM (yet), DRM isn't available for your architecture, or you can't be
> >> sure that the graphic card in the target system will support DRM, you
> >> most likely want to enable this option.
> >>
> >>
> >> This patch is the first RFC.
> >
> > I forgot to mention that by using the static fb_scrollmode() function
> > I expect the compiler to optimize-out all code which seems problematic
> > from DRM's POV...
>
> This patch is not complete, for example there are more changes necessary
> in fbcon_cw.c, bcon_ccw.c and fbcon_ccw.c.
>
> Anyway, for the first round I'm interested in general feedback, if this is
> the direction which is acceptable for you.
>
> In addition I think fb_scrollmode() should be renamed to fbcon_scrollmode()
> to make it clear that it's a fbcon-related function.

I started typing my on flavour of this and wasn't happy with some of
the ifdefs, your fb_scrollmode() takes care of the annoying ones in a
tidy way. I'll include your diff here and I'll try and get my series
sent out today (there's a bunch of random little locking cleanups in
fbcon.c that I've done since the code is just a bit too entertaining
as-is).

Cheers, Daniel
>
> If you want to test this patch you will need to first apply the revert-patches
> I sent earlier.
> Alternatively for testing it's possible to pull from the "fbcon-accel" branch from:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git  fbcon-accel
>
> Helge
>
>
>
> >> Independed of this patch I did some timing experiments with a qemu
> >> virtual machine running a PA-RISC Debian Linux installation with a
> >> screen resolution of 2048x1024 with 8bpp. In that case qemu emulated the
> >> graphics hardware bitblt and fillrect acceleration by using the native
> >> (x86) CPU.
> >>
> >> It was a simple testcase which was to run "time dmesg", where the syslog
> >> had 284 lines. The results showed a huge speedup:
> >> a) time dmesg (without acceleration):
> >>    -> 19.0 seconds
> >> b) time dmesg (with acceleration):
> >>    ->  2.6 seconds
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >>
> >> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> >> index 840d9813b0bc..da84d1c21c21 100644
> >> --- a/drivers/video/console/Kconfig
> >> +++ b/drivers/video/console/Kconfig
> >> @@ -78,6 +78,17 @@ config FRAMEBUFFER_CONSOLE
> >>      help
> >>        Low-level framebuffer-based console driver.
> >>
> >> +config FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
> >> +    bool "Framebuffer Console hardware acceleration support"
> >> +    depends on FRAMEBUFFER_CONSOLE
> >> +    default y if !DRM
> >> +    default y if !(X86 || ARM)
> >> +    help
> >> +      If you use a system on which DRM is fully supported you usually want to say N,
> >> +      otherwise you probably want to enable this option.
> >> +      If enabled the framebuffer console will utilize the hardware acceleration
> >> +      of your graphics card by using hardware bitblt and fillrect features.
> >> +
> >>  config FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
> >>         bool "Map the console to the primary display device"
> >>         depends on FRAMEBUFFER_CONSOLE
> >> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> >> index b813985f1403..f7b7d35953e8 100644
> >> --- a/drivers/video/fbdev/core/fbcon.c
> >> +++ b/drivers/video/fbdev/core/fbcon.c
> >> @@ -1136,11 +1136,13 @@ static void fbcon_init(struct vc_data *vc, int init)
> >>
> >>      ops->graphics = 0;
> >>
> >> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
> >>      if ((cap & FBINFO_HWACCEL_COPYAREA) &&
> >>          !(cap & FBINFO_HWACCEL_DISABLED))
> >>              p->scrollmode = SCROLL_MOVE;
> >>      else /* default to something safe */
> >>              p->scrollmode = SCROLL_REDRAW;
> >> +#endif
> >>
> >>      /*
> >>       *  ++guenther: console.c:vc_allocate() relies on initializing
> >> @@ -1705,7 +1707,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> >>                      count = vc->vc_rows;
> >>              if (logo_shown >= 0)
> >>                      goto redraw_up;
> >> -            switch (p->scrollmode) {
> >> +            switch (fb_scrollmode(p)) {
> >>              case SCROLL_MOVE:
> >>                      fbcon_redraw_blit(vc, info, p, t, b - t - count,
> >>                                   count);
> >> @@ -1795,7 +1797,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> >>                      count = vc->vc_rows;
> >>              if (logo_shown >= 0)
> >>                      goto redraw_down;
> >> -            switch (p->scrollmode) {
> >> +            switch (fb_scrollmode(p)) {
> >>              case SCROLL_MOVE:
> >>                      fbcon_redraw_blit(vc, info, p, b - 1, b - t - count,
> >>                                   -count);
> >> @@ -1946,12 +1948,12 @@ static void fbcon_bmove_rec(struct vc_data *vc, struct fbcon_display *p, int sy,
> >>                 height, width);
> >>  }
> >>
> >> -static void updatescrollmode(struct fbcon_display *p,
> >> +static void updatescrollmode_accel(struct fbcon_display *p,
> >>                                      struct fb_info *info,
> >>                                      struct vc_data *vc)
> >>  {
> >> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
> >>      struct fbcon_ops *ops = info->fbcon_par;
> >> -    int fh = vc->vc_font.height;
> >>      int cap = info->flags;
> >>      u16 t = 0;
> >>      int ypan = FBCON_SWAP(ops->rotate, info->fix.ypanstep,
> >> @@ -1972,12 +1974,6 @@ static void updatescrollmode(struct fbcon_display *p,
> >>      int fast_imageblit = (cap & FBINFO_HWACCEL_IMAGEBLIT) &&
> >>              !(cap & FBINFO_HWACCEL_DISABLED);
> >>
> >> -    p->vrows = vyres/fh;
> >> -    if (yres > (fh * (vc->vc_rows + 1)))
> >> -            p->vrows -= (yres - (fh * vc->vc_rows)) / fh;
> >> -    if ((yres % fh) && (vyres % fh < yres % fh))
> >> -            p->vrows--;
> >> -
> >>      if (good_wrap || good_pan) {
> >>              if (reading_fast || fast_copyarea)
> >>                      p->scrollmode = good_wrap ?
> >> @@ -1991,6 +1987,27 @@ static void updatescrollmode(struct fbcon_display *p,
> >>              else
> >>                      p->scrollmode = SCROLL_REDRAW;
> >>      }
> >> +#endif
> >> +}
> >> +
> >> +static void updatescrollmode(struct fbcon_display *p,
> >> +                                    struct fb_info *info,
> >> +                                    struct vc_data *vc)
> >> +{
> >> +    struct fbcon_ops *ops = info->fbcon_par;
> >> +    int fh = vc->vc_font.height;
> >> +    int yres = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
> >> +    int vyres = FBCON_SWAP(ops->rotate, info->var.yres_virtual,
> >> +                               info->var.xres_virtual);
> >> +
> >> +    p->vrows = vyres/fh;
> >> +    if (yres > (fh * (vc->vc_rows + 1)))
> >> +            p->vrows -= (yres - (fh * vc->vc_rows)) / fh;
> >> +    if ((yres % fh) && (vyres % fh < yres % fh))
> >> +            p->vrows--;
> >> +
> >> +    /* update scrollmode in case hardware acceleration is used */
> >> +    updatescrollmode_accel(p, info, vc);
> >>  }
> >>
> >>  #define PITCH(w) (((w) + 7) >> 3)
> >> @@ -2148,7 +2165,7 @@ static int fbcon_switch(struct vc_data *vc)
> >>
> >>      updatescrollmode(p, info, vc);
> >>
> >> -    switch (p->scrollmode) {
> >> +    switch (fb_scrollmode(p)) {
> >>      case SCROLL_WRAP_MOVE:
> >>              scrollback_phys_max = p->vrows - vc->vc_rows;
> >>              break;
> >> diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
> >> index 9315b360c898..c5c043f38162 100644
> >> --- a/drivers/video/fbdev/core/fbcon.h
> >> +++ b/drivers/video/fbdev/core/fbcon.h
> >> @@ -29,7 +29,9 @@ struct fbcon_display {
> >>      /* Filled in by the low-level console driver */
> >>      const u_char *fontdata;
> >>      int userfont;                   /* != 0 if fontdata kmalloc()ed */
> >> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
> >>      u_short scrollmode;             /* Scroll Method */
> >> +#endif
> >>      u_short inverse;                /* != 0 text black on white as default */
> >>      short yscroll;                  /* Hardware scrolling */
> >>      int vrows;                      /* number of virtual rows */
> >> @@ -208,6 +210,17 @@ static inline int attr_col_ec(int shift, struct vc_data *vc,
> >>  #define SCROLL_REDRAW          0x004
> >>  #define SCROLL_PAN_REDRAW  0x005
> >>
> >> +static inline u_short fb_scrollmode(struct fbcon_display *fb)
> >> +{
> >> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
> >> +    return fb->scrollmode;
> >> +#else
> >> +    /* hardcoded to SCROLL_REDRAW if acceleration was disabled. */
> >> +    return SCROLL_REDRAW;
> >> +#endif
> >> +}
> >> +
> >> +
> >>  #ifdef CONFIG_FB_TILEBLITTING
> >>  extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info);
> >>  #endif
> >>
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

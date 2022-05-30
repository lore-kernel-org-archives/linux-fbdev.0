Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A822C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 May 2022 08:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiE3Ijd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 May 2022 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiE3Ijb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 May 2022 04:39:31 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C46370925
        for <linux-fbdev@vger.kernel.org>; Mon, 30 May 2022 01:39:30 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id c12so242166qvr.3
        for <linux-fbdev@vger.kernel.org>; Mon, 30 May 2022 01:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8SPd3n38l95dEtxPv4gdTmZ3OWEYGAzL0sZiwgOqrc=;
        b=ig1OGjJfQ/tPWCUpytV4byFZ4oVxy3CaEZzyCsoaGqOS4Z7prtX8QZ7H6tIc0RM9ZI
         jC15oxppTpHFNcnjQD3mR8p/BH91tCxeRdq3PoiuDRCQj8tW0MA4nyMFScIt5wAhkpcd
         WFl9+8hfxy9yB1VkavvvMKOTQ4SZ9Mb6FsQtnx40SWvHm3Oq3vvQx0AVDhiyGEo6sYqw
         YpeWoeaa8C2tzyI6t8rPcb45vVrmfRSkBBaDswu1PeagWu6m1ijx+mGMDf+hh/aeSZhU
         L8jbMteUfgSO9IPhAQBN+A14D9p9MNZ9IPvKyafSohbFRnHePa9Q82UHB0K3uJwSMJqM
         WX1Q==
X-Gm-Message-State: AOAM530PUbkNCZP4eKk0sbiwQj6kMClzHIUE3BrczcGa2sPpFwQWYP0I
        7NDcTbab50CVdkWWYbOcOBjPu7MrfSa8Fg==
X-Google-Smtp-Source: ABdhPJw2vnHQq45s1dsYH7uFApNIYhCTz4AfhwPOa/ikCv/DsAd9D0UNHrr0CZeAIJSQ+3AxmEIgPg==
X-Received: by 2002:ad4:56f3:0:b0:464:43a9:2d96 with SMTP id cr19-20020ad456f3000000b0046443a92d96mr6963645qvb.29.1653899969322;
        Mon, 30 May 2022 01:39:29 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id d10-20020ac8118a000000b002f39b99f684sm6964421qtj.30.2022.05.30.01.39.28
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 01:39:28 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id z7so17878237ybf.7
        for <linux-fbdev@vger.kernel.org>; Mon, 30 May 2022 01:39:28 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr52772984ybu.604.1653899663236; Mon, 30
 May 2022 01:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191014140416.28517-1-tzimmermann@suse.de> <20191014140416.28517-10-tzimmermann@suse.de>
 <CAMuHMdU9p7KUy3WEFox9KgZBHGZGNO2y5m8tLVbzGGVHu2iNYQ@mail.gmail.com> <8b79b40b-9786-9ddf-0dc9-89efbab38c7f@suse.de>
In-Reply-To: <8b79b40b-9786-9ddf-0dc9-89efbab38c7f@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 May 2022 10:34:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7webJ0_R8uj=nagTHJY6viLGkhv2hmc9X48gwz1JDew@mail.gmail.com>
Message-ID: <CAMuHMdX7webJ0_R8uj=nagTHJY6viLGkhv2hmc9X48gwz1JDew@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] drm/fbconv: Mode-setting pipeline enable / disable
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        ajax@redhat.com,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Mathieu Malaterre <malat@debian.org>, michel@daenzer.net,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Mon, May 30, 2022 at 9:47 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> first of all, thanks for looking at the patch.

Thank you, your patch series helped a lot.

> Am 28.05.22 um 22:17 schrieb Geert Uytterhoeven:
> > On Mon, Oct 14, 2019 at 4:05 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> The display mode is set by converting the DRM display mode to an
> >> fb_info state and handling it to the fbdev driver's fb_setvar()
> >> function. This also requires a color depth, which we take from the
> >> value of struct drm_mode_config.preferred_depth
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >
> >> --- a/drivers/gpu/drm/drm_fbconv_helper.c
> >> +++ b/drivers/gpu/drm/drm_fbconv_helper.c
> >> @@ -919,6 +919,24 @@ static int drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
> >>          return 0;
> >>   }
> >>
> >> +static int drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
> >> +       struct fb_var_screeninfo *fb_var, struct drm_simple_display_pipe *pipe)
> >> +{
> >> +       struct drm_plane *primary = pipe->crtc.primary;
> >> +       struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
> >> +
> >> +       if (primary && primary->state && primary->state->fb)
> >> +               return drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
> >> +                       fb_var, primary->state->fb,
> >> +                       modeset->fb_info->fix.smem_len);
> >> +
> >> +       fb_var->xres_virtual = fb_var->xres;
> >> +       fb_var->yres_virtual = fb_var->yres;
> >> +       fb_var->bits_per_pixel = modeset->dev->mode_config.preferred_depth;
> >
> > This looks wrong to me: IMHO bits_per_pixel should be derived from
> > the fourcc format of the _new_ mode to be set...
>
> Indeed, this appears to be wrong.

OK.

>
> >
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   /**
> >>    * drm_fbconv_simple_display_pipe_mode_valid - default implementation for
> >>    *     struct drm_simple_display_pipe_funcs.mode_valid
> >> @@ -950,6 +968,28 @@ bool drm_fbconv_simple_display_pipe_mode_fixup(
> >>          struct drm_crtc *crtc, const struct drm_display_mode *mode,
> >>          struct drm_display_mode *adjusted_mode)
> >>   {
> >> +       struct drm_simple_display_pipe *pipe =
> >> +               container_of(crtc, struct drm_simple_display_pipe, crtc);
> >> +       struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
> >> +       struct fb_var_screeninfo fb_var;
> >> +       int ret;
> >> +
> >> +       if (!modeset->fb_info->fbops->fb_check_var)
> >> +               return true;
> >> +
> >> +       drm_fbconv_init_fb_var_screeninfo_from_mode(&fb_var, mode);
> >> +
> >> +       ret = drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
> >> +               &fb_var, &modeset->pipe);
> >> +       if (ret)
> >> +               return true;
> >> +
> >> +       ret = modeset->fb_info->fbops->fb_check_var(&fb_var, modeset->fb_info);
> >
> > ... hence this fails if the requested mode is valid with the new
> > fourcc format, but invalid with the old (but preferred) depth.
> > E.g. due to bandwidth limitations, a high-resolution mode is valid
> > with a low color depth, while a high color depth is limited to lower
> > resolutions.
>
> I tested the helpers with various fbdev drivers and modified them until
> all of these drivers produced at least some output. I'm not surprised
> that there are still bugs.

As usual, the devil is in the details ;-)

The other issue I was facing are the non-rounding KHZ2PICOS() and
PICOS2KHZ() macros, and the numerous back-and-forth conversions:
a valid pixclock in kHz is converted to a valid pixclock in ps,
and accepted.  The returned pixclock in ps is slightly different,
and converted to an invalid pixclock in kHz, hence rejected in the
next iteration (remember: fb_ops.fb_check_var() should only round up
values to match, never round down)...

> > Unfortunately we do not know the new fourcc format here, as both
> > drm_simple_display_pipe_funcs.mode_{valid,fixup}() are passed
> > the mode (from drm_mode_set.mode), but not the new format (from
> > drm_mode_set.fb->format).
> >
> > Am I missing something? Is the new format available in some other way?
>
> We can always get the format from the new plane state of
> modeset->pipe->plane. We'd have this in the atomic_check call. And it
> appears that drm_fbconv_simple_display_pipe_check() is a better place
> for this code anyway.

Thanks, I'll give that a try!

Anyway, I finally made some progress with KMS-style mode-setting inside
my ataridrm driver. Before, I relied solely on initial fbdev-style
mode-setting in the probe function.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

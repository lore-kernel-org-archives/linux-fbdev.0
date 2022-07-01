Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC666C43334
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Jul 2022 20:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiGAUCB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiGAUB5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 1 Jul 2022 16:01:57 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2864F199
        for <linux-fbdev@vger.kernel.org>; Fri,  1 Jul 2022 13:01:42 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id cu16so4851610qvb.7
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Jul 2022 13:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2stC06lnxIJ04peLci0uJckjsb+NhjEnb2d6jyIQDI=;
        b=CYzana6E3yLyvyx9gHa1zQA5qQrRGAnlkKzcSgSsKMlQvVY7xw0mFjLjZOx1APLVZH
         ggndnhflliqAywot74ZLIsjBomrlFLmOah3feoYFI2ehW8RYAvCrN+SAdK1c0qwsRcS3
         M74Ju5VAsc5nRvqse5aN5fCzmCfwBxWaD8fPE8d1GVwjgtAFTDd0R49yXXOxZRG2lZpX
         qrhKicY0RgbgP/7bYb+NIofzOpu+3e3om9pH8lrfCrxcVzjom2O48pYbDxn8CcddZ9YB
         lO8UY368qNkcBZN2LpdUWKO0AiY3JkLkcvdg+GkgpwyHTCwtSk/ysc8xG6eidVMSluB8
         Ly7w==
X-Gm-Message-State: AJIora+yrX9pNrvdm6VXf/HeTjFy2o/rlN75GNWNCCohU6/45sCbJPjQ
        VsKxUKuXAIIFASQ+6g83jcC7Klkn6XrpHA==
X-Google-Smtp-Source: AGRyM1ubvqoI8uShr/Vyf9aFLH4PXfBdp0XMnAfBl+S5SMsNTxwOHpWNNavNCmxBK3nQkHuB+X2GvA==
X-Received: by 2002:a05:6214:965:b0:470:5190:3350 with SMTP id do5-20020a056214096500b0047051903350mr18695490qvb.53.1656705700844;
        Fri, 01 Jul 2022 13:01:40 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id v26-20020ac873da000000b00304dec6452csm15091931qtp.78.2022.07.01.13.01.39
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 13:01:40 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id d5so5823915yba.5
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Jul 2022 13:01:39 -0700 (PDT)
X-Received: by 2002:a25:3288:0:b0:66c:8a91:74bb with SMTP id
 y130-20020a253288000000b0066c8a9174bbmr16964347yby.89.1656705699367; Fri, 01
 Jul 2022 13:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191014140416.28517-1-tzimmermann@suse.de> <20191014140416.28517-10-tzimmermann@suse.de>
 <CAMuHMdU9p7KUy3WEFox9KgZBHGZGNO2y5m8tLVbzGGVHu2iNYQ@mail.gmail.com>
 <8b79b40b-9786-9ddf-0dc9-89efbab38c7f@suse.de> <CAMuHMdX7webJ0_R8uj=nagTHJY6viLGkhv2hmc9X48gwz1JDew@mail.gmail.com>
In-Reply-To: <CAMuHMdX7webJ0_R8uj=nagTHJY6viLGkhv2hmc9X48gwz1JDew@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Jul 2022 22:01:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-QWCG16asy4o_p21meY4AnbpVNSmd4+PJkDipwPg2Vg@mail.gmail.com>
Message-ID: <CAMuHMdU-QWCG16asy4o_p21meY4AnbpVNSmd4+PJkDipwPg2Vg@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] drm/fbconv: Mode-setting pipeline enable / disable
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, ajax@redhat.com,
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

On Mon, May 30, 2022 at 10:34 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, May 30, 2022 at 9:47 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > Am 28.05.22 um 22:17 schrieb Geert Uytterhoeven:
> > > On Mon, Oct 14, 2019 at 4:05 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > >> The display mode is set by converting the DRM display mode to an
> > >> fb_info state and handling it to the fbdev driver's fb_setvar()
> > >> function. This also requires a color depth, which we take from the
> > >> value of struct drm_mode_config.preferred_depth
> > >>
> > >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > >
> > >> --- a/drivers/gpu/drm/drm_fbconv_helper.c
> > >> +++ b/drivers/gpu/drm/drm_fbconv_helper.c
> > >> @@ -919,6 +919,24 @@ static int drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
> > >>          return 0;
> > >>   }
> > >>
> > >> +static int drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
> > >> +       struct fb_var_screeninfo *fb_var, struct drm_simple_display_pipe *pipe)
> > >> +{
> > >> +       struct drm_plane *primary = pipe->crtc.primary;
> > >> +       struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
> > >> +
> > >> +       if (primary && primary->state && primary->state->fb)
> > >> +               return drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
> > >> +                       fb_var, primary->state->fb,
> > >> +                       modeset->fb_info->fix.smem_len);
> > >> +
> > >> +       fb_var->xres_virtual = fb_var->xres;
> > >> +       fb_var->yres_virtual = fb_var->yres;
> > >> +       fb_var->bits_per_pixel = modeset->dev->mode_config.preferred_depth;
> > >
> > > This looks wrong to me: IMHO bits_per_pixel should be derived from
> > > the fourcc format of the _new_ mode to be set...
> >
> > Indeed, this appears to be wrong.
>
> OK.
>
> >
> > >
> > >> +
> > >> +       return 0;
> > >> +}
> > >> +
> > >>   /**
> > >>    * drm_fbconv_simple_display_pipe_mode_valid - default implementation for
> > >>    *     struct drm_simple_display_pipe_funcs.mode_valid
> > >> @@ -950,6 +968,28 @@ bool drm_fbconv_simple_display_pipe_mode_fixup(
> > >>          struct drm_crtc *crtc, const struct drm_display_mode *mode,
> > >>          struct drm_display_mode *adjusted_mode)
> > >>   {
> > >> +       struct drm_simple_display_pipe *pipe =
> > >> +               container_of(crtc, struct drm_simple_display_pipe, crtc);
> > >> +       struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
> > >> +       struct fb_var_screeninfo fb_var;
> > >> +       int ret;
> > >> +
> > >> +       if (!modeset->fb_info->fbops->fb_check_var)
> > >> +               return true;
> > >> +
> > >> +       drm_fbconv_init_fb_var_screeninfo_from_mode(&fb_var, mode);
> > >> +
> > >> +       ret = drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
> > >> +               &fb_var, &modeset->pipe);
> > >> +       if (ret)
> > >> +               return true;
> > >> +
> > >> +       ret = modeset->fb_info->fbops->fb_check_var(&fb_var, modeset->fb_info);
> > >
> > > ... hence this fails if the requested mode is valid with the new
> > > fourcc format, but invalid with the old (but preferred) depth.
> > > E.g. due to bandwidth limitations, a high-resolution mode is valid
> > > with a low color depth, while a high color depth is limited to lower
> > > resolutions.

> > > Unfortunately we do not know the new fourcc format here, as both
> > > drm_simple_display_pipe_funcs.mode_{valid,fixup}() are passed
> > > the mode (from drm_mode_set.mode), but not the new format (from
> > > drm_mode_set.fb->format).
> > >
> > > Am I missing something? Is the new format available in some other way?
> >
> > We can always get the format from the new plane state of
> > modeset->pipe->plane. We'd have this in the atomic_check call. And it
> > appears that drm_fbconv_simple_display_pipe_check() is a better place
> > for this code anyway.
>
> Thanks, I'll give that a try!

Getting the format from the new plane state of pipe->plane doesn't
work, as pipe->plane.state->fb = NULL.
But it is indeed available in the drm_simple_display_pipe_funcs.check()
callback, so that seems to work...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

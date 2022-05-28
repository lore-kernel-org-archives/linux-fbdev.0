Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10777C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 May 2022 20:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiE1USD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 May 2022 16:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiE1USC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 May 2022 16:18:02 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637314B856
        for <linux-fbdev@vger.kernel.org>; Sat, 28 May 2022 13:18:00 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id v5so6922555qvs.10
        for <linux-fbdev@vger.kernel.org>; Sat, 28 May 2022 13:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW6Y4vJiidlHWFIwlmPdp6Tw0q2d8acxVjTk7ACvPCk=;
        b=45gEzbOH2tx0JrCJ6wdzW1e5E5P8z2Iyak9gRI0AErH96RZ4Lf372sBIijX/A+NNKV
         baAA1bBaai3Mxw6Dj4toilhGFmjMZq8Xnl+6YtpLvPQMvJfKOnGMXzLgd0dBUvh0KRkd
         yMG/eUFz4m8bkhAbmCvXCUAxYb/zZPVWXHa6gJ3E4wBxLHZpkBiZXDfTYQdn+HEevH33
         kG8vPIy2igxJP0ecQlSOy2v5Jz7EgkQIQfgssEMlQoy2lNtUGg2HK0n5MvXJf0Vu+z0M
         RMZOb+fQjX0D3AIwv5Jzw1pOP+jRoXC48qoVYbEqyMelcFr/doJgAAR5d8ibWFDtQ5P3
         /F1A==
X-Gm-Message-State: AOAM532qeoyUL13tD/U1jYeTmMrTVyIA2qR4qF3+HMloIWnXzhE5SP8T
        0hOB69WEl+S7XHcSBd3oDPaaokf2fUwPiw==
X-Google-Smtp-Source: ABdhPJyeoLWRbE1dw6Wgac918AOktweyCOAZjKY9HfAK7JU2Gwt5D0X9RbtHZ1BMWPEYW5lhT8tHew==
X-Received: by 2002:a05:6214:2342:b0:42d:7c8b:9eac with SMTP id hu2-20020a056214234200b0042d7c8b9eacmr39975906qvb.5.1653769079199;
        Sat, 28 May 2022 13:17:59 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id c13-20020a05622a024d00b002f942e6bd88sm5027951qtx.48.2022.05.28.13.17.57
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 13:17:57 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ff7b90e635so77055997b3.5
        for <linux-fbdev@vger.kernel.org>; Sat, 28 May 2022 13:17:57 -0700 (PDT)
X-Received: by 2002:a81:6c05:0:b0:30c:18f5:d2b0 with SMTP id
 h5-20020a816c05000000b0030c18f5d2b0mr3886464ywc.502.1653769077224; Sat, 28
 May 2022 13:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191014140416.28517-1-tzimmermann@suse.de> <20191014140416.28517-10-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-10-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 28 May 2022 22:17:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU9p7KUy3WEFox9KgZBHGZGNO2y5m8tLVbzGGVHu2iNYQ@mail.gmail.com>
Message-ID: <CAMuHMdU9p7KUy3WEFox9KgZBHGZGNO2y5m8tLVbzGGVHu2iNYQ@mail.gmail.com>
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

On Mon, Oct 14, 2019 at 4:05 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> The display mode is set by converting the DRM display mode to an
> fb_info state and handling it to the fbdev driver's fb_setvar()
> function. This also requires a color depth, which we take from the
> value of struct drm_mode_config.preferred_depth
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

> --- a/drivers/gpu/drm/drm_fbconv_helper.c
> +++ b/drivers/gpu/drm/drm_fbconv_helper.c
> @@ -919,6 +919,24 @@ static int drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
>         return 0;
>  }
>
> +static int drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
> +       struct fb_var_screeninfo *fb_var, struct drm_simple_display_pipe *pipe)
> +{
> +       struct drm_plane *primary = pipe->crtc.primary;
> +       struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
> +
> +       if (primary && primary->state && primary->state->fb)
> +               return drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
> +                       fb_var, primary->state->fb,
> +                       modeset->fb_info->fix.smem_len);
> +
> +       fb_var->xres_virtual = fb_var->xres;
> +       fb_var->yres_virtual = fb_var->yres;
> +       fb_var->bits_per_pixel = modeset->dev->mode_config.preferred_depth;

This looks wrong to me: IMHO bits_per_pixel should be derived from
the fourcc format of the _new_ mode to be set...

> +
> +       return 0;
> +}
> +
>  /**
>   * drm_fbconv_simple_display_pipe_mode_valid - default implementation for
>   *     struct drm_simple_display_pipe_funcs.mode_valid
> @@ -950,6 +968,28 @@ bool drm_fbconv_simple_display_pipe_mode_fixup(
>         struct drm_crtc *crtc, const struct drm_display_mode *mode,
>         struct drm_display_mode *adjusted_mode)
>  {
> +       struct drm_simple_display_pipe *pipe =
> +               container_of(crtc, struct drm_simple_display_pipe, crtc);
> +       struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
> +       struct fb_var_screeninfo fb_var;
> +       int ret;
> +
> +       if (!modeset->fb_info->fbops->fb_check_var)
> +               return true;
> +
> +       drm_fbconv_init_fb_var_screeninfo_from_mode(&fb_var, mode);
> +
> +       ret = drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
> +               &fb_var, &modeset->pipe);
> +       if (ret)
> +               return true;
> +
> +       ret = modeset->fb_info->fbops->fb_check_var(&fb_var, modeset->fb_info);

... hence this fails if the requested mode is valid with the new
fourcc format, but invalid with the old (but preferred) depth.
E.g. due to bandwidth limitations, a high-resolution mode is valid
with a low color depth, while a high color depth is limited to lower
resolutions.

Unfortunately we do not know the new fourcc format here, as both
drm_simple_display_pipe_funcs.mode_{valid,fixup}() are passed
the mode (from drm_mode_set.mode), but not the new format (from
drm_mode_set.fb->format).

Am I missing something? Is the new format available in some other way?
Thanks!

> +       if (ret < 0)
> +               return false;
> +
> +       drm_mode_update_from_fb_var_screeninfo(adjusted_mode, &fb_var);
> +
>         return true;
>  }
>  EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_mode_fixup);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983AEC43334
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jul 2022 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiGGIWO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiGGIVj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Jul 2022 04:21:39 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0984F1BD
        for <linux-fbdev@vger.kernel.org>; Thu,  7 Jul 2022 01:20:44 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id b24so12831740qkn.4
        for <linux-fbdev@vger.kernel.org>; Thu, 07 Jul 2022 01:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgXInV/talyaexy4ODdv5tDP4fWPK6BLCSeFlqnzgQQ=;
        b=GZ16AKtK3H95yDoS7+wLJGiSR3z3G5okwBQznMQGO0iRN/hnaP3jYU8vLqVArHZ5HI
         yJa9sX2CreZUQ5TfKn/Au0gFT1jVq3by0fUVG0AUkMV68Q15lm2rZOCgumCI2/6d47WW
         0rpTUrJ+AsL9OkCZsoSd1XwB4TWfyoTvK4MmeyXIwksxIBmPGWHD9KQ3Vow0O7wcS8Oo
         65W1TWPIBwgXhWKexO37HECqRQZApTe9ASdB+LBDX7mrqvYS77kID6Wm6yNMkucraOyv
         AWWBm45sxg0RF2oGi3EOiJlfLPOe62xL0O6X05Dyuwa2n4aDOfW8FrmhGLdA+MGgie5p
         ulHw==
X-Gm-Message-State: AJIora8B6PcN1YD5WVIEoyUCVC1Dv7Mji7cIrBQJXEEjap+/4SQRsN96
        1+5fcEWrGyjydY92mWtXAYXHNEsPB8eacbOl
X-Google-Smtp-Source: AGRyM1sFlVPnKRlN9KamYOZliRTve0zFKpDZuaxYXTSSuvQP5vIsxrNDqxLaDCichr7XAF678FvDIg==
X-Received: by 2002:a05:620a:99a:b0:6af:b93:6310 with SMTP id x26-20020a05620a099a00b006af0b936310mr31258553qkx.486.1657182043067;
        Thu, 07 Jul 2022 01:20:43 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id p14-20020a05620a056e00b006ab91fd03fasm28927690qkp.19.2022.07.07.01.20.42
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:20:42 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id l144so18778719ybl.5
        for <linux-fbdev@vger.kernel.org>; Thu, 07 Jul 2022 01:20:42 -0700 (PDT)
X-Received: by 2002:a05:6902:50e:b0:66e:7f55:7a66 with SMTP id
 x14-20020a056902050e00b0066e7f557a66mr11990868ybs.365.1657182042336; Thu, 07
 Jul 2022 01:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220706150253.2186-1-deller@gmx.de> <20220706150253.2186-4-deller@gmx.de>
In-Reply-To: <20220706150253.2186-4-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Jul 2022 10:20:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBOKwtVabCrvsFXi-9Yz=Rnwhn4MDmxxBwA6QOuFyZ6w@mail.gmail.com>
Message-ID: <CAMuHMdWBOKwtVabCrvsFXi-9Yz=Rnwhn4MDmxxBwA6QOuFyZ6w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] fbmem: Check virtual screen sizes in fb_set_var()
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Wed, Jul 6, 2022 at 5:02 PM Helge Deller <deller@gmx.de> wrote:
> Verify that the fbdev or drm driver correctly adjusted the virtual
> screen sizes. On failure report the failing driver and reject the screen
> size change.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1016,6 +1016,17 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>         if (ret)
>                 return ret;
>
> +       /* verify that virtual resolution >= physical resolution */
> +       if (var->xres_virtual < var->xres ||
> +           var->yres_virtual < var->yres) {
> +               pr_warn("WARNING: fbcon: Driver '%s' missed to adjust virtual"
> +                       " screen size (%dx%d vs. %dx%d)\n",

%ux%u cs. %ux%u

Please don't split messages, for easier grepping.

> +                       info->fix.id,
> +                       var->xres_virtual, var->yres_virtual,
> +                       var->xres, var->yres);
> +               return -EINVAL;
> +       }
> +
>         if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
>                 return 0;

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

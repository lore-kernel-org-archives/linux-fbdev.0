Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4300C433EF
	for <linux-fbdev@archiver.kernel.org>; Sun,  3 Jul 2022 08:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiGCIzu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 3 Jul 2022 04:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiGCIzt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 3 Jul 2022 04:55:49 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEF5F77
        for <linux-fbdev@vger.kernel.org>; Sun,  3 Jul 2022 01:55:48 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id q16so5869905qtn.5
        for <linux-fbdev@vger.kernel.org>; Sun, 03 Jul 2022 01:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1CjjNvKlUa9yj4QK1c9nMHcGVsSqE36Ijq7FI5N7FU=;
        b=R8cL0ZIUfI0T3i8+1yGkMKsYbzNnXQ5j1zjsroEjFX4mmu7llLgi0tLOWsrKxon7M1
         9sbIMGTWE7x91Yh3WXI8TCsWO0/BatUgdQt0I/9T0BpfHCzbgclyOxcrAhApcVGNg0pa
         Jeu1hbRNKHZI6DuAgSPmkDauew5ObquZBQWMOBK9bn3pd/KL5IS/S72Xu0lTvlFOVGkg
         NLbuwTevFP51lBuNMXeEWiqBP6jCDGZ4qUj9JKz78lihwTbmeIN7W/F1m/dGzqiXMdBb
         VSENzF8h6XkHcrX+CCPJ+lbIpeB5kVq1QfZDyTO9KHe02SJuEnhNv04hlZdDiIN83gr6
         kI+w==
X-Gm-Message-State: AJIora/IvitoVLiX2M+tI7Gmob7s9APZRJy+g4aF9gd0UrWqPi7khzzB
        yColnwCes9OWrAjrVwC0LH4Iwe4ZmZOERg==
X-Google-Smtp-Source: AGRyM1vscYKf0XNPP8TTUkZ36f0/LiEOSQTt0TaNymjzyOTSsw0a2czJrv8SunUrhOljtVYBq938AQ==
X-Received: by 2002:ac8:5844:0:b0:31b:ec14:cbef with SMTP id h4-20020ac85844000000b0031bec14cbefmr19123646qth.617.1656838547605;
        Sun, 03 Jul 2022 01:55:47 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id b19-20020ae9eb13000000b006aee672937esm21416266qkg.37.2022.07.03.01.55.47
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 01:55:47 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31c8bb90d09so4053237b3.8
        for <linux-fbdev@vger.kernel.org>; Sun, 03 Jul 2022 01:55:47 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr26487626ywd.283.1656838547025; Sun, 03
 Jul 2022 01:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220701202352.559808-1-deller@gmx.de> <20220701202352.559808-4-deller@gmx.de>
In-Reply-To: <20220701202352.559808-4-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 3 Jul 2022 10:55:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTwM+y+yi5ASY9hQLgJD-4pjtStGA9m82853LmbdywOA@mail.gmail.com>
Message-ID: <CAMuHMdUTwM+y+yi5ASY9hQLgJD-4pjtStGA9m82853LmbdywOA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fbmem: Prevent invalid virtual screen sizes in fb_set_var()
To:     Helge Deller <deller@gmx.de>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Fri, Jul 1, 2022 at 10:23 PM Helge Deller <deller@gmx.de> wrote:
> Prevent that drivers configure a virtual screen resolution smaller than
> the physical screen resolution.  This is important, because otherwise we
> may access memory outside of the graphics memory area.
>
> Give a kernel WARNing and show the driver name to help locating the buggy
> driver.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Thanks for your patch!

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1016,6 +1016,18 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>         if (ret)
>                 return ret;
>
> +       /* make sure virtual resolution >= physical resolution */
> +       if (WARN_ON(var->xres_virtual < var->xres)) {

WARN_ON_ONCE()?
This does mean we would miss two or more buggy drivers in a single system.

> +               pr_warn("fbcon: Fix up invalid xres %d for %s\n",

xres_virtual?

> +                       var->xres_virtual, info->fix.id);
> +               var->xres_virtual = var->xres;

I think it's better to not fix this up, but return -EINVAL instead.
After all if we get here, we have a buggy driver that needs to be fixed.

> +       }
> +       if (WARN_ON(var->yres_virtual < var->yres)) {
> +               pr_warn("fbcon: Fix up invalid yres %d for %s\n",
> +                       var->yres_virtual, info->fix.id);
> +               var->yres_virtual = var->yres;
> +       }

Same for yres.

> +
>         if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
>                 return 0;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

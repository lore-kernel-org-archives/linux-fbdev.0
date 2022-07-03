Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8295CC433EF
	for <linux-fbdev@archiver.kernel.org>; Sun,  3 Jul 2022 08:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiGCIvC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 3 Jul 2022 04:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiGCIuc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 3 Jul 2022 04:50:32 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE45AE50
        for <linux-fbdev@vger.kernel.org>; Sun,  3 Jul 2022 01:50:16 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id c13so5852955qtq.10
        for <linux-fbdev@vger.kernel.org>; Sun, 03 Jul 2022 01:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q10avrUQvDZXQrB8NbI6GXVYl9CBfKWMfdOzIE6Fs90=;
        b=jsIyPHfhTezjvELDKR6FXQsFA/uZLzJ2t3a/L79+0+fos5h6dms+mCiFMv/dembWxn
         uRrzm/THJRFfGqQEV6Ni8S2PtTUYfNAGdZymUWGbV18wSCGfD2KBPmzFOoac6jNRX40q
         62s+TSnWIb0NciOT0vmTAq8k5sut2H96r0e8QLRadUgenz4NUTBE/cFycaEwrWi0df5u
         +F0CmXKGZEiUR7/iRT79BJGD69u5F2wrlyjeJNGU2fZfdPN1S0GFi0lphIRmQLaWQR78
         vHDFxGWTYKNshs/+OBXz8FTlW8Qsfrb/JY431VZ16yC36o0VwlIIdkdIvDu+ixVhcD5x
         +wlQ==
X-Gm-Message-State: AJIora+BF2EFdfptm9CsYEBb0dYYbjbnohwNRHvvaReb9ZBKHMGJr2pO
        hn+//wgvappJPy6Y2XoxB4tfewcY4iIUjw==
X-Google-Smtp-Source: AGRyM1uQctg53G3/ObEHWd0cmOQdtso47diRO5auGU2G0u5Wrxs9BmKj+xVJCCmjhNSTIGeNVAHrMw==
X-Received: by 2002:a05:622a:144d:b0:31b:bd37:f98a with SMTP id v13-20020a05622a144d00b0031bbd37f98amr19833933qtx.426.1656838215438;
        Sun, 03 Jul 2022 01:50:15 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bk32-20020a05620a1a2000b006af1d3e8080sm17833688qkb.85.2022.07.03.01.50.14
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 01:50:15 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3176b6ed923so57494817b3.11
        for <linux-fbdev@vger.kernel.org>; Sun, 03 Jul 2022 01:50:14 -0700 (PDT)
X-Received: by 2002:a81:af27:0:b0:31c:833f:eda5 with SMTP id
 n39-20020a81af27000000b0031c833feda5mr5763706ywh.358.1656838214734; Sun, 03
 Jul 2022 01:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220701202352.559808-1-deller@gmx.de> <20220701202352.559808-3-deller@gmx.de>
In-Reply-To: <20220701202352.559808-3-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 3 Jul 2022 10:50:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCSbd38H95jSGiTARekE1Y2YUtKfak9cK3xLwd+ubGdQ@mail.gmail.com>
Message-ID: <CAMuHMdUCSbd38H95jSGiTARekE1Y2YUtKfak9cK3xLwd+ubGdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fbcon: Prevent that screen size is smaller than
 font size
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
> We need to prevent that users configure a screen size which is smaller than the
> currently selected font size. Otherwise rendering chars on the screen will
> access memory outside the graphics memory region.
>
> This patch adds a new function fbcon_modechange_possible() which
> implements this check and which later may be extended with other checks
> if necessary.  The new function is called from the FBIOPUT_VSCREENINFO
> ioctl handler in fbmem.c, which will return -EINVAL if userspace asked
> for a too small screen size.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Thanks for your patch!

> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2736,6 +2736,34 @@ void fbcon_update_vcs(struct fb_info *info, bool all)
>  }
>  EXPORT_SYMBOL(fbcon_update_vcs);
>
> +/* let fbcon check if it supports a new screen resolution */
> +int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
> +{
> +       struct fbcon_ops *ops = info->fbcon_par;
> +       struct vc_data *vc;
> +       int i;

unsigned int i

> +
> +       WARN_CONSOLE_UNLOCKED();
> +
> +       if (!ops)
> +               return -EINVAL;

This means the frame buffer device is not used as a text console
(i.e. the text console is mapped to a different frame buffer device),
hence it should return success.

> +
> +       /* prevent setting a screen size which is smaller than font size */
> +       for (i = first_fb_vc; i <= last_fb_vc; i++) {
> +               vc = vc_cons[i].d;
> +               if (!vc || vc->vc_mode != KD_TEXT ||
> +                          registered_fb[con2fb_map[i]] != info)
> +                       continue;
> +
> +               if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) ||
> +                   vc->vc_font.height > FBCON_SWAP(var->rotate, var->yres, var->xres))
> +                       return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(fbcon_modechange_possible);

EXPORT_SYMBOL_GPL()?
No idea why most of fbcon uses the non-GPL variant.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

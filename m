Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3823DC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 28 Jun 2022 08:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbiF1IkS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiF1IkN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 28 Jun 2022 04:40:13 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D640275D9
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jun 2022 01:40:13 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id i17so18913396qvo.13
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jun 2022 01:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YpN+xGTRMUaw3KBiJiQ1vTuL3RZYxt01a0NoSjORfw=;
        b=Bag+a5H8fidHptI9CF+vpPhiA39nI3ghtM6o8kpR4g15BuPmItqeLl6qYmA/Qo/Tek
         vHdzCa7zbDFxaHcJqbOy4VpOept/gGm60yrx78VsHDG30s2A50WH0ku3CLyUFS49lHYx
         AgE+Aj8NDc04igqAQ708Iooba53jPTuqP6Ip0frPKjiBP8MAbncOrbltog9tK9yKSYUu
         td/63gSlE3EDayUesGj3BgFTBuI51AebACqIV/i44M1OQkkbqRfKwfLLpl16S0MffGgm
         gDEiizM12EXku1jvmYjJfmBHo2lsJ7xSQV/pzgOhAPcC8Ta4oxBRHr5Bhm5UzvzKJqTc
         lnrw==
X-Gm-Message-State: AJIora8Q1zJbLCCLpbf/zo74d4/90ZxMBvp7fyYr7YxfVYrBrN/MYTpf
        vc8+B3dxm73gWkci6oMMnPy8RjkSAQR9Gg==
X-Google-Smtp-Source: AGRyM1v5/L02rI4CB0SntlnYUlXyipT84tCyyCvGz0ORa3NdA6DBlJOSce989IuiUFuRY6y2IiNAHQ==
X-Received: by 2002:ad4:4305:0:b0:470:4058:4fc9 with SMTP id c5-20020ad44305000000b0047040584fc9mr2650418qvs.94.1656405612289;
        Tue, 28 Jun 2022 01:40:12 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id t14-20020a05620a004e00b006a6d20386f6sm9882620qkt.42.2022.06.28.01.40.11
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:40:12 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id i15so21100229ybp.1
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jun 2022 01:40:11 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr18412036ybq.543.1656405611671; Tue, 28
 Jun 2022 01:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220626102853.124108-1-deller@gmx.de> <20220626102853.124108-4-deller@gmx.de>
In-Reply-To: <20220626102853.124108-4-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 10:39:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5zLoQWi2qd9HpP65WEvCw_q3VTsZ0MnBV1t8xM7KFUw@mail.gmail.com>
Message-ID: <CAMuHMdV5zLoQWi2qd9HpP65WEvCw_q3VTsZ0MnBV1t8xM7KFUw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] fbcon: Prevent that screen size is smaller than
 font size
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Sun, Jun 26, 2022 at 12:33 PM Helge Deller <deller@gmx.de> wrote:
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
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org # v5.4+

Thanks for your patch, which is now commit f0b6a66d33ca6e7e ("fbcon:
Prevent that screen size is smaller than font size") in fbdev/for-next

> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1112,7 +1112,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>                         return -EFAULT;
>                 console_lock();
>                 lock_fb_info(info);
> -               ret = fb_set_var(info, &var);
> +               ret = fbcon_modechange_possible(info, &var);

Again, this should be done (if done at all) after the call to
fb_ops.check_var(), as it breaks the FBIOPUT_VSCREENINFO rounding rule.

What if the user just wants to display graphics, not text?
Can't the text console be disabled instead?

> +               if (!ret)
> +                       ret = fb_set_var(info, &var);
>                 if (!ret)
>                         fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
>                 unlock_fb_info(info);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

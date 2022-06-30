Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45BDC43334
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 19:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiF3TBC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiF3TBB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 15:01:01 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE2D1EC5E
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:01:00 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id u7so609146qvm.4
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WBUVcgDv8MjfQAjmqbMGyjD439nITcAGw7oJ2dGb+s=;
        b=7OTwvb1sowQw98X2/5ZCzHolAVwTAuHhAFxAk/p1kOT8FW31W6ICzsSWMnCDCXQDGZ
         6vZvulc27U1XsjTOEFMbUHdVZwy4lmaIVqzXWJRvY+FnydO2nDh+wKduZoM3XpivmMgi
         HUN+I0sR9S+PQVlVUvkEnoT5ePbYu+fr49heP8/JRDXATZGShOLYaVgzBeUIsLwscS9Q
         mkD0HrchUjIfkqQN/YFkyP3GNMP8GHk46wIB/hiqYUCV2LQaBghzXVw0BUEXUm3JGzXt
         7r0gUbZCbh6I/qkge4m7rpxy6Iyk/VOko+uLA7wNwO0zHFXDNr6V4SXOiyMVbydtay+m
         E1vQ==
X-Gm-Message-State: AJIora8T0vx+538puUQ/y5Hk2b+lYsurYmCr7sBWNIk68V4QHEq7z/CS
        qxeIfQ7HHUy0wWts7X0+T/q45n+LQpn2Gw==
X-Google-Smtp-Source: AGRyM1sWa7HefvnkKKQzG9G2VSN88Cxs1/5oGY4rJYmI3Lxi2dMEHUKc164HUYi4GYTJLz5YC7xVfg==
X-Received: by 2002:a05:6214:20cf:b0:470:5256:c667 with SMTP id 15-20020a05621420cf00b004705256c667mr13951810qve.43.1656615659049;
        Thu, 30 Jun 2022 12:00:59 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id c24-20020ac853d8000000b003171a5dc474sm13117261qtq.23.2022.06.30.12.00.58
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:00:58 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31772f8495fso2608277b3.4
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:00:58 -0700 (PDT)
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr11920163ywb.316.1656615657800; Thu, 30
 Jun 2022 12:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-3-deller@gmx.de>
In-Reply-To: <20220629200024.187187-3-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 21:00:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJRBywf+h_u1jgA6X7hLSByDDwSkskff47a0BHfd93iA@mail.gmail.com>
Message-ID: <CAMuHMdXJRBywf+h_u1jgA6X7hLSByDDwSkskff47a0BHfd93iA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fbcon: Fix up user-provided virtual screen size
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> The virtual screen size can't be smaller than the physical screen size.
> Based on the general rule that we round up user-provided input if
> neccessary, adjust the virtual screen size as well if needed.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Thanks for your patch!

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1106,6 +1106,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>                         return -EFAULT;
>                 console_lock();
>                 lock_fb_info(info);
> +               /* adjust virtual screen size if user missed it */
> +               if (var.xres_virtual < var.xres)
> +                       var.xres_virtual = var.xres;
> +               if (var.yres_virtual < var.yres)
> +                       var.yres_virtual = var.yres;
>                 ret = fb_set_var(info, &var);
>                 if (!ret)
>                         fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);

Given "[PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in
fb_set_var", I don't think we need this patch.  Moreover, this
patch will prevent triggering the WARN_ON()s in [PATCH 4/5] in the
most common buggy case of drivers plainly ignoring var.[xy]res_virtual.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

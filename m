Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6629CC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Oct 2021 08:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9860E78
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Oct 2021 08:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJ1IHk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:07:40 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:40614 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1IHj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Oct 2021 04:07:39 -0400
Received: by mail-ua1-f51.google.com with SMTP id e2so9924732uax.7;
        Thu, 28 Oct 2021 01:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hX6YWh2Qu9VP/L6RLPs/omkiX7ZNKmtW4SWOeHX3y0=;
        b=0D452tJFovFsb28l7v8CzT1Pao9gaPuuh8ggUyZSvjyNtzhi6qYGi3DWYDq6ag5Lh9
         Ibwehkvvj+Wiie9e8TX474wlJAk29NT7gMLJTQvgzc5tzO6lDx3YsE5Y6Pn4gK7mrkY2
         pngMokbYHJhR/p1hwDWOzXQvDAW+YAOD5EGnBRwHc84r8iGFrO8Z2U5BxeEVK/A7EjvL
         G7KVzFONOH/kTbf+ZSAW+1Z05FVZJJ/EwSfm/9c0e9zeJS7FyoOYuiBvUbcmmlZTVW45
         x9Y4kCcbo4RKzTlAvopz5t7p7DdNVm92Sy+z21i3Y8TNNOLmNggDLt1BPVK9qNHXkuQy
         xQTQ==
X-Gm-Message-State: AOAM532odL91nfi74V7Yrb+wKmu7EQ4G09Kt0fI+7w0nyUcrXRmQotPg
        68AJqHtWFx7Jg6tgJlzvKkme6lMnjHIgng==
X-Google-Smtp-Source: ABdhPJzYFmsfJReHY44qrah1tHIFTN2DVuIo0LlSaq/kJvzBBBL4aIlGSolsvPNWRT1xnCKBmUmWbA==
X-Received: by 2002:a67:2c95:: with SMTP id s143mr2916623vss.0.1635408312403;
        Thu, 28 Oct 2021 01:05:12 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id y25sm343891vkb.42.2021.10.28.01.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 01:05:12 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id h133so2564703vke.10;
        Thu, 28 Oct 2021 01:05:11 -0700 (PDT)
X-Received: by 2002:a1f:1604:: with SMTP id 4mr2695337vkw.11.1635408311641;
 Thu, 28 Oct 2021 01:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <1635366613-22507-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1635366613-22507-1-git-send-email-george.kennedy@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Oct 2021 10:05:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXcO1K7da=4Ck2X0Rc_pfaM32dDKf0EfdDXNG0HL18h5Q@mail.gmail.com>
Message-ID: <CAMuHMdXcO1K7da=4Ck2X0Rc_pfaM32dDKf0EfdDXNG0HL18h5Q@mail.gmail.com>
Subject: Re: [PATCH v2] video: fbdev: cirrusfb: check pixclock to avoid divide
 by zero
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 27, 2021 at 10:32 PM George Kennedy
<george.kennedy@oracle.com> wrote:
> Do a sanity check on pixclock value to avoid divide by zero.
>
> If the pixclock value is zero, the cirrusfb driver will round up
> pixclock to get the derived frequency as close to maxclock as
> possible.
>
> Syzkaller reported a divide error in cirrusfb_check_pixclock.
>
> divide error: 0000 [#1] SMP KASAN PTI
> CPU: 0 PID: 14938 Comm: cirrusfb_test Not tainted 5.15.0-rc6 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2
> RIP: 0010:cirrusfb_check_var+0x6f1/0x1260
>
> Call Trace:
>  fb_set_var+0x398/0xf90
>  do_fb_ioctl+0x4b8/0x6f0
>  fb_ioctl+0xeb/0x130
>  __x64_sys_ioctl+0x19d/0x220
>  do_syscall_64+0x3a/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

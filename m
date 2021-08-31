Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A2C432BE
	for <linux-fbdev@archiver.kernel.org>; Tue, 31 Aug 2021 06:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD1360F9E
	for <linux-fbdev@archiver.kernel.org>; Tue, 31 Aug 2021 06:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhHaGuB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:50:01 -0400
Received: from mail-vk1-f180.google.com ([209.85.221.180]:42842 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhHaGuB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 31 Aug 2021 02:50:01 -0400
Received: by mail-vk1-f180.google.com with SMTP id bb10so5105585vkb.9;
        Mon, 30 Aug 2021 23:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKUmgc5HsRuZ5PLjImhWvj4wVvW9mMCLXiQ/PKtOxMo=;
        b=KpS2VdhsCdqgIax/sJ2jO9WvhcklQPDNebR/JT0JnFDCyOIfXVDJv+T6CxZIfU0KSg
         TzQCb3BovhK6KggZIvwCSQD29BO467ovqtNZLr8dcFxawegy1dUBLvGX/PpdfnrSDTTE
         4w+BsQCBcMH2GisUY+9CoSGMrFCWmqCP3iQf+A196NQ3QhguKIZO9rn9tvxXAd9jzdHK
         NTBBX8KJ/xfjuebbrqW+XAI8diSn5Mo0P7jpTS4x7HXW0B50n4BIkDSvIH2e2e3xbnRH
         S7dKPiWRg6zxECIb1i+drt7Dh6mP6NHnyhgPglslBwUy6ljGY2aS55zI8zZygssZfPZF
         OVeA==
X-Gm-Message-State: AOAM533WOFJXkRFDc82W3hm1VMn4qGxk36v5S+jyTcl1t23Ehd4zUD5a
        Db+Z7ohitMjoUnrf64ncmbO6/vOumCc4PhqyzWo=
X-Google-Smtp-Source: ABdhPJzEoZFw11dTEebUr/ZL3MQASD4gZXPDPDil0jflTrPULArVww18ZayyTQn/pA0/lqVcrURes38hVPnfukRK4Xc=
X-Received: by 2002:a1f:738f:: with SMTP id o137mr16613429vkc.2.1630392546165;
 Mon, 30 Aug 2021 23:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <339bfb21-8e80-c7d9-46dd-c416f87c50c0@infradead.org> <535e404d-03bf-8e7a-b296-132a2a98c599@i-love.sakura.ne.jp>
In-Reply-To: <535e404d-03bf-8e7a-b296-132a2a98c599@i-love.sakura.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Aug 2021 08:48:53 +0200
Message-ID: <CAMuHMdWX7s63X_zR9329canbQkPGBVxZNG4O+_=jUut60aGR9g@mail.gmail.com>
Subject: Re: [PATCH] fbmem: don't allow too huge resolutions
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Tetsuo,

Thanks for your patch!

On Mon, Aug 30, 2021 at 6:05 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> syzbot is reporting page fault at vga16fb_fillrect() [1], for
> vga16fb_check_var() is failing to detect multiplication overflow.
>
>   if (vxres * vyres > maxmem) {
>     vyres = maxmem / vxres;
>     if (vyres < yres)
>       return -ENOMEM;
>   }

IMHO that should be fixed in vga16fb, too.

> Since no module would accept too huge resolutions where multiplication
> overflow happens, let's reject in the common path.
>
> This patch does not use array_size(), for array_size() is allowed to
> return UINT_MAX on 32bits even if overflow did not happen. We want to
> detect only overflow here, for individual module will recheck with more
> strict limits as needed.

Which is IMHO not really an issue, as I believe on 32-bit you cannot
use a very large frame buffer, long before you reach UINT_MAX.

> Link: https://syzkaller.appspot.com/bug?extid=04168c8063cfdde1db5e [1]
> Reported-by: syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>
> Debugged-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>
> ---
>  drivers/video/fbdev/core/fbmem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 1c855145711b..9f5075dc2345 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1008,6 +1008,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>         if (var->xres < 8 || var->yres < 8)
>                 return -EINVAL;
>
> +       /* Don't allow u32 * u32 to overflow. */
> +       if ((u64) var->xres * var->yres > UINT_MAX ||
> +           (u64) var->xres_virtual * var->yres_virtual > UINT_MAX)
> +               return -EINVAL;
> +

I think it would still be better to use check_mul_overflow(), as that
makes it clear and explicit what is being done, even without a comment.

Furthermore, this restricts the virtual frame buffer size on 64-bit,
too, while graphics cards can have much more than 4 GiB of RAM.

>         ret = info->fbops->fb_check_var(var, info);
>
>         if (ret)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

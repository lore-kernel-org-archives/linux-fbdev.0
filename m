Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7CAC4320A
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Sep 2021 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D0A610E6
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Sep 2021 13:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhIBNQf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:16:35 -0400
Received: from mail-vk1-f171.google.com ([209.85.221.171]:45908 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbhIBNQe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 2 Sep 2021 09:16:34 -0400
Received: by mail-vk1-f171.google.com with SMTP id h13so597331vkc.12;
        Thu, 02 Sep 2021 06:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97U7yjyC9u7K560fHPV0AzvZLQ1JtD7v4r1SnsrSUGw=;
        b=G1yN86/PcmtMQIxqQ1SH2PVic7yweUn0FPrNVmeWWsAciPys7w0TUzFviD/Ri7wcqV
         Z+TbkBnbDtQy6aqtYGYvKtrkJkLSkKJd9AdHOfllZUPI2IAv7OVUv0BLyvn/s4gkQtVp
         8IrXMccbmMKDwv/O6IbbbgPLcMNA4heUM6gEAXVvTpTzlm9B+vWrhE5cl9LcfCDZ28fW
         VegICkSHE0W69va4CDOX8ko9h6y6bFfi02rxrAOw1TddEKOaL8tXAElAkhERycWa5/jH
         jv16G1xjuX2+oTdh/u1u6LKq//YFBYJT9C7VVoWYW6ouMXUezC+voNgxHJuG5VigGgu7
         cmQQ==
X-Gm-Message-State: AOAM532Ehp08nCAqKsx9on35GKU20SviDeFVeGuopBBSzrNoRgaCRzXD
        JJj8UwalYe0L5QzUwQGkL258s3VO4cAj0ke97+Y=
X-Google-Smtp-Source: ABdhPJyQfNHd8eekTjjRF+Djs44a/sSv6U+YNBayDddfjAvJLpLh7J03k+WxXm3fVzYEOjiv/xorOOUMd/FOKfZUqC4=
X-Received: by 2002:a1f:bd0a:: with SMTP id n10mr1537493vkf.5.1630588535725;
 Thu, 02 Sep 2021 06:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210902060213.1702544-1-mudongliangabcd@gmail.com>
In-Reply-To: <20210902060213.1702544-1-mudongliangabcd@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Sep 2021 15:15:24 +0200
Message-ID: <CAMuHMdVPUMGZ7Sq2rBgr+US0H3ZF4WVkfPPnKQD1cMg5Wd0+-w@mail.gmail.com>
Subject: Re: [PATCH 4.19] fbmem: add margin check to fb_check_caps()
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        George Kennedy <george.kennedy@oracle.com>,
        syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Dongliang,

On Thu, Sep 2, 2021 at 8:04 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> [ Upstream commit a49145acfb975d921464b84fe00279f99827d816 ]

Oops, looks like I missed when that one was submitted for review...

> A fb_ioctl() FBIOPUT_VSCREENINFO call with invalid xres setting
> or yres setting in struct fb_var_screeninfo will result in a
> KASAN: vmalloc-out-of-bounds failure in bitfill_aligned() as
> the margins are being cleared. The margins are cleared in
> chunks and if the xres setting or yres setting is a value of
> zero upto the chunk size, the failure will occur.
>
> Add a margin check to validate xres and yres settings.

Shouldn't (the caller of) bitfill_aligned() be fixed instead?
Can this be triggered by e.g. using the mini_4x6 font?

> Note that, this patch needs special handling to backport it to linux
> kernel 4.19, 4.14, 4.9, 4.4.
>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> Reported-by: syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Dhaval Giani <dhaval.giani@oracle.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/1594149963-13801-1-git-send-email-george.kennedy@oracle.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/video/fbdev/core/fbmem.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 84845275dbef..de04c097d67c 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -991,6 +991,10 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>                         goto done;
>                 }
>
> +               /* bitfill_aligned() assumes that it's at least 8x8 */
> +               if (var->xres < 8 || var->yres < 8)
> +                       return -EINVAL;

Are you sure there don't exist such small displays (e.g. OLED)?

> +
>                 ret = info->fbops->fb_check_var(var, info);
>
>                 if (ret)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

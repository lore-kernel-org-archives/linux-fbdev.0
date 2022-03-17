Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD177C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Mar 2022 07:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiCQHs4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Mar 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCQHsz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Mar 2022 03:48:55 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AABC12E7
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 00:47:39 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id r1so3628499qvr.12
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 00:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q83mXmOYdFBsuZJvBaUcgIbjkShWpffcywKnXCVB7/E=;
        b=Iub7PyAfxdrb25YJrGoYht11P8ENUqWEkwyTzzkO2+GDzNhYJQFblvhKmX4R8ZVawO
         hGaOyKXutoBV6ZwZ9yjKMQn7KYA3II012v6+6ExbvpR5c0bM/kb9noKr5WlozHCXpd0C
         Zt95OB7XfrpO+wZlgBGQ8tUudqBAQkNiyBE5UM3cC0l7mjVvBLisxJ+8pYRbCKcvWcfi
         ljISWlQwq8yNwtAgK+m+E0AZTGbs9xMylMsrSFUo70RQSVpfAndDSyGUh3ipGSJPieYi
         79EhQ8gADbG21ufoUZwKD/J1kq+rj8GSMpMJJ6dRxB9lQooGjhA4O/Wlo8Ixoz/wC72d
         w83w==
X-Gm-Message-State: AOAM532f3GUFbwMr96XHUfd4OyITJcNC9tSnA75YjBvrgHJoDYS2jmFN
        US7kPE6HOQ2Ab1D0W+vtugcRVNOPL7z8mQ==
X-Google-Smtp-Source: ABdhPJwg2r8drRsPznknx9g52vH/3fOTj6Bc0sI7NmNRZ+iTE6zRQTwtYvUrXfPWZOxrbkVNTMDH1A==
X-Received: by 2002:a05:6214:ac1:b0:435:3d5e:5ba9 with SMTP id g1-20020a0562140ac100b004353d5e5ba9mr2606782qvi.80.1647503258917;
        Thu, 17 Mar 2022 00:47:38 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id d13-20020a05622a15cd00b002e1df990d01sm3115402qty.71.2022.03.17.00.47.37
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 00:47:38 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id l2so8688383ybe.8
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 00:47:37 -0700 (PDT)
X-Received: by 2002:a25:aa0e:0:b0:633:7c3b:94a0 with SMTP id
 s14-20020a25aa0e000000b006337c3b94a0mr4045552ybi.546.1647503257248; Thu, 17
 Mar 2022 00:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220317054602.28846-1-chuansheng.liu@intel.com>
In-Reply-To: <20220317054602.28846-1-chuansheng.liu@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Mar 2022 08:47:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWH83xCn-OUmBArM-H0AG20CzzqmAsb5MFU9ufqFZQArA@mail.gmail.com>
Message-ID: <CAMuHMdWH83xCn-OUmBArM-H0AG20CzzqmAsb5MFU9ufqFZQArA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: defio: fix the pagelist corruption
To:     Chuansheng Liu <chuansheng.liu@intel.com>
Cc:     jayalk@intworks.biz, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Chuansheng,

On Thu, Mar 17, 2022 at 7:17 AM Chuansheng Liu <chuansheng.liu@intel.com> wrote:
> Easily hit the below list corruption:
> ==
> list_add corruption. prev->next should be next (ffffffffc0ceb090), but
> was ffffec604507edc8. (prev=ffffec604507edc8).
> WARNING: CPU: 65 PID: 3959 at lib/list_debug.c:26
> __list_add_valid+0x53/0x80
> CPU: 65 PID: 3959 Comm: fbdev Tainted: G     U
> RIP: 0010:__list_add_valid+0x53/0x80
> Call Trace:
>  <TASK>
>  fb_deferred_io_mkwrite+0xea/0x150
>  do_page_mkwrite+0x57/0xc0
>  do_wp_page+0x278/0x2f0
>  __handle_mm_fault+0xdc2/0x1590
>  handle_mm_fault+0xdd/0x2c0
>  do_user_addr_fault+0x1d3/0x650
>  exc_page_fault+0x77/0x180
>  ? asm_exc_page_fault+0x8/0x30
>  asm_exc_page_fault+0x1e/0x30
> RIP: 0033:0x7fd98fc8fad1
> ==
>
> Figure out the race happens when one process is adding &page->lru into
> the pagelist tail in fb_deferred_io_mkwrite(), another process is
> re-initializing the same &page->lru in fb_deferred_io_fault(), which is
> not protected by the lock.
>
> This fix is to init all the page lists one time during initialization,
> it not only fixes the list corruption, but also avoids INIT_LIST_HEAD()
> redundantly.
>
> Fixes: 105a940416fc ("fbdev/defio: Early-out if page is already
> enlisted")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>

Thanks for your patch!

> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -220,6 +219,8 @@ static void fb_deferred_io_work(struct work_struct *work)
>  void fb_deferred_io_init(struct fb_info *info)
>  {
>         struct fb_deferred_io *fbdefio = info->fbdefio;
> +       struct page *page;
> +       int i;

unsigned int i;

>         BUG_ON(!fbdefio);
>         mutex_init(&fbdefio->lock);
> @@ -227,6 +228,12 @@ void fb_deferred_io_init(struct fb_info *info)
>         INIT_LIST_HEAD(&fbdefio->pagelist);
>         if (fbdefio->delay == 0) /* set a default of 1 s */
>                 fbdefio->delay = HZ;
> +
> +       /* initialize all the page lists one time */
> +       for (i = 0; i < info->fix.smem_len; i += PAGE_SIZE) {
> +               page = fb_deferred_io_page(info, i);
> +               INIT_LIST_HEAD(&page->lru);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(fb_deferred_io_init);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

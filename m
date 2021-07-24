Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B487C4338F
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 18:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C19160E8F
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 18:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGXRVd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 13:21:33 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:46858 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGXRVd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 13:21:33 -0400
Received: by mail-vk1-f169.google.com with SMTP id d15so1101977vka.13;
        Sat, 24 Jul 2021 11:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFAXOYswwIGflCWWx9fpDZl57pj1QpRpAZ3Zwc4ZdWQ=;
        b=Eha/FENPwERCrkFNm34VQWOYwJD2ocYFpOgpbmoP2qv+R8V8d7GZQ9cvcNTmeQ2lSC
         BpL/2UaOHfM7L8AWLVrklPLU6T1PO0HY4leB24zTfvLwXDYwBqlV9EZ5VPs9HyHhU0y1
         859bGVHlDRYM4xJccrqLwy6Iffig/Wx9D45oAgIVVrHyiZK3gj1DbkKYPlsJT9Sinz85
         K5h9G7IPW0+CQslttwVCLYeyWYxxEoF4xW0ll/4WeXBW7C3vxgCd60ldNZ6UHMtKyJoD
         bz7qNEfwjiW7YennwNtiU4OTFFDL5rRYnpgsSte+OSCQwkfzc81Ejhcif5obHLQacDeZ
         eejQ==
X-Gm-Message-State: AOAM5332GLC3lsfDFOsUSPeSsbYoktABzH444FWOb4Gdhgeor3NEbeAl
        8MeJYmMLOtmP43Bt32gLxvPRKREC59uwBHOirZ2ek0nFWaA=
X-Google-Smtp-Source: ABdhPJznGi7hzvA1p2VsWdfv9lBV4MVLJwhvR4BKSFCYB+5JUdtBAWgTUa81Xuz+HTQ+Zc8W97HV8XtBugNdFeb48jQ=
X-Received: by 2002:a05:6122:a12:: with SMTP id 18mr7348420vkn.1.1627149724368;
 Sat, 24 Jul 2021 11:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210724151411.9531-1-len.baker@gmx.com> <20210724151411.9531-4-len.baker@gmx.com>
In-Reply-To: <20210724151411.9531-4-len.baker@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 24 Jul 2021 20:01:53 +0200
Message-ID: <CAMuHMdX6PUr0irndogg=Aa+AFDdiDJMeMWM74mLBkuLrW+zWng@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] staging/fbtft: Fix braces coding style
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Len,

On Sat, Jul 24, 2021 at 7:44 PM Len Baker <len.baker@gmx.com> wrote:
> Add braces to the "for" loop and remove braces from the "if" statement.
> This way the kernel coding style is followed.
>
> Signed-off-by: Len Baker <len.baker@gmx.com>

Thanks for your patch!

> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c

> @@ -1016,10 +1018,9 @@ int fbtft_init_display(struct fbtft_par *par)
>
>         i = 0;
>         while (i < FBTFT_MAX_INIT_SEQUENCE) {
> -               if (par->init_sequence[i] == -3) {
> -                       /* done */
> -                       return 0;
> -               }

These braces should not be removed, due to the presence of
the comment.

> +               if (par->init_sequence[i] == -3)
> +                       return 0; /* done */
> +
>                 if (par->init_sequence[i] >= 0) {
>                         dev_err(par->info->device,
>                                 "missing delimiter at position %d\n", i);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

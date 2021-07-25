Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E08C4338F
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 18:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DD560F13
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 18:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhGYSLZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 25 Jul 2021 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhGYSLZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 25 Jul 2021 14:11:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE4BC061757;
        Sun, 25 Jul 2021 11:51:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k1so8907723plt.12;
        Sun, 25 Jul 2021 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qirs+iLZFGRKsz/ZopqRyNng3+a0VdaNoIeySOmoJBs=;
        b=ryQJ486SrysdfwQYYY2pSFz6x9WPYf3me6zDgsy0m4p2aDx7AsvFubmhNxrWI+j4mv
         nsvVtOQpACYSIKSnrUTMMMUUQdp3SgVsYl0TD7ExOXYMOl9F27ZE/bAU4iYLTFdlttbM
         mgCsWVFzt5OIJaGyyWvVlaXnqOtUUQ3nC2OVhZV1MZ77YP7msKpmtmRPj9vV2BXO76Wu
         DeRSI5ITm7mYKMjdHyrm4wxysMYOQwP9EkFdubOY8tc52aVAyjbKLgzmaoChdQBcBiij
         VHm02K4+SLwTlRDCumkBT32LVccoGk37flJDSBLtEmBt5OrWlE4gDEz5t7dxqImxSUYj
         ZVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qirs+iLZFGRKsz/ZopqRyNng3+a0VdaNoIeySOmoJBs=;
        b=n4D0gmo2T5CESr+dmd2SLKtoxl6Cpccc6vYcxLJ6kUmq35t2RuKqpWYap3H9bzvnU6
         71sz6xzkobxNR5bXrbQKfeNKSDW2mnr4T4fWt8G4OgLRGtNvZbxeTP5KwE7soywXgH0b
         HCpXUWwO8mj0ZlYQ9UGm2kRruWG2xHC61fCxmeVPcne+RfHc6t0pYkf1JgnlHKVb7sI4
         0d6WVyoLKv96MqAZobh5KvrY38RU8yuFd0E+huyJoeH0JRLOUg1Txypd+tmVS+YgVJxC
         SQumXurNNeGjCNUVBcBvM/6OBFTcCy9BkcKnW7iVuieWN90df9POy89MjlfIb8AeOKsK
         gZNg==
X-Gm-Message-State: AOAM531vQWAqE9h2ICb46ZBFSnXEbNFN2FZ20h0mux08GDSAsyqX5MEN
        FmhoJp2fMOQMtSFrj5u/6LflxZhZ8slz5De+1jY=
X-Google-Smtp-Source: ABdhPJxHwipVJbJmzeHfWz64SwkxLZVfnnCGACfafL10iji3Cc/k3Num3SbdXCt9DRUt1CVwHIbCU+9rEVCNd+x0eNo=
X-Received: by 2002:a63:d014:: with SMTP id z20mr14700708pgf.203.1627239114212;
 Sun, 25 Jul 2021 11:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210724151411.9531-1-len.baker@gmx.com> <20210724151411.9531-2-len.baker@gmx.com>
 <CAHp75Vd+ZM_yO6CU_6oJieePMt00Sp6oKEU2+QEyZxLDg5PN8A@mail.gmail.com> <20210725135844.GA1953@titan>
In-Reply-To: <20210725135844.GA1953@titan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 25 Jul 2021 21:51:18 +0300
Message-ID: <CAHp75Vd=_qgnaLpAq+=Awf+ggUf9DEm0amNyTE0KkYThxtP=WQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] staging/fbtft: Remove all strcpy() uses
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jul 25, 2021 at 4:59 PM Len Baker <len.baker@gmx.com> wrote:
> On Sat, Jul 24, 2021 at 11:21:04PM +0300, Andy Shevchenko wrote:
> > On Sat, Jul 24, 2021 at 7:05 PM Len Baker <len.baker@gmx.com> wrote:

...

> > > -       char msg[128];
> >
> > 128 / 4 = 32. So, this buffer is enough to debug print only up to 32
> > bytes. Hence %*ph replacement won't cut output earlier than requested.
>
> I'm sorry, but I don't understand what you are trying to explain. Moreover,
> with the "0x%02X " in the sprintf followed by the strcat, the msg buffer can
> print 128/5 values (25 hex values).
>
> The %*ph replacement can print up to 64 bytes, so I don't see any problem
> here.

Right. That's what I am trying to say and the hint here is to combine
this part into a phrase in the commit message in the next version of
the patch.

...

> > > +                       for (j = i + 1; par->init_sequence[j] >= 0; j++);
> >
> > Why is i + 1 initial for the j? You may rather access the 'i + 1 +
> > j'th element in the array...
> >
> > ...
> >
> > > +                                     par->init_sequence[i], j - i - 1,
> >
> > ...and get rid of the ' - i -1' part here.
>
> Yes, it was the first idea but I prefer this method since we save aritmethic
> operations. In other words, if I use what you suggest, the index for
> par->init_sequence is calculated as a "sum" every iteration. But if the
> performance is not an issue and you believe that the above is more clear, I
> have no problem. What do you prefer?

I prefer my variant and I believe the compilers nowadays are clever
enough to understand this. Have you tried to compile and compare the
real assembly?

-- 
With Best Regards,
Andy Shevchenko

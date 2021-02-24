Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A646BC433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 12:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402B164EC3
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 12:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhBXMZb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Feb 2021 07:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBXMZb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Feb 2021 07:25:31 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF8C061574;
        Wed, 24 Feb 2021 04:24:51 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id f6so1752048iop.11;
        Wed, 24 Feb 2021 04:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lEheRsNzM6A5FEWZatOgOB06QRFT+dQp09C3//0tehA=;
        b=K9gUQlO70bOvYAFnPmmIzKwJHE9HGNz+lWqbfQIlQWkzlGyzkx7MbH3/LFlirAIr/X
         bpG20WropIRA8MpivD+QF/avfmwtisGDteD02UJS2MzfMZfRxAOSmJ5d85g3g3lcc2DI
         lTRl3R/CfKUm8OgtY2NSlGLYGds6Qu3110gfGsnrwdZP4D/dpwF2foK1/9vGs6/vDdPy
         uKfLjvJPUNxFU8rSREBxjw+D+hmqExmky5mWO9qp1woaR3TUU+pWzINCPzo3IqRhqzqC
         LI4bNUUAPtNF14cAvcHoBVsc+uJu8NTHu43jGeR1f2W2QVLJUK7pQ7Z8DIrJtiTy5pwu
         fnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEheRsNzM6A5FEWZatOgOB06QRFT+dQp09C3//0tehA=;
        b=cX0WcNF2T9PM3e6kbj0yVQJIlvJEZsCyRjhXK5E1/CJ5q02QRTYRzO4khbvyvbzjBV
         84SaFrODW9i8mB1wLhCwdxt6akPVcFHJ7gn3SxrgFtJTaqq+MiUagH3ZIuIjazZRbdyE
         jjwAfg7C4rXdXUy1GH0TrNfVXSaFbpqZIKLxhXmn46Fu7j0RvQw7zYRGRUZMP+o0rT0+
         3CwNhtrJ6PKMnlx7kCn+iOIrdAw0D0SVfXp6ADIoadiab/2VPn6sLBIK/HIStuCckA+l
         3lCoAtmwLZn+oSMovkBpzA3V1KVi74/uKJp2zPUvrOKszKslqPMm7Y9tX3w4+L4/lJfe
         IWxQ==
X-Gm-Message-State: AOAM533Ih2hly+g4bmL/lcGjlTj3j6spJVv9UKz7kwhX9CfCHa1CSAjX
        u43SWqE1+5YqwaxGkpjj06KqKU0C8mvwb8nQRpM=
X-Google-Smtp-Source: ABdhPJw1YoO4n1Zvk2QmR2jR1rnYahYdNc8+KYgpVxIiue3tnwfavAneBeKh7jJvbI//p38rQ99AqrfKhDFd8tvLPg0=
X-Received: by 2002:a6b:5818:: with SMTP id m24mr2267566iob.144.1614169490732;
 Wed, 24 Feb 2021 04:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20210220230248.320870-1-ztong0001@gmail.com> <ea1c5ff3-0b24-71c9-7a44-08b184c4854d@infradead.org>
 <CAA5qM4D0y9-gL7AAMQvtwrfJC_UvSTB5_S5PX3qkYSxHRUS-Qw@mail.gmail.com> <CAMuHMdWM5z-vKRwhCgJHjU-S_L0WR=avmDN-b8dN87b=rgi08w@mail.gmail.com>
In-Reply-To: <CAMuHMdWM5z-vKRwhCgJHjU-S_L0WR=avmDN-b8dN87b=rgi08w@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 24 Feb 2021 07:24:40 -0500
Message-ID: <CAA5qM4B1R4cA6=sDhWaVo59A=0WWR_wv5Ckp1O8giv7+pUuqRQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: pm2fb: avoid stall on fb_sync
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Geert,
IMHO - QEMU is irrelevant here. since I can do passthrough --
in fact -- many drivers do use timeout in .fb_sync
e.g. i810fb_sync(), nouveau_fbcon_sync(), sm501fb_sync() etc..
I believe the correct behaviour should be a timeout wait instead of
waiting indefinitely.
- Tong

On Wed, Feb 24, 2021 at 6:35 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Tong,
>
> On Sun, Feb 21, 2021 at 1:05 AM Tong Zhang <ztong0001@gmail.com> wrote:
> > On Sat, Feb 20, 2021 at 6:33 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 2/20/21 3:02 PM, Tong Zhang wrote:
> > > > pm2fb_sync is called when doing /dev/fb read or write.
> > > > The original pm2fb_sync wait indefinitely on hardware flags which can
> > > > possibly stall kernel and make everything unresponsive.
> > > > Instead of waiting indefinitely, we can timeout to give user a chance to
> > > > get back control.
> > >
> > > Is this a real problem or theoretical?
> > > Does someone still use this driver?
> >
> > I currently have this problem on my machine.
> > I have submitted a revised patch -- which includes the console log.
>
> Your machine is "QEMU Standard"?
> Can this happen on real hardware, too, or is this a deficiency in QEMU,
> which should be fixed there?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

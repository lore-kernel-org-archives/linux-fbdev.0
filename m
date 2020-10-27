Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B260C55178
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A759C20724
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 18:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MygqLEYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775983AbgJ0ShJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:37:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43396 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759354AbgJ0ShJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 14:37:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id x203so2299846oia.10
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2020 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgE8yf8VvPCLXY3kXPndgQiUgJhhV1XD/7Oo36pvGbU=;
        b=MygqLEYK5L/J+eMI396OafToclJIM8p9jDuPmPtJd7fAX+/4M5rpvwarc0itBKpmzs
         /bw5UPnSDfKCpmC9FP4VwDlk8Udr76hnDLOjvfhGFsddQfip47U2C4Ynt/vbfjdGuZjm
         GjYxNRv+DOxPE603nQ/5mwrW8dV+DBlUfcTRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgE8yf8VvPCLXY3kXPndgQiUgJhhV1XD/7Oo36pvGbU=;
        b=Lo1mLmyNrxEHw9NWPkVkuq/H0ZwbgLRg0pKHGu4DmI5UQoC/bvO900JGyL2wB7JZUn
         SD0NIce5zQtcjhN38gd9KBqSikMv35yADaHwXLbybf93YU0Tgpf/zT76wA+YgKR4VZvS
         QCRB1RbZh8iOQ10xQt/zAx4wcNv+j9TnmJ0RdTQVmpOf0NICrN4rq/bqOWGJwgl5V+X1
         HrSZ1lMwuFl37tN66zLdThEcU4LRXQo6AYxSyIPyv3zn4NeIAmwbTj95tKVGjRL+o923
         Axgv0H8jpPqqT5mIthHJ2L+tUOm2z0u/4wOnO5sEJyk9ZzYvVOO8+D7PXI1gaGzZ493a
         m1Vw==
X-Gm-Message-State: AOAM53184biSWgnBu0rG5LpdW2eO4h4/1jYEJ/SN8UK90ARWb2XaoQxZ
        5IRLUUgJMqbhZMVu8L97F4DVQDMvaFM78sjJdOpH8A==
X-Google-Smtp-Source: ABdhPJyicyC6gqjrwubRETzltc2wCSn7+EzSAF6sd19doLxVKlafgjjX+Xfkx+kdBYozc4TF6IgWRQLAD81gssswQiA=
X-Received: by 2002:aca:cc01:: with SMTP id c1mr2475031oig.128.1603823826322;
 Tue, 27 Oct 2020 11:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603788511.git.yepeilin.cs@gmail.com> <20201027165021.GA1178130@PWN>
In-Reply-To: <20201027165021.GA1178130@PWN>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 27 Oct 2020 19:36:54 +0100
Message-ID: <CAKMK7uH9L9WHBndEnUhAMMh0KsKUcz2zfKdi250gVqJGEG6usQ@mail.gmail.com>
Subject: Re: Following up
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 27, 2020 at 5:50 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> Hi Daniel,
>
> More about the 3 things we've discussed before:
>
>   1. Cleaning up con_font_op():
>
> (drivers/tty/vt/vt.c)
> int con_font_op(struct vc_data *vc, struct console_font_op *op)
> {
>         switch (op->op) {
>         case KD_FONT_OP_SET:
>                 return con_font_set(vc, op);
>         case KD_FONT_OP_GET:
>                 return con_font_get(vc, op);
>         case KD_FONT_OP_SET_DEFAULT:
>                 return con_font_default(vc, op);
>         case KD_FONT_OP_COPY:
>                 return con_font_copy(vc, op);
>         }
>         return -ENOSYS;
> }
>
> On Tue, Sep 29, 2020 at 04:38:49PM +0200, Daniel Vetter wrote:
> > I think if we change the conf_font_get/set/default/copy functions to not
> > take the *op struct (which is take pretty arbitrarily from one of the
> > ioctl), but the parameters each needs directly, that would clean up the
> > code a _lot_.
>
>     This is on my TODO list! One day I came up with some idea about
>     fbcon.c, so I postponed this a bit...
>
>   2. Removing dummy functions, like sisusbdummycon_font_set():
>
>     Turns out, before c396a5bf457f ("console: Expand dummy functions for
>     CFI"), they were just some macros:
>
> -#define SISUSBCONDUMMY (void *)sisusbdummycon_dummy
> +static int sisusbdummycon_font_set(struct vc_data *vc,
> +                                  struct console_font *font,
> +                                  unsigned int flags)
> +{
> +       return 0;
> +}
>
>     ...and they had been there for a very long (10+ years) time. Removing
>     code like this makes me a bit nervous, and...
>
> On Tue, Sep 29, 2020 at 04:38:49PM +0200, Daniel Vetter wrote:
> > This actually does something. tbh I would not be surprises if the
> > fb_set utility is the only thing that uses this - with a bit of code
> > search we could perhaps confirm this, and delete all the other
> > implementations.
>
>     ...you mentioned code search, where & what should we look at, in order
>     to confirm it's safe to remove them?

Way back there was google's code search, which was awesome. Now I just
put the structure name/ioctl #define/number into
google/bing/duckduckgo and see if anything turns up. Plus check how
it's used in fb tools (although I just recently learned that fb-test
pretty much disappeared from the internet, very hard to find the
original).

If you're unsure, we can merge a patch, then wait about 1 year for any
users to show up with problems. If that's not the case, assume they're
all gone, or it was never used and just implemented because it was
copied from somewhere else, or "just in case". There's lots of dead
uapi around.

>   3. Using `font_desc` in `vc_data`:
>
>     Our plan for the gradual conversion was to use a helper function to
>     set font for a vc, but after reviewing the 300-ish occurrence of
>     `vc_font`, it seems like code doesn't usually set it as a whole:
>
> (drivers/usb/misc/sisusbvga/sisusb_con.c)
>         [...]
>         c->vc_font.height = sisusb->current_font_height;
>         [...]
>
>     ...that's it! It only cares about the height. There are only 4 or 5
>     places in fbcon.c that actually set all fields of `vc_font`, like:
>
>                 vc->vc_font.width = font->width;
>                 vc->vc_font.height = font->height;
>                 vc->vc_font.data = (void *)(p->fontdata = font->data);
>                 vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
>
>     To make it even more complicated, `p` is a `struct fbcon_display *`,
>     containing yet another font data pointer (`fontdata`) that I think
>     should be replaced by a `font_desc *`...
>
>     In conclusion, I think it's all about a few hard problems in fbcon.c.
>     I'll keep trying and see how it goes.

Yeah fbcon.c is pretty good horrors unfortunately :-/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

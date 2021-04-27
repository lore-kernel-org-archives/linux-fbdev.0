Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0667C433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Apr 2021 12:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830CF613E2
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Apr 2021 12:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhD0MLQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Apr 2021 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhD0MLP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Apr 2021 08:11:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6711C061574;
        Tue, 27 Apr 2021 05:10:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t22so6941485pgu.0;
        Tue, 27 Apr 2021 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFns5/VsmEuhW6BFWribM/FHEmMkehdcNDcB3HXxuuw=;
        b=HNETH0OLfLiShq7AcW+L88ywPZDO8cU6Y6ThAvLx4MoB+YWrRf4Pq3xMYOjS9nJaXc
         xBlPQl402XFA9l/GEHmI6/aO7otQIMfCwyOr7vmJqqrDEq6txh7URe5y1rslCUt0zxlb
         0wXm1NL3Xfk5BgOArWcqNvWYkI3cXlvm1+02gz0SAOaAH2HtLpUMNYj8MDgci0ReAMzd
         k92/kisjqNKvdGAu8ElYjtP4vzwCT+B5O4oZBfPvw+2NqKWiv/fjvJsiXjm+3o4ng0Ow
         KC9niJ3R00A0lG9mwUg0Y1cX8PXFBgdA10W5FciKCTemu4pRML51RMcREDN1+IIt1fde
         blYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFns5/VsmEuhW6BFWribM/FHEmMkehdcNDcB3HXxuuw=;
        b=AVwVpRLsvG91wRm9SKdBnv8t/jr80/bPYTdzdGcA/NxgR17eMRTow16PFkN4Z0wNgf
         oZ8mUBl2RJbifhKCNgBTw6CAKGjYGpE9rnLOnXsqrDkOOxAP225t/XZjod/c+Wdp80tT
         7FeUD3aStbbQ9BzwJbJIqwLVHu9ck81vAQ0uv7d7egjDLQeN0yszxmPVcTTqP8xG6fHq
         +44z76WA7oe8WmnYjxLXWa8qjHIVmJBs+CGBMHj3JkqQfmzkfMflZ/ob4n8P6pEmDSVn
         oXfXFRNAoaCogOANl4taXpBRhVAW7yJwbdpl2Oir7jLLulP7pz+ttc9IUHtrnXt5yIU+
         SPPA==
X-Gm-Message-State: AOAM531BKilKvxxqj/7Wr4s9lxJkwW/bXn5rlcwcH2b/lLVr/svR5f3g
        tzgNZpKMFCtjDL8VafKKGlLQkK6wzOZKq4Wz9O8=
X-Google-Smtp-Source: ABdhPJzxZgX8TOkf06ULjK9UhatMG6bwCZGoTYAzSH7DAex31IQ5gsrlyM/5e/vVr5Nvm8eb9Y29b5AE65ZU6gtJ7wU=
X-Received: by 2002:a63:a847:: with SMTP id i7mr21248455pgp.203.1619525431391;
 Tue, 27 Apr 2021 05:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com> <YIfwZ/oPVB9splQq@kroah.com>
In-Reply-To: <YIfwZ/oPVB9splQq@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Apr 2021 15:10:14 +0300
Message-ID: <CAHp75VdkPWKVSYmYqerMs=6BpkS81KcL9DnYGL5XbkMm-rrW9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fbtft: Replace custom ->reset() with generic one
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 27, 2021 at 2:09 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Apr 16, 2021 at 05:20:41PM +0300, Andy Shevchenko wrote:
> > The custom ->reset() repeats the generic one, replace it.
> >
> > Note, in newer kernels the context of the function is a sleeping one,
> > it's fine to switch over to the sleeping functions. Keeping the reset
> > line asserted longer than 20 microseconds is also okay, it's an idling
> > state of the hardware.
> >
> > Fixes: b2ebd4be6fa1 ("staging: fbtft: add fb_agm1264k-fl driver")
>
> What does this "fix"?  A bug or just a "it shouldn't have been done this
> way"?

There is nothing to fix actually, it's rather a pointer where this
change has been missed for some reason. I'll remove the tag.

> And as others pointed out, if you could put "staging: fbtft:" as a
> prefix here, that would be much better.

Got it, thanks!

-- 
With Best Regards,
Andy Shevchenko

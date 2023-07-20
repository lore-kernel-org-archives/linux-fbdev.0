Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACCAEB64DD
	for <linux-fbdev@archiver.kernel.org>; Thu, 20 Jul 2023 13:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGTNSm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 20 Jul 2023 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjGTNSk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 20 Jul 2023 09:18:40 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E462E171E
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Jul 2023 06:18:35 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4814505ddbbso357913e0c.0
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Jul 2023 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689859115; x=1690463915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXhM/iBeNWLU9aGvrS5Nh6IgYVixwX5IvTfGDZPWzYY=;
        b=163yDjos2VMpaWmVafqEFlvHJZG8PCITKo7RogtaCcUh9zpuaB4DK9LBaCrebm/gGc
         VxaavcUc2kBkfD0ABfzRPmKlo8P6qjG47A7tptqfa//bgvcIcb2Qk+UWDUQNULOgBYHh
         UErH2wEKUiWEwhtuVnjYLC/RPOA/JwwonTA0525M1zB/qxqjvdG+x3AYcwWSd54fhXkN
         By0XkFkvt+Bj2aDEKD7/njrh06sYLtjzFlN/5XS9GaNMeKKR/UbTX+r3kKxrLnSH91qf
         ezM43dRFOn12zXsgBh+l1D3a/Jd/UAbbiz68hzEptnagof5pBwPnIIrEOUc4XG0pyTRM
         oczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859115; x=1690463915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXhM/iBeNWLU9aGvrS5Nh6IgYVixwX5IvTfGDZPWzYY=;
        b=bkZv+yBtPvQcJfvU5cqox5dDPfaevRdvfLdunDbRJnlCWsYK0GytEzH6wjszhBoAbm
         u9TxgVN8GEmzrm8SH2bUoScGHryEmr9M2EQLnJnO58MyIJCH/iiW1UDdWHuPFX1HDxug
         nsv/TNvufNZmLbsuE7njZcxX+x2mWsk2jF4nuE8yB6kZFOTY5vkxHbolRtXmQYXv7AV2
         +oXqSMjJ0Aeg7P1TNfY+DE6Z9Ydv/HGzUxnDtYMCRrsRsuoh2g73FJcfp1CG6ZCYk5h0
         PQ/qf5dyRB+4mDKzAK4EzHJGhwS9IF++IhvRsVi27DmeZSb3fFsY+1yzU9h/uWT5TMPA
         tbtA==
X-Gm-Message-State: ABy/qLbodBP9F952TyuI+ScxejCkUXW18Aru1rYsp4vnMBNPegwnTE7D
        /ahL6B0fYNXJjn9vTCITg8C+C4SMVY3SpFLCrtifRA==
X-Google-Smtp-Source: APBJJlHJYZlWcBXBplUKlK9oabrw93fYrNUQO8PCZbzhbFqjMOYjQsRksuI/YPb4v8tq0zvev7jN+HdyrB18M5aVFUQ=
X-Received: by 2002:a1f:bd52:0:b0:47e:1a97:20f4 with SMTP id
 n79-20020a1fbd52000000b0047e1a9720f4mr3971038vkf.3.1689859115045; Thu, 20 Jul
 2023 06:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230720061105.154821-1-victor.liu@nxp.com> <20230720112742.GA2525277@aspen.lan>
 <CAMRc=MfbWjWTdU4ToFMp_ZV6eGdRnjD--Y+qsN329TsLFGQYxg@mail.gmail.com> <20230720131029.GB2525277@aspen.lan>
In-Reply-To: <20230720131029.GB2525277@aspen.lan>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 15:18:24 +0200
Message-ID: <CAMRc=MfKN9pmLtyzxO4Fsx_=8XFt-xFQ-HiZfJQOvCgoZ70-dg@mail.gmail.com>
Subject: Re: [PATCH] backlight: gpio_backlight: Drop output gpio direction
 check for initial power state
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Ying Liu <victor.liu@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jul 20, 2023 at 3:10=E2=80=AFPM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Jul 20, 2023 at 02:56:32PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Jul 20, 2023 at 1:27=E2=80=AFPM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Thu, Jul 20, 2023 at 06:06:27AM +0000, Ying Liu wrote:
> > > > Bootloader may leave gpio direction as input and gpio value as logi=
cal low.
> > > > It hints that initial backlight power state should be FB_BLANK_POWE=
RDOWN
> > > > since the gpio value is literally logical low.
> > >
> > > To be honest this probably "hints" that the bootloader simply didn't
> > > consider the backlight at all :-) . I'd rather the patch description
> > > focus on what circumstances lead to the current code making a bad
> > > decision. More like:
> > >
> > >   If the GPIO pin is in the input state but the backlight is currentl=
y
> > >   off due to default pull downs then ...
> > >
> > > > So, let's drop output gpio
> > > > direction check and only check gpio value to set the initial power =
state.
> > >
> > > This check was specifically added by Bartosz so I'd be interested in =
his
> > > opinion of this change (especially since he is now a GPIO maintainer)=
!
> > >
> > > What motivates (or motivated) the need to check the direction rather
> > > than just read that current logic level on the pin?
> > >
> > >
> > > Daniel.
> > > [I'm done but since Bartosz and Linus were not on copy of the origina=
l
> > > thread I've left the rest of the patch below as a convenience ;-) ]
> > >
> >
> > This was done in commit: 706dc68102bc ("backlight: gpio: Explicitly
> > set the direction of the GPIO").
> >
> > Let me quote myself from it:
> > --
> > The GPIO backlight driver currently requests the line 'as is', without
> > actively setting its direction. This can lead to problems: if the line
> > is in input mode by default, we won't be able to drive it later when
> > updating the status and also reading its initial value doesn't make
> > sense for backlight setting.
> > --
>
> You are perhaps quoting the wrong bit here ;-). The currently proposed
> patch leaves the code to put the pin into output mode unmodified. However
> there was an extra line at the bottom of your commit message:
> --
> Also: check the current direction and only read the value if it's output.
> --

Yeah I'm no longer sure why I did this. The commit doesn't look harmful tho=
ugh.

Bart

>
> This was the bit I wanted to check on, since the proposed patch
> literally reverses this!
>
> However...
>
>
> > I agree with Thomas that it's highly unlikely the bootloader "hints"
> > at any specific backlight settings. That being said, the change itself
> > looks correct to me. The other branch of that if will always unblank
> > the backlight if the GPIO is in input mode which may not be desirable.
>
> ... if you're happy the proposed change is OK then I'm happy too!
> I came to the same conclusion after reviewing the GPIO code this morning,
> however I copied you in because I was worried I might have overlooked
> something.
>
>
> > I don't see any obvious problem with this change, just make sure the
> > commit message makes more sense.
>
> Agreed.
>
>
> Daniel.

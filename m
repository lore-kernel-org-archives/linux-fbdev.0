Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8AC2BA4C
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 10:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbiAZKcJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 05:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiAZKcB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 05:32:01 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF044C061748
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 02:31:57 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q186so36616426oih.8
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 02:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PARYSeIeXIRXwXqFcnW3Wz91jHJIg+/6lKoOo1XNXrI=;
        b=I3kUr8qfahBfszwo6LNqD5ZWF9kbC+G+AIHcoBCRezvQYE3SqIfzljpjCVjfIeUbKL
         /hb68PKQhFaCjgZOyHw+gYJ/ei9uM4swYOiN4djukilmM5j6y7WPe4l6XWAgd0gufDNh
         xhsFCpIAtqhF8Nluu4DTHaEsI1zgLKLsFCHtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PARYSeIeXIRXwXqFcnW3Wz91jHJIg+/6lKoOo1XNXrI=;
        b=wWpf2hHRMcahOY//QLvVvvR3X15pzw4mYqv+EW0/sihknGoqaQ8/c6s/RDISKvGN9g
         KujXUAzMCRAE1J6i2fss1CmsN5aIuaGenIL1u5UrSuKxkrjGMZlcjz6mKyAajwSUElV9
         7aI48EZAWeaC1YbrIqY8+PpwBFsfJH3uyAR54np0v4HJdMW+I6uTJAykUnPu561rR9i7
         oapo6SWGxM8uMgOWZ0yU0vrnOLjtXh5KZUP0HifldyTz6Ps3hRxezzjsysp7birj7GfB
         wW3r0xLgEYBCT4tmVcaLWDretaG7PnoGSV+ivCJpTO6JHt69rFquVs4a0kDWngLdBFHx
         UGvQ==
X-Gm-Message-State: AOAM5321TeaVQRflwIMNGhNOzaSEoJ4CAR0VF39PYO2lAlprmjMFd2BF
        ohXU8+SYYUrUEiKjK2K14JswqYiJrnkXXMnOKcIv8Q==
X-Google-Smtp-Source: ABdhPJzjwv/0sLlbLiWvmxRAGel0mMOAKI6UYaYppLOrZDc1WgZAwnk5CLyfI1LGm6q5W5cApZ7TCM6rQd58C8u5svs=
X-Received: by 2002:a05:6808:f03:: with SMTP id m3mr3247262oiw.330.1643193116706;
 Wed, 26 Jan 2022 02:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com> <YfEG2qVO9K9G+g1d@kroah.com>
In-Reply-To: <YfEG2qVO9K9G+g1d@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 26 Jan 2022 11:31:45 +0100
Message-ID: <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 26, 2022 at 9:31 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 25, 2022 at 10:21:14PM +0200, Andy Shevchenko wrote:
> > Let's maintain occasional fixes to the fbtft driver.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  MAINTAINERS | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ea3e6c914384..16e614606ac1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7372,9 +7372,11 @@ F:     Documentation/fault-injection/
> >  F:   lib/fault-inject.c
> >
> >  FBTFT Framebuffer drivers
> > +M:   Andy Shevchenko <andy@kernel.org>
> >  L:   dri-devel@lists.freedesktop.org
> >  L:   linux-fbdev@vger.kernel.org
> > -S:   Orphan
> > +S:   Maintained
> > +T:   git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-fbtft.git
>
> I'm ok with the files moving if the dri developers agree with it.  It's
> up to them, not me.

On one hand I'm happy anytime someone volunteers to help out.

On the other hand ... why does it have to be resurrecting fbdev?
There's an entire community of people who really know graphics and
display and spent considerable amount of effort on creating useful and
documented helpers for pretty much anything you might ever want to do.
And somehow we have to go back to typing out things the hard way, with
full verbosity, for an uapi that distros are abandoning (e.g. even for
sdl the direction is to run it on top of drm with a compat layer,
afaiui fedora is completely ditching any userspace that still even
uses /dev/fb/0). And yes I know there's still some gaps in drm,
largely for display features which were really en vogue about 20 years
ago. And we're happy to add that support, if someone who still has
such hardware can put in the little bit of work needed ...

I don't get this.
-Daniel


--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

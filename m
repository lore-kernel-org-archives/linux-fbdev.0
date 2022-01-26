Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF19C28CF5
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 10:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiAZKne (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 05:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiAZKne (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 05:43:34 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAA4C061744
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 02:43:33 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so13419042otr.11
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 02:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK+78XaAQPCLB0cX0TSDW4GUNb2Fr1WFpEws/EiYsHo=;
        b=H5Mpc3SICXdb/tu7QNJsAZJY9cx8gxyADjsjYqFs2OGzikcrQv9d6aUFd4nu2DR/uM
         pg7r7egDc5hJX7SpJWHXbqu8eN/zn6I3n9JfcARrYRnMh14um9Nuf3hnkZUyptzEzpMD
         xu/W8FcZqPRJYWljwQmeV3Ea1kT+hmVGT0+Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK+78XaAQPCLB0cX0TSDW4GUNb2Fr1WFpEws/EiYsHo=;
        b=ztvNeifZLc8z21TQQHJfg8q0JpAHxaz7uvhgP2PMT+1NF6TRa2Nh2yJuK1kIQL7468
         A0ec62mIMuaDSsreJEYTPjdaz0xI+mcgx+1vqv1J+nAws79ALqm+UsKPe8Hi6RNEQiiC
         sPS6WrVgsUbOFxUHTp1R061CmPiD1NqToOoBs5125Yt+M21VqAyjdex0qHVnHt0Pjth4
         JrySzDV90NdyB+c0UkzZXo314XaLE5vNIYEhZrbFXQl1uabc8VLYlug9jkFafgp5KHLa
         bb6MT3AiwEsq3gJ+p5quRvG2UY2ubHyrRU8DibrF8U/FaEZ4LjHBdBxyfTQyIJWE5i50
         L0sQ==
X-Gm-Message-State: AOAM5304CJRqv0biQEEN+v9FaOHBnbFxga5GiufcvJPMiIQ6+e8guRRy
        tMe3MwUbp5gfLdenBVpZABS9/RlKWy8/8meRkozSHw==
X-Google-Smtp-Source: ABdhPJypyU3SWjtazA+dR1jy9183rhmFmvhtPfxYhBvLEhFBxk3eEbVjurEEmBVicGmboHD3dxP03AD+st+JrZGg+yE=
X-Received: by 2002:a05:6830:2704:: with SMTP id j4mr17390007otu.323.1643193812904;
 Wed, 26 Jan 2022 02:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de> <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
In-Reply-To: <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 26 Jan 2022 11:43:21 +0100
Message-ID: <CAKMK7uEQUxDUg6yFgcc5gee=fqS6ehuVV_ZouwvTeq7kLreqNQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 26, 2022 at 11:03 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jan 26, 2022 at 10:52 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Hi
> >
> > Am 25.01.22 um 21:21 schrieb Andy Shevchenko:
> > > Since we got a maintainer for fbdev, I would like to
> > > unorphan fbtft (with the idea of sending PRs to Helge)
> > > and move it out of staging since there is no more clean
> > > up work expected and no more drivers either.
> > >
> > > Thoughts?
>
> Thanks for sharing yours, my answers below.
>
> > But why? We already have DRM drivers for some of these devices.
>
> No, we do not (only a few are available).
>
> > Porting
> > the others to DRM is such a better long-term plan.  OTOH, as no one has
> > shown up and converted them, maybe they should be left dead or removed
> > entirely.
>
> As I mentioned above there are devices that nobody will take time to
> port to a way too complex DRM subsystem. But the devices are cheap and
> quite widespread in the embedded world. I'm in possession of 3 or 4
> different models and only 1 is supported by tiny DRM.

If we go with "way too complex" no one should try writing good linux
drivers in general, because with the bazillion of helpers, different
subsystems and specific solution for pretty much any possible problem
you might ever have, the linux kernel overall is "way too complex".

Yes it's overwhelming and also dri-devel is a chaotic firehose, but
let's try to address these issues instead of creating tiny little
corners where nothing happens, but at least things are simple.

Maybe Greg needs to expand his "I'll help you upstream your drivers"
project to drm? We're trying to do that but sometimes it's a bit too
much chaos, and also no one is actually paid in drm to do that kind of
work even part time (except contracting for specific customers, but
that's not the problem here I think).
-Daniel

> On top of that the subtle fact people forgot about FBTFT is that it
> does support parallel interface (yes, I know that it's not performant,
> but one of the displays I have is with that type of interface).
>
> P.S. For the record, I will personally NAK any attempts to remove that
> driver from the kernel. And this is another point why it's better not
> to be under the staging.
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

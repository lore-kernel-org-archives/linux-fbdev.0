Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B567C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 27 Jan 2022 10:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiA0KdL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiA0KdK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 27 Jan 2022 05:33:10 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D0C061714
        for <linux-fbdev@vger.kernel.org>; Thu, 27 Jan 2022 02:33:10 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id g205so5023192oif.5
        for <linux-fbdev@vger.kernel.org>; Thu, 27 Jan 2022 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9lbSU/ybc6OppgRIX8ZBQPJXb4PzkNkIkqyzEe4vsM=;
        b=h5X8KiOAwvCCoeask1zcBMENoSVPTMzB0G9oA/mLHo88nDVixWpSb7px6ea/B1fPEL
         PkvItn1CwvuTQktdczAAqHeDGBXOYOfOrLz2U+mxe7iuVSUwVTaAEcOAqnvnrVcvfqS1
         h5tS2oE1tTYgRY7YfjUQIijdf9VNx0qvTN4IJLLVTFntzU7jOJfQDSa01XLgSnH3EvZ3
         pEmGFTmgQZT7p4xg7+zEOjpe66HJFk76oAeJhm0Gi1hrITnqHwkuyechpuEh0xvKNaac
         3mMOk3jpmNiwzprGnlDdUxUkeGeterETUL3Z6t7fc3PHj58yCj3ZowkQVhwGMfoI1SQt
         b/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9lbSU/ybc6OppgRIX8ZBQPJXb4PzkNkIkqyzEe4vsM=;
        b=GcF2NQ2toxacwa8Dr1kGf1WZHFNOOguKoOOSpLaxU80lQucDM51cgUG8/NP/wBpyMT
         iT6bqTxQHSPGm7n3JGEB+nxWjQwhPWtNGdfZaLSKLChb+WU/J6s00hwsBNyp5Pj9PT2Y
         RrbcLLjqRcPfpBntamgVUrUgN9Tqmf6ohOCuoO05XDqNYFAnqtsMEnGK/Kqz5hrrHHfr
         4xb+O4Fhlq/v1XN/v2o6Rp6aolVByzvGKPR1M48eyCwaFCqLKvp/uBLL9T1Tf8TwRXGh
         uXLg5k9eyextp8Y9OBS2YU8c4l8bkY/+SvIzU3yRHlsKHymUrcVrsGHyL4fayufPJfq3
         HGdg==
X-Gm-Message-State: AOAM530x3WfCA6GOt7+6gW/Qk9KrHDdjyH3RGJlK1rTGzjnwlePgVbz8
        uhxxG1KzKS1ui1NK7XXBkGYarcD+0oV5xzXJzGThLw==
X-Google-Smtp-Source: ABdhPJy01OZg2SzTN7RAjLIdxIQiBfvVYOOHfj92G4lxP3BuUPFrtmf9Vh+t5p9LhrGQAJTdPvmIkkVRVunGv9b2WW0=
X-Received: by 2002:a05:6808:b10:: with SMTP id s16mr1773942oij.307.1643279589694;
 Thu, 27 Jan 2022 02:33:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de> <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
 <YfFMSkhbvHaR0YNE@smile.fi.intel.com> <f6ffe9bb-8683-4061-c876-1d559267ebae@redhat.com>
 <YfFWmmJFtEB93jUi@smile.fi.intel.com> <3430838d-1c63-da49-b774-c5a883e7085f@redhat.com>
 <YfFZkgE3wfPXLpYA@kroah.com> <20220126144524.GB1951@kadam>
 <CAKMK7uGEFW4nd+W6PiT=uwSPz=pA6HKZXj6ePcdsAGiMDb3BxA@mail.gmail.com> <20220127062945.GC1951@kadam>
In-Reply-To: <20220127062945.GC1951@kadam>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Jan 2022 11:32:58 +0100
Message-ID: <CACT4Y+bWMFK40o1gw6Ze7vkSKjAyBPNecjEBw+g7sMFbUZyXXA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 27 Jan 2022 at 07:30, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Jan 26, 2022 at 11:31:02PM +0100, Daniel Vetter wrote:
> > dOn Wed, Jan 26, 2022 at 3:46 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > The other advantage of staging is the I don't think syzbot enables it.
> > > I guess it's easier to persuade Dmitry to ignore STAGING than it was to
> > > get him to disable FBDEV.  :P
> > >
> > > The memory corruption in fbdev was a real headache for everyone because
> > > the stack traces ended up all over the kernel.
> >
> > Uh Dmitry disabled all of FBDEV?
>
> No that's the opposite of what I meant.  STAGING is disabled in syzbot
> and FBDEV is enabled.

Is there still any problem with syzbot config?
syzbot configs are stored here:
https://github.com/google/syzkaller/tree/master/dashboard/config/linux
